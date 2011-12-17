//
//  BSJSONRequestOperation.m
//  bSafe
//
//  Created by Alexandr Fal' on 10/4/11.
//  Copyright 2011 Ciklum. All rights reserved.
//

#import "BSJSONRequestOperation.h"
#import "JSONKit.h"

static dispatch_queue_t af_json_request_operation_processing_queue;
static dispatch_queue_t json_request_operation_processing_queue() {
    if (af_json_request_operation_processing_queue == NULL) {
        af_json_request_operation_processing_queue = dispatch_queue_create("com.alamofire.json-request.processing", 0);
    }
    
    return af_json_request_operation_processing_queue;
}

@implementation BSJSONRequestOperation

+ (BSJSONRequestOperation *)operationWithRequest:(NSURLRequest *)urlRequest
                           acceptableStatusCodes:(NSIndexSet *)acceptableStatusCodes
                          acceptableContentTypes:(NSSet *)acceptableContentTypes
                                         success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                         failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON, NSError *error))failure
{
    return (BSJSONRequestOperation *)[self operationWithRequest:urlRequest completion:^(NSURLRequest *request, NSHTTPURLResponse *response, NSData *data, NSError *error) {        
        if (!error) {
            if (acceptableStatusCodes && ![acceptableStatusCodes containsIndex:[response statusCode]]) {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setValue:[NSString stringWithFormat:NSLocalizedString(@"Expected status code %@, got %d", nil), acceptableStatusCodes, [response statusCode]] forKey:NSLocalizedDescriptionKey];
                [userInfo setValue:[request URL] forKey:NSURLErrorFailingURLErrorKey];
                
                error = [[[NSError alloc] initWithDomain:AFNetworkingErrorDomain code:NSURLErrorBadServerResponse userInfo:userInfo] autorelease];
            }
            
            if (acceptableContentTypes && ![acceptableContentTypes containsObject:[response MIMEType]]) {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setValue:[NSString stringWithFormat:NSLocalizedString(@"Expected content type %@, got %@", nil), acceptableContentTypes, [response MIMEType]] forKey:NSLocalizedDescriptionKey];
                [userInfo setValue:[request URL] forKey:NSURLErrorFailingURLErrorKey];
                
                error = [[[NSError alloc] initWithDomain:AFNetworkingErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo] autorelease];
            }
        }
        
        if (error) {
            if (failure) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    failure(request, response, data, error);
//                });
                dispatch_async(json_request_operation_processing_queue(), ^(void) {
                    id JSON = nil;
                    NSError *JSONError = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_4_3
                    if ([NSJSONSerialization class]) {
                        JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
                    } else {
                        JSON = [[JSONDecoder decoder] objectWithData:data error:&JSONError];
                    }
#else
                    JSON = [[JSONDecoder decoder] objectWithData:data error:&JSONError];
#endif
                    
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        if (JSONError) {
                            if (failure) {
                                failure(request, response, nil, JSONError);
                            }
                        } else {
                            if (failure) {
                                failure(request, response, JSON, error);
                            }
                        }
                    });
                });
            }
        } else if ([data length] == 0) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(request, response, nil);
                });
            }
        } else {
            dispatch_async(json_request_operation_processing_queue(), ^(void) {
                id JSON = nil;
                NSError *JSONError = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_4_3
                if ([NSJSONSerialization class]) {
                    JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
                } else {
                    JSON = [[JSONDecoder decoder] objectWithData:data error:&JSONError];
                }
#else
                JSON = [[JSONDecoder decoder] objectWithData:data error:&JSONError];
#endif
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    if (JSONError) {
                        if (failure) {
                            failure(request, response, nil, JSONError);
                        }
                    } else {
                        if (success) {
                            success(request, response, JSON);
                        }
                    }
                });
            });
        }
    }];
}

@end
