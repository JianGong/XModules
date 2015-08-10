//
//  SWPhotoPicker.m
//  SinaWeather
//
//  Created by cui on 13-2-20.
//
//

#import "SWPhotoPicker.h"
#import "UIImage+Utility.h"
#import "SVProgressHUD.h"

@interface SWPhotoPicker ()
<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (unsafe_unretained, nonatomic) UIViewController *parentController;
@property (copy, nonatomic) void (^completion)(UIImage *image);
@property (assign, nonatomic) UIStatusBarStyle originalStyle;
@end

@implementation SWPhotoPicker

- (id)init
{
    self = [super init];
    if (self) {
        self.allowsEditing=YES;
    }
    return self;
}

- (void)pickPhotoWithPresentingController:(UIViewController *)controller
                               completion:(void (^)(UIImage *image))completion
{
    self.parentController = controller;
    self.completion = completion;
    SWPhotoPickerSourceMask sourceMask = self.sourceMask;
    
    if (sourceMask == 0 && (self.sourceMask & SWPhotoPickerCamera)) {
        [SVProgressHUD showErrorWithStatus:@"没有找到照相机"];
        return;
    }
    
    switch (sourceMask) {
        case SWPhotoPickerAll: {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择需要的操作"
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"打开相机", @"来自相册", nil];
            
            [actionSheet showInView:controller.view];
        }
            break;
        case (SWPhotoPickerCamera):
            [self cameraBigChooseBtnPressed];
            break;
        case SWPhotoPickerAlbum:
            [self pictureBigChooseBtnPressed];
            break;
        default:
            NSLog(@"shouldn't be here, %s, %d", __PRETTY_FUNCTION__, __LINE__);
    }
    
    self.originalStyle=[[UIApplication sharedApplication] statusBarStyle];
}

- (void)dealloc
{
    self.completion = nil;
}

- (void)setAllowsEditing:(BOOL)allowsEditing
{
    _allowsEditing=allowsEditing;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

//  performSelector becouse ipad UIActionSheet already a pop view
    
    if(buttonIndex == 0)
    {
        [self performSelector:@selector(cameraBigChooseBtnPressed) withObject:nil afterDelay:0];
    }
    else if(buttonIndex == 1)
    {
        [self performSelector:@selector(pictureBigChooseBtnPressed) withObject:nil afterDelay:0];
    }
}

-(void)cameraBigChooseBtnPressed
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    imagePicker.allowsEditing=YES;
    imagePicker.edgesForExtendedLayout=UIRectEdgeNone;
    [self.parentController presentViewController:imagePicker animated:YES completion:nil];
}

//点击图片
-(void)pictureBigChooseBtnPressed
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.delegate = self;
    imagePicker.allowsEditing=YES;
    [imagePicker.navigationBar setTranslucent:NO];
    imagePicker.edgesForExtendedLayout=UIRectEdgeNone;
    [self.parentController presentViewController:imagePicker animated:YES completion:nil];
}

    
- (void)navigationController:(UIImagePickerController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]])
    {
        if (navigationController.sourceType==UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
            [navigationController.navigationBar setTranslucent:NO];
            viewController.edgesForExtendedLayout = UIRectEdgeNone;
            navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
        }
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    __block UIImage *newImage = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        newImage = [image imageAdujstOrientation:1200];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.parentController dismissViewControllerAnimated:YES
                                                      completion:^{
                                                          [[UIApplication sharedApplication] setStatusBarStyle:self.originalStyle];
                                                      }];
            [[UIApplication sharedApplication] setStatusBarStyle:self.originalStyle];
            if (self.completion) self.completion(newImage);
        });
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.parentController dismissViewControllerAnimated:YES
                                              completion:^{
                                                  [[UIApplication sharedApplication] setStatusBarStyle:self.originalStyle];
                                              }];
    [[UIApplication sharedApplication] setStatusBarStyle:self.originalStyle];
    if (self.completion) {
        self.completion(nil);
    }
}

@end
