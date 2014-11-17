//
//  myNotificationViewController.m
//  HandyHyatt
//
//  Created by Chris Portokalis on 11/13/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "myNotificationViewController.h"
#import "notificationDetailsViewController.h"

@interface myNotificationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray* notifArray;
@property (strong, nonatomic) NSDate* notifDate;


@end

@implementation myNotificationViewController
@synthesize tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //get bgImage from push Segue
    UIImage* bg = self.bgImage;
    
    //setup background ImageView  and tableView color
    [self.background setImage: bg];
    [self.tableView setBackgroundColor: [UIColor clearColor]];

    //get todays date so notifications from today are the only ones displayed
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute: 0];
    NSDate *today = [calendar dateFromComponents:components];
    
    //set notification array from pfQuery that gets notifications only from today
    PFQuery* notifQuery = [PFQuery queryWithClassName:@"Notifications"];
    [notifQuery whereKey:@"createdAt" greaterThan: today];
    [notifQuery orderByDescending:@"createdAt"];
    self.notifArray = [notifQuery findObjects];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.notifArray.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
 
     [cell setBackgroundColor:[UIColor clearColor]];
     
     PFObject* notification = self.notifArray[indexPath.row];
     
     cell.textLabel.text = notification[@"title"];
    
    return cell;
 }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedNotification = self.notifArray[indexPath.row];
    //self.notifDate = self.selectedNotification[@"createdAt"];
    
    [self performSegueWithIdentifier:@"notificationToDetail" sender: self];

}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    notificationDetailsViewController* destView = (notificationDetailsViewController*) [segue destinationViewController];
    
    destView.bgImage = self.bgImage;
    destView.notifDate = self.notifDate;
    destView.selectedNotification = self.selectedNotification;
    
    
}

@end
