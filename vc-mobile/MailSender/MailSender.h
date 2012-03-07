//
//  MailSender.h
//  vc-mobile
//
//  Created by Ирина Дидковская on 07.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailSender : NSObject <UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
    NSString *emailTo;
}

@property (nonatomic, retain) id vcId;

+ (MailSender *)sharedMailSender;
- (void)sendLogsToMail:(NSString *)email;
-(void)displayComposerSheet;
//- (id)initWithEmail:(NSString *)email;

@end
