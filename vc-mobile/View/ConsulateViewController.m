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
    
    
    UILabel *labelAddress = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120, self.view.frame.size.width, 15)] autorelease];
    labelAddress.text = NSLocalizedString(@"Адресс", nil);
    [labelAddress setFont:[UIFont boldSystemFontOfSize:13]];
    [labelAddress sizeToFit];
    [self.view addSubview:labelAddress];
    
    UILabel *address = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height, self.view.frame.size.width, 25)] autorelease];
    
    [address setFont:[UIFont systemFontOfSize:13]];
    address.text = self.consulate.address;
    [address sizeToFit];
    
    [self.view addSubview:address];
    
    UILabel *labelTimeWork = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height, self.view.frame.size.width, 20)] autorelease];
    labelTimeWork.text = NSLocalizedString(@"Часы работы", nil);
    [labelTimeWork setFont:[UIFont boldSystemFontOfSize:13]];
    [labelTimeWork sizeToFit];
    [self.view addSubview:labelTimeWork];
    
    
    UILabel *timeWork = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height, self.view.frame.size.width, 20)] autorelease];
    timeWork.text = NSLocalizedString(@"10:00 - 18:00", nil);
    [timeWork setFont:[UIFont systemFontOfSize:13]];
    [timeWork sizeToFit];
    [self.view addSubview:timeWork];
    
    
    
    
    
    UILabel *lablePhone = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height + 40, self.view.frame.size.width, 20)] autorelease];
    lablePhone.text = NSLocalizedString(@"Телефон", nil);
    [lablePhone setFont:[UIFont boldSystemFontOfSize:13]];
    [lablePhone sizeToFit];
    [self.view addSubview:lablePhone];
    
    
    UIButton *phone = [[[UIButton alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height + 65, self.view.frame.size.width, 20)] autorelease];
    phone.titleLabel.font = [UIFont systemFontOfSize:13];
    [phone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phone setTitle:NSLocalizedString(@"123 456 789 10", nil) forState:UIControlStateNormal];
    [phone addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
    phone.tag = 2;
    [phone sizeToFit];
    [self.view addSubview:phone];
    
    
    
    
    UILabel *lableMail = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height + 80, self.view.frame.size.width, 20)] autorelease];
    lableMail.text = NSLocalizedString(@"E-mail", nil);
    [lableMail setFont:[UIFont boldSystemFontOfSize:13]];
    [lableMail sizeToFit];
    [self.view addSubview:lableMail];
    
    
    UIButton *mail = [[[UIButton alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height + 105, self.view.frame.size.width, 20)] autorelease];
    [mail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mail setTitle:NSLocalizedString(@"bla@bla.com", nil) forState:UIControlStateNormal];
    [mail addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
    mail.tag = 3;
    [mail sizeToFit];
    [self.view addSubview:mail];

    
    
    UILabel *lableSite = [[[UILabel alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height + 125, self.view.frame.size.width, 20)] autorelease];
    lableSite.text = NSLocalizedString(@"Site", nil);
    [lableSite setFont:[UIFont boldSystemFontOfSize:13]];
    [lableSite sizeToFit];
    [self.view addSubview:lableSite];
    
    
    UIButton *site = [[[UIButton alloc] initWithFrame:CGRectMake(15, 120 + labelAddress.frame.size.height+10 + address.frame.size.height + labelTimeWork.frame.size.height + 140, self.view.frame.size.width, 20)] autorelease];
    site.titleLabel.font = [UIFont systemFontOfSize:13];
    [site setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [site setTitle:NSLocalizedString(@"www.bla-bla-bla.com", nil) forState:UIControlStateNormal];
    [site addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
    site.backgroundColor = [UIColor clearColor];
    site.tag = 1;
    [site sizeToFit];
    [self.view addSubview:site];
    
    
}
 
- (void)openURL:(UIButton *)sender 
{
    if (sender.tag == 1) 
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.co.uk"]];
    } 
    else if (sender.tag == 2) 
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:12125551212"]];
    }
    else if (sender.tag == 3)
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
    [self finedOnMap];
    [self.view addSubview:headerLabel];
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
