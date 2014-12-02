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
    
    
      // PFUser *user=[PFUser currentUser];
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
