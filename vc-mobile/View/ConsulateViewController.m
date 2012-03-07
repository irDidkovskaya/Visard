//
//  ConsulateViewController.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 22.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConsulateViewController.h"
#import "ConsulateLocationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorfulButton.h"
#import "AppStyle.h"
#import "MailSender.h"

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

- (void)addMainPartOfInformation {
    
    NSArray *labelsTitleName = [NSArray arrayWithObjects:NSLocalizedString(@"Адресс", nil), NSLocalizedString(@"Часы работы", nil), NSLocalizedString(@"Цена", nil), NSLocalizedString(@"Телефон", nil), NSLocalizedString(@"E-mail", nil), NSLocalizedString(@"Site", nil), nil];
    
    
    NSArray *labelsDescriptionName = [NSArray arrayWithObjects:self.consulate.address, self.consulate.workTime,  self.consulate.price, self.consulate.phone, self.consulate.email, self.consulate.site, nil];
    
    CGRect rect = CGRectMake(15, 120, 0, 20);
    
    for (int i = 0; i < [labelsTitleName count]; i++) 
    {

        UILabel *titleName = [[[UILabel alloc] initWithFrame:rect] autorelease];
        titleName.textColor = [UIColor blackColor];
        titleName.backgroundColor = [UIColor clearColor];
        titleName.text = [labelsTitleName objectAtIndex:i];
        [titleName setFont:[UIFont boldSystemFontOfSize:14]];
        [titleName sizeToFit];
        [self.view addSubview:titleName];
        
        rect.origin.y += titleName.frame.size.height + 2;
        
        if (i > 2) 
        {
            
            UIButton *descriptionText = [[[UIButton alloc] initWithFrame:rect] autorelease];
            descriptionText.titleLabel.font = [UIFont systemFontOfSize:14];
            [descriptionText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [descriptionText setTitle:[labelsDescriptionName objectAtIndex:i] forState:UIControlStateNormal];
            [descriptionText addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
            descriptionText.tag = i;
            [descriptionText sizeToFit];
            [self.view addSubview:descriptionText];
            
            rect.origin.y += descriptionText.frame.size.height + 10;
        } 
        else 
        {
            UILabel *descriptionText = [[[UILabel alloc] initWithFrame:rect] autorelease];
            descriptionText.textColor = [UIColor blackColor];
            [descriptionText setFont:[UIFont systemFontOfSize:14]];
            descriptionText.text = [labelsDescriptionName objectAtIndex:i];
            [descriptionText sizeToFit];
            
            [self.view addSubview:descriptionText];
            
            rect.origin.y += descriptionText.frame.size.height + 10;
            
        }
        
    }
    
     
}
 
- (void)openURL:(UIButton *)sender 
{
    if (sender.tag == 5) 
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.co.uk"]];
    } 
    else if (sender.tag == 3) 
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:12125551212"]];
    }
    else if (sender.tag == 4)
    {
        MailSender *sendEmail = [MailSender sharedMailSender];
        sendEmail.vcId = self;
        [sendEmail sendLogsToMail:@"bla@bla.com"];
    }
}

- (void)finedOnMap {
    
    UIButton *btnShowMap = [[[UIButton alloc] initWithFrame:CGRectMake(15, 350, 200, 30)] autorelease];
    
    btnShowMap.titleLabel.font = [UIFont systemFontOfSize:13];
    //btnShowMap = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    [btnShowMap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnShowMap setTitle:NSLocalizedString(@"Посмотреть адресс на карте", nil) forState:UIControlStateNormal];
    [btnShowMap addTarget:self action:@selector(showConsulateOnTheMap) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnShowMap];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    self.navigationItem.title = self.countryName;
    
    UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 132, 88)] autorelease];
    iv.layer.borderWidth = 1;
    iv.layer.borderColor = [UIColor blackColor].CGColor;
    
    [iv setImage:[UIImage imageNamed:self.img]];
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 25, 0, 0)];
    
    NSString *consolateGen = NSLocalizedString(@"Консульство", nil);
    headerLabel.text = [NSString stringWithFormat:@"%@\n%@ в\n%@" ,consolateGen, self.countryName, self.consulate.city];
    
    headerLabel.numberOfLines = 10;
    
    [headerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerLabel sizeToFit];
    
    [self addMainPartOfInformation];
    //[self finedOnMap];
    [self.view addSubview:headerLabel];
    [self.view addSubview:iv];
    
    
    UIBarButtonItem *showMapBtn = [[[UIBarButtonItem alloc] initWithTitle:@"Show Map" style:UIBarButtonItemStyleBordered target:self action:@selector(showConsulateOnTheMap)] autorelease];
    
    self.navigationItem.rightBarButtonItem = showMapBtn;
    
    
    
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
