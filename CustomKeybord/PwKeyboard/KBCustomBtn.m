//
//  KBCustomBtn.m
//  CustomKeybord
//
//  Created by Ketty on 2018/1/24.
//  Copyright © 2018年 Ketty. All rights reserved.
//

#import "KBCustomBtn.h"

@implementation KBCustomBtn
{
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self configSubTitle];
    }
    return self;
}
- (void)configSubTitle
{
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 35)];
    [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 15)];
    _subTitleLabel.font = [UIFont systemFontOfSize:13];
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_subTitleLabel];
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    _subTitleLabel.text = subTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
