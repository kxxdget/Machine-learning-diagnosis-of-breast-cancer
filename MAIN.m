clc
clear
% shuxingyuejian
% clearvars
% dataname = 'b'; %  'ecoli' / 'wine'
% zeta = 0.25; % the preset parameter 唯一需要设置的参数：补偿系数
% str = strcat('load',32,dataname);
% eval(str)
% % label resort 数据预处理
% [WDBC,label] = resortLabel_fun(WDBC,label);
% class = unique(label); % update
% numclass = numel(class);
% Xcell = cell(numclass,1); % decision class
% for i = 1:numclass
%     Xcell{i} = find(label == class(i)); 
% end
% 
% % Reduct ... 
% disp('Begin reducting ...')
% tic
% red = SPDTRS(WDBC,label,zeta,categoyr,Xcell);
% toc
% str = strcat('The attribute IDs in reduction set are:',32,num2str(red));
% disp(str)
% % red=[21,27,22,29,20,25,2,18,5,8,11,6];
% wdbc=WDBC(:,red);
% load 'c.mat'
%%
%%jiangwei
%%mds
% load 'b.mat'
% load 'dtrsjw.mat'
% Y = spe(WDBC,14,'Global');
% mappedX = mds(WDBC,12);
% Y = sne(WDBC,15,9);
% [mappedX, mapping] = nca(WDBC, label,11, 0);
% Y=mappedX;
%%
% NRS
% lammda=0.6; 
% sig_ctrl=0.01; 
% PosSet = getPosSet(zong,lammda);
% redSet = reduceSet(zong,lammda,sig_ctrl); 
% weight = weightD(zong,lammda);
% %RS
% a=abs(weight)
% bar(a)
% ylabel('absolute value of importance')
% xlabel('attribute number')
%%
%%fenleiqi
% %%PSO-SVM
% % wdbc=Y;
% % % % wdbc=WDBC;
% % % wdbc=mappedX;
% a=randperm(569);
% train_data=wdbc(a(1:400),:);
% test_data=wdbc(a(401:569),:);
% clabel=label;
% train_label=clabel(a(1:400),:);
% test_label=clabel(a(401:569),:);
% Method_option.plotOriginal=0;
% Method_option.scale=0;x
% Method_option.plotscale=0;
% Method_option.pca=0;
% Method_option.type=3;
% [predict_lable,accuracy] = SVC(train_label,train_data,test_label,test_data,Method_option);
% [train_scale,test_scale,ps] = scaleForSVM(train_data,test_data,0,1);
%     pso_option.c1 = 1.5;
%     pso_option.c2 = 1.7;
%     pso_option.maxgen = 100;
%     pso_option.sizepop = 20;
%     pso_option.k = 0.6;
%     pso_option.wV = 1;
%     pso_option.wP = 1;
%     pso_option.v = 5;
%     pso_option.popcmax = 100;
%     pso_option.popcmin = 0.1;
%     pso_option.popgmax = 100;
%     pso_option.popgmin = 0.1;   
% % [bestacc,bestc,bestg]=psoSVMcgForClass(train_data_labels,train_scale,pso_option)
% tic
% Y=sim(net,p_train);
% Yc=vec2ind(Y);
% t_train_temp =vec2ind(t_train);
% %zhunquelv
% % T_sim = predict(wdbc,p_test);
% % k1 = length(find(t_test == T_sim));
% k1 = length(find(t_train_temp == Yc));
% n1 = length(t_train_temp);
% Accuracy_1 = k1/n1*100
% %%xvlian
% Y2=sim(net,p_test);
% Y2c=vec2ind(Y2);
% k2 = length(find(t_test == Y2c));
% n2 = length(t_test);
% Accuracy_2 = k2/n2*100
% toc
%%
%%PNN
% wdbc=mappedX;
clear
clc

% wdbc=WDBC;
% load 'nrsjw.mat'
% wdbc=nrsjiangwei(:,1:13),
load 'PNNjiaoyou.mat'
% a=randperm(569);
% clabel=WDBC(:,1);
% wdbc=WDBC(:,2:31);
Train=wdbc(a(1:400),:);
Test=wdbc(a(401:569),:);
p_train=Train';
t_train=clabel(a(1:400),:)';
p=length(find(clabel(a(401:569),:)==1));
p_test=Test';
t_test=clabel(a(401:569),:)';
t_train=ind2vec(t_train);
t_train_temp=t_train;
Spread=0.75;
net=newpnn(p_train,t_train,Spread);
tic
Y=sim(net,p_train);
Yc=vec2ind(Y);
t_train_temp =vec2ind(t_train);
%zhunquelv
% T_sim = predict(wdbc,p_test);
% k1 = length(find(t_test == T_sim));
k1 = length(find(t_train_temp == Yc));%预测等于真实值的时候
n1 = length(t_train_temp);
Accuracy_1 = k1/n1*100
%混淆矩阵
real_label = t_train_temp; 
% 预测类别
predict_label = Yc;
% 利用“confusionmat”可以直接产生混淆矩阵，不过-1在前，1在后
[A,~] = confusionmat(real_label,predict_label); 
% 计算1类的评价值
c1_precise = A(1,1)/(A(1,1) + A(2,1));
c1_recall = A(1,1)/(A(1,1) + A(1,2));
c1_F1 = 2 * c1_precise * c1_recall/(c1_precise + c1_recall); 
%%xvlian
Y2=sim(net,p_test);
Y2c=vec2ind(Y2);
k2 = length(find(t_test == Y2c));
n2 = length(t_test);
Accuracy_2 = k2/n2*100
real_label1 = t_test; 
% 预测类别
predict_label1 = Y2c;
[A1,~] = confusionmat(real_label1,predict_label1); 
% 计算1类的评价值
c1_precise = A1(1,1)/(A1(1,1) + A1(2,1));
c1_recall = A1(1,1)/(A1(1,1) + A1(1,2));
c1_F1 = 2 * c1_precise * c1_recall/(c1_precise + c1_recall); 
figure;
hold on;
plot(t_train_temp,'ob');
plot(Yc,'r*');
xlabel('Training set sample','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Classification of actual training sets','Predictive training set classification');
% title('??????????????','FontSize',12);
% grid on
snapnow
figure;
hold on;
plot(t_test,'ob');
plot(Y2c,'r*');
xlabel('Training set sample','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Classification of actual test sets','Predictive test set classification');
% title('??????????????','FontSize',12);
% grid on
% snapnow
% % % %huatu
% % figure(1)
% % % subplot(1,2,1)
% stem(1:length(Yc),Yc,'bo')
% hold on
% stem(1:length(Yc),t_train_temp,'r*')
% % title('PNN network training results')
% xlabel('The sample label')
% ylabel('The classification results')
% set(gca,'Ytick',[1:5])
% % % subplot(1,2,2)
% H=Yc-t_train_temp;
% stem(H)
% % title('PNN network after training error diagram')
% xlabel('The sample label')
% ylabel('The classification results')
% Y2=sim(net,p_test);
% Y2c=vec2ind(Y2);
% % figure(2)
% hold on
% stem(1:length(Y2c),Y2c,'b^')
% stem(1:length(Y2c),t_test_temp,'r*')
% % title('The prediction effect of PNN network')
% xlabel('Forecast sample number')
% ylabel('The classification results')
% set(gca,'Ytick',[1:5])
% figure(3)
% H1=Y2c-t_test_temp;
% stem(H1)
% % title('PNN network after training error diagram')
% xlabel('The sample label')
% ylabel('The classification results')
% ROC=[t_train_temp',Yc']
% ROC1=[t_test',Y2c']
%%
% LVQ
% clc
% clear
% Y = sne(WDBC,15,30);
% wdbc=Y;
% clabel=label;
% a=randperm(569);
% clabel=label;
% wdbc=Y;
% Train=wdbc(a(1:400),:);
% Test=wdbc(a(401:569),:);
% P_train =Train';
% Tc_train = clabel(a(1:400),:)';
% T_train = ind2vec(Tc_train);
% P_test =Test';
% Tc_test = clabel(a(401:569),:)';
% count_B = length(find(Tc_train == 1));
% count_M = length(find(Tc_train == 2));
% rate_B = count_B/400;
% rate_M = count_M/400;
% net = newlvq(minmax(P_train),10,[rate_B rate_M],0.01,'learnlv1');
% net.trainParam.epochs = 400;
% net.trainParam.show = 10;
% net.trainParam.lr = 0.1;
% net.trainParam.goal = 0.1;
% net = train(net,P_train,T_train);
% tic
% T_sim1 = sim(net,P_train);
% Tc_sim1 = vec2ind(T_sim1);
% result1 = [Tc_sim1;Tc_train];
% k1 = length(find(Tc_train == Tc_sim1));
% n1 = length(Tc_train);
% Accuracy_1 = k1/n1*100
% real_label = Tc_train; 
% % 预测类别
% predict_label = Tc_sim1;
% % 利用“confusionmat”可以直接产生混淆矩阵，不过-1在前，1在后
% [A,~] = confusionmat(real_label,predict_label); 
% % 计算1类的评价值
% c1_precise = A(1,1)/(A(1,1) + A(2,1));
% c1_recall = A(1,1)/(A(1,1) + A(1,2));
% c1_F1 = 2 * c1_precise * c1_recall/(c1_precise + c1_recall); 
% T_sim = sim(net,P_test);
% Tc_sim = vec2ind(T_sim);
% result = [Tc_sim;Tc_test];
% k2 = length(find(Tc_test == Tc_sim));
% n2 = length(Tc_test);
% Accuracy_2 = k2/n2*100
% real_label1 = Tc_test; 
% % 预测类别
% predict_label1 = Tc_sim;
% % 利用“confusionmat”可以直接产生混淆矩阵，不过-1在前，1在后
% [A1,~] = confusionmat(real_label1,predict_label1); 
% % 计算1类的评价值
% c1_precise1 = A1(1,1)/(A1(1,1) + A1(2,1));
% c1_recall1 = A1(1,1)/(A1(1,1) + A1(1,2));
% c1_F11 = 2 * c1_precise1 * c1_recall1/(c1_precise1 + c1_recall1); 
% toc
%%
%BP
% wdbc=Y;
% wdbc=WDBC;
% wdbc=mappedX;
% clabel=label;
%  k=rand(1,569);
% clear
% clc
% wdbc=nrsjiangwei;
% a=randperm(569);
%  [m,n]=sort(a);
% % 
% % wdbc=WDBC(:,2:31);
% % clabel=WDBC(:,1);
% input=wdbc;
%  output1=clabel;
%  %设定每组输入输出信号
%  output=zeros(569,2);
%  for i=1:569
%      switch output1(i)
%          case 1
%              output(i,:)=[1 0];
%         case 2
%              output(i,:)=[0 1];
%     end
%  end
% % 
%  %
%  input_train=input(n(1:400),:)';
%  output_train=output(n(1:400),:)';
%  input_test=input(n(401:569),:)';
%  output_test=output(n(401:569),:)';
% 
% %
% [inputn,inputps]=mapminmax(input_train);
% 
% %% 网络结构初始化
% innum=15;
% midnum=10;
% outnum=2;
% 
% 
% %
% w1=rands(midnum,innum);
% b1=rands(midnum,1);
% w2=rands(midnum,outnum);
% b2=rands(outnum,1);
% 
% w2_1=w2;w2_2=w2_1;
% w1_1=w1;w1_2=w1_1;
% b1_1=b1;b1_2=b1_1;
% b2_1=b2;b2_2=b2_1;
% 
% %
% xite=0.05;
% alfa=0.039;
% loopNumber=10;
% I=zeros(1,midnum);
% Iout=zeros(1,midnum);
% FI=zeros(1,midnum);
% dw1=zeros(innum,midnum);
% db1=zeros(1,midnum);
% %% 
% E=zeros(1,loopNumber);
% tic
% for ii=1:loopNumber
%     E(ii)=0;
%     for i=1:1:400
%        %% 
%         x=inputn(:,i);
%         % 
%         for j=1:1:midnum
%             I(j)=inputn(:,i)'*w1(j,:)'+b1(j);
%             Iout(j)=1/(1+exp(-I(j)));
%         end
%         % 
%         yn=w2'*Iout'+b2;
%         
%       
%         e=output_train(:,i)-yn;     
%         E(ii)=E(ii)+sum(abs(e));
%         
%         %计算权值变化率
%         dw2=e*Iout;
%         db2=e';
%         
%         for j=1:1:midnum
%             S=1/(1+exp(-I(j)));
%             FI(j)=S*(1-S);
%         end      
%         for k1=1:1:innum
%             for j=1:1:midnum
%                 dw1(k1,j)=FI(j)*x(k1)*(e(1)*w2(j,1)+e(2)*w2(j,2));
%                 db1(j)=FI(j)*(e(1)*w2(j,1)+e(2)*w2(j,2));
%             end
%         end
%            
%         w1=w1_1+xite*dw1';
%         b1=b1_1+xite*db1';
%         w2=w2_1+xite*dw2';
%         b2=b2_1+xite*db2';
%         
%         w1_2=w1_1;w1_1=w1;
%         w2_2=w2_1;w2_1=w2;
%         b1_2=b1_1;b1_1=b1;
%         b2_2=b2_1;b2_1=b2;
%     end
% end
% 

% inputn_test=mapminmax('apply',input_test,inputps);
% fore=zeros(2,169);
% for ii=1:1
%     for i=1:169%1500
%         %隐含层输出
%         for j=1:1:midnum
%             I(j)=inputn_test(:,i)'*w1(j,:)'+b1(j);
%             Iout(j)=1/(1+exp(-I(j)));
%         end
%         
%         fore(:,i)=w2'*Iout'+b2;
%     end
% end
% % 
% inputn_train=mapminmax('apply',input_train,inputps);
% fore1=zeros(2,400);
% for ii=1:1
%     for i1=1:400%1500
%         %隐含层输出
%         for j=1:1:midnum
%             I(j)=inputn_train(:,i1)'*w1(j,:)'+b1(j);
%             Iout(j)=1/(1+exp(-I(j)));
%         end
%         
%         fore1(:,i1)=w2'*Iout'+b2;
%     end
% end
% 
% 
% output_fore=zeros(1,169);
% for i=1:169
%     output_fore(i)=find(fore(:,i)==max(fore(:,i)));
% end
% 
% output_fore2=zeros(1,400);
% for i1=1:400
%     output_fore2(i1)=find(fore1(:,i1)==max(fore1(:,i1)));
% end
% 
% %BP
% error=output_fore-output1(n(401:569))';%
% error1=output_fore2-output1(n(1:400))';%
% k2=zeros(1,2);  
% %
% for i=1:169
%     if error(i)~=0
%         [b,c]=max(output_test(:,i));
%         switch c
%             case 1 
%                 k2(1)=k2(1)+1;
%             case 2 
%                 k2(2)=k2(2)+1;
%         end
%     end
% end
% k3=zeros(1,2);
% for i1=1:400
%     if error1(i1)~=0
%         [b,c]=max(output_train(:,i1));
%         switch c
%             case 1 
%                 k3(1)=k3(1)+1;
%             case 2 
%                 k3(2)=k3(2)+1;
%         end
%     end
% end
% %
% kk=zeros(1,2);
% for i=1:169
%     [b,c]=max(output_test(:,i));
%     switch c
%         case 1
%             kk(1)=kk(1)+1;
%         case 2
%             kk(2)=kk(2)+1;
%     end
% end
% 
% kk1=zeros(1,2);
% for i1=1:400
%     [b,c]=max(output_train(:,i1));
%     switch c
%         case 1
%             kk1(1)=kk1(1)+1;
%         case 2
%             kk1(2)=kk1(2)+1;
%     end
% end
% % 
% rightridio=(kk-k2)./kk;
% disp('test正确率')
% disp(rightridio);
% %
% real_label1 = output_fore; 
% % 
% predict_label1 = output1(n(401:569));
% % confusionmat
% [A1,~] = confusionmat(real_label1,predict_label1); 
% % 
% c1_precise1 = A1(1,1)/(A1(1,1) + A1(2,1));
% c1_recall1 = A1(1,1)/(A1(1,1) + A1(1,2));
% c1_F11 = 2 * c1_precise1 * c1_recall1/(c1_precise1 + c1_recall1); 
% rightridio1=(kk1-k3)./kk1;
% toc
% disp('train正确率')
% disp(rightridio1);
%%
% huatuduibi
% x=15:-1:1;
% % y1=jiangweiduibi(:,2);
% % y2=jiangweiduibi(:,3);
% y3=jiangweiduibi(:,4);
% y4=jiangweiduibi(:,5);
% y5=jiangweiduibi(:,6);
% y6=jiangweiduibi(:,7);
% y7=jiangweiduibi(:,8);
% y8=jiangweiduibi(:,9);
% y9=jiangweiduibi(:,10);
% y10=jiangweiduibi(:,11);
% hold on
% figure(1)
% % title('Dimension reduction dimension comparison')
% xlabel('dimension')
% ylabel('Accuracy of training set')
% plot(x,y3,'go-',x,y5,'ko-',x,y7,'ro-',x,y9,'yo-','linewidth',1.5)
% legend('NRS','sne','spe','nca')
% % % figure(2)
% plot(x,y4,'g*-',x,y6,'k*-',x,y8,'r*-',x,y10,'y*-','linewidth',1.5)
% % title('Dimension reduction dimension comparison')
% xlabel('dimension')
% ylabel('Accuracy of test set ')
% legend('NRS','sne','spe','nca')
% % %shijian
% x=15:-1:1;
% y1=jiangweiduibi(:,13);
% y2=jiangweiduibi(:,14);
% y3=jiangweiduibi(:,15);
% y4=jiangweiduibi(:,16);
% plot(x,y1,'g*-',x,y2,'ko-',x,y3,'r.-',x,y4,'yd-','linewidth',1.5)
% xlabel('dimension')
% ylabel('Training time')
% legend('NRS','sne','spe','nca')
% % title('Comparison of Training Time')
% % figure(2)
% % subplot(3,2,1)
% % plot(x,y1,'bo-',x,y2,'r*-','linewidth',1.5)
% % xlabel('dimension')
% % ylabel('accuracy')
% % subplot(3,2,2)
% % plot(x,y3,'bo-',x,y4,'r*-','linewidth',1.5)
% % xlabel('dimension')
% % ylabel('accuracy')
% % subplot(3,2,3)
% % plot(x,y5,'bo-',x,y6,'r*-','linewidth',1.5)
% % xlabel('dimension')
% % ylabel('accuracy')
% % subplot(3,2,4)
% % plot(x,y7,'bo-',x,y8,'r*-','linewidth',1.5)
% % xlabel('dimension')
% % ylabel('accuracy')
% % subplot(3,2,5)
% % plot(x,y9,'bo-',x,y10,'r*-','linewidth',1.5)
% % xlabel('dimension')
% % ylabel('accuracy')
% % hold off
% 
%sparedhuatu
% x=0.5:0.5:10;
% y1=spread(:,2);
% y2=spread(:,3);
% y3=spread(:,4);
% hold on
% figure(1)
% [AX,H1,H2]=plotyy(x,[y1,y2],x,y3);
% set(AX(1),'XColor','k','YColor','M'); 
% set(AX(2),'XColor','k','YColor','r');
% set(H1(1),'LineStyle','-','linewidth',1.5,'color','b','Marker','o');
% set(H1(2),'LineStyle','-','linewidth',1.5,'color','g','Marker','*');
% set(H2,'LineStyle','-.','linewidth',1.5,'color','r','Marker','s'); 
% % title('Parameter comparison diagram')
% xlabel('The SPREAD value')
% ylabel(AX(1),'Accuracy')
% ylabel(AX(2),'Time')
% legend('The training set','The test set','Time')



