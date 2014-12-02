//
//  loginView.m
//  HandyHyatt
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/12/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "loginView.h"
#import <Parse/Parse.h>

#import <QuartzCore/QuartzCore.h>
#include "mainMenuView.h"

@interface loginView ()
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *buttonClear;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UITextField *textBox4;
@property (weak, nonatomic) IBOutlet UITextField *textBox3;
@property (weak, nonatomic) IBOutlet UITextField *textBox2;
@property (weak, nonatomic) IBOutlet UITextField *textBox1;
@property (strong,nonatomic) NSString *userName;


@end

@implementation loginView

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
    self.button9.titleLabel.text = @" ";
    self.button8.titleLabel.text = @" ";
    self.button7.titleLabel.text = @" ";
    self.button6.titleLabel.text = @" ";
    self.button5.titleLabel.text = @" ";
    self.button4.titleLabel.text = @" ";
    self.button3.titleLabel.text = @" ";
    
}

- (IBAction)buttonTapped:(id)sender
{
    self.buttonBack.hidden=NO;
    self.buttonClear.hidden=NO;
    
    self.errorLabel.hidden=true;
    if (sender == self.button0)
        [self addButtonText:@"0"];
    else if (sender == self.button1)
        [self addButtonText:@"1"];
    else if (sender == self.button2)
        [self addButtonText:@"2"];
    else if (sender == self.button3)
        [self addButtonText:@"3"];
    else if (sender == self.button4)
        [self addButtonText:@"4"];
    else if (sender == self.button5)
        [self addButtonText:@"5"];
    else if (sender == self.button6)
        [self addButtonText:@"6"];
    else if (sender == self.button7)
        [self addButtonText:@"7"];
    else if (sender == self.button8)
        [self addButtonText:@"8"];
    else if (sender == self.button9)
        [self addButtonText:@"9"];
    else if(sender == self.buttonBack)
        [self addButtonText:@"back"];
    else if(sender == self.buttonClear)
        [self addButtonText:@"clear"];
    
}

- (void) addButtonText : (NSString *) text
{
    if([text isEqualToString:@"clear"])
    {
        self.textBox1.text=@"";
        self.textBox2.text=@"";
        self.textBox3.text=@"";
        self.textBox4.text=@"";
        self.buttonBack.hidden=YES;
        self.buttonClear.hidden=YES;
    }
    else if([text isEqualToString:@"back"])
    {
        if(![self.textBox4.text isEqualToString:@""])
        {
            self.textBox4.text=@"";
        }
        else if(![self.textBox3.text isEqualToString:@""])
        {
            self.textBox3.text=@"";
        }
        else if(![self.textBox2.text isEqualToString:@""])
        {
            self.textBox2.text=@"";
        }
        else
        {
            self.textBox1.text=@"";
            self.buttonBack.hidden=YES;
            self.buttonClear.hidden=YES;
        }
    }
    else
    {
        if([self.textBox1.text isEqualToString:@""])
        {
            self.textBox1.text=text;
        }
        else if([self.textBox2.text isEqualToString:@""])
        {
            self.textBox2.text=text;
            self.userName=[self.textBox1.text stringByAppendingString:self.textBox2.text];
            
        }
        else if([self.textBox3.text isEqualToString:@""])
        {
            self.textBox3.text=text;
            self.userName=[self.userName stringByAppendingString:self.textBox3.text];
            
        }
        else
        {
            self.textBox4.text=text;
            self.userName=[self.userName stringByAppendingString:self.textBox4.text];
            
            // to create empty boxes after logout
            self.textBox1.text=@"";
            self.textBox2.text=@"";
            self.textBox3.text=@"";
            self.textBox4.text=@"";
            self.buttonClear.hidden=YES;
            self.buttonBack.hidden=YES;
            
            [self validate];
        }
    }
    
}

- (void) validate
{
    //NSString *part1 = [self.textBox1.text stringByAppendingString:self.textBox2.text];
    //NSString *part2 = [part1 stringByAppendingString:self.textBox3.text];
    //self.username = [part2 stringByAppendingString:self.textBox4.text];
    //self.username = [NSString stringWithFormat:@"%@%@%@%@",self.textBox1.text,self.textBox2.text,self.textBox3.text,self.textBox4.text];
    self.userName=[self.userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [PFUser logInWithUsernameInBackground:self.userName password:self.userName block:^(PFUser *user, NSError *error)
     {
         if (!error)
         {
             NSLog(@"Login Success");
             // Do stuff after successful login.
             self.navigationController.navigationBarHidden=false;
             [self performSegueWithIdentifier: @"mainMenuView" sender: self];
             
         }
         else
         {
             // The login failed. Check error to see why.
             self.errorLabel.hidden=false;
             self.errorLabel.text=@"Error. Try Again ! ";
             [self addButtonText:@"clear"];
             
         }
     }];
    
    
}




-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController viewDidAppear:animated];
    self.errorLabel.hidden=true;
    
    self.navigationController.navigationBarHidden=true;
    
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 65)];
    UINavigationItem* item = [[UINavigationItem alloc] init];
    [navBar   setBackgroundImage:[UIImage imageNamed:@"TabBar_Background.png"] forBarMetrics: UIBarMetricsDefault];
    
    UIImage *originalImage = [UIImage imageNamed:@"Pin.png"];
    CGSize destinationSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
    self.buttonClear.hidden=YES;
    self.buttonBack.hidden =YES;
    
    // create compnay logo image on navigation bar at titleview
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *titleImage=[[UIImageView alloc ] initWithFrame:CGRectMake(0, -5, 200, 50)];
    titleImage.image=[UIImage imageNamed:@"TabBar_Logo_PinScreen1.png"];
    [titleView addSubview:titleImage];
    
    item.titleView=titleView;
    [navBar pushNavigationItem:item animated:YES];
    //[navBar addSubview:titleView];
    [self.view addSubview:navBar];
    
    
    // self.navigationItem.titleView=titleView;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
