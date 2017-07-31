//
//  JsCallOcMethod.h
//  JavascriptCoreDemo
//
//  Created by 董瑞鹤 on 2017/7/31.
//  Copyright © 2017年 董瑞鹤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//创建实现JSExport协议的协议
@protocol JSObjectProtocol <JSExport>

-(void)JsCallOcMethod;
-(void)JsCallOcMethod1:(NSString *)message;
-(void)JsCallOcMethod2:(NSString *)message1 SecondMessage:(NSString *)message2;

@end


@interface JsCallOcMethod : NSObject <JSObjectProtocol>  //实现创建的协议

@end
