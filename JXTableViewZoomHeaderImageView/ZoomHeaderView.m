//
//  ZoomHeaderView.m
//  JXTableViewZoomHeaderImageView
//
//  Created by jiaxin on 15/12/17.
//  Copyright © 2015年 jiaxin. All rights reserved.
//

#import "ZoomHeaderView.h"
#import "Masonry.h"

@interface ZoomHeaderView ()

@property (nonatomic, assign) ZoomHeaderViewType type;
@property (nonatomic, weak) UIImageView *headerImageView;
//没有约束
@property (nonatomic, assign) CGRect originalHeaderImageViewFrame;
//代码约束
@property (nonatomic, strong) MASConstraint *codeConstraintHeight;
@property (nonatomic, assign) CGFloat originalHeaderImageViewHeight;
//xib约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeightOfHeaderImageView;

@end

@implementation ZoomHeaderView

- (instancetype)initWithFrame:(CGRect)frame type:(ZoomHeaderViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isNeedNarrow = YES;
        self.type = type;
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.isNeedNarrow = YES;
        [self initUIXibConstraint];
    }
    return self;
}

- (void)initUI
{
    switch (self.type) {
        case ZoomHeaderViewTypeNoConstraint:
            [self initUINoConstraint];
            break;
        case ZoomHeaderViewTypeCodeConstraint:
            [self initUICodeConstraint];
            break;
        default:
            break;
    }
}

- (void)initUINoConstraint
{
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    headerImageView.clipsToBounds = YES;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.image = [UIImage imageNamed:@"lufei.jpg"];
    [self addSubview:headerImageView];
    self.headerImageView = headerImageView;
    self.originalHeaderImageViewFrame = self.bounds;
}

- (void)initUICodeConstraint
{
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.clipsToBounds = YES;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.image = [UIImage imageNamed:@"lufei.jpg"];
    [self addSubview:headerImageView];
    self.headerImageView = headerImageView;
    //约束设置为：跟父视图左、下、右贴紧，再约束高度，所以更新高度约束的时候会向上增加，xib约束同理
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self).offset(0);
        self.codeConstraintHeight = make.height.equalTo(@(self.bounds.size.height));
    }];
    self.originalHeaderImageViewHeight = self.bounds.size.height;
}

- (void)initUIXibConstraint
{
    self.type = ZoomHeaderViewTypeXibConstraint;
    self.originalHeaderImageViewHeight = self.bounds.size.height;
}

- (void)updateHeaderImageViewFrameWithOffsetY:(CGFloat)offsetY
{
    //用于实现向上滚动的时候，图片不变窄
    if (!self.isNeedNarrow && offsetY > 0) {
        return;
    }
    switch (self.type) {
        case ZoomHeaderViewTypeNoConstraint:
        {
            //防止height小于0
            if (self.originalHeaderImageViewFrame.size.height - offsetY < 0) {
                return;
            }
            //如果不使用约束的话，图片的y值要上移offsetY,同时height也要增加offsetY
            CGFloat x = self.originalHeaderImageViewFrame.origin.x;
            CGFloat y = self.originalHeaderImageViewFrame.origin.y + offsetY;
            CGFloat width = self.originalHeaderImageViewFrame.size.width;
            CGFloat height = self.originalHeaderImageViewFrame.size.height - offsetY;
            self.headerImageView.frame = CGRectMake(x, y, width, height);
        }
            break;
        case ZoomHeaderViewTypeCodeConstraint:
        {
            //防止height小于0
            if (self.originalHeaderImageViewHeight -offsetY < 0) {
                return;
            }
            //第一种方式：获取到这个约束，直接对约束值修改
            //self.codeConstraintHeight.equalTo(@(self.originalHeaderImageViewHeight -offsetY));
            //第二种方式：直接使用masonry提供的更新约束方法，其实原理是一样的
            [self.headerImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.originalHeaderImageViewHeight -offsetY));
            }];
        }
            break;
        case ZoomHeaderViewTypeXibConstraint:
        {
            //防止height小于0
            if (self.originalHeaderImageViewHeight -offsetY < 0) {
                return;
            }
            self.layoutHeightOfHeaderImageView.constant = self.originalHeaderImageViewHeight - offsetY;
        }
            break;
        default:
            break;
    }
    

}

@end
