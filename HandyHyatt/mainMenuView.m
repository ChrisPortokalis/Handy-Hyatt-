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
#import "navBarViewController.h"
#import "CKViewController.h"
#import <Parse/Parse.h>


#import "departmentList.h"


@interface mainMenuView ()



@property (weak, nonatomic) IBOutlet UIImageView *background;
@property  CGRect actualFrame;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UIButton *scheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *checkListButton;
@property (strong, nonatomic) NSArray* todaysNotifs;
@property (nonatomic) CustomBadge* notifBadge;


@property (assign) int dept;
@property  (strong,nonatomic) NSMutableArray *tasks;

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
    [self.navigationController viewDidAppear:FALSE];
    
    //tasks for department list 
     self.tasks=[[NSMutableArray alloc] init];
    
    //set tags for 3 main menu buttons
    self.checkListButton.tag = 1;
    self.scheduleButton.tag = 2;
    self.notificationButton.tag = 3;
    
    
    //test -- ***NOT needed after login page is finished
    //[PFUser logInWithUsername: @"1456" password:@"1456"];
    
    //get current user
    PFUser* curr = [PFUser currentUser];
    
    //get dept to set background
    NSNumber* dept = curr[@"dept"];
   // NSString* name = curr[@"employeeName"];
    [self queryTodaysNotifications];

    //check the department to select appropriate background images
    if([dept  isEqual: @1])
    {
        self.dept=1;
        [self.background setImage:[UIImage  imageNamed: @"Kitchen.png"]];
    }
    else if([dept isEqual: @2])
    {
        self.dept=2;
        [self.background setImage:[UIImage imageNamed:@"Housekeeping.png"]];

    }
    else if([dept isEqual: @3])
    {
        self.dept=3;
        [self.background setImage:[UIImage imageNamed: @"Maintenance.png"]];
    }
    else
    {
        [self.background setImage:[UIImage imageNamed: @"Pin.png"]];
    }
    
    
    
    [self.navigationItem setHidesBackButton:YES];
     [self departmentList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController viewDidAppear:animated];
}


- (void) departmentList
{
    // NSLog(@" dept id: %d",self.dept);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    [query whereKey:@"dept" equalTo:@(self.dept)];
    [query whereKey:@"status" equalTo:@"true"];
    [query orderByAscending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %d scores.", objects.count);
            
            // Do something with the found objects
            for (PFObject *object in objects)
            {
                NSString *objectID=[object objectId];
                NSLog(@" Object id :%@",objectID);
                [self.tasks addObject:objectID];
            }
        }}];
    
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [self queryTodaysNotifications];
    [self.navigationController viewDidAppear:animated];
   
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
       // NSLog(@"Task");
        
        
    }
    else if(senderButton.tag == 2)
    {
       // NSLog(@"Sched");
        CKViewController* ckView = (CKViewController*) [segue destinationViewController];
        ckView.bgImage = self.background.image;
    }
    else
    {
        //send background pic to next view
        //NSLog(@"Noti");
        myNotificationViewController* notiView = (myNotificationViewController*) [segue destinationViewController];
        
        notiView.bgImage = self.background.image;
        
    }
    if([segue.identifier isEqualToString:@"departmentList"])
    {
        
        //mainMenuView  *m = (mainMenuView *) segue.destinationViewController;
        // m.userName=self.userName;
        //NSLog(@" department list segue calling");
        departmentList  *d= (departmentList *) segue.destinationViewController;
        
        d.view.opaque=true;
        // NSLog(@" Tasks count : %d",[self.tasks count]);
        d.tasks=self.tasks;
        
        
        
        
    }
        
}

-(void)popBack
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) queryTodaysNotifications
{
    //get current date from hour 0 min 0
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
    
    //if there are notifcations for today display a badge on notifications
    if(self.todaysNotifs.count != 0)
    {
        NSString* badgeNumber = [[NSNumber numberWithInt:self.todaysNotifs.count] stringValue];
    
        CGFloat newX = self.notificationButton.frame.origin.x + self.notificationButton.frame.size.width - 20;
        CGFloat newY = self.notificationButton.frame.origin.y - 20;
    
        //self.notifBadge = [[CustomBadge alloc] init];
        self.notifBadge = [CustomBadge customBadgeWithString: badgeNumber];
    
        [self.notifBadge setFrame: CGRectMake(newX, newY, 50, 50)];
        [self.notifBadge.badgeStyle setBadgeTextColor: [UIColor whiteColor]];
        [self.notifBadge.badgeStyle setBadgeInsetColor: [UIColor colorWithRed: 17.0/255.0 green: 101.0/255.0 blue: 168.0/255.0 alpha: 1.0]];
    
        [self.view addSubview:self.notifBadge];
        [self.view bringSubviewToFront:self.notifBadge];
    
        NSLog(@"Todays Notif Count = %ld", (unsigned long)self.todaysNotifs.count);
    
    }
    
}

@end
