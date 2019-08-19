//
//  StitchingImageView.m
//  GLStitchingImageView
//
//  Created by william on 2019/8/19.
//  Copyright © 2019 william. All rights reserved.
//

#import "StitchingImageView.h"

@implementation StitchingImageView

#pragma mark - Super

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupViews];
}

#pragma mark - Self

- (void)setupViews
{
    self.spaceRatio = 27.;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSInteger i = 0; i < 9; i ++) {
        UIImageView *iv = [UIImageView new];
        iv.layer.cornerRadius  = self.radius;
        iv.layer.masksToBounds = YES;
#if DEBUG
        iv.backgroundColor = [UIColor yellowColor];
#endif
        [self addSubview:iv];
    }
}

- (void)reload:(NSInteger)imgCount
{
    for (UIImageView *iv in self.subviews) {
        iv.image  = nil;
        iv.hidden = YES;
    }
    
    CGFloat itemWidth = 0;
    CGFloat margin    = self.width / self.spaceRatio;
    CGFloat oY        = 0;
    
    switch (imgCount) {
        case 1:
            itemWidth = self.width;
            break;
            
        case 2:
            itemWidth = (self.width - margin * 3) / 2;
            oY = (self.width - itemWidth) / 2.;
            break;
            
        case 3:
        case 4:
            itemWidth = (self.width - margin * 3) / 2;
            oY = (self.width - itemWidth * 2) / 3.;
            break;
            
        case 5:
        case 6:
            itemWidth = (self.width - margin * 4) / 3;
            oY = (self.width - itemWidth * 2 - margin) / 2.;
            break;
            
        case 7:
        case 8:
        case 9:
            itemWidth = (self.width - margin * 4) / 3;
            oY = (self.width - itemWidth * 3) / 4.;
            break;
            
        default:
            break;
    }
    
    if (1 == imgCount) {
        UIImageView *iv = self.subviews[0];
        iv.hidden = false;
        iv.frame  = CGRectMake(0, 0, itemWidth, itemWidth);
        !self.stitchingImageBlock ?: self.stitchingImageBlock(iv, 0);
    }
    else if (3 == imgCount || 7 == imgCount) {
        UIImageView *iv = self.subviews[0];
        iv.hidden = false;
        iv.frame  = CGRectMake((self.width - itemWidth) / 2., oY, itemWidth, itemWidth);
        !self.stitchingImageBlock ?: self.stitchingImageBlock(iv, 0);
        
        oY = oY + itemWidth + margin;
    }
    else if (5 == imgCount || 8 == imgCount) {
        UIImageView *iv1 = self.subviews[0];
        iv1.hidden = false;
        iv1.frame  = CGRectMake((self.width - 2 * itemWidth - margin) / 2., oY, itemWidth, itemWidth);
        !self.stitchingImageBlock ?: self.stitchingImageBlock(iv1, 0);
        
        UIImageView *iv2 = self.subviews[1];
        iv2.hidden = false;
        iv2.frame  = CGRectMake(CGRectGetMaxX(iv1.frame) + margin, oY, itemWidth, itemWidth);
        !self.stitchingImageBlock ?: self.stitchingImageBlock(iv2, 1);
        
        oY = oY + itemWidth + margin;
    }
    
    int cellCount;
    int maxRow;
    int maxColumn;
    int ignoreCountOfBegining;
    
    if (imgCount <= 4)
    {
        maxRow = 2;
        maxColumn = 2;
        ignoreCountOfBegining = imgCount % 2;
        cellCount = 4;
    }
    else
    {
        maxRow = 3;
        maxColumn = 3;
        ignoreCountOfBegining = imgCount % 3;
        cellCount = 9;
    }
    
    NSArray *subViews = self.subviews;
    for (NSInteger i = 0; i < imgCount; i ++) {
        if (i > imgCount - 1) break;
        if (i < ignoreCountOfBegining) continue;
        
        int row = floor((float)(i - ignoreCountOfBegining) / maxRow);
        int column = (i - ignoreCountOfBegining) % maxColumn;
        
        CGFloat origin_x = margin + itemWidth * column + margin * column;
        CGFloat origin_y = oY + itemWidth * row + margin * row;
        
        UIImageView *iv = subViews[i];
        iv.hidden = false;
        iv.frame  = CGRectMake(origin_x, origin_y, itemWidth, itemWidth);
        !self.stitchingImageBlock ?: self.stitchingImageBlock(iv, i);
    }
}

@end
