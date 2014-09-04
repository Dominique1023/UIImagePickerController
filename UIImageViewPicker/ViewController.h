//
//  ViewController.h
//  UIImageViewPicker
//
//  Created by Dominique on 8/14/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)onTakePhotoButtonPressed:(UIButton *)sender;
- (IBAction)onSelectPhotoButtonPressed:(UIButton *)sender;

@end
