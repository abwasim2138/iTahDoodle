//
//  ViewController.m
//  iTahDoodle2
//
//  Created by Layla Nawawi on 10/2/15.
//  Copyright © 2015 Laylapp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSString *DocPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [pathList[0] stringByAppendingString:@"data.td"];
}
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //self.tasks = [NSMutableArray array];
    NSArray *pList = [NSArray arrayWithContentsOfFile:DocPath()];
    if (pList) {
        
        self.tasks = [pList mutableCopy];
    }else {
        self.tasks = [NSMutableArray array];
    }
    
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect tableFrame = CGRectMake(0, 80, frame.size.width, frame.size.height-100);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    //TABLEVIEW
    
    self.taskTable = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    self.taskTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.taskTable.dataSource = self;
    [self.taskTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //TEXTFIELD
    
    self.taskField = [[UITextField alloc]initWithFrame:fieldFrame];
    self.taskField.borderStyle = UITextBorderStyleRoundedRect;
    self.taskField.placeholder = @"Type a task, tap Insert";
    
    //UIBUTTON
    self.insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.insertButton.frame = buttonFrame;
    [self.insertButton setTitle:@"INSERT" forState:UIControlStateNormal];
    
    [self.insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    //ADD THE THREE VIEWS TO THE WINDOW OBJECT
    [self.view addSubview:self.taskTable];
    [self.view addSubview:self.taskField];
    [self.view addSubview:self.insertButton];
    // Do any additional setup after loading the view.
}


#pragma mark - TableView Management

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *item = [self.tasks objectAtIndex:indexPath.row];
    c.textLabel.text = item;
    
    return c;
}
#pragma mark - Actions
-(void)addTask:(id)sender
{
    NSString *text = [self.taskField text];
    
    if ([text length] == 0) {
        return;
    }
    [self.tasks addObject:text];
    [self.taskTable reloadData];
    
    NSLog(@"TASK ENTERED: %@", text);
    
    [self.taskField setText:@""];
    [self.taskField resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
     [self.tasks writeToFile:DocPath() atomically:YES];
}

@end
