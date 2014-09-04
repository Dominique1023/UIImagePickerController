//
//  ViewController.m
//  UIImageViewPicker
//
//  Created by Dominique on 8/14/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIImage *chosenImage;
@property NSData *imageData;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self whatSourceType];

}

//CHECKING IF THE DEVICE HAS A CAMERA, IF NOT SHOWING AN ALERT VIEW AND ALLOWING THE USER TO CONTINUE WITH THE APP
-(void)whatSourceType{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Device Has No Camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [myAlertView show];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//ONLY WORKS IF DEVICE HAS A CAMERA
- (IBAction)onTakePhotoButtonPressed:(UIButton *)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker animated:YES completion:nil];
}

//GRABBING PHOTOS FROM PHOTO ALBUM
- (IBAction)onSelectPhotoButtonPressed:(UIButton *)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:nil];
}

//UIIMAGEPICKER DELEGATE METHODS
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = self.chosenImage;

    self.imageData = UIImagePNGRepresentation(self.chosenImage);

    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end

