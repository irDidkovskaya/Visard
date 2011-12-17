//
//  BSJSONRequestOperation.h
//  bSafe
//
//  Created by Alexandr Fal' on 10/4/11.
//  Copyright 2011 Ciklum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"


@interface BSJSONRequestOperation : AFJSONRequestOperation {
    
}

+ (BSJSONRequestOperation *)operationWithRequest:(NSURLRequest *)urlRequest
                           acceptableStatusCodes:(NSIndexSet *)acceptableStatusCodes
                          acceptableContentTypes:(NSSet *)acceptableContentTypes
                                         success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                         failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON, NSError *error))failure;

@end
