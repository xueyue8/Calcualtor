//
//  RootViewController.m
//  Calcualtor
//
//  Created by Ibokan on 14-3-14.
//  Copyright (c) 2014年 gg. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
//延展
//用于声明私有变量
@interface RootViewController ()
{//输出面板
    //lable 用于展示文字控件
    UILabel * _resultLable;
    //输出面板数据
    NSMutableString * _resultStr;
    //临时存储变量
    //a+b;
    //当输入完加号后，再输入b是，用temp
    NSMutableString * _tempStr;
    NSString * flag;
}
@end

@implementation RootViewController

//当前VC视图加载完成时，该方法被调用


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor greenColor]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    //创建输出面板
    _resultLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    [_resultLable setBackgroundColor:[UIColor blackColor]];
    [_resultLable setTextColor:[UIColor whiteColor]];
    [_resultLable setFont:[UIFont systemFontOfSize:40]];
    [_resultLable setTextAlignment:NSTextAlignmentRight];
    [_resultLable setText:@"0"];
    
    //将输出面板加载到当前视图中
    [self.view addSubview:_resultLable];
    //外循环控制行
    for (int i=1; i<=5; i++) {
        for (int j=1; j<=4; j++) {
            UIButton * b=[UIButton buttonWithType:UIButtonTypeCustom];
            float px=(j-1)*80;
            float py=i*77;
            [b setFrame:CGRectMake(px, py, 75, 73)];
            [b setBackgroundColor:[UIColor grayColor]];
            [b setTitle:@"Button" forState:UIControlStateNormal];
            //设置Button的tag值，方便随后判断
            b.tag=(i-1)*4+j;
            [b addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
           // [b.layer setMasksToBounds:YES];
            [b.layer setCornerRadius:20];
            [b.layer setShadowColor:[UIColor whiteColor].CGColor];
            [b.layer setShadowOffset:CGSizeMake(5, 5)];
            [b.layer setShadowOpacity:1];
            [b.layer setBorderWidth:1];
            [b.layer setBorderColor:[UIColor whiteColor].CGColor];
            if (b.tag%4==0) {
                [b setBackgroundColor:[UIColor brownColor]];
                
            }
            [b.titleLabel setFont:[UIFont systemFontOfSize:40]];
            NSArray * titles=[NSArray arrayWithObjects:@"C",@"±",@"%",@"÷",@"7",@"8",@"9",@"×", @"4",@"5",@"6",@"-",@"1",@"2",@"3",@"+",@"0",@".",@"00",@"=",nil];
            [b setTitle:titles[b.tag-1] forState:UIControlStateNormal];
            [b setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//            if (b.tag==19) {
//                [b setUserInteractionEnabled:NO];
//                
//            }
//            if (b.tag==18) {
//                [b setFrame:CGRectMake(75, 400, 160, 75)];
//            }
            [self.view addSubview:b];
        }
    }
    
    
	// Do any additional setup after loading the view.
}
-(void)doButton:(UIButton *)b
{
    NSLog(@"tag:%d",b.tag);
    if (b.tag%4==0 || b.tag<4) {
        [self doOperata:b];
    }
    if (b.tag>4 && b.tag%4!=0) {
        if (_resultStr==nil) {
            _resultStr=[NSMutableString string];
        }
        [_resultStr appendString:b.titleLabel.text];
        _resultLable.text=_resultStr;
    }
}
-(void)doOperata:(UIButton *)b
{
//    char c=[b.titleLabel.text characterAtIndex:0];
//    NSLog(@"%c",c);
    NSString  * text=b.titleLabel.text;
    if ([text isEqualToString:@"C"]) {
         [_resultStr  setString:@"0"];
         [_resultLable setText:_resultStr];
    }
    if ([text isEqualToString:@"±"]) {
        float revertValue=-_resultStr.floatValue;
        _resultStr=[NSMutableString stringWithFormat:@"%f",revertValue];
        [_resultLable setText:_resultStr];
        
    }
    if ([text isEqualToString:@"%"]) {
                float percentValue=_resultStr.floatValue/100;
        _resultStr=[NSMutableString stringWithFormat:@"%f",percentValue];
        [_resultLable setText:_resultStr];
        
    
    }
    if ([text isEqualToString:@"÷"]) {
        _tempStr=[NSMutableString stringWithFormat:@"%@",_resultStr];
        flag=@"÷";
        [_resultStr setString:@""];
    }
    if ([text isEqualToString:@"×"]) {
        _tempStr=[NSMutableString stringWithFormat:@"%@",_resultStr];
        flag=@"×";
        [_resultStr setString:@""];
        NSLog(@"乘数是%@",_tempStr);
    }
    if ([text isEqualToString:@"-"]) {
        _tempStr=[NSMutableString stringWithFormat:@"%@",_resultStr];
        flag=@"-";
        [_resultStr setString:@""];
    }
    if ([text isEqualToString:@"+"]) {
        _tempStr=[NSMutableString stringWithFormat:@"%@",_resultStr];
        flag=@"+";
        [_resultStr setString:@""];
    }
    if ([text isEqualToString:@"="]) {
        float result;
        if (flag==@"÷") {
         result=_tempStr.floatValue/_resultStr.floatValue;
        }
        if (flag==@"-") {
         result=_tempStr.floatValue-_resultStr.floatValue;
        }
        if (flag==@"+") {
          result=_tempStr.floatValue+_resultStr.floatValue;
        }
        if (flag==@"×") {
            
        
        result=_tempStr.floatValue*_resultStr.floatValue;
       
       // _resultStr=[NSMutableString stringWithFormat:@"%f",result];
        }
        _resultStr=[NSMutableString stringWithFormat:@"%f",result];
        [_resultLable setText:_resultStr];
    }
//    char c=[b.titleLabel.text characterAtIndex:0];
//    NSLog(@"%c",c);
//    switch (b.tag) {
//        case 1:
//        {
//        [_resultStr  setString:@""];
//            [_resultLable setText:_resultStr];
//        }
//            break;
//        case 2:
//        {
//            int a=_resultStr.floatValue;
//            
//            [_resultLable setText:_resultStr];
//        }
//        case '+':
//        {
//            
//           
//            [_resultLable setText:_resultStr];
//        }
//            
//        default:
//            break;
//    }
//    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
