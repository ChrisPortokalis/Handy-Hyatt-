//
//  loginView.m
//  HandyHyatt
//
//  Created by PORTOKALIS CHRISTOPHER G on 11/12/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import "loginView.h"
#import <Parse/Parse.h>

@interface loginView ()

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
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController viewDidAppear:animated];
}

-(void) getRealDate
{
    NSDate *notifDate=[[NSDate alloc] init];
    
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"d MMMM YYYY"];
    NSString* dateString = [format stringFromDate: notifDate];
    
}

- (void) getRealTime
{
    NSDate *notifDate=[[NSDate alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@" hh:mma "];
    NSString* timeString = [df stringFromDate: notifDate];
    
}

// to get time left
- (NSString *) getTimeWorked : (NSString *) punchInTime
{
    NSDate *currentDate=[[NSDate alloc] init];
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"<your date format goes here"];
    //    NSDate *date = [dateFormatter dateFromString:string1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:currentDate];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    
    
    
    
    return @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
