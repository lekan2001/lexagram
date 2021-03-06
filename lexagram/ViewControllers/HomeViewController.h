//
//  HomeViewController.h
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/7/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property  (strong,nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
