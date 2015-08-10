//
//  SXViewController.m
//  SXClient
//
//  Created by iBcker on 14-9-13.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXViewController.h"
#import "SXButton.h"
#import "UIViewController+isPresentModal.h"
#import "SXApp.h"

@interface SXViewController ()
@end

@implementation SXViewController

- (id)init
{
    self=[super init];
    if (self) {
        self.needLeftPresentCloseButton=YES;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.needLeftPresentCloseButton=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if (self.needLeftPresentCloseButton&&self.isPresentModal&&!self.navigationItem.leftBarButtonItem) {
        UIButton *closeButton = [[SXButton alloc] initWithFrame:CGRectMake(0, 0, 49, 40)];
        [closeButton setTitle:SXLocalString(@"nav->button->关闭") forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    }
    // Do any additional setup after loading the view.
}

- (void)onClose:(id)sender
{
    if (self.isPresentModal) {
        [self.navigationController dismissViewControllerAnimated:YES
                                                      completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
