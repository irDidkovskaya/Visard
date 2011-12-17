//
//  NetworkController.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface NetworkController : AFHTTPClient

extern NSString * const baseURLString;

@property (nonatomic, retain) NSURL *baseURL;

+ (NetworkController *)sharedNetworkController;

#pragma mark - overriden AFNetworking methods

- (void)enqueueHTTPOperationWithRequest:(NSURLRequest *)request 
                                success:(void (^)(NSHTTPURLResponse *, id JSON))success 
                                failure:(void (^)(NSHTTPURLResponse *, id JSON, NSError *))failure;

- (void)getPath:(NSString *)path 
     parameters:(NSDictionary *)parameters 
        success:(void (^)(NSHTTPURLResponse *response, id object))success 
        failure:(void (^)(NSHTTPURLResponse *response, id jsonObject, NSError *error))failure;

- (void)postPath:(NSString *)path 
      parameters:(NSDictionary *)parameters 
         success:(void (^)(NSHTTPURLResponse *response, id object))success 
         failure:(void (^)(NSHTTPURLResponse *response, id jsonObject, NSError *error))failure;

#pragma mark - Reachability

- (BOOL)isHostReachable:(NSString *)host;

#pragma mark - Calls

- (NSArray *)loadCountiesList;

@end
