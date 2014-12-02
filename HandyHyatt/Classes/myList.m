//
//  myList.m
//  HandyHyatt
//
//  Created by TETALA VEERA V on 11/17/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "myList.h"
#import "myListDetail.h"
#import "mainMenuView.h"
#import <Parse/Parse.h>

@interface myList ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property  (strong,nonatomic) NSString *userName;
@property  (strong,nonatomic) NSString *userID;
@property (assign) int dept;

@property (strong,nonatomic) NSString *taskTitle;
@property (strong,nonatomic) NSString *taskSubTitle;
@property (strong,nonatomic) NSString *removeObjectid;
@property (strong,nonatomic) NSString *selectedobjectid;
@property (weak, nonatomic) IBOutlet UIImageView *background;


@end

@implementation myList
/*- (IBAction)backToMainMenu:(id)sender
{
    mainMenuView *prevVC = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:prevVC animated:YES];
}*/

/*- (IBAction)displayDeptList:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}*/

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
    // Do any additional setup after loading the view.
    //self.mytasks=[[NSMutableArray alloc] init];
    
   // [self.navigationItem setHidesBackButton:YES];
    
    PFUser *user=[PFUser currentUser];
    self.userName=user.username;
    self.userID=[user objectId];
    
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
             // [self displayDepartmentList];
             [self displayMyList];
             
         }
     }];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView setTableFooterView:v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                
                [self.tableView reloadData];
                
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




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
   // NSLog(@" count : %d",[self.mytasks count]);
    return [self.mytasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"myListCell" forIndexPath:indexPath];
    
    
    if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myListCell"];
    }
    
    NSString *object =[self.mytasks objectAtIndex:indexPath.row];
    NSLog(@" Object id :%@",object);
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    //AND whereKey:@"status" equalTo:@"true"
    [query getObjectInBackgroundWithId:object block:^(PFObject *object, NSError *error) {
        if (!error)
        {
            // The find succeeded.
            NSLog(@" object retrieved");
            self.taskTitle=[object objectForKey:@"title"];
            self.taskSubTitle=[object objectForKey:@"subtitle"];
            
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        
        cell.textLabel.text=self.taskTitle;
        cell.detailTextLabel.text=self.taskSubTitle;
        
        
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
    self.selectedobjectid=[self.mytasks objectAtIndex:indexPath.row];
    return indexPath;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if([segue.identifier isEqualToString:@"myListDetail"])
    {
        
        // NSLog(@" department list detail segue calling");
        myListDetail  *mlist= (myListDetail *) segue.destinationViewController;
        mlist.detailObjectid=self.selectedobjectid;
        
    }
    else
    {
        //    NSLog(@"Wrong seque calling");
    }
    
    
    
}

- (IBAction)unwindToMyList:(UIStoryboardSegue *)sender
{
    myListDetail *dt = (myListDetail *) sender.sourceViewController;
    self.selectedobjectid=dt.detailObjectid;
    [self.mytasks removeObject:self.selectedobjectid];
    [self.tableView reloadData];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.selectedobjectid block:^(PFObject *object, NSError *error)
     {
         
         // Now let's update it with some new data. In this case, only cheatMode and score
         // will get sent to the cloud. playerName hasn't changed.
         object[@"status"] = @"completed";
         object[@"user"]=self.userID;
         //[self.tasks removeObject:self.selectedobjectid];
         //[object saveEventually];
         [object saveInBackground];
         //[self displayMyList];
        //[self.tableView reloadData];
         
     }];
    
    
}

- (IBAction)unwindToMyListForDelete:(UIStoryboardSegue *)sender
{
    myListDetail *dt = (myListDetail *) sender.sourceViewController;
    self.selectedobjectid=dt.detailObjectid;
    [self.mytasks removeObject:self.selectedobjectid];
    [self.tableView reloadData];

    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.selectedobjectid block:^(PFObject *object, NSError *error)
     {
         
         // Now let's update it with some new data. In this case, only cheatMode and score
         // will get sent to the cloud. playerName hasn't changed.
         object[@"status"] = @"true";
         object[@"user"]=@"";
         //[self.tasks removeObject:self.selectedobjectid];
         //[object saveEventually];
         [object saveInBackground];
         //[self displayMyList];
        // [self.tableView reloadData];
         
     }];
    
    
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *remove=cell.textLabel.text;
        PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
        [query whereKey:@"title" equalTo:remove];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
         {
             if (!object)
             {
                 NSLog(@"The getFirstObject request failed.");
             }
             else {
                 // The find succeeded.
                 NSLog(@"Successfully retrieved the object.");
                 NSString *objectID = [object objectId];
                 self.removeObjectid=objectID;
                 for(int x=0;x<[self.mytasks count];x++)
                 {
                     NSString *arrayid=[self.mytasks objectAtIndex:x];
                     
                     if([arrayid isEqualToString:objectID])
                     {
                         [self.mytasks removeObject:arrayid];
                         break;
                     }
                 }
                 UIAlertView *message = [[UIAlertView alloc] initWithTitle:@" Delete the task?"
                                                                   message:@""
                                                                  delegate:self
                                                         cancelButtonTitle:@"Completed"
                                                         otherButtonTitles:nil];
                 [message addButtonWithTitle:@"Delete"];
                 [message show];
                 
                 
                 
             }
         }];
        
        
        
    }
    
}

#pragma mark - Alert View

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    // NSLog(@" Title :%@",title);
    
    
    if(buttonIndex==0)
    {
        //completed - change status of tasks and make visible in dept.
        NSLog(@" Completed - Change status ");
        PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
        
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:self.removeObjectid block:^(PFObject *object, NSError *error)
         {
             
             // update status and employee id
             NSDate *currentTime = [NSDate date];
             object[@"status"] = @"completed";
             object[@"finishTime"] =currentTime;
             //object[@"user"] = self.userName;
             [object saveInBackground];
             
         }];
        [self.tableView reloadData];
        
        
    }
    else if(buttonIndex==1)
    {
        // delete task      - add to department list back.
        
        NSLog(@" Delete - Add to department list");
        [self.mytasks removeObject:self.removeObjectid];
        PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
        
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:self.removeObjectid block:^(PFObject *object, NSError *error)
         {
             
             // update status and employee id
             object[@"status"] = @"true";
             object[@"user"] = @"";
             [object saveInBackground];
             
         }];

        
        [self.tableView reloadData];
    }
}








@end
