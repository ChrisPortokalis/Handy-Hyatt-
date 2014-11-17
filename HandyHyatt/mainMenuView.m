//
//  mainMenuView.m
//  HandyHyatt
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/10/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "mainMenuView.h"
#import "myNotificationViewController.h"
#import <Parse/Parse.h>

@interface mainMenuView ()

@property (weak, nonatomic) IBOutlet UIImageView *background;

@property  CGRect actualFrame;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UIButton *scheduleButton;
@property (weak, nonatomic) IBOutlet UIButton *checkListButton;

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
    
    //set tags for 3 main menu buttons
    self.checkListButton.tag = 1;
    self.scheduleButton.tag = 2;
    self.notificationButton.tag = 3;
    
    
    //test -- ***NOT needed after login page is finished
    [PFUser logInWithUsername: @"CP" password:@"0000"];
    
    //get current user
    PFUser* curr = [PFUser currentUser];
    
    //get dept to set background
    NSNumber* dept = curr[@"dept"];
    NSString* name = curr[@"employeeName"];

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

@end
