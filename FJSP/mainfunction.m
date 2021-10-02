%% 算法主程序
% clear the record
close all;
clear all;
clc;
%% 1输入数据 及  数据 预处理 
run datain.m %输入数据
data=preset(data);% 预处理 

%% 2设置参数
%整体参数
para.popsize=300;% 种群大小  %大于2 整数
para.Generationnmax=500;%最大迭代次数 %整数 大于0
para.pcrossover=0.5;% 进入交叉算子概率 % 0 到  1  取值范围 小数
para.pmutation=0.2;% 进入变异算子概率 % 0 到  1  取值范围 小数
para.timelimit=20000;% 最长运行时间 单位为秒 
%算子参数
%选择算子
para.sel=2;% 选择算子 1轮盘赌  2  二元竞标赛制 3  四元竞标赛制
%交叉算子
para.pcr=[1 0.3
    2 0.9
    3 0.5];% 交叉算子 1为单点交叉 2 为双点交叉（交叉中间基因）3 为选取随机的位置 对应各自概率
% 变异算子-顺序
para.pmtseq=[1 2.2
    2 0.3
    3 0.6];%  变异若为顺序 1 为两点互换   2 选取1点进行前后互换  3 选取 n个位置 随机排序  对应各自概率
% 变异算子-数值-变化位置
para.pmtnum=[1 0.2
    2 0.3
    3 0.5];%  变异若为数值  1为单点 2为双点 3 为选取n个位置 对应各自概率
% 变异算子-数值-变化步长
para.step=[0.3 0.6
    0.6 0.3
    0.8 0.2];%%  变异若为数值 表示数值类型的在取值范围内的步长概率

%%  3 编码方式
% 编码层数
Encode.degree=1;%整数输入   --编码段数 
% 编码类型
Encode.style=1; %一维数组输入     --每段基因组的数据类型 0整数数值  1 为实数数值    数值要求取值范围  顺序要求具体集合 % 数组输入
% 每层基因数
Encode.dnum=data.lena*2;%一维数组输入     -- 每段编码的基因位 
%每层取值范围
Encode.bounds{1}=[0;1]*ones(1,data.lena*2); % 胞体输入    --0 1.数值要求取值范围二维矩阵 2 数值要求一维矩阵

%% 4定义计算目标的函数
fsolver.fitness=@fit_all; %计算目标的函数 
fsolver.minmax=-1;% 1 为求最大    -1为求最小

%% 5运算算法
[result,paintd]=GAsolver(para,Encode,fsolver,data);

%% 6出图
figure
plot(paintd.f_best)


figure(2)
colorall=rand(4,3);
hold on
taskrecord=result.taskrecord;
len_a=size(taskrecord,1);
tm=max(taskrecord(:,5));
tn=8;
for i=1:len_a
    xa=[taskrecord(i,4),taskrecord(i,5),taskrecord(i,5),taskrecord(i,4)];
    ys=[(taskrecord(i,6)-1)*1.5,(taskrecord(i,6)-1)*1.5,(taskrecord(i,6)-1)*1.5+1,(taskrecord(i,6)-1)*1.5+1];
    patch(xa,ys,colorall(taskrecord(i,2),:),'EdgeColor','w');
    %         text( (xa(1)+xa(2))/2,(ys(1)+ys(3))/2+0.0,[num2str(z),' | ',num2str(buf(i,1))],'FontSize',10);
    text( (xa(1)+xa(2))/2,(ys(1)+ys(3))/2+0.0,[num2str(taskrecord(i,2)),'|',num2str(taskrecord(i,3))],'FontSize',10);

    
end
pp={'资源1','资源2','资源3','资源4','资源5','资源6','资源7','资源8','资源9'};
set(gca, 'XLim',[0 tm]); % X轴的数据显示范围
% set(gca, 'XTick',[1:bufy(end)+1] ); % X轴的记号点
% set(gca, 'XTicklabel',{'-pi','0','pi'}); % X轴的记号
set(gca, 'YLim',[0 tn*1.5]); % X轴的数据显示范围
set(gca, 'YTick',0.5+[0:tn-1].*1.5 ); % X轴的记号点
set(gca, 'YTicklabel',pp ); % X轴的记号点
xlabel('时间','FontSize',16);
set(gcf,'color','w')%将界面设置成白色


