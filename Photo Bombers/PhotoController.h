//
//  PhotoController.h
//  Photo Bombers
//
//  Created by Benedict Aluan on 7/09/15.
//  Copyright (c) 2015 Pencil Rocket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *) photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
