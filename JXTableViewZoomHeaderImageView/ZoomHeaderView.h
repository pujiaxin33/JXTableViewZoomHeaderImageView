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

- (instancetype)initWithFrame:(CGRect)frame type:(ZoomHeaderViewType)type;
- (void)updateHeaderImageViewFrameWithOffsetY:(CGFloat)offsetY;

@end
