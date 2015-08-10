//
//  DismissSegue.m
//  
//
//  Created by iBcker on 15/6/12.
//
//

#import "DismissSegue.h"

@implementation DismissSegue
- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"kDidLoginNotif" object:nil];
}
@end
