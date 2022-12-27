
load('breast.mat') % 加载的test.mat数据为邻域粗糙集使用的数值型决策系统数据
%load('test.txt') % 同学们在加载数据的时候也可以直接加载txt个数数据，或者excel格式的文件
% 最后一列为决策属性
lammda=0.6; %???
% 这里lammda取值尽量在0.5~1.5之间，如果太大，则不能输出正常结果，如果太小，则程序报错
% 如果数据内包含的样本数比较多（几十以上），则调大lammda=2~4
sig_ctrl=0.1; %重要度下限的控制参数，取接近0的数
% PosSet = getPosSet(Wine,lammda);
redSet = reduceSet(binayaqi,lammda,sig_ctrl); %计算约简集合
weight = weightD(binayaqi,lammda); %计算权重
