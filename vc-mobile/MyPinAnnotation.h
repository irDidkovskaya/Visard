//
//  MyPinAnnotation.h
//  Danish
//
//  Created by Ирина Дидковская on 02.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyPinAnnotation : NSObject <MKAnnotation>
{
    
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) NSString *thumb;
@property (nonatomic, assign) NSInteger tag;

- (id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) nTitle;

@end
