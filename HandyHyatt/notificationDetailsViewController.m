//
//  notificationDetailsViewController.m
//  HandyHyatt
//
//  Created by Chris Portokalis on 11/16/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "notificationDetailsViewController.h"

@interface notificationDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeOnCalendarButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIImageView *divBar;


@property (strong, nonatomic) PFObject* thisNotifcation;


@end

@implementation notificationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController viewDidAppear:NO];
    //get data from push segue
    UIImage* sentBG = self.bgImage;
    self.thisNotifcation = self.selectedNotification;
    
    //setup UI from notification that was selected
    [self.background setImage: sentBG];
    [self setupViews];
    [self setLabelFont: self.nameLabel];
  
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setupViews
{
    NSString* titleText = self.thisNotifcation[@"title"];
    
    self.detailTextView.text = self.thisNotifcation[@"description"];
    self.detailTextView.editable = NO;
    self.titleLabel.text = self.thisNotifcation[@"title"];
    
    //get and display date from notification
   [self getRealDate: self.thisNotifcation.createdAt];
    
    
    
    if([titleText isEqualToString:@"Shift Change Request"])
    {
        //dont hide views
        self.acceptButton.hidden = NO;
        self.declineButton.hidden = NO;
        self.divBar.hidden = NO;
        self.nameLabel.hidden = NO;
       
        
        //get the current user
        PFUser* thisUser = [PFUser currentUser];
        
        
        self.nameLabel.text = thisUser[@"employeeName"];
        
    }
    else
    {
        //hide views
        self.acceptButton.hidden = YES;
        self.declineButton.hidden = YES;
        self.divBar.hidden = YES;
        self.nameLabel.hidden = YES;
    }
    
    
}


-(void)getRealDate: (NSDate*) notifDate {
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"EEEE, d MMMM"];
    NSString* dateString = [format stringFromDate: notifDate];
    
    
    self.dateLabel.text = dateString;
    
}


-(void)setLabelFont: (id) sender
{
    UILabel* thisLabel = (UILabel*) sender;
    
    /*for(NSString* family in [UIFont familyNames])
     {
     for(NSString* name in [UIFont fontNamesForFamilyName:family])
     {
     NSLog(@" %@", name);
     }
     }*/
    
    thisLabel.font = [UIFont fontWithName: @"BodoniSvtyTwoSCITCTT-Book" size: 32.0];
    thisLabel.textColor = [UIColor colorWithRed:17.0f/255.0f green:101.0f/255.0f blue:168.0f/255.0f alpha:1.0];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
