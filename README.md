# MFAnimationTransitionMigrate
实现了iOS的一种页面切换效果，可以将界面一和界面二的某个控件关联起来，达到平移过渡的效果，具体如下。

![](https://github.com/lmf12/ImageHost/blob/master/MFAnimationTransitionMigrate/exhibition.gif)

## 如何导入
#### 手动导入
将MFAnimationTransitionMigrate文件夹拖入工程中。

## 如何使用
#### 1.引入头文件
```Objective-c
#import "UIViewController+MFAnimationTransitionMigrate.h"
```
#### 2.在对应位置添加和移除代理
```Objective-c
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self mf_registerNavigationControllerDelegate];
}
```
```Objective-c
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self mf_removeNavigationControllerDelegate];
}
```
#### 3.在需要添加手势返回的页面，启动手势返回（可选）
```Objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    [self mf_enablePopInteractivePopTransition];
}
```
#### 4.在界面一和界面二中设置关联，可以设置多组关联
在界面一中的imageView1设置标签：
```Objective-c
[self mf_setMigrateSourceView:imageView1 withTag:@"imageView"];
```
在界面二中的imageView2设置标签：
```Objective-c
[self mf_setMigrateTargetView:imageView2 withTag:@"imageView"];
```
这样就把imageView1和imageView2关联起来，在push动画执行的时候，可以看到两个控件之间会产生过渡动画。

## 注意事项
    1.动画的实现是基于frame的计算，因此界面的实现最好是基于frame。
    2.在设置关联的时候，如果同个界面的tag相同，会相互覆盖，以最后一个为准。
