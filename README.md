# PolarCode

**本程序在[polar-code](https://github.com/luxinjin/polar-code)的基础上加以改进，仅供学习交流使用，请勿用于商业目的。**

*注：部分代码已添加注释，如出现乱码使用GB 2312编码重新打开*

## 程序说明

基础学习资料见[Information](https://github.com/AramakiYui/PolarCode/tree/master/info)

本程序主要分为三个功能模块：构造编码模块；译码模块；仿真对比模块



### main.m

```js
# 对于主函数main：
N = 256;                                        #码长
K = 128;                                        #信息位长度
Rc = K/N;                                       #码率
Rm = 1;                                         #BPSK通信系统的调制率，一般为1
ebn0 = 1:0.5:3.5;                               #比特信噪比步进
SNR = ebn0 + 10*log10(Rc*Rm) + 10*log10(2);     #符号信噪比，实数信号 + 10*log10(2)2倍过采样系数

design_snr_dB = 0;  #巴氏参数法构造极化码参数，论文证明0dB最佳
sigma = 0.9;        #高斯近似法构造极化码参数（噪声方差）

min_frame_errors = 10;	#完成一个信噪比情况下译码的最小错帧数
min_frame_num = 5000;	#完成一个信噪比情况下译码的最小次数
max_frame_num = 1e7;	#完成一个信噪比情况下译码的最大次数

switch decoding_method:
    #SC译码无需输入参数
    #SSC译码同样无需输入参数，运算速度更快
    #CA-SCL，输入List大小和CRC校验位数，crc_size=0时退化为SCL算法
    #BP,输入迭代次数，一般为40
    #SCAN，输入迭代次数，一般为1-4
    
#构造编码

for j = 1:length(ebn0)
	#一个信噪比情况下编码+译码
end

#输出仿真结果
```



### PolarCode数据结构

```js
#initPC(N,K,construction_method,design_snr_dB,sigma,crc_size);
#Polar码初始化程序，主要构建Polar码的数据结构PCparams：

# N:码长
# K:信息位长
# n = log2(N)
# FZlookup:长向量，为0表示冻结比特的位置，为-1表示信息比特的位置
# L:用于存储运算过程中的左信息值对数似然比（算法中的L矩阵）
# B:用于存储运算过程中的右信息值硬判决比特（算法中的B矩阵）
# bitreversedindices:比特反序矩阵
# crc_size:CRC校验位大小

根据构造方式不同加载信息比特序列，进行信息位的选取
```



### 构造编码模块



### 译码模块



### 仿真对比模块

