//
//  StitchingImageView.h
//  GLStitchingImageView
//
//  Created by william on 2019/8/19.
//  Copyright © 2019 william. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StitchingImageView : UIView

@property (nonatomic) CGFloat width;

/**
 default 0
 */
@property (nonatomic) CGFloat radius;

/**
 default 27
 */
@property (nonatomic) CGFloat spaceRatio;

@property (nonatomic, copy) void(^stitchingImageBlock) (UIImageView *iv, NSInteger index);

- (void)reload:(NSInteger)imgCount;

@end

NS_ASSUME_NONNULL_END
