//
//  PwNumKeyBoardView.m
//  CustomKeybord
//
//  Created by King on 2018/1/10.
//  Copyright © 2018年 King. All rights reserved.
//

#import "PwNumKeyBoardView.h"
#import "KBCustomBtn.h"
@implementation PwNumKeyBoardView
{
    NSArray *_allNums;
    NSArray *_allSubTitles;
    NSMutableArray *_arr1;
    NSMutableArray *_arr2;
    NSMutableArray *_allNumBtns;
    
    UIButton *delBtn, *confirmBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _arr1 = [[NSMutableArray alloc] init];
        _arr2 = [[NSMutableArray alloc] init];
        _allNumBtns = [[NSMutableArray alloc] init];
        [self configNumKeyBoard];
    }
    return self;
}
- (void)getAllNums
{
    _allNums = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    _allSubTitles = @[@"",@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"PQR",@"TUV",@"WXYZ",@""];
    
    if (self.allowRandomLayout) {
        [self randomNum];
    }
}

-(void) setForbidClickedShow:(BOOL)forbidClickedShow {
    _forbidClickedShow = forbidClickedShow;
    if (_forbidClickedShow) {
        for (UIButton *tempBtn in _allNumBtns) {
            [tempBtn setBackgroundImage:[UIColor createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        }
        [delBtn setBackgroundImage:[UIColor createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [confirmBtn setBackgroundImage:[UIColor createImageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    }
    
}

-(void) randomNum {
    //以下是随记排版数字
    _allNums = [_allNums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        } else {
            return [obj2 compare:obj1];
        }
    }];
    for (NSInteger i = 0; i < _allNums.count; i++) {
        if(i < 8)
        {
            [_arr1 addObject:_allNums[i]];
        }
        else
        {
            [_arr2 addObject:_allNums[i]];
        }
    }
}

-(void) setAllowRandomLayout:(BOOL)allowRandomLayout {
    _allowRandomLayout = allowRandomLayout;
    if (allowRandomLayout) {
        [self reRankNum];
    }
}


- (void)configNumKeyBoard
{
    [self getAllNums];
    CGFloat leftDiatance = 10;
    CGFloat distance = 8;
    CGFloat btnWidth = (DeviceWidth-leftDiatance*2-distance*2)/3;
    CGFloat bottomBank = 50;
    CGFloat yDistance = 10;
    CGFloat btnStartY = 0;
    CGFloat btnHeight = (self.frame.size.height-btnStartY-bottomBank-yDistance*3 - 40)/4;
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j= 0; j < 3; j++) {
            CGFloat btnX = leftDiatance+j*(btnWidth+distance);
            CGFloat btnY = btnStartY+i*(btnHeight+yDistance);
            KBCustomBtn *btn = [[KBCustomBtn alloc] initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnHeight)];
//            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.buttonType = UIButtonTypeCustom;
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
            btn.backgroundColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
            if(i == 3 && j == 0)
            {
                [btn setImage:[UIImage imageNamed:@"键盘-删除"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                delBtn = btn;
            }
            else if(i == 3 && j == 2)
            {
                [btn setTitle:@"确认" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(returnBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                confirmBtn = btn;
            }
            else
            {
                [btn addTarget:self action:@selector(numBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_allNumBtns addObject:btn];
            }
            [self addSubview:btn];
        }
    }
    [self reRankNum];
}
- (void)numBtnClicked:(KBCustomBtn *)sender
{
    [self buttonBackGroundNormal:sender];
    if(self.btnClickedCallback)
    {
        self.btnClickedCallback(sender.title);
    }
}
- (void)deleteBtnClicked:(KBCustomBtn *)sender
{
    [self buttonBackGroundNormal:sender];
    if(self.deleteBtnClickedCallback)
    {
        self.deleteBtnClickedCallback();
    }
}
- (void)returnBtnClicked:(KBCustomBtn *)sender
{
    [self buttonBackGroundNormal:sender];
    if(self.returnBtnClickedCallback)
    {
        self.returnBtnClickedCallback();
    }
}
- (void)buttonBackGroundNormal:(KBCustomBtn *)sender
{
    sender.backgroundColor = [UIColor whiteColor];
}
- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor grayColor];
}
- (void)reRankNum
{
    [self getAllNums];
    for (NSInteger i = 0; i < _allNumBtns.count; i++) {
        KBCustomBtn *currentBtn = _allNumBtns[i];
        [currentBtn setTitle:_allNums[i]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
