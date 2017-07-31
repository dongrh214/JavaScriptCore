//
//  JsCallOcMethod.m
//  JavascriptCoreDemo
//
//  Created by 董瑞鹤 on 2017/7/31.
//  Copyright © 2017年 董瑞鹤. All rights reserved.
//

#import "JsCallOcMethod.h"

@implementation JsCallOcMethod


-(void)JsCallOcMethod {
    NSLog(@"there is no message");
}
-(void)JsCallOcMethod1:(NSString *)message{
    NSLog(@"the message is %@",message);
    
}
-(void)JsCallOcMethod2:(NSString *)message1 SecondMessage:(NSString *)message2{
    NSLog(@"messages are %@-----%@ ",message1,message2);
}


@end
