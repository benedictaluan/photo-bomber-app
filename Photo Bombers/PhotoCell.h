//
//  PhotoCell.h
//  Photo Bombers
//
//  Created by Benedict Aluan on 7/09/15.
//  Copyright (c) 2015 Pencil Rocket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PINCache/PINCache.h>

@interface PhotoCell : UICollectionViewCell

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSDictionary *photo;

@end
