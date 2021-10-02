function [fnow,fbest,fmean,resultall,index]=cacul(popsize,population,data,fsolver,Encode)
%%  计算适应度： 以及最佳值，平均值，结果，以及最佳解的序号
% popsize 群体个数
%population 方案集合
% data 数据
%fsolver 目标方程
%Encode 编码方式
%% 适应度计算
fnow=zeros(1,popsize);
resultall=cell(1,popsize);
for i=1:popsize
    [fnow(i),resultall{i}]=fsolver.fitness(population(i,:),data,Encode);%目标函数计算
end
fnow=fnow*fsolver.minmax;%  将目标值转化成 适应度值
[fbest,index]=max(fnow);
fmean=mean(fnow);
end