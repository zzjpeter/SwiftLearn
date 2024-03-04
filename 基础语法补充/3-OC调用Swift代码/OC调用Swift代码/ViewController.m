//
//  ViewController.m
//  OC调用Swift代码
//
//  Created by 朱志佳 on 2024/3/4.
//

#import "ViewController.h"
#import "OC调用Swift代码-Swift.h" // 引入Swift头文件 #import "工程名-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.在OC项目中创建一个swift文件的时候，Xcode 会提示 需要创建一个桥接文件，点确定创建桥接文件，Xcode会自动创建一个桥接文件, 其实OC调用Swift这个桥接文件作用并不大, 可以不创建;
    
    //2.进入TARGETS ->Build Settings -> Packaging 中 设置Defines Module为YES; 如图:readMe.png
    
    //3.设置 Product Module Name ，也可以不设置，默认为工程的名字。这个在后面会用到
    //4.在swift写一个类,注意这个类一定要继承NSObject，不然在OC中没法用
    //4.1要暴露给OC的类、属性、方法 要加 @objc 标识
    
    //5.在OC需要用到的swift文件中 导入文件 "Product Module Name -Swift.h"  因为 Product Module Name默认是工程的名字, 所以直接导入 #import "工程名-Swift.h"


    Person *person = [[Person alloc] initWithName:@"John Doe"];
    [person greet]; // 输出 "Hello, my name is John Doe."
    
    self.view.backgroundColor = UIColor.whiteColor;
}


@end
