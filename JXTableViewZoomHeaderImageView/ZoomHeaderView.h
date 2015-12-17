//
//  ZoomHeaderView.h
//  JXTableViewZoomHeaderImageView
//
//  Created by jiaxin on 15/12/17.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZoomHeaderViewType) {
    ZoomHeaderViewTypeNoConstraint,
    ZoomHeaderViewTypeCodeConstraint,
    ZoomHeaderViewTypeXibConstraint,
};

@interface ZoomHeaderView : UIView

//是否需要向上滑动的时候图片收缩，默认YES，具体效果看Demo
@property (nonatomic, assign) BOOL isNeedNarrow;
- (instancetype)initWithFrame:(CGRect)frame type:(ZoomHeaderViewType)type;
- (void)updateHeaderImageViewFrameWithOffsetY:(CGFloat)offsetY;

@end
