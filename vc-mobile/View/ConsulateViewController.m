//
//  ConsulateViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConsulateViewController.h"
#import "ConsulateLocationViewController.h"


@implementation ConsulateViewController
@synthesize consulate, countryName, img;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)dealloc {
    self.consulate = nil;
    self.countryName = nil;
    self.img = nil;
    
    [super dealloc];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:7/255.0 green:200/255.0 blue:98/255.0 alpha:1];
    self.navigationItem.title = self.countryName;
    
    UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 132, 88)] autorelease];
    
    [iv setImage:[UIImage imageNamed:self.img]];
    
    [self.view addSubview:iv];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Actions 

- (void)showConsulateOnTheMap {
    
    
    NSNumber *lalitude = self.consulate.latitude;
    NSNumber *longitude = self.consulate.longitude;
    
    ConsulateLocationViewController *vc = [[ConsulateLocationViewController alloc] initWithLocationLatitute:[lalitude doubleValue] longitude:[longitude doubleValue]];
    vc.img = self.img;
    vc.address = self.consulate.address;
    vc.countryName = self.countryName;
    vc.cityName = self.consulate.city;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
