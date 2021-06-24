# Polar Code

**本程序在[polar-code](https://github.com/luxinjin/polar-code)的基础上加以改进，仅供学习交流使用，请勿用于商业目的。**

*注：部分代码已添加注释，如出现乱码使用GB 2312编码重新打开*

## 程序说明

基础学习资料见[Info](https://github.com/AramakiYui/PolarCode/tree/master/info)

本程序主要分为三个功能模块：构造编码模块；译码模块；仿真对比模块。



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



### Polar Code数据结构

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

相对于源代码仓库的手动生成构造编码序列位置，本程序自动生成不同编码方式在当前运行场景下的信息位置并自动加载。

```js
# 巴氏参数上界
constructedCode//PolarCode_block_length_%d_designSNR_%.2fdB_method_Bhattacharyya.txt

# 高斯近似
constructedCode//PolarCode_block_length_%d_sigma_%.2f_method_GA.txt
```

pencode()是编码程序。引入crc校验时，需要将crc校验信息当成是信息的一部分进行编码。



### 译码模块

译码算法相关都在文件夹[function](https://github.com/AramakiYui/PolarCode/tree/master/function)下：

```js
# polar_SC_decode是SC译码算法，逐次消除译码(Successive Cancellation)

# polar_SSC_decode是SC算法的简化算法，简化逐次消除译码(Simplified Successive Cancellation)

# polar_SCL_decode是CA-SCL译码算法，循环冗余校验辅助的逐次消除列表译码(CRC Aided Successive Cancellation List)；若crc_size = 0，退化为逐次消除列表译码(Successive Cancellation List)

# polar_BP_decode是BP译码算法，置信传播译码(Belief Propagation)

# polar_SCAN_decode是SCAN译码算法，软消除译码(Soft-Cancellation)
```



### 仿真对比模块

仿真对比结果都在文件夹[result](https://github.com/AramakiYui/PolarCode/tree/master/result)下，包括同译码算法不同码长性能分析；同译码算法不同码长性能分析和构造编码方式对性能的影响，详见[readme](https://github.com/AramakiYui/PolarCode/blob/master/result/readme.md)。