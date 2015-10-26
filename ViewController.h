//
//  ViewController.h
//  iTahDoodle2
//
//  Created by Layla Nawawi on 10/2/15.
//  Copyright © 2015 Laylapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>
@property (nonatomic) UITableView *taskTable;
@property (nonatomic) UITextField *taskField;
@property (nonatomic) UIButton *insertButton;
@property (nonatomic) NSMutableArray *tasks;

- (void)addTask:(id)sender;


@end
