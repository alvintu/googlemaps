//
//  ViewController.m
//  GoogleMaps
//
//  Created by Jo Tu on 7/8/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomMarker.h"
#import "CustomMarkerClass.h"
#import "WebViewController.h"
@import GoogleMaps;

@interface ViewController()<GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;
@property(strong,nonatomic) NSMutableArray *markerArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
@implementation ViewController

- (void)viewDidLoad {
//    [self testAPI];
    
    self.title = @"Google Maps";
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.741434
                                                            longitude:-73.990039
                                                                 zoom:6];
    self.mapView_.camera = camera;
    self.mapView_.myLocationEnabled = YES;
    self.mapView_.delegate = self;
//    self.view = self.mapView_;
    // Creates a marker in the center of the map.
    
    CustomMarkerClass *marker = [[CustomMarkerClass alloc]init];
    marker.position = CLLocationCoordinate2DMake(40.741434, -73.990039);
    marker.title = @"TurnToTech";
    marker.subtitle = @"iOS BootCamp";
    marker.url = [NSURL URLWithString:@"http://turntotech.io"];
    marker.image = [UIImage imageNamed:@"apple-icon-180x180.png"];
    marker.map = self.mapView_;
    marker.infoWindowAnchor = CGPointMake(0.5, -0.25);



    CustomMarkerClass *marker1 = [[CustomMarkerClass alloc] init];
    marker1.position = CLLocationCoordinate2DMake(40.744464, -73.993063);
    marker1.title = @"Perpetuum";
    marker1.subtitle = @"Coffee Shop";
    marker1.url = [NSURL URLWithString:@"http://yelp.com/biz/perpetuum-cafe-new-york"];
    marker1.image = [UIImage imageNamed:@"perpetuum.mpg"];
    marker1.map = self.mapView_;
    marker1.infoWindowAnchor = CGPointMake(0.5, -0.25);

    CustomMarkerClass *marker2 = [[CustomMarkerClass alloc] init];
    marker2.position = CLLocationCoordinate2DMake(40.742037, -73.987563);
    marker2.title = @"Shake Shack";
    marker2.subtitle = @"Burgers";
    marker2.url = [NSURL URLWithString:@"http://shakeshack.com"];
    marker2.image = [UIImage imageNamed:@"shakeshack.png"];
    marker2.map = self.mapView_;
    marker2.infoWindowAnchor = CGPointMake(0.5, -0.25);
    
    CustomMarkerClass *marker3 = [[CustomMarkerClass alloc] init];
    marker3.position = CLLocationCoordinate2DMake(40.740543, -73.98781);
    marker3.title = @"Sophies Cuban Cuisine";
    marker3.subtitle = @"Cuban Food";
    marker3.url = [NSURL URLWithString:@"http://sophiescuban.com/"];
    marker3.image = [UIImage imageNamed:@"sophies.jpg"];
    marker3.map = self.mapView_;
    marker3.infoWindowAnchor = CGPointMake(0.5, -0.25);
    
    self.markerArray =  [[NSMutableArray alloc]init];
    [self.markerArray addObject:marker];
    [self.markerArray addObject:marker1];
    [self.markerArray addObject:marker2];
    [self.markerArray addObject:marker3];
    [self focusMapToShowAllMarkers];
    
    NSLog(@"count of markerarray is %lu",[self.markerArray count]);
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)focusMapToShowAllMarkers
{
    CLLocationCoordinate2D myLocation = ((GMSMarker *)self.markerArray.firstObject).position;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
    
    for (GMSMarker *marker in self.markerArray)
        bounds = [bounds includingCoordinate:marker.position];
    
    [self.mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:15.0f]];
}


- (IBAction)changeMapType:(UISegmentedControl *)sender {
    
    NSUInteger selectedMapType = sender.selectedSegmentIndex;
    
    switch (selectedMapType) {
        case 0:
            self.mapView_.mapType = kGMSTypeNormal;
            break;
        case 1:
            self.mapView_.mapType = kGMSTypeHybrid;
            break;
        case 2:
            self.mapView_.mapType = kGMSTypeSatellite;
            break;
            
        default:
            self.mapView_.mapType = kGMSTypeNormal;
            break;
    }
}


-(UIView*) mapView: (GMSMapView*)mapView markerInfoWindow:(GMSMarker *)marker
{
    MyCustomMarker * infoWindow = [[[NSBundle mainBundle]loadNibNamed:@"MyCustomMarker" owner:self options:nil]objectAtIndex:0];
    CustomMarkerClass *customann = (CustomMarkerClass*)marker;

    infoWindow.title.text = customann.title;
    infoWindow.detail.text = customann.subtitle;
    if(infoWindow.title.text == customann.title){
        infoWindow.image.image = customann.image;

    }
//    infoWindow.image.image = [UIImage imageNamed:@"australia"];
//    infoWindow.webLink = [NSURL URLWithString:(nonnull NSString *)]
    
    return infoWindow;
}



-(void)mapView:(GMSMapView*)mapview didTapInfoWindowOfMarker:(nonnull GMSMarker *)marker{
    NSLog(@"hm");
    
    WebViewController *webViewController = [[WebViewController alloc]init];
    CustomMarkerClass *customann = (CustomMarkerClass*)marker;
    NSLog(@"%@'",customann.url);
    webViewController.webLink = customann.url;
    
    [self.navigationController pushViewController:webViewController animated:YES];

}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//
//    // If the text changed, reset the tableview if it wasn't empty.
//    if (self.places.count != 0) {
//
//        // Set the list of places to be empty.
//        self.places = @[];
//        // Reload the tableview.
//        [self.tableView reloadData];
//        // Disable the "view all" button.
//        self.viewAllButton.enabled = NO;
//    }
//}


- (void)startSearch:(NSString *)searchString {
    // 1
    NSString *searchBarText =  self.searchBar.text;
    [searchBarText stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    NSString *dataUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?location=40.741434,-73.990039&radius=100&query=%@=&key=AIzaSyCUKnKpPUIrYO_uUKgtQ-fNFop7Cd_RN8I",searchBarText];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              if (data) {

                                                  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

                                                  
//                                                  NSLog(@"%@",dictionary);
                                                  NSArray *results = [dictionary objectForKey:@"results"];
                                                  NSLog(@"results is %@",results);
                                                  for (int i=0; i<[results count]; i++) {
                                                      NSDictionary* place = [results objectAtIndex:i];
                                                      
                                                      NSDictionary *geo = [place objectForKey:@"geometry"];
                                                      NSString *name=[place objectForKey:@"name"];
                                                      NSDictionary *loc = [geo objectForKey:@"location"];

                                                      CLLocationCoordinate2D placeCoord;
                                                      // Set the lat and long.
                                                      placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
                                                      placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
                                                      dispatch_async(dispatch_get_main_queue(), ^{

                                                      
                                                      CustomMarkerClass *marker = [[CustomMarkerClass alloc]init];
                                                      marker.position = placeCoord;
                                                      marker.title = name;
                                                      marker.map = self.mapView_;
//                                                      marker.subtitle = @"iOS BootCamp";
//                                                      marker.url = [NSURL URLWithString:@"http://turntotech.io"];

                                                      });
                                                      
                                                  }

                                              }
                                              // 4: Handle response here
                                          }];
    
    // 3
    [downloadTask resume];

//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self startSearch:self.searchBar.text];
//    [self testAPI];
    
}



@end
