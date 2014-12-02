//
//  departmentList.m
//  HandyHyatt
//
//  Created by TETALA VEERA V on 11/14/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "departmentList.h"
#import "deptListDetail.h"
#import "myList.h"
#import <Parse/Parse.h>
#import "navBarViewController.h"




@interface departmentList () 
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSString *userName;
@property  (strong,nonatomic) NSString *userID;
@property (assign) int dept;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (strong,nonatomic) NSString *taskTitle;
@property (strong,nonatomic) NSString *taskSubTitle;
@property (strong,nonatomic) NSString *removeObjectid;
@property (strong,nonatomic) NSString  *selectedobjectid;
@property (strong,nonatomic) NSMutableArray *mytasks;
@property (assign) NSNumber *priority;

@end

@implementation departmentList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController viewDidAppear:FALSE];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:self.userName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if (error)
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         } else
         {
             
             self.dept =[[object objectForKey:@"dept"] intValue];
             if(self.dept==1)
             {
                 /*UIImage *originalImage = [UIImage imageNamed:@"Kitchen.png"];
                 CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
                 UIGraphicsBeginImageContext(destinationSize);
                 [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
                 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                 UIGraphicsEndImageContext();
                 self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];*/
                 self.background.image= [UIImage imageNamed:@"Kitchen.png"];
                 
             }
             else if(self.dept==2)
             {
                 // dept 2       => HouseKeeping
                 /*UIImage *originalImage = [UIImage imageNamed:@"HouseKeeping.png"];
                 CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
                 UIGraphicsBeginImageContext(destinationSize);
                 [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
                 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                 UIGraphicsEndImageContext();
                 self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];*/
                 
                  self.background.image= [UIImage imageNamed:@"HouseKeeping.png"];
                 
             }
             else if(self.dept==3)
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
             // [self displayDepartmentList];
             [self displayMyList];
             
         }
     }];

    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
   [self.navigationController viewDidAppear:FALSE];
    
   
    
    self.mytasks=[[NSMutableArray alloc] init];
    
    PFUser *user=[PFUser currentUser];
    self.userName=user.username;
    self.userID = [user objectId];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView setTableFooterView:v];

    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:self.userName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
     {
         if (error)
         {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         } else
         {
             
            self.dept =[[object objectForKey:@"dept"] intValue];
             if(self.dept==1)
             {
                 UIImage *originalImage = [UIImage imageNamed:@"Kitchen.png"];
                 CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
                 UIGraphicsBeginImageContext(destinationSize);
                 [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
                 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                 UIGraphicsEndImageContext();
                 self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
                 
             }
             else if(self.dept==2)
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
             else if(self.dept==3)
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
            // [self displayDepartmentList];
             [self displayMyList];
             
         }
     }];

}

- (void) displayDepartmentList
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    [query whereKey:@"dept" equalTo:@(self.dept)];
    [query whereKey:@"status" equalTo:@"true"];
    [query orderByAscending:@"updatedAt"];
    
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // The find succeeded.
           // NSLog(@"Successfully retrieved %d scores.", objects.count);
            
            // Do something with the found objects
            for (PFObject *object in objects)
            {
                NSString *objectID=[object objectId];
               // NSLog(@" Object id :%@",objectID);
                if(![self.tasks containsObject:objectID])
                {
                    [self.tasks addObject:objectID];
                }
                [self.tableView reloadData];

               // NSLog(@"no of rows : %d ",[self.tasks count]);
                
                
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (void) displayMyList
{
   // NSLog(@" my list :%@",self.userID);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
   [query whereKey:@"dept" equalTo:@(self.dept)];
   [query whereKey:@"status" notEqualTo:@"completed"];
    
    [query whereKey:@"user" equalTo:self.userID];
  //  [query orderByAscending:@"updatedAt"];
  
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            
            // NSLog(@"Successfully retrieved %d scores.", objects.count);
            
            // Do something with the found objects
            for (PFObject *object in objects)
            {
                NSString *objectID=[object objectId];
               // NSLog(@" Object id :%@",objectID);
                if(![self.mytasks containsObject:objectID])
                {
                   // NSLog(@" add object to my tasks");
                    [self.mytasks addObject:objectID];
                }
                
                 //NSLog(@"no of rows : %d ",[self.mytasks count]);
                
                
            }
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


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"deptListCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.opaque=true;
  
    
    if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"deptListCell"];
    }
    
    NSString *object =[self.tasks objectAtIndex:indexPath.row];
    // NSLog(@" Object id :%@",object);
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    //AND whereKey:@"status" equalTo:@"true"
    [query getObjectInBackgroundWithId:object block:^(PFObject *object, NSError *error) {
        if (!error)
        {
            // The find succeeded.
          //  NSLog(@" object retrieved");
            self.taskTitle=[object objectForKey:@"title"];
            self.taskSubTitle=[object objectForKey:@"subtitle"];
            self.priority=[object objectForKey:@"Priority"];
            
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
       
         cell.backgroundColor=[UIColor clearColor];
        
        cell.textLabel.font=[UIFont fontWithName:@"Verdana" size:24];
        cell.textLabel.textColor=[UIColor colorWithRed:128.0f/255.0f
                                                 green:130.0f/255.0f
                                                  blue:132.0f/255.0f
                                                 alpha:1.0f];
        cell.textLabel.text=self.taskTitle;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.numberOfLines = 1;
        
        cell.detailTextLabel.font=[UIFont fontWithName:@"Verdana Italic" size:16];
        cell.detailTextLabel.textColor=[UIColor colorWithRed:17.0f/255.0f
                                                       green:101.0f/255.0f
                                                        blue:168.0f/255.0f
                                                       alpha:1.0f];
        cell.detailTextLabel.text=self.taskSubTitle;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.numberOfLines=1;
        
        if([self.priority isEqual:@1])
        {
            cell.imageView.image=[UIImage imageNamed:@"Content_SmallSquare_Red.png"];
        }
        else if([self.priority isEqual:@2])
        {
            cell.imageView.image=[UIImage imageNamed:@"Content_SmallSquare_Blue.png"];
        }
        else if([self.priority isEqual:@3])
        {
            cell.imageView.image=[UIImage imageNamed:@"Content_SmallSquare_Turquois.png"];
        }
        else
        {
           cell.imageView.image=[UIImage imageNamed:@"Content_SmallSquare_Empty.png"];
        }
        
       
       

    }];

    
    
     return cell;
    
    //UIImage *image = [UIImage imageNamed:@"unchecked.png"];
    //cell.imageView.image = image;
    
    
    
    }

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}




- (NSIndexPath *) tableView:(UITableView *)tableView  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     self.selectedobjectid=[self.tasks objectAtIndex:indexPath.row];
    return indexPath;
 }


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if([segue.identifier isEqualToString:@"deptListDetail"])
    {
        
       // NSLog(@" department list detail segue calling");
        deptListDetail  *de= (deptListDetail *) segue.destinationViewController;
        de.detailObjectid=self.selectedobjectid;
        
    }
    else if([segue.identifier isEqualToString:@"myList"])
    {
        //NSLog(@" my list  segue calling");

        myList *m = (myList *) segue.destinationViewController;
       // NSLog(@"prepare for segue, count : %d",[self.mytasks count]);
        m.mytasks=self.mytasks;
     }
    else
    {
    //    NSLog(@"Wrong seque calling");
    }
    
    
    
}


//unwinding segue

- (IBAction)unwindToDepartmentList:(UIStoryboardSegue *)sender
{
    deptListDetail *dt = (deptListDetail *) sender.sourceViewController;
    self.selectedobjectid=dt.detailObjectid;
    
    [self.mytasks addObject:self.selectedobjectid];
    NSLog(@" before adding to my list : %d",[self.tasks count]);
    [self.tasks removeObject:self.selectedobjectid];
     NSLog(@" after adding to my list : %d",[self.tasks count]);
    
    //NSLog(@"unwind segue, count : %d",[self.mytasks count]);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.selectedobjectid block:^(PFObject *object, NSError *error)
    {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        object[@"status"] = @"false";
        object[@"user"]=self.userID;
       //[self.tasks removeObject:self.selectedobjectid];
        //[object saveEventually];
       [object saveInBackground];
        [self displayMyList];
        [self.tableView reloadData];
        
    }];
    
    
}


-(IBAction)unwindFromMyList :(UIStoryboardSegue *)sender
{
    myList *ml=(myList *)sender.sourceViewController;
    self.mytasks=ml.mytasks;
    [self displayDepartmentList];
    
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
