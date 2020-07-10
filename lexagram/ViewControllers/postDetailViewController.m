//
//  postDetailViewController.m
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/9/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "postDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Datetools.h"
#import "Post.h"
#import <Parse/Parse.h>


@interface postDetailViewController ()
@property (nonatomic, strong) NSArray * userpost;
@end

@implementation postDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePostDetails];
    // Do any additional setup after loading the view.
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/






-(void)updatePostDetails{
    
    self.detailpost.file = self.post[@"image"];
    [self.detailpost loadInBackground];
    self.detailscaption.text = self.post[@"caption"];
    self.detailstime.text = self.post[@"createdAt"];
    self.detailsuser_name.text = self.post[@"userID"];
   // self.detailstime.text = self.post.createdAtString;
    //NSLog(@"%@", self.post.createdAtString);
    
    NSDate *mydate = self.post.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    formatter.dateStyle = NSDateFormatterShortStyle;
    if (mydate == nil) {
        NSLog(@"I was not here");
    }
    [formatter stringFromDate:mydate];
    self.detailstime.text = [formatter stringFromDate:mydate];
        
    }
  




@end
