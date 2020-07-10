//
//  PostViewCell.h
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/9/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface PostViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet  PFImageView *postImage;
@property(strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;


@end

NS_ASSUME_NONNULL_END
