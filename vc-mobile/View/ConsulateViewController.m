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
@synthesize consulate, countryName, img, toolBar, numbersList;


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
    self.toolBar = nil;
    self.numbersList = nil;
    
    [super dealloc];
    
}

- (void)addMainPartOfInformation {
    
    NSArray *labelsTitleName = [NSArray arrayWithObjects:NSLocalizedString(@"Адресс", nil), NSLocalizedString(@"Часы работы", nil), NSLocalizedString(@"Цена", nil), NSLocalizedString(@"Телефон", nil), NSLocalizedString(@"E-mail", nil), NSLocalizedString(@"Site", nil), nil];
    
    
    NSArray *labelsDescriptionName = [NSArray arrayWithObjects:self.consulate.address, self.consulate.workTime,  self.consulate.price, self.consulate.phone, self.consulate.email, self.consulate.site, nil];
    
    CGRect rect = CGRectMake(15, 0, 280, 20);
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(15, 110, self.view.frame.size.width-30, 240)] autorelease];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.layer.borderWidth = 1;
    scrollView.layer.borderColor = [AppStyle colorForSeparatorInTable].CGColor;
    scrollView.layer.cornerRadius = 5;
    
    for (int i = 0; i < [labelsTitleName count]; i++) 
    {

        if (![[labelsDescriptionName objectAtIndex:i] isEqualToString:@""])
        {
            CGSize constraintSize = CGSizeMake(280, MAXFLOAT);
            CGSize labelSize = [[labelsTitleName objectAtIndex:i] sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            float height = labelSize.height;  
            rect.size.height = height;
            UILabel *titleName = [[[UILabel alloc] initWithFrame:rect] autorelease];
            titleName.numberOfLines = 0;
            titleName.textColor = [UIColor blackColor];
            titleName.backgroundColor = [UIColor clearColor];
            titleName.text = [labelsTitleName objectAtIndex:i];
            [titleName setFont:[UIFont boldSystemFontOfSize:14]];
            
            //[titleName sizeToFit];
            [scrollView addSubview:titleName];
            
            rect.origin.y += titleName.frame.size.height + 2;
            
            
            CGSize descriptionSize = [[labelsTitleName objectAtIndex:i] sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
            float heightOfdescription = descriptionSize.height;  
            rect.size.height = heightOfdescription;
            
            UILabel *descriptionLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
            descriptionLabel.numberOfLines = 0;
            descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
            descriptionLabel.textColor = [UIColor blackColor];
            [descriptionLabel setFont:[UIFont systemFontOfSize:14]];
            descriptionLabel.text = [labelsDescriptionName objectAtIndex:i];
            
            [descriptionLabel sizeToFit];
            
            [scrollView addSubview:descriptionLabel];
            
            rect.origin.y += descriptionLabel.frame.size.height + 10;
        }
        
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width-30, rect.origin.y);
    [self.view addSubview:scrollView];
    
}

- (void)showActionSheet 
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles: nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
   self.numbersList = [self.consulate.phone componentsSeparatedByString:@","];

    for (NSString *btnName in self.numbersList) {
        [popupQuery addButtonWithTitle:btnName];
    }
    [popupQuery showInView:self.view];
    [popupQuery release];

}

- (void)openURL:(UIButton *)sender 
{
    if (sender.tag == 5) 
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.consulate.site]];
    } 
    else if (sender.tag == 3) 
    {
        [self showActionSheet];
    }
    else if (sender.tag == 4)
    {
        MailSender *sendEmail = [MailSender sharedMailSender];
        sendEmail.vcId = self;
        [sendEmail sendLogsToMail:self.consulate.email];
    }
}

- (void)finedOnMap {
    
    UIButton *btnShowMap = [[[UIButton alloc] initWithFrame:CGRectMake(15, 350, 200, 30)] autorelease];
    
    btnShowMap.titleLabel.font = [UIFont systemFontOfSize:13];

    [btnShowMap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnShowMap setTitle:NSLocalizedString(@"Посмотреть адресс на карте", nil) forState:UIControlStateNormal];
    [btnShowMap addTarget:self action:@selector(showConsulateOnTheMap) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnShowMap];
    
}

- (void)addToolBarOnTheView
{
    
    UIToolbar *tb = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 372, self.view.frame.size.width, 44)] autorelease];
    tb.tintColor = [AppStyle colorForToolBar];
    
    UIBarButtonItem *showMapBtn = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pin_map.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showConsulateOnTheMap)] autorelease];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *phoneBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openURL:)];
    phoneBtn.tag = 3;
    
    UIBarButtonItem *emailBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"email.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openURL:)];
    emailBtn.tag = 4;
    
    UIBarButtonItem *openUrlBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"internet.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openURL:)];
    openUrlBtn.tag = 5;
    
    
    NSArray *arrayWithButtons = [NSArray arrayWithObjects:showMapBtn, phoneBtn, emailBtn, openUrlBtn, nil];
    NSArray *arrayWithInfo = [NSArray arrayWithObjects:self.consulate.address, self.consulate.phone, self.consulate.email, self.consulate.site, nil];
    NSMutableArray *validButtons = [NSMutableArray array];
    NSLog(@"arrayWithButtons = %@", arrayWithButtons);
    for (int i = 0; i < [arrayWithButtons count]; i++) {
        
        if (![[arrayWithInfo objectAtIndex:i] isEqualToString:@""])
        {
            [validButtons addObject:flexibleSpace];
            [validButtons addObject:[arrayWithButtons objectAtIndex:i]];
        }
    }
    NSLog(@"validButtons = %@", validButtons);
    [validButtons addObject:flexibleSpace];
    [tb setItems:validButtons];
    
    
    self.toolBar = tb;
    [self.view addSubview:self.toolBar];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [AppStyle backgroundColor];
    
    self.navigationController.navigationBar.tintColor = [AppStyle colorForNavigationBar];
    self.navigationItem.title = self.countryName;
    
    UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 105, 70)] autorelease];
    iv.layer.borderWidth = 1;
    iv.layer.borderColor = [AppStyle colorForSeparatorInTable].CGColor;
    iv.layer.cornerRadius = 5;
    iv.layer.masksToBounds = YES;
    iv.layer.shadowOffset = CGSizeMake(0, 1);
    iv.layer.shadowColor = [UIColor whiteColor].CGColor;
    [iv setImage:[UIImage imageNamed:self.img]];
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 20, 0, 0)];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
    headerLabel.shadowColor = [AppStyle colorForSeparatorInTable];
    NSString *consolateGen = NSLocalizedString(@"Консульство", nil);
    headerLabel.text = [NSString stringWithFormat:@"%@\n%@ в\n%@" ,consolateGen, self.countryName, self.consulate.city];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.numberOfLines = 5;
    headerLabel.textColor = [UIColor whiteColor];
    [headerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerLabel sizeToFit];
    
    [self addMainPartOfInformation];
    //[self finedOnMap];
    [self.view addSubview:headerLabel];
    [self.view addSubview:iv];
    
    [self addToolBarOnTheView];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.toolBar = nil;
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
    NSString *link = [NSString stringWithFormat:@"maps://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@&z=17", lalitude, longitude, lalitude, longitude];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
//    NSNumber *lalitude = self.consulate.latitude;
//    NSNumber *longitude = self.consulate.longitude;
//    
//    ConsulateLocationViewController *vc = [[ConsulateLocationViewController alloc] initWithLocationLatitute:[lalitude doubleValue] longitude:[longitude doubleValue]];
//    vc.img = self.img;
//    vc.address = self.consulate.address;
//    vc.countryName = self.countryName;
//    vc.cityName = self.consulate.city;
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma makr ActionSheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex > 0) {
        NSString *phoneNumber = [self.numbersList objectAtIndex:buttonIndex-1];
        NSCharacterSet *backSpace = [NSCharacterSet characterSetWithCharactersInString:@" "];
        NSCharacterSet *dash = [NSCharacterSet characterSetWithCharactersInString:@"-"];
        phoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet:backSpace] componentsJoinedByString:@""];
        phoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet: dash] componentsJoinedByString:@""];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]]];
    }

}


@end
