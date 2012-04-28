//
//  MailSender.m
//  vc-mobile
//
//  Created by Ирина Дидковская on 07.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MailSender.h"


@implementation MailSender

@synthesize vcId;

+ (MailSender *)sharedMailSender
{
    static MailSender *_sharedMailSender = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedMailSender = [[self alloc] init];
        
        // You additional setup goes here...
        //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //_sharedMailSender.managedObjectContext = appDelegate.managedObjectContext;
        
        
    });
    
    return _sharedMailSender;
}


- (void)sendLogsToMail:(NSString *)email

{
    emailTo = email;
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
        
	}
    
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:NSLocalizedString(@"Отправить письмо", nil)];
	[picker setToRecipients:[NSArray arrayWithObject:emailTo]];
    
	// Fill out the email body text
	NSString *emailBody = NSLocalizedString(@"Text", nil);
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self.vcId presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
    
	NSString *resultString;

	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[[UIAlertView alloc] init] autorelease];
            [alert setTitle:NSLocalizedString(@"Результат", nil)];
            [alert setMessage:resultString];
            [alert setDelegate:self];
            [alert addButtonWithTitle:NSLocalizedString(@"OK", nil)];
			resultString = NSLocalizedString(@"Результат: Ошибка при отправлении письма", nil);
            [alert show];
        }
			break;
		default:
			break;
	}
    
    if (self.vcId) {
        
        [self.vcId dismissModalViewControllerAnimated:YES];
        self.vcId = nil;
    } else {
        NSLog(@"CurrentVC isn't setup"); 
    }
    
    
}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
//    if (buttonIndex == 0)
//    {
//        if (self.vcId) {
//        
//            [self.vcId dismissModalViewControllerAnimated:YES];
//            self.vcId = nil;
//        } else {
//            NSLog(@"CurrentVC isn't setup"); 
//        }
//        
//    }
}

- (void)dismissModalViewControllerAnimated {
    [self.vcId dismissModalViewControllerAnimated:YES];
    
}


-(void)dealloc {
    self.vcId = nil;
    [super dealloc];
}


@end
