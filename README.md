# TKIdentifyInputView
支持多种样式的验证码输入框/an input view for vertifing code 

## 支持
 * Swift 4.2
 * SnapKit设置约束
 * 密文显示，支持自定义密文样式
 * 支持下划线，边框等样式
 * 支持自动填充验证码(支持iOS12之后的版本)
 
## 安装

### CocoaPod

```
pod 'TKIdentifyInputView' 
```

### 手动安装
把TKIdentifyInputView文件夹拖到工程中

## 使用方式

```
 let input = TKIdentifyInputView.init(frame: .zero)
 input.itemConfig = TKIdentifyInputItemConfig()
 view.addSubview(input)
 input.snp.makeConstraints {  (make) in
 	// 支持snapkit
  }
  // 设置layout或者itemConfig后请调用此方法
  input.reload()
```
详情看Demo

## 样式
| 类型  | 示例图片 |
| :-------------: | :-------------: |
| 下划线/underline |  ![underline](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/underline.png)               |
| 边框/border      |  ![border](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/border.png)               |
| 背景圆角/background&corner |  ![background](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/background.png)               |
| 光标/cursor      | ![cursor](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/cursor.png)                |
| 密文/security   | ![security](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/security.png)                |
| 自定义密文/custom security | ![custom_security](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/custom_security.png)                |
| 自定义大小，字体，字体大小/item size&font&text color | ![custom](https://github.com/TongKai/TKIdentifyInputView/blob/master/imgs/custom.png)                | 

## 参考与感谢
[CRBoxInputView](https://github.com/CRAnimation/CRBoxInputView)
