//
//  PwCustomKeyboard.m
//  CustomKeybord
//
//  Created by King on 2018/1/9.
//  Copyright © 2018年 King. All rights reserved.
//

#import "PwCustomKeyboard.h"
#import "PwLettersKeyboard.h"
#import "PwNumKeyBoardView.h"
#import "PwSymbolKeyboard.h"



typedef NS_ENUM(NSInteger, CustomKeyboardType)
{
    CustomKeyboardType_Num  = 1,//数字
    CustomKeyboardType_Letters  = 2,//字母
    CustomKeyboardType_Symbol  = 3//符号
};
@interface PwCustomKeyboard()
{
    NSMutableArray *keyboardBtnArray;
    UILabel *safeTitleLabel;
}

/** 三种键盘样式---数字、字母、符号 */
@property(nonatomic, strong) PwLettersKeyboard *letterKeyboard;
@property(nonatomic, strong) PwNumKeyBoardView *numKeyboard;
@property(nonatomic, strong) PwSymbolKeyboard *symbolKeyboard;
@end

@implementation PwCustomKeyboard
static CGFloat keyY = 50;
- (instancetype)initWithTextView:(UITextView *)textView
{
    self = [super init];
    if(self)
    {
        keyboardBtnArray = [NSMutableArray array];
        self.textView = textView;
        [self viewInit];
    }
#ifndef DEBUG
    if (TARGET_IPHONE_SIMULATOR) {
        abort();
    }
#endif
    return self;
}
- (instancetype)initWithTextField:(UITextField *)field
{
    self = [super init];
    if(self)
    {
        keyboardBtnArray = [NSMutableArray array];
        self.frame = CGRectMake(0, G_SCREEN_H - 350, G_SCREEN_W, 350);
        self.textField = field;
        [self viewInit];
    }
    return self;
}
- (void)viewInit
{
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self configKeyboardType];
    [self configNumKeyBoard];
    [self configLetterKeyboard];
    [self configSymbolKeyboard];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
}

-(void) willShowKeyboard:(NSNotification*) notify {
    if (self.onlyKeyboardType == PWKeyboardTypeNum) {
        [self clickNumTypeBtn];
    }
}

-(void) setOnlyKeyboardType:(PWKeyboardType)onlyKeyboardType {
    _onlyKeyboardType = onlyKeyboardType;
    [self typeBtnClicked:keyboardBtnArray[onlyKeyboardType - 1]];
    for (UIButton *tempBtn in keyboardBtnArray) {
        tempBtn.hidden = YES;
    }
}

-(void) setAllowRandomLayout:(BOOL)allowRandomLayout {
    _allowRandomLayout = allowRandomLayout;
    if (allowRandomLayout) {
        if (_numKeyboard != nil) {
            _numKeyboard.allowRandomLayout = allowRandomLayout;
        }
    }
}

-(void) setForbidClickedShow:(BOOL)forbidClickedShow {
    _forbidClickedShow = forbidClickedShow;
    if (_numKeyboard) {
        _numKeyboard.forbidClickedShow = forbidClickedShow;
    }
    if (_letterKeyboard) {
        _letterKeyboard.forbidClickedShow = forbidClickedShow;
    }
    if (_symbolKeyboard) {
        _symbolKeyboard.forbidClickedShow = forbidClickedShow;
    }
}

-(void) setForbidKeyBoardType:(PWKeyboardType)forbidKeyBoardType {
    _forbidKeyBoardType = forbidKeyBoardType;
    
    UIButton *getBtn = keyboardBtnArray[forbidKeyBoardType-1];
    [getBtn removeFromSuperview];
    [keyboardBtnArray removeObject:getBtn];
    [self typeBtnClicked:keyboardBtnArray[0]];
    
    CGFloat btnWidth = getBtn.frame.size.width;
    for (int i = 0; i < keyboardBtnArray.count; i ++) {
        UIButton *tempBtn = keyboardBtnArray[i];
        CGRect getFrame = tempBtn.frame;
        getFrame.origin.x = (DeviceWidth/2)+(i + 1)*btnWidth;
        tempBtn.frame = getFrame;
    }
}

/**
  *  锁定键盘高度
  */
- (void)setFrame:(CGRect)frame
{
//    frame.size.height = 350;//AUTO_ADAPT_SIZE_VALUE(233, 253, 283);
    frame = CGRectMake(0, G_SCREEN_H - 350, G_SCREEN_W, 350);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
//    bounds.size.height = 350;//AUTO_ADAPT_SIZE_VALUE(233, 253, 283);
    [super setBounds:bounds];
}

//创建三种键盘切换button
- (void)configKeyboardType
{
    
    safeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 140, 40)];
    safeTitleLabel.backgroundColor = [UIColor clearColor];
    safeTitleLabel.text = @"安全键盘";
    safeTitleLabel.textColor = [UIColor blackColor];
    safeTitleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:safeTitleLabel];
    
    
    NSInteger btnTypeCount = 3;
    CGFloat btnWidth = (DeviceWidth/2)/btnTypeCount;
    CGFloat btnHeight = 40;
    NSArray *titles = @[@"数字",@"字母",@"符号"];
    for (NSInteger i = 0; i < btnTypeCount; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((DeviceWidth/2)+i*btnWidth, 5, btnWidth, btnHeight);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.210 green:0.621 blue:0.846 alpha:1.00] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.tag = (CustomKeyboardType)i+1;
//        if(i == 1)
//        {
//            //默认字母键盘
//            btn.selected = YES;
//        }
        [btn addTarget:self action:@selector(typeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [keyboardBtnArray addObject:btn];
    }
    [self typeBtnClicked:keyboardBtnArray[1]];
}
//点击切换键盘
- (void)typeBtnClicked:(UIButton *)sender
{
    if(sender.selected)
    {
        return;
    }
    UIButton *btn_num = [self viewWithTag:CustomKeyboardType_Num];
    UIButton *btn_let = [self viewWithTag:CustomKeyboardType_Letters];
    UIButton *btn_sym = [self viewWithTag:CustomKeyboardType_Symbol];
    sender.selected = YES;
    if(sender == btn_num)
    {
        btn_let.selected = NO;
        btn_sym.selected = NO;
        [self clickNumTypeBtn];
    }
    if(sender == btn_let)
    {
        btn_num.selected = NO;
        btn_sym.selected = NO;
        [self clickLetterTypeBtn];
    }
    if(sender == btn_sym)
    {
        btn_num.selected = NO;
        btn_let.selected = NO;
        [self clickSymbleTypeBtn];
    }
}
//创建字母键盘
- (void)configLetterKeyboard
{
    self.letterKeyboard = [[PwLettersKeyboard alloc] initWithFrame:CGRectMake(0, keyY, DeviceWidth, self.frame.size.height-keyY)];
    WS(weakSelf, self);
    [self.letterKeyboard setBtnClickedCallback:^(NSString *str) {
        if (!weakSelf.allowSpace && [str containsString:@" "]) {
            return;
        }
        
        if (weakSelf.textField && [weakSelf.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            NSRange getRange = NSMakeRange(weakSelf.textField.text.length, 0);
            BOOL isOk = [weakSelf.textField.delegate textField:weakSelf.textField shouldChangeCharactersInRange:getRange replacementString:str];
            if (isOk) {
                [weakSelf.textView?weakSelf.textView:weakSelf.textField  insertText:str];
            }
        } else if (weakSelf.textView && [weakSelf.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [weakSelf.textView.delegate textViewDidChange:weakSelf.textView];
            [weakSelf.textView?weakSelf.textView:weakSelf.textField  insertText:str];
        } else {
            [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
        }
        
    }];
    [self.letterKeyboard setDeleteBtnClickedCallback:^{
        [weakSelf.textView?weakSelf.textView:weakSelf.textField deleteBackward];
        if (weakSelf.textField && [weakSelf.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            NSRange getRange = NSMakeRange(weakSelf.textField.text.length, 0);
            [weakSelf.textField.delegate textField:weakSelf.textField shouldChangeCharactersInRange:getRange replacementString:@""];
        } else if (weakSelf.textView && [weakSelf.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [weakSelf.textView.delegate textViewDidChange:weakSelf.textView];
        }
    }];
    [self.letterKeyboard setReturnBtnClickedCallback:^{
        if([weakSelf.delegate respondsToSelector:@selector(customKeyboardDidClickedReturn:)])
        {
            [weakSelf.delegate customKeyboardDidClickedReturn:weakSelf];
        }
    }];
    [self addSubview:self.letterKeyboard];
}
//创建数字键盘
- (void)configNumKeyBoard
{
    self.numKeyboard = [[PwNumKeyBoardView alloc] initWithFrame:CGRectMake(0, keyY, DeviceWidth, self.frame.size.height-keyY)];
    self.numKeyboard.allowRandomLayout = self.allowRandomLayout;
    WS(weakSelf, self);
    [self.numKeyboard setBtnClickedCallback:^(NSString *str) {
        if (!weakSelf.allowSpace && [str containsString:@" "]) {
            return;
        }
        
        if (weakSelf.textField && [weakSelf.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            NSRange getRange = NSMakeRange(weakSelf.textField.text.length, 0);
            BOOL isOk = [weakSelf.textField.delegate textField:weakSelf.textField shouldChangeCharactersInRange:getRange replacementString:str];
            if (isOk) {
                [weakSelf.textView?weakSelf.textView:weakSelf.textField  insertText:str];
            }
        } else if (weakSelf.textView && [weakSelf.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [weakSelf.textView.delegate textViewDidChange:weakSelf.textView];
            [weakSelf.textView?weakSelf.textView:weakSelf.textField  insertText:str];
        } else {
            [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
        }
        
    }];
    [self.numKeyboard setDeleteBtnClickedCallback:^{
        [weakSelf.textView?weakSelf.textView:weakSelf.textField deleteBackward];
        if (weakSelf.textField && [weakSelf.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            NSRange getRange = NSMakeRange(weakSelf.textField.text.length, 0);
            [weakSelf.textField.delegate textField:weakSelf.textField shouldChangeCharactersInRange:getRange replacementString:@""];
        } else if (weakSelf.textView && [weakSelf.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [weakSelf.textView.delegate textViewDidChange:weakSelf.textView];
        }
    }];
    [self.numKeyboard setReturnBtnClickedCallback:^{
        if([weakSelf.delegate respondsToSelector:@selector(customKeyboardDidClickedReturn:)])
        {
            [weakSelf.delegate customKeyboardDidClickedReturn:weakSelf];
        }
    }];
}
//创建符号键盘
- (void)configSymbolKeyboard
{
    self.symbolKeyboard = [[PwSymbolKeyboard alloc] initWithFrame:CGRectMake(0, keyY, DeviceWidth, self.frame.size.height-keyY)];
    WS(weakSelf, self);
    [self.symbolKeyboard setBtnClickedCallback:^(NSString *str) {
        if (!weakSelf.allowSpace && [str containsString:@" "]) {
            return;
        }
        
        if (weakSelf.textField && [weakSelf.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            NSRange getRange = NSMakeRange(weakSelf.textField.text.length, 0);
            BOOL isOk = [weakSelf.textField.delegate textField:weakSelf.textField shouldChangeCharactersInRange:getRange replacementString:str];
            if (isOk) {
                [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
            }
        } else if (weakSelf.textView && [weakSelf.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [weakSelf.textView.delegate textViewDidChange:weakSelf.textView];
            [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
        } else {
            [weakSelf.textView?weakSelf.textView:weakSelf.textField insertText:str];
        }
        
    }];
    [self.symbolKeyboard setDeleteBtnClickedCallback:^{
        [weakSelf.textView?weakSelf.textView:weakSelf.textField deleteBackward];
        if (weakSelf.textField && [weakSelf.textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            NSRange getRange = NSMakeRange(weakSelf.textField.text.length, 0);
            [weakSelf.textField.delegate textField:weakSelf.textField shouldChangeCharactersInRange:getRange replacementString:@""];
        } else if (weakSelf.textView && [weakSelf.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [weakSelf.textView.delegate textViewDidChange:weakSelf.textView];
        }
    }];
    [self.symbolKeyboard setReturnBtnClickedCallback:^{
        if([weakSelf.delegate respondsToSelector:@selector(customKeyboardDidClickedReturn:)])
        {
            [weakSelf.delegate customKeyboardDidClickedReturn:weakSelf];
        }
    }];
}
- (void)clickNumTypeBtn
{
    [self.letterKeyboard removeFromSuperview];
    [self.symbolKeyboard removeFromSuperview];
    [self addSubview:self.numKeyboard];
    [self.numKeyboard reRankNum];
}
- (void)clickLetterTypeBtn
{
    [self.numKeyboard removeFromSuperview];
    [self.symbolKeyboard removeFromSuperview];
    [self addSubview:self.letterKeyboard];
}
- (void)clickSymbleTypeBtn
{
    [self.numKeyboard removeFromSuperview];
    [self.letterKeyboard removeFromSuperview];
    [self addSubview:self.symbolKeyboard];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
