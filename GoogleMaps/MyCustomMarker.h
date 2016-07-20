//
//  MyCustomMarker.h
//  GoogleMaps
//
//  Created by Jo Tu on 7/8/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyCustomMarker : UIView
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (strong,nonatomic) NSURL *webLink;

@end
