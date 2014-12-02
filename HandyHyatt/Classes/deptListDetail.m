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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController viewDidAppear:FALSE];
    [self.navigationItem setHidesBackButton:YES];
    
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
            self.subtitle.text=[object objectForKey:@"subtitle"];
            self.desc.text=[object objectForKey:@"description"];
            
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
