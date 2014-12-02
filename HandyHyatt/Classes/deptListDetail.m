//
//  deptListDetail.m
//  HandyHyatt
//
//  Created by TETALA VEERA V on 11/17/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "deptListDetail.h"
#import <Parse/Parse.h>
#import "navBarViewController.h"
#import "navBarViewController.h"

@interface deptListDetail ()
@property (weak, nonatomic) IBOutlet UILabel *tasktitle;
@property (weak, nonatomic) IBOutlet UITextView *desc;

@property (weak, nonatomic) IBOutlet UILabel *completionTime;



@property (weak, nonatomic) IBOutlet UILabel *subtitle;





@end

@implementation deptListDetail

- (IBAction)popBack:(id)sender
{
            [self.navigationController popViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)     viewWillAppear:(BOOL)animated
{
    self.desc.text=@ " ";
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController viewDidAppear:FALSE];
    
    self.desc.backgroundColor = [UIColor clearColor];
    
    
    

    
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
            self.tasktitle.text=[object objectForKey:@"title"];
            [self.tasktitle setFont:[UIFont fontWithName:@"Bodoni 72 OldStyle" size:32]];
            [self.tasktitle setTextColor:[UIColor colorWithRed:17.0f/255.0f green:101.0f/255.0f blue:168.0f/255.0f alpha:1.0f]];
            [self.tasktitle sizeToFit];
            
            
            self.subtitle.text=[object objectForKey:@"subtitle"];
            [self.subtitle setFont:[UIFont fontWithName:@"Verdana" size:24]];
            [self.subtitle setTextColor:[UIColor colorWithRed:128.0f/255.0f green:130.0f/255.0f blue:132.0f/255.0f alpha:1.0f]];
            [self.subtitle sizeToFit];
            
            self.desc.text=[object objectForKey:@"description"];
            if([self.desc.text isEqualToString:@" "])
            {
                self.desc.text=@" NO DESCRIPTION AVAILABLE";
            }
            [self.desc setTextColor:[UIColor colorWithRed:128.0f/255.0f green:130.0f/255.0f blue:132.0f/255.0f alpha:1.0f]];
            [self.desc setFont:[UIFont fontWithName:@"Verdana" size:21]];
            [self.desc sizeToFit];
            
             NSDate *notifDate=[[NSDate alloc] init];
            NSDateFormatter* format = [[NSDateFormatter alloc] init];
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            [format setDateFormat:@"dd MMMM YYYY"];
            [df setDateFormat:@" hh:mma "];
            notifDate=[object objectForKey:@"finishTime"];
            NSString* dateString = [format stringFromDate: notifDate];
            NSString* timeString = [df stringFromDate: notifDate];
                        
            
            
            self.completionTime.text=[NSString stringWithFormat:@"%@ %@ (%@)",@" Complete By", timeString,dateString];
            [self.completionTime sizeToFit];
            //[self.completionTime  setFont:[UIFont fontWithName:@"Verdana Italic" size:21]];
            [self.completionTime setTextColor:[UIColor colorWithRed:17.0f/255.0f green:101.0f/255.0f blue:168.0f/255.0f alpha:1.0f]];
            
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
