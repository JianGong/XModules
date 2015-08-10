//
//  SWPhotoPicker.h
//  SinaWeather
//
//  Created by cui on 13-2-20.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    SWPhotoPickerNone = 0,
    SWPhotoPickerCamera = 1,
    SWPhotoPickerAlbum = 2,
    SWPhotoPickerAll = SWPhotoPickerAlbum | SWPhotoPickerCamera
} SWPhotoPickerSourceMask;

@interface SWPhotoPicker : NSObject
@property (nonatomic) SWPhotoPickerSourceMask sourceMask;
@property (nonatomic) BOOL allowsEditing; //default = YES

- (void)pickPhotoWithPresentingController:(UIViewController *)controller
                               completion:(void (^)(UIImage *image))completion;

@end
