//
//  IMAGEViewController.m
//  lexagram
//
//  Created by Olalekan Abdurazaq Adisa on 7/9/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "IMAGEViewController.h"
#import "Post.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "PostViewCell.h"
@interface IMAGEViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIButton *submitPost;

@property (weak, nonatomic) IBOutlet PFTextField *postCaption;
@property (strong, nonatomic) UIImage *originalImage;
@end


@implementation IMAGEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)onTAp:(id)sender {
    
    NSLog(@"I am tapped");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    
    // imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //  [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    
    // Get the image captured by the UIImagePickerController
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.postImage.image = self.originalImage;
    
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)createPost:(id)sender {
    Post *post = [Post new];
    post.caption = self.postCaption.text;
    
    [Post postUserImage:self.originalImage withCaption:self.postCaption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@" ,error.localizedDescription);
        }
        else{
            NSLog(@"The picture was saved!");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    

    
    
    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    
    
    
    
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
      UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
      
      resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
      resizeImageView.image = image;
      
      UIGraphicsBeginImageContext(size);
      [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
      UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      
      return newImage;
  }
    




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
