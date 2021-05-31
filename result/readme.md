# 1. 同译码算法不同码长性能分析

码率：0.5

构造方式：Gaussian Approximation

## 1.1 SC

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SC_GA_256_128
ebn0 = 1:0.5:4;
N=256;
K=128;
历时238.993112秒

# SC_GA_512_256
ebn0 = 1:0.5:4;
N=512;
K=256;
历时566.663608秒

# SC_GA_1024_512
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
历时1011.686061秒

# SC_GA_2048_1024
ebn0 = 1:0.5:3.5;
N=2048;
K=1024;
历时5302.934839秒
```

## 1.2 SSC

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SSC_GA_256_128
ebn0 = 1:0.5:4;
N=256;
K=128;
历时94.096922秒

# SSC_GA_512_256
ebn0 = 1:0.5:4;
N=512;
K=256;
历时227.652723秒

# SSC_GA_1024_512
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
历时321.300100秒

# SSC_GA_2048_1024
ebn0 = 1:0.5:3.5;
N=2048;
K=1024;
历时1461.736439秒
```

## 1.3 SCL

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SCL_GA_256_128_2
ebn0 = 1:0.5:4;
N=256;
K=128;
scl_list_size=2;
历时1104.813429秒

# SCL_GA_512_256_2
ebn0 = 1:0.5:4;
N=512;
K=256;
scl_list_size=2;
历时2990.702464秒

# SCL_GA_1024_512_2
ebn0 = 1:0.5:3;
N=1024;
K=512;
scl_list_size=2;
历时3088.389609秒

# SCL_GA_2048_1024_2
ebn0 = 1:0.5:3;
N=2048;
K=1024;
scl_list_size=2;
历时8858.776496秒
```

## 1.4 CA-SCL

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# CA_SCL_GA_256_128_2_16
ebn0 = 1:0.5:4;
N=256;
K=128;
scl_list_size=2;
crc_size=16;
历时903.160479秒

# CA_SCL_GA_512_256_2_16
ebn0 = 1:0.5:3.5;
N=512;
K=256;
scl_list_size=2;
crc_size=16;
历时2979.459168秒

# CA_SCL_GA_1024_512_2_16
ebn0 = 1:0.5:3;
N=1024;
K=512;
scl_list_size=2;
crc_size=16;
历时6515.456955秒

# CA_SCL_GA_2048_1024_2_16
ebn0 = 1:0.5:2.5;
N=2048;
K=1024;
scl_list_size=2;
crc_size=16;
历时7050.670762秒
```

## 1.5 BP

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# BP_GA_256_128_40
ebn0 = 1:0.5:4;
N=256;
K=128;
bp_iter_num=40;
历时1739.015108秒

# BP_GA_512_256_40
ebn0 = 1:0.5:4;
N=512;
K=256;
bp_iter_num=40;
历时5909.400765秒

# BP_GA_1024_512_40
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
bp_iter_num=40;
历时6951.258954秒

# BP_GA_2048_1024_40
ebn0 = 1:0.5:3;
N=2048;
K=1024;
bp_iter_num=40;
历时11890.250541秒
```

## 1.6 SCAN

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SCAN_GA_256_128_2
ebn0 = 1:0.5:4;
N=256;
K=128;
scan_iter_num=2;
历时425.550593秒

# SCAN_GA_512_256_2
ebn0 = 1:0.5:4;
N=512;
K=256;
scan_iter_num=2;
历时1622.779838秒

# SCAN_GA_1024_512_2
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
scan_iter_num=2;
历时3248.181843秒

# SCAN_GA_2048_1024_2
ebn0 = 1:0.5:3;
N=2048;
K=1024;
scan_iter_num=2;
历时3264.101838秒
```



# 2. 不同译码算法同码长码率性能分析

## N=256，K=128

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SC_GA_256_128
ebn0 = 1:0.5:4;
N=256;
K=128;
历时238.993112秒

# SSC_GA_256_128
ebn0 = 1:0.5:4;
N=256;
K=128;
历时94.096922秒

# SCL_GA_256_128_4
ebn0 = 1:0.5:4;
N=256;
K=128;
scl_list_size=4;
历时1710.293248秒

# CA_SCL_GA_256_128_4_16
ebn0 = 1:0.5:4;
N=256;
K=128;
scl_list_size=4;
crc_size=16;
历时秒

# BP_GA_256_128_40
ebn0 = 1:0.5:4;
N=256;
K=128;
bp_iter_num=40;
历时1739.015108秒

# SCAN_GA_256_128_4
ebn0 = 1:0.5:4;
N=256;
K=128;
scan_iter_num=4;
历时883.635721秒
```

## N=1024，K=512

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SC_GA_1024_512
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
历时1011.686061秒

# SSC_GA_1024_512
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
历时321.300100秒

# SCL_GA_1024_512_4
ebn0 = 1:0.5:3;
N=1024;
K=512;
scl_list_size=4;
历时秒

# CA_SCL_GA_1024_512_4_16
ebn0 = 1:0.5:3;
N=1024;
K=512;
scl_list_size=4;
crc_size=16;
历时秒

# BP_GA_1024_512_40
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
bp_iter_num=40;
历时6951.258954秒

# SCAN_GA_1024_512_4
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
scan_iter_num=4;
历时秒
```



# 3. 构造编码方式对性能的影响

## N=256，K=128

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SC_GA_256_128
ebn0 = 1:0.5:4;
N=256;
K=128;
历时238.993112秒

# SC_BA_256_128
ebn0 = 1:0.5:4;
N=256;
K=128;
历时193.663135秒
```

## N=1024，K=512

```js
min_frame_errors = 10;
min_frame_num = 5000;
max_frame_num = 1e7;

# SC_GA_1024_512
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
历时1011.686061秒

# SC_BA_1024_512
ebn0 = 1:0.5:3.5;
N=1024;
K=512;
历时1051.325662秒
```

