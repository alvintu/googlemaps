//
//  WebViewController.h
//  GoogleMaps
//
//  Created by Jo Tu on 7/9/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import "ViewController.h"

@interface WebViewController : ViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSURL *webLink;



@end
