# TKIdentifyInputView
支持多种样式的验证码输入框/an input view for vertifing code 

## 支持
 * Swift 4.2
 * SnapKit设置约束
 * 密文显示，支持自定义密文样式
 * 支持下划线，边框等样式
 
## 安装

### CocoaPod

```
pod 'TKIdentifyInputView' 
```

### 手动安装
把TKIdentifyInputView文件夹拖到工程中

### 使用方式

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

### 样式
| 类型  | 示例图片 |
| :-------------: | :-------------: |
| 下划线/underline |                 |
| 边框/border      |                 |
| 背景圆角/background&corner |                 |
| 光标/cursor      |                 |
| 密文/security   |                 |
| 自定义密文/custom security |                 |
| 自定义大小，字体，字体大小/item size&font&text color |                 | 