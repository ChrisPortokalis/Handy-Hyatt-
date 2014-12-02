//
//  myList.h
//  HandyHyatt
//
//  Created by TETALA VEERA V on 11/17/14.
//  Copyright (c) 2014 PORTOKALIS CHRISTOPHER G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myList : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (strong,nonatomic) NSMutableArray *mytasks;

@end
