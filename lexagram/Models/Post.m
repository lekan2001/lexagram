//
//  Post.m
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/8/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "Post.h"
#import "NSDate+DateTools.h"
@implementation Post
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
+ (nonnull NSString *)parseClassName {
    return @"Post";
}
+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    NSString *createdAtOriginalString = newPost[@"createdAt"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    newPost.createdAtString = [date shortTimeAgoSinceNow];
    
    [newPost saveInBackgroundWithBlock: completion];
}
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        if (!image) {
           return nil;
        }
        return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    }
//    NSData *imageData = UIImagePNGRepresentation(image);
//    // get image data and check if that is not nil
//    if (!imageData) {
//        return nil;
//    }
//    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];

@end
