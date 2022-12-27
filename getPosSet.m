function PosSet = getPosSet(dataArray,lammda)
[m,n]=size(dataArray); % m为样本数 n为属性个数(最后一列为决策属性)
if m<3 && n<3
    disp('输入的决策系统行列个数不得小于3个！');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% guiyihua
for j=1:n
    amin=min(dataArray(:,j));
    amax=max(dataArray(:,j));
    for i=1:m
        dataArray(i,j)=(dataArray(i,j)-amin)./(amax-amin);
    end
end
% 此时得到的条件属性为归一化后的属性

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 计算邻域半径
delta=std(dataArray)/lammda; %这里最后一列的决策属性的邻域半径没有用的

condiAtt=dataArray(:,1:n-1); % tiaojianshuxingji
decsAtt=dataArray(:,n); % jueceshuxingji

NbrSet=[]; % 存放邻域集合
Nbr_tmp=[];% 存放每个样本（临时）的邻域集合

%%%%%%%%%%%%%%%%% 计算所有条件属性的邻域集合
for i=1:m
   Nbr_tmp=[];% 置空处理
   for j=1:m
       flag1=1; % 是否写入邻域集合的判断标记 1可以写入 0不可以写入
       dist=abs(condiAtt(i,1)-condiAtt(j,1)); % 计算距离
       if dist<delta(1,1) % 与对应的第一行第1列的邻域半径做对比
           for k=2:n-1 % 其他属性的遍历判断
              dist_tmp = abs(condiAtt(i,k)-condiAtt(j,k)); % 计算对应的两个样本在不同属性下距离是否满足对应的要求
              if dist_tmp<delta(1,k) % 对应的第k个属性的邻域半径
                  flag1=1; % 是否写入邻域集合的判断标记 1可以写入 0不可以写入
              else
                  flag1=0;
                  break % 如果出现了属性内对应样本之间的距离大于邻域半径了，就跳出for循环
              end
           end
           if flag1==1 %可以写入邻域集合 即 得到了下近似的集合
              Nbr_tmp=[Nbr_tmp,j]; % 得到的下近似集合
              flag1=0;
           end
       end
   end
   NbrSet(i,(1:length(Nbr_tmp)))=Nbr_tmp; % 存放所有条件属性的所有的邻域集合
   % 即在该矩阵中，每行内存放的都是对应的样本的邻域集合
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 计算决策属性的划分情况
for p=1:m
    NbrD_tmp=[]; %清空
   for q=1:m
      if decsAtt(p,1)==decsAtt(q,1)
          NbrD_tmp=[NbrD_tmp,q];
      end
   end
   NbrD_Set(p,(1:length(NbrD_tmp)))=NbrD_tmp; % 存放决策属性的划分情况
end


%%%%%%%%%%%%%%%%%%%%%%%%%% 求积极域（正域)
for r=1:m %遍历得出的每个样本的邻域集合
    tmp=NbrSet(r,:); %取出第r行的下近似集合（可能包含0数字）
    for t=1:length(tmp)
        if tmp(1,t)~=0 % 排除为0的情况
            sign=ismember(tmp(1,t),NbrD_Set(r,:)); %如果是其中的元素，则返回sign=1，不是则为0
        end
        if sign==1 %是其中的元素
            flag2=1;
        else
            flag2=0;
            break % 这种情况直接跳出循环，证明该组集合元素不是决策对应集合的子集
        end
    end
    if flag2==1
        PosSet_tmp(r,(1:length(tmp)))=tmp; %存放积极域
    end
end

%%%%%%%%%%%%%%%%%%%%%%% 整理得出正域
PosSet=[];% 存放正域集合
for s=1:length(PosSet_tmp) % 遍历临时得到的正域
   posTmp=PosSet_tmp(s,:);
   flag3=1;
   for z=1:length(posTmp)
       flag3=1;
       if posTmp(1,z)~=0 % 剔除0的元素
          flag3=ismember(posTmp(1,z),PosSet); %判断当前元素是否已经存在在正域内 
       end
       if flag3==0 %不是则加入到正域集合中
           PosSet=[PosSet,posTmp(1,z)];
       end
   end
end



