
//
//  DetailViewController.m
//  Photo Bombers
//
//  Created by Benedict Aluan on 7/09/15.
//  Copyright (c) 2015 Pencil Rocket. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoController.h"

@interface DetailViewController ()

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -320.0, 320.0f, 320.0f)];
    [self.view addSubview:self.imageView];
    
    [PhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:self.view.center];
    [self.animator addBehavior:snap];
}

- (void)close {
    [self.animator removeAllBehaviors];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
    [self.animator addBehavior:snap];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
