//
//  navBarViewController.m
//  HandyHyatt
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/12/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "navBarViewController.h"
#import <Parse/Parse.h>
#import "loginView.h"

@interface navBarViewController ()

@property (strong, nonatomic) IBOutlet UILabel *alertClockStatus;
@property (strong, nonatomic) IBOutlet UILabel *alertTime;
@property (strong, nonatomic) IBOutlet UILabel *alertDate;
@property (strong, nonatomic) IBOutlet UILabel *alertEmpName;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (strong,nonatomic) IBOutlet UIButton *alertClose;
@property (strong, nonatomic) IBOutlet UIView* titleView;

@property(strong,nonatomic) IBOutlet UIView *clockAlertView;
@property (assign) Boolean alertClockOutStatus;
@property (strong,nonatomic) IBOutlet UILabel *clockoutTitle;
@property (strong,nonatomic) IBOutlet UILabel *clockoutSubtitle;
@property (strong,nonatomic) IBOutlet UIButton *clockoutClose;
@property (strong,nonatomic) IBOutlet UIButton *clockoutAccept;


@property (strong,nonatomic) IBOutlet UIView *logoutAlertView;
@property(strong,nonatomic) IBOutlet UIBarButtonItem *logoutButton;


@property (strong,nonatomic) IBOutlet UILabel *navClockStatus;
@property (strong,nonatomic) IBOutlet UIButton *navClockButton;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *userObjectid;
@property (strong,nonatomic) NSString *clockStatus;
@property (assign) int dept;
@property  (strong,nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSString* timeLeft;
@property (strong, nonatomic) NSString* hoursLeft;
@property (strong, nonatomic) NSString* minsLeft;
@property int secsLeft;
@property (strong, nonatomic) NSTimer* shiftTimer;
@property bool status;
@property bool startTimer;
@property bool shiftIsOver;


@end

@implementation navBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (IBAction)logout:(id)sender
{
    [self createLogoutAlertView];
}

- (void) createLogoutAlertView
{
    // creating a alert view
    CGRect frame1 = CGRectMake(150.0, 300.0, 720.0, 250.0);
    self.logoutAlertView = [[UIView alloc] initWithFrame:frame1];
    [self.logoutAlertView setBackgroundColor:[UIColor whiteColor]];
    
    //creating close button
    self.alertClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertClose addTarget:self
                        action:@selector(closelogoutAlertView)
              forControlEvents:UIControlEventTouchUpInside];
    [self.alertClose setBackgroundImage:[UIImage imageNamed:@"PopUp_ExitX.png"] forState:UIControlStateNormal];
    self.alertClose.frame = CGRectMake(680.0, 20.0, 20.0, 20.0);
    [self.logoutAlertView addSubview:self.alertClose];
    
    
    //creating title label
    self.alertEmpName= [[UILabel alloc] initWithFrame:CGRectMake(180.0, 60.0, 50.0, 50.0)];
    [self.alertEmpName setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                    green:130.0f/255.0f
                                                     blue:132.0f/255.0f
                                                    alpha:1.0f]];
    [self.alertEmpName setFont:[UIFont fontWithName:@"Verdana" size:24]];
    [self.alertEmpName setText:@"Are you sure you want to"];
    [self.alertEmpName sizeToFit];
    [self.logoutAlertView addSubview:self.alertEmpName];
    
    //creating subtitle label Bookman OldStyle - replaced by Bodoni 72 OldStyle
    self.alertDate= [[UILabel alloc] initWithFrame:CGRectMake(240.0, 90.0, 80.0, 80.0)];
    [self.alertDate setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                 green:130.0f/255.0f
                                                  blue:132.0f/255.0f
                                                 alpha:1.0f]];
    [self.alertDate setFont:[UIFont fontWithName:@"Bodoni 72 OldStyle" size:60]];
    [self.alertDate setText:@"log out?"];
    [self.alertDate sizeToFit];
    [self.logoutAlertView addSubview:self.alertDate];
    
    
    //creating accept button
    UIButton *alertAccept = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertAccept addTarget:self
                    action:@selector(alertLogoutAccepted)
          forControlEvents:UIControlEventTouchUpInside];
    alertAccept.frame = CGRectMake(280.0, 180.0, 50.0, 50.0);
    alertAccept.titleLabel.font=[UIFont fontWithName:@"Verdana" size:25];
    [alertAccept setTitleColor:[UIColor colorWithRed:17.0f/255.0f
                                               green:101.0f/255.0f
                                                blue:168.0f/255.0f
                                               alpha:1.0f] forState:(UIControlStateNormal)];
    [alertAccept setTitle:@"ACCEPT" forState:UIControlStateNormal];
    [alertAccept sizeToFit];
    [self.logoutAlertView addSubview:alertAccept];
    
    [self.view addSubview:self.logoutAlertView];
    
}

- (void) alertLogoutAccepted
{
    self.logoutAlertView.hidden=true;
    [self.logoutAlertView  removeFromSuperview];
    if([PFUser currentUser]!=nil)
    {
        [PFUser logOut];
    }
    [self popToRootViewControllerAnimated:NO];
}

- (void) closelogoutAlertView
{
    self.logoutAlertView.hidden=true;
    [self.logoutAlertView  removeFromSuperview];
}



- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController

{
    
    
    if(![viewController isKindOfClass:[loginView class]])
    {
    //creating logout bar button
    self.logoutButton =[[UIBarButtonItem alloc] initWithTitle:@"LOG OUT" style:UIBarButtonItemStyleBordered target:self
                                                       action:@selector(logout:)];
    
    
    [self.logoutButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIFont fontWithName:@"Verdana" size:18.0], NSFontAttributeName,
                                               [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:1.0f], NSForegroundColorAttributeName,
                                               nil]
                                     forState:UIControlStateNormal];
    
    viewController.navigationItem.rightBarButtonItem = self.logoutButton;
    
    
    UIImage *unclockedImage = [UIImage imageNamed:@"TabBar_Clock_ClockedOut.png"];
    UIImage *clockedImage =   [UIImage imageNamed:@"TabBar_Clock_ClockedIn.png"];
    if([PFUser currentUser] != nil)
    {
        [self setTimer];
    PFUser* user = [PFUser currentUser];
    
    self.userName = user[@"employeeName"];
    self.alertEmpName.text=self.userName;
    [self.alertEmpName sizeToFit];
    
    // create clock button, name label and clock staus label on navigation bar
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    self.titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setFrame:CGRectMake(50,20,100,20)];
    [nameLabel setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                            green:130.0f/255.0f
                                             blue:132.0f/255.0f
                                            alpha:1.0f]];
    [nameLabel setFont:[UIFont fontWithName:@"Verdana" size:14]];
    [nameLabel setText:self.userName];
    [nameLabel sizeToFit];
    [self.titleView addSubview:nameLabel];
    
    
    self.navClockStatus = [[UILabel alloc] init];
    [self.navClockStatus setFrame:CGRectMake(50,-5,150,20)];
    
    [self.navClockStatus setFont:[UIFont fontWithName:@"Verdana" size:24]];
    [self.titleView addSubview:self.navClockStatus];
    
    
    self.navClockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navClockButton setFrame:CGRectMake(0, -5, 44, 44)];
    [self.navClockButton addTarget:self action:@selector(puncherAction) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:self.navClockButton];
    self.tasks=[[NSMutableArray alloc] init];
    self.userObjectid = [user objectId];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:user.username];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if (error)
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
             
             
             
             
         } else
         {
             // checking user punchin/punchout status
             PFQuery *query = [PFQuery queryWithClassName:@"Clock"];
             [query whereKey:@"user" equalTo:user.username];
             [query orderByDescending:@"updatedAt"];
             [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
              {
                  
                  if (error)
                  {
                      NSLog(@"Error: %@ %@", error, [error userInfo]);
                      self.clockStatus=@"Clocked Out";
                      [self.navClockButton setImage:unclockedImage forState:UIControlStateNormal];
                      [self.navClockStatus setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                                        green:130.0f/255.0f
                                                                         blue:132.0f/255.0f
                                                                        alpha:1.0f]];
                      [self.navClockStatus setText: @"CLOCKED OUT"];
                      [self.navClockStatus sizeToFit];
                      viewController.navigationItem.titleView = self.titleView;
                      
                  }
                  else
                  {
                      //bool status=false;
                      self.status=[[object objectForKey:@"status"] boolValue];
                      // status true indicates he logged in and not logged out
                      if(self.status == true)
                      {
                          
                          
                          [self.navClockButton setImage:clockedImage forState:UIControlStateNormal];
                          
                          // get the time left to work
                          //NSString *punchedInTime=object[@"punchIn"];
                          // NSString *timeWorked = [self getTimeWorked:punchedInTime];
                          [self.navClockStatus setTextColor:[UIColor colorWithRed:255.0f/255.0f
                                                                            green:255.0f/255.0f
                                                                             blue:255.0f/255.0f
                                                                            alpha:1.0f]];
                          
                          //[self setTimer];
                          [self.navClockStatus setText:self.timeLeft];
                          [self.navClockStatus sizeToFit];
                          
                          
                          viewController.navigationItem.titleView = self.titleView;
                          
                      }
                      else
                      {
                          self.clockStatus=@"Clocked Out";
                          [self.navClockButton setImage:unclockedImage forState:UIControlStateNormal];
                          [self.navClockStatus setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                                            green:130.0f/255.0f
                                                                             blue:132.0f/255.0f
                                                                            alpha:1.0f]];
                          [self.navClockStatus setText: @"CLOCKED OUT"];
                          [self.navClockStatus sizeToFit];
                          viewController.navigationItem.titleView = self.titleView;
                      }
                  }}];
         }
     }];
    
    }
    }
    else if([viewController isKindOfClass:[loginView class]])
    {
        NSLog(@"login view title view");
        // create compnay logo image on navigation bar at titleview*/
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titleView.backgroundColor = [UIColor clearColor];
        
        UIImageView *titleImage=[[UIImageView alloc ] initWithFrame:CGRectMake(0, -5, 200, 50)];
        titleImage.image=[UIImage imageNamed:@"TabBar_Logo_PinScreen1.png"];
        [titleView addSubview:titleImage];
        [viewController.navigationItem.titleView addSubview:titleImage];
        
    }
}


- (void)viewDidLoad
{

    [super viewDidLoad];

    self.shiftIsOver = false;
    
    [self.navigationBar setBackgroundColor: [UIColor clearColor]];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"TabBar_Background.png"]forBarMetrics: UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    [self setNavBackButton];
    

    
    CGRect frame1 = CGRectMake(150.0, 300.0, 720.0, 250.0);
    self.alertView = [[UIView alloc] initWithFrame:frame1];
    [self.alertView setBackgroundColor:[UIColor whiteColor]];
    
    //creating close button
    self.alertClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.alertClose addTarget:self
                        action:@selector(closeAlertView)
              forControlEvents:UIControlEventTouchUpInside];
    [self.alertClose setBackgroundImage:[UIImage imageNamed:@"PopUp_ExitX.png"] forState:UIControlStateNormal];
    self.alertClose.frame = CGRectMake(680.0, 20.0, 20.0, 20.0);
    [self.alertView addSubview:self.alertClose];
    
    
    //creating employee name label
    self.alertEmpName= [[UILabel alloc] initWithFrame:CGRectMake(200.0, 60.0, 50.0, 50.0)];
    [self.alertEmpName setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                    green:130.0f/255.0f
                                                     blue:132.0f/255.0f
                                                    alpha:1.0f]];
    [self.alertEmpName setFont:[UIFont fontWithName:@"Verdana" size:40]];
    [self.alertEmpName sizeToFit];
    [self.alertView addSubview:self.alertEmpName];
    
    //creating date label
    self.alertDate= [[UILabel alloc] initWithFrame:CGRectMake(220.0, 120.0, 50.0, 50.0)];
    [self.alertDate setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                 green:130.0f/255.0f
                                                  blue:132.0f/255.0f
                                                 alpha:1.0f]];
    [self.alertDate setFont:[UIFont fontWithName:@"Verdana" size:24]];
    [self.alertView addSubview:self.alertDate];
    
    
    //creating alert clock status    Bookman OldStyle - replaced by Verdana-Bold
    self.alertClockStatus= [[UILabel alloc] initWithFrame:CGRectMake(100.0, 160.0, 50.0, 50.0)];
    [self.alertClockStatus setTextColor:[UIColor colorWithRed:17.0f/255.0f
                                                        green:101.0f/255.0f
                                                         blue:168.0f/255.0f
                                                        alpha:1.0f]];
    [self.alertClockStatus setFont:[UIFont fontWithName:@"Verdana-Bold" size:35]];
    [self.alertView addSubview:self.alertClockStatus];
    
    //creating image view
    UIImageView *separator=[[UIImageView alloc] initWithFrame:CGRectMake(360.0, 160.0, 5.0, 50.0)];
    separator.image=[UIImage imageNamed:@"PopUp_DividerLine.png"];
    [self.alertView addSubview:separator];
    
    //creating time label
    self.alertTime= [[UILabel alloc] initWithFrame:CGRectMake(400.0, 160.0, 50.0, 50.0)];
    [self.alertTime setTextColor:[UIColor colorWithRed:17.0f/255.0f
                                                 green:101.0f/255.0f
                                                  blue:168.0f/255.0f
                                                 alpha:1.0f]];
    [self.alertTime setFont:[UIFont fontWithName:@"Verdana-Bold" size:35]];
    [self.alertView addSubview:self.alertTime];
    
    //hiding the alert view
    self.alertView.hidden=YES;
    
    
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    [self setNavBackButton];
    [self setNeedsStatusBarAppearanceUpdate];
    
    if([PFUser currentUser] != nil)
    {
        [self navigationController:self didShowViewController:self.topViewController];
    }
}

-(void) setNavBackButton
{
    //set back button arrow color
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //set back button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    //set back button arrow color
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)popBack
{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void) puncherAction
{
    NSDate *now = [[NSDate alloc] init];
    [self getRealDate];
    [self getRealTime];
    
    PFUser *user=[PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Clock"];
    [query whereKey:@"user" equalTo:user.username];
    [query orderByDescending:@"updatedAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if (error)
         {
             // Log details of the failure
             //NSLog(@"Error: %@ %@", error, [error userInfo]);
             
             self.alertClockStatus.text=@"Clocked In";
             [self.alertClockStatus sizeToFit];
             
             // change navigation bar status to time left and clock images to clockedin image
             UIImage *clockedImage =   [UIImage imageNamed:@"TabBar_Clock_ClockedIn.png"];
             [self.navClockButton setImage:clockedImage forState:UIControlStateNormal];
             
             [self.navClockStatus setTextColor:[UIColor colorWithRed:255.0f/255.0f
                                                               green:255.0f/255.0f
                                                                blue:255.0f/255.0f
                                                               alpha:1.0f]];
             self.navClockStatus.text = self.timeLeft;
             [self.navClockStatus sizeToFit];
             
             if(self.shiftTimer == nil)
             {
                 [self setTimer];
                 self.shiftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                    target:self
                                                                  selector:@selector(controlTimer)
                                                                  userInfo:nil repeats:YES];
             }
             
             PFObject *punchIn = [PFObject objectWithClassName:@"Clock"];
             punchIn[@"user"] = user.username;
             punchIn[@"punchIn"] = now;
             punchIn[@"status"] = @YES;
             [punchIn saveInBackground];
             [self displayAlertView];
             
             
         }
         else if(error.code==101)
         {
             self.alertClockStatus.text=@"Clocked In";
             [self.alertClockStatus sizeToFit];
            
             
             // change navigation bar status to time left and clock images to clockedin image
             UIImage *clockedImage =   [UIImage imageNamed:@"TabBar_Clock_ClockedIn.png"];
             [self.navClockButton setImage:clockedImage forState:UIControlStateNormal];
             
             [self.navClockStatus setTextColor:[UIColor colorWithRed:255.0f/255.0f
                                                               green:255.0f/255.0f
                                                                blue:255.0f/255.0f
                                                               alpha:1.0f]];
             self.navClockStatus.text = self.timeLeft;
             [self.navClockStatus sizeToFit];
             
             if(self.shiftTimer == nil)
             {
                 [self setTimer];
                 self.shiftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                    target:self
                                                                  selector:@selector(controlTimer)
                                                                  userInfo:nil repeats:YES];
                 
             }
             
             PFObject *punchIn = [PFObject objectWithClassName:@"Clock"];
             punchIn[@"user"] = user.username;
             punchIn[@"punchIn"] = now;
             punchIn[@"status"] = @YES;
             [punchIn saveInBackground];
             [self displayAlertView];

             
         }
         else
         {
             //self.alertClockOutStatus=false;
             self.status=[[object objectForKey:@"status"] boolValue];
             if(self.status==YES)
             {
                 // display clock out alert view
                 [self createClockOutAlertView];
                 
             }
             else
             {
                 
                 self.alertClockStatus.text=@"Clocked In";
                 [self.alertClockStatus sizeToFit];
                 
                 // change navigation bar status to time left and clock images to clockedin image
                 UIImage *clockedImage =   [UIImage imageNamed:@"TabBar_Clock_ClockedIn.png"];
                 [self.navClockButton setImage:clockedImage forState:UIControlStateNormal];
                 
                 [self.navClockStatus setTextColor:[UIColor colorWithRed:255.0f/255.0f
                                                                   green:255.0f/255.0f
                                                                    blue:255.0f/255.0f
                                                                   alpha:1.0f]];
                 self.navClockStatus.text = self.timeLeft;
                 [self.navClockStatus sizeToFit];
                 
                 if(self.shiftTimer == nil)
                 {
                     [self setTimer];
                     self.shiftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                        target:self
                                                                      selector:@selector(controlTimer)
                                                                      userInfo:nil repeats:YES];
                     
                 }
                 
                 PFObject *punchIn = [PFObject objectWithClassName:@"Clock"];
                 punchIn[@"user"] = user.username;
                 punchIn[@"punchIn"] = now;
                 punchIn[@"status"] = @YES;
                 [punchIn saveInBackground];
                 [self displayAlertView];
                 
             }
         }
     }];

    
    
    
}


- (void) displayAlertView
{
    self.alertView.hidden=NO;
    [self.view addSubview:self.alertView];
    [self attachPopUpAnimation];
    
    
    
}

- (void) createClockOutAlertView
{
    // creating a alert view
    CGRect frame1 = CGRectMake(150.0, 300.0, 720.0, 250.0);
    self.clockAlertView = [[UIView alloc] initWithFrame:frame1];
    [self.clockAlertView setBackgroundColor:[UIColor whiteColor]];
    
    //creating close button
     self.clockoutClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clockoutClose addTarget:self
                   action:@selector(closeClockOutAlertView)
         forControlEvents:UIControlEventTouchUpInside];
    [self.clockoutClose setBackgroundImage:[UIImage imageNamed:@"PopUp_ExitX.png"] forState:UIControlStateNormal];
    self.clockoutClose.frame = CGRectMake(680.0, 20.0, 20.0, 20.0);
    [self.clockAlertView addSubview:self.clockoutClose];
    
    
    //creating title label
    self.clockoutTitle= [[UILabel alloc] initWithFrame:CGRectMake(180.0, 60.0, 50.0, 50.0)];
    [self.clockoutTitle setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                             green:130.0f/255.0f
                                              blue:132.0f/255.0f
                                             alpha:1.0f]];
    [self.clockoutTitle setFont:[UIFont fontWithName:@"Verdana" size:24]];
    [self.clockoutTitle setText:@"Are you sure you want to"];
    [self.clockoutTitle sizeToFit];
    [self.clockAlertView addSubview:self.clockoutTitle];
    
    //creating subtitle label Bookman OldStyle - replaced by Bodoni 72 OldStyle
     self.clockoutSubtitle= [[UILabel alloc] initWithFrame:CGRectMake(240.0, 90.0, 80.0, 80.0)];
    [self.clockoutSubtitle setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                green:130.0f/255.0f
                                                 blue:132.0f/255.0f
                                                alpha:1.0f]];
    [self.clockoutSubtitle setFont:[UIFont fontWithName:@"Bodoni 72 OldStyle" size:60]];
    [self.clockoutSubtitle setText:@"clock out?"];
    [self.clockoutSubtitle sizeToFit];
    [self.clockAlertView addSubview:self.clockoutSubtitle];
    
    
    //creating accept button
     self.clockoutAccept = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clockoutAccept addTarget:self
                    action:@selector(alertClockOutAccepted)
          forControlEvents:UIControlEventTouchUpInside];
    self.clockoutAccept.frame = CGRectMake(280.0, 180.0, 50.0, 50.0);
    self.clockoutAccept.titleLabel.font=[UIFont fontWithName:@"Verdana" size:25];
    [self.clockoutAccept setTitleColor:[UIColor colorWithRed:17.0f/255.0f
                                               green:101.0f/255.0f
                                                blue:168.0f/255.0f
                                               alpha:1.0f] forState:(UIControlStateNormal)];
    [self.clockoutAccept setTitle:@"ACCEPT" forState:UIControlStateNormal];
    [self.clockoutAccept sizeToFit];
    [self.clockAlertView addSubview:self.clockoutAccept];
    
    [self.view addSubview:self.clockAlertView];
    
}

- (void) alertClockOutAccepted
{
    NSDate *now = [[NSDate alloc] init];
    
    self.clockAlertView.hidden=true;
    [self.clockAlertView removeFromSuperview];
    
    self.alertClockStatus.text=@"Clocked Out";
    [self.alertClockStatus sizeToFit];
    [self.shiftTimer invalidate];
    
    self.shiftTimer = nil;
    
     // change navigation bar status to clocked out and image to unclocked image
    UIImage *unclockedImage = [UIImage imageNamed:@"TabBar_Clock_ClockedOut.png"];
    [self.navClockButton setImage:unclockedImage forState:UIControlStateNormal];
    [self.navClockStatus setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                      green:130.0f/255.0f
                                                       blue:132.0f/255.0f
                                                      alpha:1.0f]];
    self.navClockStatus.text=@"CLOCKED OUT";
    [self.navClockStatus sizeToFit];
    
    PFUser *user=[PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Clock"];
    [query whereKey:@"user" equalTo:user.username];
    [query orderByDescending:@"updatedAt"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         object[@"status"]=@NO;
         object[@"punchOut"]=now;
         [object saveInBackground];
     }];


    [self displayAlertView];
}

- (void) closeClockOutAlertView
{
    self.clockAlertView.hidden=true;
    [self.clockAlertView removeFromSuperview];
    
    
}



-(void) getRealDate
{
    NSDate *notifDate=[[NSDate alloc] init];
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"d MMMM YYYY"];
    NSString* dateString = [format stringFromDate: notifDate];
    
    self.alertDate.text = dateString;
    [self.alertDate sizeToFit];
    
}

- (void) getRealTime
{
    NSDate *notifDate=[[NSDate alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@" hh:mma "];
    NSString* timeString = [df stringFromDate: notifDate];
    self.alertTime.text=timeString;
    [self.alertTime sizeToFit];
    
}

// to get time left


- (void) attachPopUpAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    //[self.layer addAnimation:animation forKey:@"popup"];
}


- (void)closeAlertView
{
    self.alertView.hidden=true;
    [self.alertView removeFromSuperview];
}

-(void)controlTimer
{
    NSInteger hours = [self.hoursLeft integerValue];
    NSInteger mins = [self.minsLeft integerValue];
    
    //bool to flag if shift is over
   // bool shiftIsOver = false;
    
    self.secsLeft--;
    if(self.secsLeft == 0)
    {
        mins--;
        if(mins <= 0)
        {
            if(hours <= 0)
            {
                self.navClockStatus.text = @"Shift Over";
                self.shiftIsOver = true;
            }
            else
            {
                hours--;
                mins = 59;
            }
        }
        
        self.secsLeft = 59;
    }
    

    if(hours <= 0 && mins <= 0)
    {
        //shiftIsOver = true;
    }
    
    //set strings for hours and mins
    self.hoursLeft = [NSString stringWithFormat:@"%ld", (long)hours];
    self.minsLeft = [NSString stringWithFormat:@"%ld", (long)mins];
    
    
    if(self.shiftIsOver)
    {
       
        [self.shiftTimer invalidate];
        self.shiftTimer = nil;
        
    }
    else
    {
        //set timer label
       self.timeLeft = [NSString stringWithFormat:@"%@H %@M" , self.hoursLeft, self.minsLeft];
    }
    
    //check status of user
    if([PFUser currentUser] != nil)
    {
        PFUser *user=[PFUser currentUser];
        PFQuery *query = [PFQuery queryWithClassName:@"Clock"];
        [query whereKey:@"user" equalTo:user.username];
        [query orderByDescending:@"updatedAt"];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
            bool status = [object[@"status"] boolValue];
             if(error)
             {
                 NSLog(@"Error with timer");
                 //self.navClockStatus.text = @"CLOCKED OUT";
                 [self.shiftTimer invalidate];
                 self.shiftTimer = nil;
             
             }
             else
             {
                 
             
                 if(status)
                 {
                     self.navClockStatus.text = self.timeLeft;
                 }
             
             }
    
         }];
    }
    
}

-(void)setTimer
{
    if([PFUser currentUser] != nil)
    {
        PFUser* user = [PFUser currentUser];
        //get start time of today 0:00:00
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *todayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour| NSCalendarUnitMinute fromDate:now];
        [todayComponents setHour: 0];
        [todayComponents setMinute: 0];
        [todayComponents setSecond: 0];
        [todayComponents setNanosecond:0];
        NSDate* today = [calendar dateFromComponents:todayComponents];
    
    //get actual time today
        NSDateComponents *todayActualComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour| NSCalendarUnitMinute fromDate:now];
        [todayActualComp setMinute: [todayActualComp minute] - 30];
        NSDate* todayActual = [calendar dateFromComponents:todayActualComp];
    
        NSDateComponents *upper = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:now];
        [upper setHour: [upper hour] + 13];
    
        NSDate* upperDate = [calendar dateFromComponents:upper];
    
    //query for schedule that is today but ending after current time
        PFQuery* schedQuery = [PFQuery queryWithClassName:@"Schedule"];
        [schedQuery whereKey:@"from" greaterThan:today];
        [schedQuery whereKey:@"from" lessThan:upperDate];
        [schedQuery whereKey:@"to" greaterThan:todayActual];
        [schedQuery whereKey:@"user" equalTo:user];
        [schedQuery orderByAscending:@"from"];
        [schedQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
            if(!error)
            {
                //self.todayArr = [[NSArray alloc] initWithArray: results];
                if(results.count != 0)
                {
                    //grab first object
                    PFObject *obj = results[0];
                
                    //setup up calendar and get time left from now till end of shift
                    NSDate* to = obj[@"to"];
                    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
                    NSDateComponents *components = [calendar components:unitFlags
                                                                    fromDate:now
                                                                      toDate:to
                                                                     options:0];
                    int hours = [components hour];
                    int mins = [components minute];
                    self.secsLeft = [components second];
                
                    if(hours <= 0 && mins <= 0)
                    {
                        //if shift over
                        self.timeLeft = @"Shift Over";
                        self.shiftIsOver = true;
                        [self.shiftTimer invalidate];
                        self.shiftTimer = nil;
                    }
                
                    else
                    {
                        //set label for timer
                        self.hoursLeft = [NSString stringWithFormat:@"%ld", (long) hours];
                        self.minsLeft = [NSString stringWithFormat:@"%ld", (long) mins];
                        self.timeLeft = [NSString stringWithFormat:@" %@H %@M", self.hoursLeft, self.minsLeft];
                    }
                    
                    if(self.shiftTimer == nil)
                    {
                        self.shiftTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                           target:self
                                                                         selector:@selector(controlTimer)
                                                                         userInfo:nil repeats:YES];
                        
                    }
                    
                }
                else
                {
                    //no scheduled time so clocked in appears
                    self.timeLeft = @"CLOCKED IN";
                    [self.shiftTimer invalidate];
                    self.shiftTimer = nil;
                }
            
            
            }
            else
            {
                NSLog(@"Error in query for setTimer in navBarController.m");
            }
        }];
        
    }
    
    
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



@end
