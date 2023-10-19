# htm
Hierarchical Triangular Mesh

This is a copy of the SDSS HTM implementation from [1] developed by O'Mullane, Kunszt, Szalay

> - [x]: 2023-10-19 Add READNME Chinese translation By Chris
>- [ ] 

**HTM 分层三角网格**

这是由O'Mullane, Kunszt, Szalay开发的SDSS HTM实现[1]的副本.

# Original Readme

Configurtion 笔记:

在这个目录中有一个 `Makefile.generic` 文件。`Makefile`由
配置shell脚本生成。**不要编辑`Makefile`**，而是编辑`Makefile.generic`。

计划是将所有与系统相关的东西定义为(参见`Makefile.generic`) `stuff = @@stuff##` 并且让流编辑器在任何地方修改它们。

只有`u*x` (unix, linux, irix, darwin, bsd, solaris…)系统能从中获益，
`Windows`版本有自己的项目文件，将来还会有`nmakefiles`。

在这个版本中有几个变化。`bitlist`不见了。部分和完整的列表(Partial and full lists)都消失了。它们被合并到一个名为`HtmRange`的数据类型中。

这种单一的数据类型可以表示查看大量(或少量)`HTMIDS`。

应用`intersect`读取域描述文件,并输出了`hids`(HTM-ID)到标准输出。根据用户的需求，隐藏的数量可能非常大。考虑这样一个例子，域包含一个很大的区域，应用程序要求在20级产生所有`hids`!对于一个具体的例子,考虑一个小磁盘在域描述文件所描述的“北极”: (`testTiny`目录)

```shell
----------------------
#DOMAIN
1
#CONVEX
1
0.0 0.0 1.0 0.9999
----------------------
```

20级三角形的数量，或者我们现在所说的`trixels`(三角形像素)的数量大约是10亿(10^9)。将所有这些数字(`hids`)放入输出流可能是不可行的，因此`HtmRanges`允许我们利用大型`hids`集合中隐含的数字连续性。虽然一般来说，两个连续的`hids`不一定代表相邻的三角形，但从一个父三角形派生的所有`hids`的集合形成一个连接的组件是正确的。简而言之，如果你对它们进行排序，就不会有间隔。因此，方便地将这些大的隐藏块表示为一个范围，或者更准确地说，表示为一个有序对:`(low_hid, high_hid)`。因此，任何任意**`DOMAIN`**都被表示为`(lo, hi)`对的集合(列表、向量、数组等)。

使用HTM接口的最佳方法是使用`intersect`程序。

## 1. 考虑`DOMAIN`描述

```shell
---------------testTiny ------------------------
#DOMAIN
1
#CONVEX
1
0.0 0.0 1.0 0.9999
---------------END: testTiny--------------------
```

`intersect`` 提供的范围区间

```shell
% intersect 20 testTiny
13469017440256 13469285875711
14568529068032 14568797503487
15668040695808 15668309131263
16767552323584 16767820759039
```

## 2. 考虑`DOMAIN`描述

如果您希望看到由仍然包含在`DOMAIN`中的`hid`表示的最大三角形，请使用一个选项告诉应用程序生成可变长度的`hids`而不是范围。

```shell
% intersect -varlength 20 testTiny
50176
54272
58368
62464
```

## 3. 更多的例子

文件`testInputIntersect`包含以下`DOMAIN`描述:

```shell
------------------- testInputIntersect -----------------
#DOMAIN
1
#CONVEX
3
0.9 0.007107 0.05 0.780775301220802
0.5 0.5 0.707107 0.63480775301220802
0.707107 -0.5 0.3 0.8480775301220802
------------------- END: testInputIntersect -------------
```

运行`intersect`程序，得到141个区间。前三个和后三个显示在这里:


```shell
% intersect  20 testInputIntersect
13211319402496 13213466886143
13213802430464 13213803479039
13214003757056 13214305746943
...
14214513033216 14214529810431
14215536443392 14215670661119
14215771324416 14215788101631
```

可变长度选项将产生207个`hids`。第一个和最后一个分别是:

```shell
3089
14170322436984
```

表示trixels `N0100000`和`N032031021002100031320`。运行`intersect`不带参数获取使用信息:

```shell
-----------------------------------------------------------------------------------
usage: 
intersect [-save savelevel] [-verbose] [-olevel olevel] level domainfile
[-save savelevel]   : store up to this depth (default 2)
[-verbose]          : verbose
[-olevel out_level] : output HTMID level (must be >= level)
[-symbolic]         : output HTMID as a symbolic name, must be used with -varlength
[-varlength]        : output natural HTMID (conflicts with -olevel)
[-nranges nrages]   : keep number of ranges below this number
level               : Maximal spatialindex depth 
domainfile          : filename of domain 
-----------------------------------------------------------------------------------
```

Comments about this READ_ME? Please send me mail mailto:gfekete@pha.jhu.edu

## Some stats:

```shell
==========
At level 20
the largets HID  is  N333333333333333333333 = 17592186044415
The smallest HID is  S000000000000000000000 =  8796093022208
The difference is
   17592186044415 
  - 8796093022208 =  ....................   =  8796093022207

17,592,186,044,415
 8,796,093,022,207

about 17 and a half trillion.
difference is about 8 and three quarters trillion.

At level 12
The largest HID is   N3333333333333 = 268435455
The smallest HID is  S0000000000000 = 134217728   268435455-134217728
The difference is                   = 134217727
                                       16777219 
268,435,455
134,217,728

about 268  million.
difference is about 134 million.

(16777219 16777230 369098836)
16777219 
```

[1] http://www.skyserver.org/htm/implementation.aspx
