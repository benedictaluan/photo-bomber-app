//
//  PhotoCell.m
//  Photo Bombers
//
//  Created by Benedict Aluan on 7/09/15.
//  Copyright (c) 2015 Pencil Rocket. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"images"][@"thumbnail"][@"url"]];
    [self dowloadPhotoWithURL:url];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Makes image view fill the cell
    self.imageView.frame = self.contentView.bounds;
}

- (void)dowloadPhotoWithURL:(NSURL *)url {
    NSString *key = [[NSString alloc] initWithFormat:@"%@-thumbnail", self.photo[@"id"]];

    // Retrieve cache
    UIImage *photo = [[PINCache sharedCache] objectForKey:key];
    
    if (photo) {
        self.imageView.image = photo;
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        // Set the cache
        [[PINCache sharedCache] setObject:image forKey:key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    
    [task resume];
}

@end
