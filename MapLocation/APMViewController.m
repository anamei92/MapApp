//
//  APMViewController.m
//  MapLocation
//
//  Created by Ana Mei on 2/16/13.
//  Copyright (c) 2013 Ana Mei. All rights reserved.
//

#import "APMViewController.h"
#import "APMAppDelegate.h"

@interface APMViewController ()
@property (strong, nonatomic) APMAppDelegate *appDelegate;
@end

@implementation APMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.appDelegate =[[UIApplication sharedApplication] delegate];
    self.appDelegate.locationManager = [[CLLocationManager alloc] init];
     self.appDelegate.locationManager.delegate = self;
    [ self.appDelegate.locationManager startMonitoringSignificantLocationChanges];
    

    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    
    //sets the accuracy to within 100 meters
     self.appDelegate.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //call update only when horizontal distance reaches 1000m
     self.appDelegate.locationManager.distanceFilter = 1000;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"lat: %f, lon:%f", location.coordinate.latitude, location.coordinate.longitude);
    [self addPinToMapAtLocation:location];
    
}

- (void)addPinToMapAtLocation:(CLLocation *)location
{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = location.coordinate;
    pin.title = @"Location";
    pin.subtitle = @"Currently At";
    [self.mapview addAnnotation:pin];
    [self focusOnPoint:location];
}

- (void) focusOnPoint:(CLLocation*) location
{
    CLLocationCoordinate2D here =  location.coordinate;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=10;
    span.longitudeDelta=10;
    region.span=span;
    region.center=here;
    [self.mapview setRegion:region animated:TRUE];
    [self.mapview regionThatFits:region];
    
}
@end
