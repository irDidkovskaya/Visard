//
//  NetworkController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkController.h"
#import "AFJSONRequestOperation.h"
#import "BSJSONRequestOperation.h"
#import "JSONKit.h"
#import "Reachability.h"
#import "DataController.h"

NSString * const baseURLString = @"http://xenon.net.ua/projects/visard/package";

static NSString * AFURLEncodedStringFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFLegalCharactersToBeEscaped = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ ";
    
	return [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, (CFStringRef)kAFLegalCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding)) autorelease];
}

@implementation NetworkController

@synthesize baseURL;

+ (NetworkController *)sharedNetworkController
{
    static NetworkController *_sharedNetworkController = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedNetworkController = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    
    return _sharedNetworkController;
}

- (void)dealloc
{
    self.baseURL = nil;
    
    [super dealloc];
}

#pragma mark - overriden AFNetworking methods

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method 
                                      path:(NSString *)path 
                                parameters:(NSDictionary *)parameters 
{	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    
    NSMutableDictionary *defaultHeaders = [NSMutableDictionary dictionary];
    // REST API Version
    [defaultHeaders setValue:@"1" forKey:@"bsafe-rest-version"];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[defaultHeaders setValue:@"application/json" forKey:@"Accept"];
    
	// Accept-Encoding HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3
    [defaultHeaders setValue:@"gzip" forKey:@"Accept-Encoding"];
	
	// Accept-Language HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
	NSString *preferredLanguageCodes = [[NSLocale preferredLanguages] componentsJoinedByString:@", "];
    [defaultHeaders setValue:[NSString stringWithFormat:@"%@, en-us;q=0.8", preferredLanguageCodes] forKey:@"Accept-Language"];
	
	// User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    [defaultHeaders setValue:[NSString stringWithFormat:@"%@/%@ (%@, %@ %@, %@, Scale/%f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey], @"unknown", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion], [[UIDevice currentDevice] model], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0)] forKey:@"User-Agent"];
    
    
	NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:defaultHeaders];
    //	NSURL *url = [NSURL URLWithString:path relativeToURL:self.baseURL];
    
    NSURL *url = [self.baseURL URLByAppendingPathComponent:path];
    
    NSLog(@"base URL: %@", [self.baseURL absoluteString]);
    
    NSLog(@"request url: %@", [url absoluteString]);
	
    if (parameters) {
        NSMutableArray *mutableParameterComponents = [NSMutableArray array];
        for (id key in [parameters allKeys]) {
            NSString *component = [NSString stringWithFormat:@"%@=%@", AFURLEncodedStringFromStringWithEncoding([key description], self.stringEncoding), AFURLEncodedStringFromStringWithEncoding([[parameters valueForKey:key] description], self.stringEncoding)];
            [mutableParameterComponents addObject:component];
        }
        //        NSLog(@"parameters: %@", parameters);
        NSString *queryString = nil;
        if ([method isEqualToString:@"GET"]) {
            queryString = [mutableParameterComponents componentsJoinedByString:@"&"];
            //            NSLog(@"query string: %@", queryString);
            url = [NSURL URLWithString:[[url absoluteString] stringByAppendingFormat:[path rangeOfString:@"?"].location == NSNotFound ? @"?%@" : @"&%@", queryString]];
        } else {
            queryString = [parameters JSONString];
            //            NSLog(@"query string: %@", queryString);
            //            NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
            [headers setValue:@"application/json" forKey:@"Content-Type"];
            [request setHTTPBody:[queryString dataUsingEncoding:self.stringEncoding]];
            //            NSString* newStr = [NSString stringWithUTF8String:[[request HTTPBody] bytes]];
            //            NSLog(@"Request body: %@", newStr);
        }
    }
    
	[request setURL:url];
	[request setHTTPMethod:method];
	[request setAllHTTPHeaderFields:headers];
    
	return request;
}

- (void)enqueueHTTPOperationWithRequest:(NSURLRequest *)request 
                                success:(void (^)(NSHTTPURLResponse *, id JSON))success 
                                failure:(void (^)(NSHTTPURLResponse *, id JSON, NSError *))failure
{
    // Acceptable status codes
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
    //[indexSet addIndex:420];
    
    BSJSONRequestOperation *operation = [BSJSONRequestOperation operationWithRequest:request 
                                                               acceptableStatusCodes:indexSet 
                                                              acceptableContentTypes:[AFJSONRequestOperation defaultAcceptableContentTypes] 
                                                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                 if (success) {
                                                                                     success(response, JSON);
                                                                                 }
                                                                             } 
                                                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON, NSError *error) {
                                                                                 if (failure) {
                                                                                     failure(response, JSON, error);
                                                                                 }
                                                                             }];
    
    [self.operationQueue addOperation:operation];
}

- (void)getPath:(NSString *)path 
     parameters:(NSDictionary *)parameters 
        success:(void (^)(NSHTTPURLResponse *response, id object))success 
        failure:(void (^)(NSHTTPURLResponse *response, id jsonObject, NSError *error))failure
{
    NSURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
	[self enqueueHTTPOperationWithRequest:request success:success failure:failure];
}

- (void)postPath:(NSString *)path 
      parameters:(NSDictionary *)parameters 
         success:(void (^)(NSHTTPURLResponse *response, id object))success 
         failure:(void (^)(NSHTTPURLResponse *response, id jsonObject, NSError *error))failure
{
    NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
	[self enqueueHTTPOperationWithRequest:request success:success failure:failure];
}

#pragma mark - Reachability

- (BOOL)isHostReachable:(NSString *)host
{
    Reachability *r = [Reachability reachabilityWithHostName:host];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    BOOL connectionRequired = [r connectionRequired];
    NSLog(@"internet status: %d", internetStatus);
    if(internetStatus == NotReachable || connectionRequired) {
        return NO;
    }
    return YES;
}

#pragma mark

- (void)loadData
{
    // Заглушка
//    NSString *countriesListFilePath = [[NSBundle mainBundle] pathForResource:@"CountriesList3" ofType:@"json"];
//    NSData* jsonData = [NSData dataWithContentsOfFile:countriesListFilePath];
    
    // End Заглушка
    NSString *path = @"pkg.json";
    [self getPath:path 
       parameters:nil success:^(NSHTTPURLResponse *response, id object) {
           NSLog(@"[response statusCode] = %d", [response statusCode]);
           NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:@"loadedData"];
           dispatch_async(dispatch_get_main_queue(), ^{
               [[NSNotificationCenter defaultCenter] postNotificationName:@"DataLoaded" object:self userInfo:userInfo];
           });
       } failure:^(NSHTTPURLResponse *response, id jsonObject, NSError *error) {
           dispatch_async(dispatch_get_main_queue(), ^{
               NSLog(@"[response statusCode] = %d", [response statusCode]);

               [[NSNotificationCenter defaultCenter] postNotificationName:@"DataLoadFailed" object:self];
           });
       }];

    
    
    
//    JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
//    NSArray *countriesList = [decoder objectWithData:jsonData];
////    NSLog(@"All the Data: %@", countriesList);
//    if ([countriesList count]) {
//        [[DataController sharedDataController] updateCoreDataWithDataArray:countriesList];
//    }
}

@end
