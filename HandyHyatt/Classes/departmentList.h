//
//  departmentList.h
//  HandyHyatt
//
//  Created by TETALA VEERA V on 11/14/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface departmentList : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *tasks;
@property(strong,nonatomic) UIAlertView *alertView;
@end
