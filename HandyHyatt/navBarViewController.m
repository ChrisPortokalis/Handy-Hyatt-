//
//  navBarViewController.m
//  HandyHyatt
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/12/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "navBarViewController.h"
#import <Parse/Parse.h>

@interface navBarViewController ()

@end

@implementation navBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



/*-(void)drawRect:(CGRect*) rect
{
    UIColor *colorFlat = [UIColor blueColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [colorFlat CGColor]);
    CGContextFillRect(context, *rect);
    
    
}*/

- (void)viewDidLoad
{

    [super viewDidLoad];

    [self.navigationBar setBackgroundColor: [UIColor clearColor]];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"TabBar_Background.png"]forBarMetrics: UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
    
    [self setNavBackButton];
    
    

    
    
    //[self.navigationBar setTintColor: [UIColor clearColor]];
   
    
    // UIBarButtonItem *clockImage = [[UIBarButtonItem alloc] initWithImage:faceImage style:UIBarButtonItemStyleBordered target:nil action:nil];
    
   /* [someButton setBackgroundImage:faceImage forState:UIControlStateNormal];
    [someButton addTarget:self action:nil
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    NSMutableArray* buttonArr = [[NSMutableArray alloc] init];
    [buttonArr addObject: mailbutton];
    self.navigationItem.leftBarButtonItems=buttonArr;*/
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    [self setNavBackButton];
    
    
    
    
    //[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"TabBar_Background.png"]forBarMetrics: UIBarMetricsDefault];
   // UIImage *clockImage = [[UIImage imageNamed:@"TabBar_Clock_ClockedOut.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    //CGRect frameimg = CGRectMake(0, 0, 20, 20);
    //UIImageView* clockView = [[UIImageView alloc] initWithImage: clockImage];
    
    //UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    //[self.navigationBar addSubview:clockView];
    
    if([PFUser currentUser] != nil)
    {
       /* NSDate* now = [NSDate date];
        PFUser* currUser = [PFUser currentUser];
        PFQuery* clockQuery = [PFQuery queryWithClassName: @"Clock"];
        
        [clockQuery whereKey:@"createdAt" equalTo: now];
        NSArray* clockedIn = [clockQuery findObjects];
        
        if(clockedIn.count == 0)
        {
            NSLog(@"Logged");
            NSLog(@"");
            UIImage *faceImage = [[UIImage imageNamed:@"TabBar_Clock_ClockedOut.png"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
            CGRect frameimg = CGRectMake(0, 0, faceImage.size.width, faceImage.size.height);
            UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];*/
            
            
           // UIBarButtonItem *clockImage = [[UIBarButtonItem alloc] initWithImage:faceImage style:UIBarButtonItemStyleBordered target:nil action:nil];
            
            /*[someButton setBackgroundImage:faceImage forState:UIControlStateNormal];
            [someButton addTarget:self action:nil
                 forControlEvents:UIControlEventTouchUpInside];
            [someButton setShowsTouchWhenHighlighted:YES];
            
            UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
            self.navigationItem.rightBarButtonItem=mailbutton;*/
            
            
            /*UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
            face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
           //[face setImage:faceImage forState:UIControlStateNormal];
            UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
            self.navigationItem.rightBarButtonItem = faceBtn;*/
            
        //}
    
    }
    
}

-(void) setNavBackButton
{
    //set back button arrow color
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //set back button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    //set back button arrow color
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
   
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popBack
{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
