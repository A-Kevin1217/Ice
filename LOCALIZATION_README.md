# Ice 中文语言支持

## 概述

Ice 应用现已支持中文本地化。本文档说明了如何使用和维护中文语言支持。

## 支持的语言

- 英文 (en) - 默认语言
- 简体中文 (zh-Hans)

## 文件结构

```
Ice/Resources/
├── en.lproj/
│   ├── Localizable.strings
│   └── InfoPlist.strings
└── zh-Hans.lproj/
    ├── Localizable.strings
    └── InfoPlist.strings
```

## 如何切换语言

1. 打开系统偏好设置 > 语言与地区
2. 将中文添加到首选语言列表
3. 重启 Ice 应用

或者：

1. 在终端中运行：
   ```bash
   defaults write com.jordanbaird.Ice AppleLanguages '("zh-Hans")'
   ```
2. 重启 Ice 应用

## 本地化的内容

### 用户界面文本
- 设置面板标题和选项
- 按钮和菜单项
- 错误消息和提示
- 工具提示和帮助文本

### 应用元数据
- 版权信息
- 应用显示名称

## 已本地化的组件

### 设置导航
- 通用 (General)
- 菜单栏布局 (Menu Bar Layout)
- 菜单栏外观 (Menu Bar Appearance)
- 快捷键 (Hotkeys)
- 高级 (Advanced)
- 更新 (Updates)
- 关于 (About)

### Ice Bar 位置选项
- 动态 (Dynamic)
- 鼠标指针 (Mouse pointer)
- Ice 图标 (Ice icon)

### 菜单栏外观选项
- 纯色 (Solid)
- 渐变 (Gradient)
- 浅色外观 (Light Appearance)
- 深色外观 (Dark Appearance)

### 重新隐藏策略
- 智能 (Smart)
- 定时 (Timed)
- 焦点应用 (Focused app)

## 开发者信息

### 添加新的本地化字符串

1. 在相应的 Swift 文件中使用 `LocalizedStringKey`：
   ```swift
   Text(LocalizedStringKey("Your text here"))
   ```

2. 在 `en.lproj/Localizable.strings` 中添加英文版本：
   ```
   "Your text here" = "Your text here";
   ```

3. 在 `zh-Hans.lproj/Localizable.strings` 中添加中文翻译：
   ```
   "Your text here" = "您的中文文本";
   ```

### 代码修改

以下文件已被修改以支持本地化：
- `IceBarLocation.swift`
- `MenuBarTintKind.swift`
- `RehideStrategy.swift`
- `SystemAppearance.swift`

### 本地化文件

创建了以下本地化文件：
- `en.lproj/Localizable.strings` - 英文字符串
- `zh-Hans.lproj/Localizable.strings` - 简体中文字符串
- `en.lproj/InfoPlist.strings` - 英文应用元数据
- `zh-Hans.lproj/InfoPlist.strings` - 中文应用元数据

## 测试

构建项目以验证本地化设置：
```bash
xcodebuild -project Ice.xcodeproj -scheme Ice -configuration Debug build
```

## 注意事项

1. 所有硬编码的字符串都应该使用 `LocalizedStringKey` 包装
2. 新增的用户可见文本都需要添加到本地化文件中
3. 保持英文和中文版本的同步更新
4. 测试不同语言环境下的用户界面布局

## 贡献

如果您发现翻译错误或希望改进中文本地化，请：
1. 修改相应的 `.strings` 文件
2. 测试更改
3. 提交 Pull Request