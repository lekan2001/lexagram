//
//  postDetailViewController.h
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/9/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface postDetailViewController : UIViewController

@property  (strong,nonatomic) Post *post;
@property (weak,nonatomic) IBOutlet PFImageView *detailpost;
@property (weak,nonatomic) IBOutlet UILabel *detailsuser_name;
@property (weak,nonatomic) IBOutlet UILabel *detailscaption;
@property (weak,nonatomic) IBOutlet UILabel *detailstime;

@end

NS_ASSUME_NONNULL_END
