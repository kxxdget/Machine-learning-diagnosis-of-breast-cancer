clear
clc
load 'xinjiang.mat'
%%NRS
x=15:-1:1;
y(:,1)=ncajiangwei(:,1);
y(:,2)=ncajiangwei(:,4);
y(:,3)=ncajiangwei(:,2);
grid
% subplot(1,2,1)
y(:,4)=ncajiangwei(:,5);
y(:,5)=ncajiangwei(:,3);
y(:,6)=ncajiangwei(:,6);
bar3(y,0.25)
xlabel('classifier');
ylabel('dimension');
zlabel('accuracy(%)')
legend('tr-PNN','test-PNN','tr-LVQ','tese-LVQ','tr-BP','tese-BP')
%
x=15:-1:1;
y1=xinjiang(:,1);
y2=xinjiang(:,2);
y3=xinjiang(:,3);
y4=xinjiang(:,4);
y5=xinjiang(:,5);
y6=xinjiang(:,6);
% hold on
figure(1)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Accuracy(%)')
plot(x,y1,'go-',x,y2,'ko-',x,y3,'ro-',x,y4,'g*-.',x,y5,'k*-.',x,y6,'r*-.','linewidth',1.5)
legend('PNN','LVQ','BP','PNN','LVQ','BP')
figure(2)
hold on
y7=shijian(:,1);
y8=shijian(:,2);
y9=shijian(:,3);
plot(x,y7,'g*-',x,y8,'k*-',x,y9,'r*-','linewidth',1.5)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Train time(s) ')
legend('PNN','LVQ','BP')
hold off

%%sne
x=15:-1:1;
z1=snejiangwei(:,1);
z2=snejiangwei(:,2);
z3=snejiangwei(:,3);
z4=snejiangwei(:,4);
z5=snejiangwei(:,5);
z6=snejiangwei(:,6);
hold on
figure(1)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Accuracy(%)')
plot(x,z1,'go-',x,z2,'ko-',x,z3,'ro-',x,z4,'g*-.',x,z5,'k*-.',x,z6,'r*-.','linewidth',1.5)
legend('PNN','LVQ','BP','PNN','LVQ','BP')
% figure(2)
hold on
z7=snetime(:,1);
z8=snetime(:,2);
z9=snetime(:,3);
plot(x,z7,'g*-',x,z8,'k*-',x,z9,'r*-','linewidth',1.5)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Train time(s) ')
legend('PNN','LVQ','BP')
hold off

%%spe

x=15:-1:1;
z1=spejiangwei(:,1);
z2=spejiangwei(:,2);
z3=spejiangwei(:,3);
z4=spejiangwei(:,4);
z5=spejiangwei(:,5);
z6=spejiangwei(:,6);
hold on
figure(1)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Accuracy(%)')
plot(x,z1,'go-',x,z2,'ko-',x,z3,'ro-',x,z4,'g*-.',x,z5,'k*-.',x,z6,'r*-.','linewidth',1.5)
legend('PNN','LVQ','BP','PNN','LVQ','BP')
% figure(2)
hold on
z7=spetime(:,1);
z8=spetime(:,2);
z9=spetime(:,3);
plot(x,z7,'g*-',x,z8,'k*-',x,z9,'r*-','linewidth',1.5)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Train time(s) ')
legend('PNN','LVQ','BP')
hold off

%%nca
x=15:-1:1;
z1=ncajiangwei(:,1);
z2=ncajiangwei(:,2);
z3=ncajiangwei(:,3);
z4=ncajiangwei(:,4);
z5=ncajiangwei(:,5);
z6=ncajiangwei(:,6);
hold on
figure(1)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Accuracy(%)')
plot(x,z1,'go-',x,z2,'ko-',x,z3,'ro-',x,z4,'g*-.',x,z5,'k*-.',x,z6,'r*-.','linewidth',1.5)
legend('PNN','LVQ','BP','PNN','LVQ','BP')
% figure(2)
hold on
z7=ncatime(:,1);
z8=ncatime(:,2);
z9=ncatime(:,3);
plot(x,z7,'g*-',x,z8,'k*-',x,z9,'r*-','linewidth',1.5)
% title('Dimension reduction dimension comparison')
xlabel('dimension')
ylabel('Train time(s) ')
legend('PNN','LVQ','BP')
hold off
%%spread
x=0.5:0.05:1.5;
y1=spreadduibi(:,1);
y2=spreadduibi(:,2);
y3=spreadduibi(:,3);
hold on
figure(1)
[AX,H1,H2]=plotyy(x,[y1,y2],x,y3);
set(AX(1),'XColor','k','YColor','k'); 
set(AX(2),'XColor','k','YColor','r');
set(H1(1),'LineStyle','-','linewidth',3,'color','b','Marker','o');
set(H1(2),'LineStyle','-','linewidth',3,'color','g','Marker','*');
set(H2,'LineStyle','-.','linewidth',3,'color','r','Marker','s'); 
% title('Parameter comparison diagram')
xlabel('The SPREAD value')
ylabel(AX(1),'Accuracy(%)')
ylabel(AX(2),'Time(s)')
legend('The training set','The test set','Time')

%%sanweichangshi
x=15:-1:1;
y(:,1)=ncajiangwei(:,1);
y(:,2)=ncajiangwei(:,4);
y(:,3)=ncajiangwei(:,2);
grid
% subplot(1,2,1)
y(:,4)=ncajiangwei(:,5);
y(:,5)=ncajiangwei(:,3);
y(:,6)=ncajiangwei(:,6);
bar3(y,0.25)
xlabel('classifier');
ylabel('dimension');
zlabel('accuracy(%)')
legend('tr-PNN','test-PNN','tr-LVQ','tese-LVQ','tr-BP','tese-BP')
% subplot(1,2,2)
% y7=ncatime(:,1);
% y8=ncatime(:,2);
% y9=ncatime(:,3);
% plot(x,y7,'g*-',x,y8,'k*-',x,y9,'r*-','linewidth',1.5)
% xlabel('dimension')
% ylabel('Test time(s) ')
% legend('PNN','LVQ','BP')