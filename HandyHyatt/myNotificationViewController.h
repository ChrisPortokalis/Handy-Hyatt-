//
//  myNotificationViewController.h
//  HandyHyatt
//
//  Created by Chris Portokalis on 11/13/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface myNotificationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) PFObject* selectedNotification;
@property (strong, nonatomic) UIImage* bgImage;
@end
