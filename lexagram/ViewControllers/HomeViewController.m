//
//  HomeViewController.m
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/7/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostViewCell.h"
@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *postView;

@property (nonatomic, strong) NSArray * userpost;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postView.delegate = self;
    self.postView.dataSource = self;
    self.postView.rowHeight = 500;
    [self fetchPosts];
    
    // Do any additional setup after loading the view.
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        NSLog(@"Log out Sucessful");
   
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.userpost = posts;
            [self.postView reloadData];
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  PostViewCell *poster = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
  
    poster.post = self.userpost [indexPath.row ];
    
   // return query;
    
    return poster;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userpost.count;

}


@end
