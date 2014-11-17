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
@property (strong, nonatomic) NSDate* segDate;

@end

@implementation notificationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //get data from push segue
    self.segDate = self.notifDate;
    PFUser* thisUser = [PFUser currentUser];
    UIImage* sentBG = self.bgImage;
    self.thisNotifcation = self.selectedNotification;
    
    //setup UI from notification that was selected
    [self.background setImage: sentBG];
    self.detailTextView.text = self.thisNotifcation[@"description"];
    self.detailTextView.editable = NO;
    self.titleLabel.text = self.thisNotifcation[@"title"];
    
    NSString* titleText = self.thisNotifcation[@"title"];
    
    if([titleText isEqualToString:@"Shift Change Request"])
    {
        self.acceptButton.hidden = NO;
        self.declineButton.hidden = NO;
        self.divBar.hidden = NO;
    }
    else
    {
        self.acceptButton.hidden = YES;
        self.declineButton.hidden = YES;
        self.divBar.hidden = YES;
    }
    
    
    self.nameLabel.text = thisUser[@"employeeName"];
    [self getRealDate: self.thisNotifcation.createdAt];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getRealDate: (NSDate*) notifDate {
    
   // NSDateComponents* components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate: notifDate];
    [components setCalendar: calendar];
    NSInteger monthInt = [components month];
    
    NSLog([NSString stringWithFormat:@"Month = %ld", (long)monthInt]);
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"EEEE, d MMMM"];
    NSString* dateString = [format stringFromDate: notifDate];
    

    self.dateLabel.text = dateString;
    
}

-(NSString*)getMonthString: (NSInteger) month
{
    
    int monthInt = month;
    
    //NSLog([NSString stringWithFormat: @"Month int = %ld", monthInt]);
    
    if(monthInt == 1)
    {
        return @"Jan";
    }
    else if(monthInt == 2)
    {
        return @"Feb";
    }
    else if(monthInt == 3)
    {
        return @"Mar";
    }
    else if(monthInt == 4)
    {
        return @"Apr";
    }
    else if(monthInt == 5)
    {
        return @"May";
    }
    else if(monthInt == 6)
    {
        return @"Jun";
    }
    else if(monthInt == 7)
    {
        return @"Jul";
    }
    else if(monthInt == 8)
    {
        return @"Aug";
    }
    else if(monthInt == 9)
    {
        return @"Sep";
    }
    else if(monthInt == 10)
    {
        return @"Oct";
    }
    else if(monthInt == 11)
    {
        return @"Nov";
    }
    else if(monthInt == 12)
    {
        return @"Dec";
    }
    else
    {
        return @"Error unknown date";
    }
    
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
