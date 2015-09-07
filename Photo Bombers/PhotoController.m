//
//  PhotoController.m
//  Photo Bombers
//
//  Created by Benedict Aluan on 7/09/15.
//  Copyright (c) 2015 Pencil Rocket. All rights reserved.
//

#import "PhotoController.h"
#import <PINCache/PINCache.h>

@implementation PhotoController

+ (void)imageForPhoto:(NSDictionary *) photo size:(NSString *)size completion:(void(^)(UIImage *image))completion {
    if (photo == nil && size == nil && completion == nil) {
        return;
    }
    
    NSString *key = [[NSString alloc] initWithFormat:@"%@-%@", photo[@"id"], size];
    
    // Retrieve cache
    UIImage *image = [[PINCache sharedCache] objectForKey:key];
    
    if (image) {
        completion(image);
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size][@"url"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        // Set the cache
        [[PINCache sharedCache] setObject:image forKey:key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    }];
    
    [task resume];
}

@end
