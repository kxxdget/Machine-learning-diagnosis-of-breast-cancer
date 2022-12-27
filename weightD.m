function weight = weightD(dataArray,lammda)


[m,n]=size(dataArray); % m为样本数 n为属性个数(最后一列为决策属性)
if m<4 || n<4 % 小于4个就没有意义了,将导致计算依赖度时去掉一个属性后只有一条属性
    disp('输入的决策系统行列个数不得小于4个！');
    return
end

%%%%%%%%%%%% 计算全体条件属性的依赖度
PosSet_all = getPosSet(dataArray,lammda); %计算全体条件属性相对于决策属性的正域
dpd_all=length(PosSet_all)/m; % 得到全体条件属性的依赖度

%%%%%%%%%%%% 遍历计算每个条件属性的依赖度、重要度
for g=1:n-1 %遍历每个条件属性
    if g==1
        condiAtt_new=dataArray(:,2:n-1); %处理第一个条件属性问题
    elseif g==n-1
        condiAtt_new=dataArray(:,1:n-2); %处理最后一个条件属性问题
    else
        condiAtt_new=[dataArray(:,1:g-1),dataArray(:,g+1:n-1)];
    end
    dataArray_new=[condiAtt_new,dataArray(:,n)]; %重新组合需要计算的决策系统
    % 此时得到的决策系统为去掉了指定的条件属性的新的决策系统
    PosSet_Att=getPosSet(dataArray_new,lammda); %得到去掉某一属性后的条件属性的正域
    dpd_Att_tmp=length(PosSet_Att)/m; % 计算每个属性的依赖度
    dpd_Att(g,1)=dpd_Att_tmp; % 将每个属性的依赖度存储起来,共g行
    sig_Att_tmp=dpd_all-dpd_Att_tmp; % 计算每个属性的重要度
    sig_Att(g,1)=sig_Att_tmp; % 将每个属性的重要度存储起来，共g行
end

%%%%%%%%%%%%% 计算每个属性的权重
for i=1:n-1
    weight_tmp=sig_Att(i,1)/sum(sig_Att);
    weight(i,1)=weight_tmp; %整理输出每个属性的权重（代数观下的权值）
end

