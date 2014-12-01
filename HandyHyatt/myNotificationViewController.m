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


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *screenTitleLabel;
@property (strong, atomic) NSArray* todayArr;
@property (strong, atomic) NSArray* yesterdayArr;
@property (strong, atomic) NSArray* dayBeforeArr;
@property (strong, atomic) NSArray* twoDaysBeforeArr;
@property (strong, atomic) NSArray* threeDaysBeforeArr;
@property (strong, atomic) NSArray* fourDaysBeforeArr;
@property (strong, atomic) NSArray* fiveDaysBeforeArr;
@property (strong, nonatomic) NSMutableArray* sectionArr;
@property (strong, atomic) NSArray* test;


@end

@implementation myNotificationViewController
@synthesize tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.navigationController viewDidAppear:NO];
    //get bgImage from push Segue
    UIImage* bg = self.bgImage;
    
    //setup background ImageView  and tableView color
    [self.background setImage: bg];
    [self.tableView setBackgroundColor: [UIColor clearColor]];

    //get todays date so notifications from today are the only ones displayed
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;


    [self queryDBforNotifications];
    [self setLabelFont:self.screenTitleLabel];
    //[self initSectionArr];
    //[self.tableView reloadData];
    
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self.navigationController viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    thisLabel.font = [UIFont fontWithName: @"BodoniSvtyTwoSCITCTT-Book" size: 40.0];
    thisLabel.textColor = [UIColor colorWithRed:17.0f/255.0f green:101.0f/255.0f blue:168.0f/255.0f alpha:1.0];
    
    
    
    
}

-(void) queryDBforNotifications
{
    //get date min date for now
    PFUser* user = [PFUser currentUser];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [todayComponents setHour:0];
    [todayComponents setMinute: 0];
    [todayComponents setSecond: 0];
    [todayComponents setNanosecond:0];
    
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    NSLog(@"%@", today);
    
    NSDateComponents* yesterdayComponents = todayComponents;
    [yesterdayComponents setDay: [todayComponents day] - 1];
    NSDate *yesterday = [calendar dateFromComponents: yesterdayComponents];
    
    NSLog(@"%@", yesterday);
    
    NSDateComponents* dayBeforeComp = yesterdayComponents;
    [dayBeforeComp setDay: [yesterdayComponents day] - 1];
    NSDate *dayBefore = [calendar dateFromComponents: dayBeforeComp];
    
    NSDateComponents* twoDaysBeforeComp = dayBeforeComp;
    [twoDaysBeforeComp setDay: [dayBeforeComp day] - 1];
    NSDate *twoDaysBefore = [calendar dateFromComponents:twoDaysBeforeComp];
    
    NSDateComponents* threeDaysBeforeComp = twoDaysBeforeComp;
    [threeDaysBeforeComp setDay: [twoDaysBeforeComp day] - 1];
    NSDate* threeDaysBefore = [calendar dateFromComponents:threeDaysBeforeComp];
    
    NSDateComponents* fourDaysBeforeComp = threeDaysBeforeComp;
    [fourDaysBeforeComp setDay: [threeDaysBeforeComp day] - 1];
    NSDate* fourDaysBefore = [calendar dateFromComponents:fourDaysBeforeComp];

    NSDateComponents* fiveDaysBeforeComp = fourDaysBeforeComp;
    [fiveDaysBeforeComp setDay: [fourDaysBeforeComp day]- 1];
    NSDate* fiveDaysBefore = [calendar dateFromComponents:fiveDaysBeforeComp];
    
    NSNumber *x = user[@"dept"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"dept = 0 OR dept = %@", x];
    
    
    
    
    //set notification array from pfQuery that gets notifications only from today
    PFQuery* notifQuery = [PFQuery queryWithClassName:@"Notifications" predicate:predicate];
    [notifQuery whereKey:@"createdAt" greaterThan: today];
    [notifQuery orderByDescending:@"createdAt"];
    [notifQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
    
        if(!error)
        {
            self.todayArr = [[NSArray alloc] initWithArray: results];
        }
        else
        {
            NSLog(@"Error today query");
        }
        
        [self initSectionArr];
        [self.tableView reloadData];
    
    }];

    PFQuery* minYestQuery = [PFQuery queryWithClassName: @"Notifications" predicate:predicate];
    [minYestQuery whereKey:@"createdAt" lessThan: today];
    [minYestQuery whereKey:@"createdAt" greaterThan: yesterday];
    [minYestQuery orderByDescending:@"createdAt"];
    [minYestQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
        if(!error)
        {
            self.yesterdayArr = [[NSArray alloc] initWithArray: results];
        }
        else
        {
            NSLog(@"Error yesterday query");
        }
        [self initSectionArr];
        [self.tableView reloadData];
        
       
    }];
    
    PFQuery* oneDayQuery = [PFQuery queryWithClassName: @"Notifications" predicate:predicate];
    [oneDayQuery whereKey:@"createdAt" lessThan: yesterday];
    [oneDayQuery whereKey:@"createdAt" greaterThan: dayBefore];
    [oneDayQuery orderByDescending:@"createdAt"];
    [oneDayQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
        if(!error)
        {
            self.dayBeforeArr = [[NSArray alloc] initWithArray: results];
        }
        else
        {
            NSLog(@"Error day before query");
        }
        [self initSectionArr];
        [self.tableView reloadData];
        
    }];
    
    PFQuery* twoDayQuery = [PFQuery queryWithClassName: @"Notifications" predicate:predicate];
    [twoDayQuery whereKey:@"createdAt" lessThan: dayBefore];
    [twoDayQuery whereKey:@"createdAt" greaterThan: twoDaysBefore];
    [twoDayQuery orderByDescending:@"createdAt"];
    //self.twoDaysBeforeArr = [twoDayQuery findObjects];
    [twoDayQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
        if(!error)
        {
            self.twoDaysBeforeArr = [[NSArray alloc] initWithArray: results];
        }
        else
        {
            NSLog(@"Error two day query");
        }
        
        [self initSectionArr];
        [self.tableView reloadData];
    }];
    
    PFQuery* threeDaysBeforeQuery = [PFQuery queryWithClassName:@"Notifications" predicate:predicate];
    [threeDaysBeforeQuery whereKey: @"createdAt" lessThan: twoDaysBefore];
    [threeDaysBeforeQuery whereKey: @"createdAt" greaterThan:threeDaysBefore];
    [threeDaysBeforeQuery orderByDescending:@"createdAt"];
    //self.threeDaysBeforeArr = [threeDaysBeforeQuery findObjects];
    [threeDaysBeforeQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
        if(!error)
        {
            self.threeDaysBeforeArr = [[NSArray alloc] initWithArray: results];
        }
        else
        {
            NSLog(@"Error three days query");
        }
        [self initSectionArr];
        [self.tableView reloadData];
        
    }];
    
    PFQuery* fourDayQuery = [PFQuery queryWithClassName:@"Notifications" predicate:predicate];
    [fourDayQuery whereKey:@"createdAt" lessThan: threeDaysBefore];
    [fourDayQuery whereKey:@"createdAt" greaterThan:fourDaysBefore];
    [fourDayQuery orderByDescending:@"createdAt"];
   // self.fourDaysBeforeArr = [fourDayQuery findObjects];
    [fourDayQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
        if(!error)
        {
            self.fourDaysBeforeArr = [[NSArray alloc] initWithArray: results];
        }
        else
        {
            NSLog(@"Error four days query");
        }
        [self initSectionArr];
        [self.tableView reloadData];
        
    }];
    
    PFQuery* fiveDayQuery = [PFQuery queryWithClassName:@"Notifications" predicate: predicate];
    [fiveDayQuery whereKey:@"createdAt" lessThan: fourDaysBefore];
    [fiveDayQuery whereKey:@"createdAt" greaterThan:fiveDaysBefore];
    [fiveDayQuery orderByDescending:@"createdAt"];
    //self.fiveDaysBeforeArr = [fiveDayQuery findObjects];
    [fiveDayQuery findObjectsInBackgroundWithBlock:^ (NSArray* results, NSError* error) {
        
        if(!error)
        {
            self.fiveDaysBeforeArr = [[NSArray alloc] initWithArray: results];
            NSLog(@"WOOT");
        }
        else
        {
            NSLog(@"Error five days query");
        }
        [self initSectionArr];
        [self.tableView reloadData];
        
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    //NSArray* temp = self.sectionArr[section];
    //return temp.count;
    return [self.sectionArr[section] count];
    
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
     
 

     [cell setBackgroundColor:[UIColor clearColor]];
     
     PFObject* notification = self.sectionArr[indexPath.section][indexPath.row];
     
     PFUser* user = [PFUser currentUser];
     
     NSNumber* userDept = user[@"dept"];
     NSNumber* notifDept = notification[@"dept"];
     
     UIImageView* cellImage = [[UIImageView alloc] initWithFrame: CGRectMake(20, 30, 20, 20)];
     
     if( userDept == notifDept)
     {
         //cell.imageView.image = [UIImage imageNamed: @"Content_SmallSquare_Blue.png"];
         cellImage.image = [UIImage imageNamed: @"Content_SmallSquare_Blue.png"];
     }
     else if([notifDept  isEqual: @0])
     {
         //cell.imageView.image = [UIImage imageNamed: @"Content_SmallSquare_Red.png"];
         cellImage.image = [UIImage imageNamed: @"Content_SmallSquare_Red.png"];
     }
     
     if([notification[@"title"] isEqualToString:@"Shift Change Request"])
     {
         //cell.imageView.image = [UIImage imageNamed: @"Content_SmallSquare_Turquois.png"];
         cellImage.image =[UIImage imageNamed: @"Content_SmallSquare_Turquois.png"];
     }
     
     //cell.imageView.frame =
         
     
     
     cell.textLabel.text = notification[@"title"];
     cell.textLabel.font = [UIFont fontWithName: @"Verdana" size:24.0];
     cell.textLabel.textColor = [UIColor colorWithRed: 128.0/255.0 green: 130.0/255.0 blue: 132.0/255.0 alpha: 1.0];
     
     cell.detailTextLabel.text = notification[@"subTitle"];
     cell.detailTextLabel.textColor = [UIColor colorWithRed: 17.0/255.0 green: 101.0/255.0 blue: 168.0/255.0 alpha: 1.0];
     
     [cell.contentView addSubview: cellImage];
     [cell.contentView bringSubviewToFront:cellImage];
     
    
    return cell;
 }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedNotification = self.sectionArr[indexPath.section][indexPath.row];
    
    [self performSegueWithIdentifier:@"notificationToDetail" sender: self];

}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString* dateString;
    NSArray* temp = self.sectionArr[section];
    if(temp.count != 0)
    {
        PFObject* notification = temp[0];
        NSDate* notifDate = notification.createdAt;
        NSDateFormatter* format = [[NSDateFormatter alloc] init];
        
        [format setDateFormat:@"EEEE, d MMMM"];
        dateString = [format stringFromDate: notifDate];
        
    }
    
    UILabel* headerText = [[UILabel alloc] init];
    headerText.frame = CGRectMake(10, 0, 500, 40);
    [headerText setBackgroundColor:[UIColor clearColor]];
    headerText.text = dateString;
   // headerText.textColor = [UIColor colorWithRed:17.0f/255.0f green:101.0f/255.0f blue:168.0f/255.0f alpha:1.0];
    headerText.textColor = [UIColor whiteColor];
    [headerText setFont: [UIFont fontWithName:@"Verdana" size: 20.0]];
    
    UIView* sectionView = [[UIView alloc] initWithFrame: CGRectMake(0,0,self.tableView.frame.size.width, 500)];
    [sectionView setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed: @"TabBar_Background"]]];
    //[sectionView setBackgroundColor:[UIColor colorWithRed: 17.0/255.0 green: 101.0/255.0 blue: 168.0/255.0 alpha: 0.8]];
    [sectionView addSubview:headerText];
    [sectionView bringSubviewToFront:headerText];
    
    
    
    return sectionView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
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
    destView.selectedNotification = self.selectedNotification;
    
    
}

-(void) initSectionArr
{
    self.sectionArr = [[NSMutableArray alloc] init];
    
    if(self.todayArr.count != 0)
    {
        [self.sectionArr addObject:self.todayArr];
    }
    
    if(self.yesterdayArr.count !=  0)
    {
        [self.sectionArr addObject:self.yesterdayArr];
    }
    if(self.dayBeforeArr.count != 0)
    {
        [self.sectionArr addObject:self.dayBeforeArr];
    }
    if(self.twoDaysBeforeArr.count !=0)
    {
        [self.sectionArr addObject:self.twoDaysBeforeArr];
    }
    if(self.threeDaysBeforeArr.count != 0)
    {
        [self.sectionArr addObject: self.threeDaysBeforeArr];
    }
    if(self.fourDaysBeforeArr.count != 0)
    {
        [self.sectionArr addObject: self.fourDaysBeforeArr];
    }
    if(self.fiveDaysBeforeArr.count != 0)
    {
        [self.sectionArr addObject: self.fiveDaysBeforeArr];
    }
}

@end
