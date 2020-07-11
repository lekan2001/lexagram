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
#import "SceneDelegate.h"
#import "postDetailViewController.h"
@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *postView;

@property (nonatomic, strong) NSArray * userpost;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, strong)UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation HomeViewController
NSString *CellIdentifier = @"PostCell";
NSString *HeaderViewIdentifier = @"TableViewHeaderView";



- (void)viewDidLoad {
    [super viewDidLoad];
//    PFUser *user = [PFUser currentUser];     if (user != nil) {
//
//    NSLog(@"Welcome back %@ 😀", user.username);
//
    PFUser *user = [PFUser currentUser];
    if (user!= nil) {
        
        NSString *userNum = user.username;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome 😀"
                                                                       message: userNum
        preferredStyle:(UIAlertControllerStyleAlert)];
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        
        
    }
    
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
        
        SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *loginNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        sceneDelegate.window.rootViewController = loginNavigationController;
        
        
        NSLog(@"Log out Sucessful");
   
    }];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"postdetailSegue"]){
        postDetailViewController *postdetailscontroller = [segue destinationViewController];
        PostViewCell *selectedcell =(PostViewCell *) sender;
        postdetailscontroller.post = selectedcell.post;
    }
    
    // Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
}



-(void) fetchPosts{
    [self.activityIndicator startAnimating];
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;

    // fetch data asynchronously
    __weak typeof (self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.userpost = posts;
            [self.postView reloadData];
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    [weakSelf.postView reloadData];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.postView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.postView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.postView.isDragging) {
            self.isMoreDataLoading = true;
            [self fetchMorePosts];
            // ... Code to load more results ...
        }
    }
  
    
    
    }
-(void)fetchMorePosts{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    //[query whereKey:@"likesCount" greaterThan:@100];
   // query.limit = 20;

    // fetch data asynchronously
    __weak typeof (self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.userpost = posts;
           //
            // do something with the array of object returned by the call
        } else {
            self.isMoreDataLoading = false;
            [self.postView reloadData];
            NSLog(@"%@", error.localizedDescription);
        }
        [weakSelf.postView reloadData];
    }];
    
    
    
    
}



    
    




@end
