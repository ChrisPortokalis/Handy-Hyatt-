//
//  myListDetail.m
//  HandyHyatt
//
//  Created by TETALA VEERA V on 11/20/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "myListDetail.h"
#import <Parse/Parse.h>
#import "navBarViewController.h"

@interface myListDetail ()
@property (weak, nonatomic) IBOutlet UITextView *detailDesc;
@property (weak, nonatomic) IBOutlet UILabel *detailSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *completionTime;

@end

@implementation myListDetail


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
    
    
    self.detailDesc.backgroundColor = [UIColor clearColor];
    //[self.navigationController viewDidAppear:FALSE];
    
    
    PFUser *user=[PFUser currentUser];
    NSNumber *dept = user[@"dept"];
    if([dept isEqual:@1])
    {
        UIImage *originalImage = [UIImage imageNamed:@"Kitchen.png"];
        CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        UIGraphicsBeginImageContext(destinationSize);
        [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    }
    else if([dept isEqual:@2])
    {
        // dept 2       => HouseKeeping
        UIImage *originalImage = [UIImage imageNamed:@"HouseKeeping.png"];
        CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        UIGraphicsBeginImageContext(destinationSize);
        [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
        
    }
    else if([dept isEqual:@3])
    {
        // dept 3       => Maintenance
        UIImage *originalImage = [UIImage imageNamed:@"Maintenance.png"];
        CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        UIGraphicsBeginImageContext(destinationSize);
        [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
        
    }
    else
    {
        // if employee belongs to no department or still department is not connected, then default screen image will be allocated.
        UIImage *originalImage = [UIImage imageNamed:@"Pin.png"];
        CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        UIGraphicsBeginImageContext(destinationSize);
        [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
        
    }

    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    // NSLog(@" object id in detail dept list : %@",self.detailObjectid);
    [query getObjectInBackgroundWithId:self.detailObjectid block:^(PFObject *object, NSError *error)
     {
         if (!error)
         {
             // The find succeeded.
             // NSLog(@" object retrieved");
             self.detailTitle.text=[object objectForKey:@"title"];
             [self.detailTitle sizeToFit];
             
             self.detailSubTitle.text=[object objectForKey:@"subtitle"];
             [self.detailSubTitle sizeToFit];
             
             self.detailDesc.text=[object objectForKey:@"description"];
             [self.detailDesc sizeToFit];
             
             NSDate *notifDate=[[NSDate alloc] init];
             NSDateFormatter* format = [[NSDateFormatter alloc] init];
             NSDateFormatter *df = [[NSDateFormatter alloc]init];
             [format setDateFormat:@"dd MMMM YYYY"];
             [df setDateFormat:@" hh:mma "];
             notifDate=[object objectForKey:@"finishTime"];
             NSString* dateString = [format stringFromDate: notifDate];
             NSString* timeString = [df stringFromDate: notifDate];
            // NSLog(@"%@ %@ ",dateString,timeString);
             
             self.completionTime.text=[NSString stringWithFormat:@"%@ %@ (%@)",@" Complete By", timeString,dateString];
             [self.completionTime sizeToFit];
            
           

             
         }
         else
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
         
         
         
         
     }];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
