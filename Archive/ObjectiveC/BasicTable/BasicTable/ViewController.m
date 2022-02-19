//
//  ViewController.m
//  BasicTable
//
//  Created by Ness Bautista on 29/05/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

#import "ViewController.h"
#import "Course.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableArray<Course *> *courses;
@end

@implementation ViewController

NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCourses];
    [self fetchCoursesUsingJSON];
    
    self.navigationItem.title = @"Courses";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = [[UIColor alloc] initWithRed:.5 green:.9 blue:.5 alpha:1];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}

- (void) setupCourses {
    Course *course = Course.new;
    course.name = @"Instagram Firabase";
    course.numberOfLessons = @(49);
    
    self.courses = NSMutableArray.new;
    [self.courses addObject:course];
}

-(void) fetchCoursesUsingJSON {
    NSLog(@"fetching courses");
    NSString *urlString = @"https://api.letsbuildthatapp.com/jsondecodable/courses";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *dummyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Finished fetching: %@", dummyStr);
        
        NSError *err;
        NSArray *arrayJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            NSLog(@"Failed to serialize JSON");
            return;
        }
        
        NSMutableArray<Course *> *courses = NSMutableArray.new;
        for (NSDictionary *courseDict in arrayJSON){
            NSString *name = courseDict[@"name"];
            NSLog(@"%@", name);
            
            Course *course = Course.new;
            course.name = name;
            course.numberOfLessons = (NSNumber *)courseDict[@"number_of_lessons"];
            [courses addObject:course];
        }
        self.courses = courses;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }]resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    Course *course = self.courses[indexPath.row];
    NSString *courseName = course.name;
    cell.textLabel.text = courseName;
    cell.detailTextLabel.text = course.numberOfLessons.stringValue;
    return cell;
}

@end
