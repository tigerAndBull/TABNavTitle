## 前言
在ios11以后，大标题风格比较流行，但是系统的大标题风格有着以下不足

>1. 仅支持ios11以上的系统
>2. 可拓展性较差
>3. 公司女同事用的故事板开发，好像遇到了大标题隐藏的bug

自定义缺点

> 实现方式是headView，目前在导航栏过场动画上有所局限，可以说是伪大标题

## 效果图
![效果图.gif](https://upload-images.jianshu.io/upload_images/5632003-12ed42f861bf3118.gif?imageMogr2/auto-orient/strip)

## 简要说明
>1. 利用scrollDelegate计算位置，实现推阻效果
>2. 下拉字体逐渐变大
>3. 丝滑不卡顿
>4. 没有写UICollectionView的实现

## 最后惊喜：demo里附赠tab和nav的封装
>1. github地址:https://github.com/tigerAndBull/CustomLargeNavTitle
>2. 如果有问题欢迎在下方留言，也可以加笔者wx：awh199833
>3. 如果对您有所帮助的话，麻烦在github上点颗星哦，谢谢～

## 原生骨架屏地址：https://www.jianshu.com/p/6a0ca4995dff







