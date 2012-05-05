//
//  ReminderSetupViewController.m
//  vc-mobile
//
//  Created by Alexandr Fal' on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReminderSetupViewController.h"
#import "DataController.h"
#import "VCustomAccessory.h"
#import "AppDelegate.h"

@interface ReminderSetupViewController () {
@private
    BOOL reminderIsOn;
}

@property (nonatomic, retain) Requirement *targetRequirement;
@property (nonatomic, retain) NSDate *reminderDate;
@property (nonatomic, retain) NSString *reminderText;
@property (nonatomic, retain) NSMutableIndexSet *expandedSections;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *cancelButton;
@property (nonatomic ,retain) UIDatePicker *datePicker;

- (void)setupNavigationBarButtons;
- (void)showRemiderDateSelector;
- (void)hideRemiderDateSelector;

@end

@implementation ReminderSetupViewController

@synthesize targetRequirement;
@synthesize expandedSections;
@synthesize reminderDate;
@synthesize reminderText;
@synthesize doneButton;
@synthesize cancelButton;
@synthesize datePicker;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRequirement:(Requirement *)requirement
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.targetRequirement = requirement;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.targetRequirement = nil;
    self.expandedSections = nil;
    self.reminderDate = nil;
    self.reminderText = nil;
    self.doneButton = nil;
    self.cancelButton = nil;
    self.datePicker = nil;
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    self.navigationItem.title = NSLocalizedString(@"Напоминание", nil);
    if (!self.expandedSections)
    {
        NSMutableIndexSet *sections = [[[NSMutableIndexSet alloc] init] autorelease];
        self.expandedSections = sections;
    }
    [self setupNavigationBarButtons];
    reminderIsOn = self.targetRequirement.reminderDate ? YES : NO;
    self.reminderDate = self.targetRequirement.reminderDate;
    if (reminderIsOn) {
        [self.expandedSections addIndex:1];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.datePicker) {
        [self hideRemiderDateSelector];
    }
    
    [super viewWillDisappear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupNavigationBarButtons
{
    UIBarButtonItem *doneBtn = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Готово", nil) 
                                                                style:UIBarButtonItemStyleDone 
                                                               target:self 
                                                               action:@selector(applyChanges)] autorelease];
    self.navigationItem.rightBarButtonItem = doneBtn;
    
    UIBarButtonItem *cancelBtn = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Отмена", nil)
                                                                  style:UIBarButtonItemStylePlain 
                                                                 target:self 
                                                                 action:@selector(discardChanges)] autorelease];
    self.navigationItem.leftBarButtonItem = cancelBtn;
}

//- (void)setupDatePickerButtons
//{
//    UIBarButtonItem *doneBtn = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Select", nil) 
//                                                                 style:UIBarButtonItemStyleDone 
//                                                                target:self 
//                                                                action:@selector(selectRemiderDate)] autorelease];
//    self.navigationItem.rightBarButtonItem = doneBtn;
//    
//    UIBarButtonItem *cancelBtn = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", nil)
//                                                                   style:UIBarButtonItemStylePlain 
//                                                                  target:self 
//                                                                  action:@selector(cancelRemiderDateSelection)] autorelease];
//    self.navigationItem.leftBarButtonItem = cancelBtn;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.expandedSections containsIndex:section])
    {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        NSString *cellText = nil;
        if (!indexPath.row) {
            cellText = targetRequirement.name;
        } else {
            cellText = targetRequirement.value;
        }
        UIFont *cellFont = [UIFont systemFontOfSize:17.0];
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat heightForCell = labelSize.height + 20.0f;
        if (heightForCell > 44) {
            return heightForCell;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    if (!indexPath.section) {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        if (!indexPath.row) {
            cell.textLabel.text = self.targetRequirement.name;
            if ([self.expandedSections containsIndex:indexPath.section]) {
                cell.accessoryView = [VCustomAccessory accessoryWithColor:[UIColor grayColor] type:VCustomAccessoryTypeUp];
            } else {
                cell.accessoryView = [VCustomAccessory accessoryWithColor:[UIColor grayColor] type:VCustomAccessoryTypeDown];
            }
        } else {
            cell.textLabel.text = self.targetRequirement.value;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    } else {
        if (!indexPath.row) {
            cell.textLabel.text = NSLocalizedString(@"Напомнить", nil);
            UISwitch *switchBtn = [[[UISwitch alloc] init] autorelease];
            [switchBtn setOn:reminderIsOn];
            [switchBtn addTarget:self action:@selector(switchReminderSate:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchBtn;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            if (!self.reminderDate) {
                self.reminderDate = [NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970] + 60)];
            }
            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormatter setDateFormat: @"dd.MM.yyyy, HH:mm"];
            cell.textLabel.text = [dateFormatter  stringFromDate:self.reminderDate];
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section && !indexPath.row) {
        if ([self.expandedSections containsIndex:0]) {
            [self.expandedSections removeIndex:0];
        } else {
            [self.expandedSections addIndex:0];
        }
        if (self.datePicker) {
            [self hideRemiderDateSelector];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    } else if (indexPath.section && indexPath.row) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (!self.datePicker) {
            [self showRemiderDateSelector];
        } else {
            [self hideRemiderDateSelector];
        }
    }
}

#pragma mark - Actions

- (void)switchReminderSate:(UISwitch *)sender
{
    NSLog(@"Is Reminder On: %@", [NSNumber numberWithBool:sender.isOn]);
    reminderIsOn = sender.isOn;
    if ([self.expandedSections containsIndex:1]) {
        if (self.datePicker) {
            [self hideRemiderDateSelector];
        }
        [self.expandedSections removeIndex:1];
        self.reminderDate = nil;
    } else {
        if (!self.datePicker) {
            [self showRemiderDateSelector];
        }
        [self.expandedSections addIndex:1];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)showRemiderDateSelector
{
    if ([self.expandedSections containsIndex:0]) {
        [self.expandedSections removeIndex:0];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.frame = CGRectMake(0.0, 460, 320.0, 216.0);
    [picker setDate:[NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970] + 60)]];
    [picker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970] + 60)]];
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    [picker addTarget:self action:@selector(datePickerDateValueChanged) forControlEvents:UIControlEventValueChanged];
    self.datePicker = picker;
    [[((AppDelegate *)[[UIApplication sharedApplication] delegate]) window] addSubview:self.datePicker];
    [picker release];
//    [self setToDarkMode];
    [UIView animateWithDuration:0.5 
                     animations:^{
                         //
                         self.datePicker.frame = CGRectMake(0.0, 264.0, 320.0, 216.0);
                         self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320.0, 200.0);
                     } completion:^(BOOL finished){
                         //
//                         self.tableView.userInteractionEnabled = NO;
//                         [self setupDatePickerButtons];
                         [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                     }];
}

- (void)hideRemiderDateSelector
{
    [UIView animateWithDuration:0.5 
                     animations:^{
                         //
                         self.datePicker.frame = CGRectMake(0.0, 480, 320.0, 216.0);
                         self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320.0, 367.0);
                     } completion:^(BOOL finished){
                         //
                         self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320.0, 367.0);
                         self.datePicker = nil;
//                         self.tableView.userInteractionEnabled = YES;
//                         [self setupNavigationBarButtons];
                     }];
}

- (void)datePickerDateValueChanged
{
    self.reminderDate = datePicker.date;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)selectRemiderDate
{
    self.reminderDate = datePicker.date;
    [self hideRemiderDateSelector];
}

- (void)cancelRemiderDateSelection
{
    self.reminderDate = self.targetRequirement.reminderDate;
    [self hideRemiderDateSelector];
}

- (void)applyChanges
{
    NSLog(@"applying reminder setup changes");
    // save updated with remider date requirement to DB
    [[DataController sharedDataController] updateRequirementWithName:self.targetRequirement.name 
                                                             forVisa:self.targetRequirement.visa 
                                                     withRemiderDate:self.reminderDate];
    
    // setup reminder local notification
    [[DataController sharedDataController] scheduleRemiderForRequirementWithName:self.targetRequirement.name 
                                                                         forVisa:self.targetRequirement.visa 
                                                                 withRemiderDate:self.reminderDate];
    
    // Dissmiss view
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)discardChanges
{
    NSLog(@"Discarding reminder setup changes");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
