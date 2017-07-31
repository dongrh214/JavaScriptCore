# JavaScriptCore
js和oc基于JavaScriptCore的交互

本人以前一直使用WebViewJavascriptBridge，自从苹果在推出ios7推出JavaScriptCore，使得h5与ios之间的交互变得更简单。

本文从如下解释JavaScriptCore的简单使用
>* oc调用js
>* js调用oc(简单版本)
>* js调用oc对象方法(升级版本，需要实现JSContext协议)
>* js向oc传参(以json对象形式)
