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

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, strong)UIRefreshControl *refreshControl;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postView.delegate = self;
    self.postView.dataSource = self;
    self.postView.rowHeight = 480;
    [self fetchPosts];
    self.refreshControl = [[UIRefreshControl alloc]init];
       self.activityIndicator = [[UIActivityIndicatorView alloc]init];
       [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.postView insertSubview:self.refreshControl atIndex:0];
    [self.postView addSubview:self.refreshControl];
       [_refreshControl setTintColor:[UIColor redColor]];
       
    
    
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
    [self.activityIndicator startAnimating];
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
    
    [self.refreshControl endRefreshing];
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


- (IBAction)postDetailTap:(id)sender {
    NSLog(@"I am tapped");
}



@end
