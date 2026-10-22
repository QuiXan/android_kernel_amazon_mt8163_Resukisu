#!/bin/bash

if [ -d include/config ];
then
    echo "Find config,will remove it"
	rm -rf include/config
else
	echo "No Config,good."
fi


echo " "
echo "***Setting environment...***"
# 交叉编译器路径
export PATH=$PATH:$(pwd)/aarch64-linux-android-4.9/bin
export CROSS_COMPILE=aarch64-linux-android-

export GCC_COLORS=auto
export ARCH=arm64
if [ ! -d "out" ];
then
	mkdir out
fi

# 提示用户选择选项
echo "请选择一个选项："
echo "1. 设置defconfig参数为 giza_defconfig"
echo "2. 设置defconfig参数为 douglas_defconfig"
echo "3. 设置defconfig参数为 quixan_dksu_defconfig(带droidspaces支持)"
echo "请输入数字1~3"

read choice

case $choice in
  1)
    defconfig="giza_defconfig"
    ;;
  2)
    defconfig="douglas_defconfig"
    ;;
  3)
    defconfig="quixan_dksu_defconfig"
    ;;
  *)
    echo "无效的选项"
    exit 1
    ;;
esac

make ARCH=arm64 O=out ${defconfig}
make ARCH=arm64 O=out -j64 2>&1 | tee build_kernel.log
