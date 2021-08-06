//
//  PwSymbolKeyboard.m
//  CustomKeybord
//
//  Created by King on 2018/1/10.
//  Copyright © 2018年 King. All rights reserved.
//

#import "PwSymbolKeyboard.h"
#import "KeyBoardConstant.h"
@implementation PwSymbolKeyboard
{
    NSMutableArray *_firArr;
    NSMutableArray *_secArr;
    NSMutableArray *_thirArr;
    NSMutableArray *_forthArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _firArr = [[NSMutableArray alloc] init];
        _secArr = [[NSMutableArray alloc] init];
        _thirArr = [[NSMutableArray alloc] init];
        _forthArr = [[NSMutableArray alloc] init];
        [self configSymbolKeyboard];
    }
    return self;
}
- (void)getAllSymbols
{
//    NSArray *letters =@[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",@"_",@"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",@".",@",",@"?",@"!",@"'",@"",@"|",@"~",@"`",@"<",@">",@"n",@"m",@"",@""];
    NSArray *letters = @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",
                         @"_",@"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",
                         @".",@",",@"?",@"!",@"'",@"\\",@"|",@"~",@"`",
                         @"<",@">",@"€",@"￡",@"￥",@"\"",@""];
    for (NSInteger i = 0; i < letters.count; i++) {
        if(i < 10)
        {
            [_firArr addObject:letters[i]];
        }
        else if(i < 20)
        {
            [_secArr addObject:letters[i]];
        }
        else if(i < 29)
        {
            [_thirArr addObject:letters[i]];
        }
        else
        {
            [_forthArr addObject:letters[i]];
        }
    }
}
- (void)configSymbolKeyboard
{
    [self getAllSymbols];
    CGFloat xDistance = 5;
    CGFloat yDistance = 10;
    CGFloat bottomBank = 5;
    CGFloat btnWidth = (DeviceWidth-5*(_firArr.count+1))/_firArr.count;
    CGFloat btnHeight = (self.frame.size.height-yDistance*3-bottomBank - 40)/4;
    for (NSInteger i = 0; i < _firArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(xDistance+i*(xDistance+btnWidth), 0, btnWidth, btnHeight) title:_firArr[i] contentView:self];
        [btn addTarget:self action:@selector(symbolBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    }
    CGFloat secBtnY = yDistance+btnHeight;
    for (NSInteger i = 0; i < _secArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(xDistance+i*(xDistance+btnWidth), secBtnY, btnWidth, btnHeight) title:_secArr[i] contentView:self];
        [btn addTarget:self action:@selector(symbolBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    }
    for (NSInteger i = 0; i < _thirArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(xDistance+i*(xDistance+btnWidth), secBtnY*2, btnWidth, btnHeight) title:_thirArr[i] contentView:self];
        [btn addTarget:self action:@selector(symbolBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    }
    for (NSInteger i = 0; i < _forthArr.count; i++) {
        UIButton *btn = [self configBtn:CGRectMake(xDistance+i*(xDistance+btnWidth), secBtnY*3, btnWidth, btnHeight) title:_forthArr[i] contentView:self];
        if (i == _forthArr.count - 1) {
//            btn.frame.size.width = btnWidth*2;
            CGRect getBtnFrame = btn.frame;
            getBtnFrame.size.width = btnWidth*2;
            
            btn.frame = getBtnFrame;
            [btn setImage:[UIImage imageNamed:@"键盘-空格"] forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor greenColor];
        }
        [btn addTarget:self action:@selector(symbolBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    }
    //删除键
    UIButton *deleteBtn = [self configBtn:CGRectMake(xDistance+9*(xDistance+btnWidth), secBtnY*2, btnWidth+xDistance, btnHeight) title:@"delete" contentView:self];
    [deleteBtn setTitle:@"" forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"键盘-删除"] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = KBColorFromRGB(0xE5E5E5);//[UIColor grayColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //确认键
    UIButton *returnBtn = [self configBtn:CGRectMake(xDistance+8*(xDistance+btnWidth), secBtnY*3, btnWidth*2+xDistance*2, btnHeight) title:@"确认" contentView:self];
    returnBtn.backgroundColor = [UIColor whiteColor];
    [returnBtn addTarget:self action:@selector(returnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)symbolBtnClicked:(UIButton *)sender
{
    [self buttonBackGroundNormal:sender];
    if(self.btnClickedCallback)
    {
        self.btnClickedCallback(sender.currentTitle);
    }
}
- (void)deleteBtnClicked
{
    if(self.deleteBtnClickedCallback)
    {
        self.deleteBtnClickedCallback();
    }
}
- (void)returnBtnClicked
{
    if(self.returnBtnClickedCallback)
    {
        self.returnBtnClickedCallback();
    }
}
- (void)buttonBackGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = [UIColor whiteColor];
}
- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor grayColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
