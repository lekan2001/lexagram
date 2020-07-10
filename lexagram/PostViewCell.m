//
//  PostViewCell.m
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/9/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "PostViewCell.h"

@implementation PostViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPost:(Post *)post {
    _post = post;
    self.postCaption.text = post[@"caption"];
    self.postImage.file = post[@"image"];
    [self.postImage loadInBackground:nil progressBlock:nil];
    
}
//
//- (IBAction)likeTap:(id)sender {
//    if (self.post.likeCount) {
//
//    }
    
//    self.post.likeCount = self.post.likeCount + NSNumber numberWithInt:1;
//
//    NSNumber *bNumber = [NSNumber numberWithInt:[self.post.likeCount intValue] + 1];
//    self.likeButton.titleLabel = self.post.likeCount.bNumber;
    
//}




@end
