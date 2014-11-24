//
//  mainMenuView.m
//  HandyHyatt
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/10/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "mainMenuView.h"
#import "myNotificationViewController.h"
#import "CustomBadgeViewController.h"
#import "CustomBadge.h"
#import <Parse/Parse.h>

@interface mainMenuView ()

@property (weak, nonatomic) IBOutlet UIImageView *background;

@property  CGRect actualFrame;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UIButton *scheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *checkListButton;
@property (strong, nonatomic) NSArray* todaysNotifs;
@property (nonatomic) CustomBadge* notifBadge;

@end

@implementation mainMenuView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
     [self.parentViewController.navigationItem.backBarButtonItem setTitle: @" "];

    //set tags for 3 main menu buttons
    self.checkListButton.tag = 1;
    self.scheduleButton.tag = 2;
    self.notificationButton.tag = 3;
    
    
    //test -- ***NOT needed after login page is finished
    [PFUser logInWithUsername: @"1456" password:@"1456"];
    
    //get current user
    PFUser* curr = [PFUser currentUser];
    
    //get dept to set background
    NSNumber* dept = curr[@"dept"];
    NSString* name = curr[@"employeeName"];
    [self queryTodaysNotifications];

    //check the department to select appropriate background images
    if([dept  isEqual: @1])
    {
        
        [self.background setImage:[UIImage  imageNamed: @"Kitchen.png"]];
        

    }
    else if([dept isEqual: @2])
    {
        [self.background setImage:[UIImage imageNamed:@"Housekeeping.png"]];

    }
    else
    {
        [self.background setImage:[UIImage imageNamed: @"Maitenance.png"]];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self queryTodaysNotifications];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    UIButton* senderButton = sender;
    
    if(senderButton.tag == 1 )
    {
        NSLog(@"Task");
        
        
    }
    else if(senderButton.tag == 2)
    {
        NSLog(@"Sched");
        
    }
    else
    {
        NSLog(@"Noti");
        myNotificationViewController* notiView = (myNotificationViewController*) [segue destinationViewController];
        
        notiView.bgImage = self.background.image;
        
    }
        
}

-(void)popBack
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) queryTodaysNotifications
{
    PFUser* user = [PFUser currentUser];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [todayComponents setHour:0];
    [todayComponents setMinute: 0];
    [todayComponents setSecond: 0];
    [todayComponents setNanosecond:0];
    
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    NSNumber *x = user[@"dept"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"dept = 0 OR dept = %@", x];
    
    PFQuery* notifQuery = [PFQuery queryWithClassName:@"Notifications" predicate:predicate];
    [notifQuery whereKey:@"createdAt" greaterThan: today];
    
    self.todaysNotifs = [notifQuery findObjects];
    
    if(self.todaysNotifs.count != 0)
    {
        NSString* badgeNumber = [[NSNumber numberWithInt:self.todaysNotifs.count] stringValue];
    
        CGFloat newX = self.notificationButton.frame.origin.x + self.notificationButton.frame.size.width - 20;
        CGFloat newY = self.notificationButton.frame.origin.y - 20;
    
        self.notifBadge = [[CustomBadge alloc] init];
        self.notifBadge = [CustomBadge customBadgeWithString: badgeNumber];
    
        [self.notifBadge setFrame: CGRectMake(newX, newY, 50, 50)];
        [self.notifBadge.badgeStyle setBadgeTextColor: [UIColor whiteColor]];
        [self.notifBadge.badgeStyle setBadgeInsetColor: [UIColor colorWithRed: 17.0/255.0 green: 101.0/255.0 blue: 168.0/255.0 alpha: 1.0]];
     //rgba(17, 101, 168, 1.0)
    
        [self.view addSubview:self.notifBadge];
        [self.view bringSubviewToFront:self.notifBadge];
    
        NSLog(@"Todays Notif Count = %ld", (unsigned long)self.todaysNotifs.count);
    
    }
    
}

@end
