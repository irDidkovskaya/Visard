//
//  DataController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"

@implementation DataController

+ (DataController *)sharedDataController
{
    static DataController *_sharedDataController = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedDataController = [[self alloc] init];
        
        // You additional setup goes here...
        
    });
    
    return _sharedDataController;
}

@end
