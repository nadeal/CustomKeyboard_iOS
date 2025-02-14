//
//  ViewController.m
//  CustomKeybord
//
//  Created by King on 2018/1/9.
//  Copyright © 2018年 King. All rights reserved.
//

#import "ViewController.h"
#import "PwCustomKeyboard.h"
@interface ViewController ()<CustomKeyboardDelegate>
@property (strong, nonatomic) UITextView *textView;
@property(nonatomic, strong)  UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 100, 300, 200)];
//    self.textView.backgroundColor = [UIColor greenColor];
//    PwCustomKeyboard *keyboard = [[PwCustomKeyboard alloc] initWithTextView:self.textView];
//    keyboard.delegate = self;
//    self.textView.inputView = keyboard;
//    [self.textView becomeFirstResponder];
//    [self.view addSubview:self.textView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, 300, 200)];
    self.textField.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.textField];
    // Do any additional setup after loading the view, typically from a nib.
    
    PwCustomKeyboard *keyboard = [[PwCustomKeyboard alloc] initWithTextField:self.textField];
    keyboard.delegate = self;
//    keyboard.forbidClickedShow = YES;
//    keyboard.onlyKeyboardType = PWKeyboardTypeNum;
//    keyboard.allowRandomLayout = YES;
//    keyboard.forbidKeyBoardType = PWKeyboardTypeSymbol;
    self.textField.inputView = keyboard;
    
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 80, 40)];
    tempBtn.backgroundColor = [UIColor grayColor];
    [tempBtn setTitle:@"收起键盘" forState:UIControlStateNormal];
    tempBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [tempBtn addTarget:self action:@selector(onTempBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempBtn];
}

-(void) onTempBtnPressed {
    [self.textField resignFirstResponder];
}

#pragma mark - HJFCustomLoginKeyboardDelegate
- (void)customKeyboardDidClickedReturn:(PwCustomKeyboard *)customKeyboard
{
    //至于点击键盘上的return键后想干什么就自己决定了...
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
