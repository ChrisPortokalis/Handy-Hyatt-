//
//  notificationDetailsViewController.h
//  HandyHyatt
//
//  Created by Chris Portokalis on 11/16/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface notificationDetailsViewController : UIViewController

@property (strong, nonatomic) UIImage* bgImage;
@property (strong, nonatomic) PFObject* selectedNotification;

@end
