## 前言
iOS11+，大标题风格比较流行，但是系统的大标题风格有着以下不足

>1. 仅支持ios11以上的系统
>2. 可拓展性较差
>3. 用的故事板开发,遇到了大标题隐藏的bug

自定义实现的缺点

> 实现方式是headView，目前在导航栏过场动画上有所局限

## 效果图
![效果图.gif](https://upload-images.jianshu.io/upload_images/5632003-12ed42f861bf3118.gif?imageMogr2/auto-orient/strip)

## 简要说明
>1. 利用scrollDelegate计算位置，实现推阻效果
>2. 下拉字体逐渐变大
>3. 不卡顿
>4. 没有写UICollectionView的实现







