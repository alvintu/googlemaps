//
//  CustomMarkerClass.h
//  GoogleMaps
//
//  Created by Jo Tu on 7/8/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMaps;

@interface CustomMarkerClass : GMSMarker


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) UIImage *image;


@end
