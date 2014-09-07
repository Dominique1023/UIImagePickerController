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
@property (weak, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (weak, nonatomic) IBOutlet UIImageView *flippedImageView;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self whatSourceType];

    //Adding a tapGesture on the image
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flipImage)];
    tap.numberOfTapsRequired = 1;

    [self.chosenImageView addGestureRecognizer:tap];
}

-(void)flipImage{
    //copying and flipping the image and storying it in a new image
    UIImage *flippedImage = [UIImage imageWithCGImage:self.chosenImage.CGImage scale:self.chosenImage.scale orientation:UIImageOrientationUpMirrored];
    self.flippedImageView.image = flippedImage;

    //making the transition NOTE: the images have to be in their own UIView for the transition to work, otherwise it will animate the whole ViewController
    [UIView transitionFromView:self.chosenImageView toView:self.flippedImageView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
}

//CHECKING IF THE DEVICE HAS A CAMERA, IF NOT SHOW AN ALERT VIEW AND ALLOWING THE USER TO CONTINUE WITH THE APP
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
    //creating an instance of a UIImagePickerController and instantiate it
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;

    picker.allowsEditing = YES;

    //tells the picker that the image is going to come from the camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    //opens up the camera
    [self presentViewController:picker animated:YES completion:nil];
}

//GRABBING PHOTOS FROM PHOTO ALBUM
- (IBAction)onSelectPhotoButtonPressed:(UIButton *)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;

    //allows the user to edit the photo by displaying it.
    //if you want the picture displayed on a view than this is needed
    picker.allowsEditing = YES;

    //tells the picker that image is going to come from the photo library on the device
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    //openes up the library
    [self presentViewController:picker animated:YES completion:nil];
}

//REQUIRED UIIMAGEPICKER DELEGATE METHODS
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    //takes the image taken/chosen and puts it in a dictionary used for editing and displaying
    self.chosenImage = info[UIImagePickerControllerEditedImage];

    //sets the chosen image to the image view on the view controller
    self.chosenImageView.image = self.chosenImage;

    //changes the data from the image to a PNG file
    self.imageData = UIImagePNGRepresentation(self.chosenImage);

    //dismisses the camera
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//needed if the user changes their mind about the photo
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClearButtonPressed:(id)sender {
    self.chosenImageView.image = nil;
}


@end

