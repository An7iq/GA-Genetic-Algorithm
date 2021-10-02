function [fnownew,populationnew]=selection(fnow,population,parasel,numin,numout)
%% 选择：根据选择规则，从已有种群中选取特定个数的个体
% fnow  适应度值 
% population 解
% parasel 选择类型
% numin 输入的数据个数
% numout  输出的数据个数
% 根据选择的类型 来处理， 输出numout个选择的个体（会重复）
seln=zeros(1,numout);
if parasel==1 % 如果是轮盘赌
    f_z=fnow-min(fnow)+1;
    f_z=f_z./sum(f_z);
    cumsump=cumsum(f_z);
    for i=1:numout
        r=rand;
        prand=cumsump-r;
        j=find(prand>=0);
        seln(i)=j(1);
    end %gambel , the better solution have the better prob to be selected
elseif parasel==2 % 如果是二元锦旗赛制
    for i=1:numout
        r=randperm(numin,2);%选取两个
        [~,j]=max(fnow(r));
        seln(i)=r(j);
    end %选取两个 挑选最好的
elseif parasel==3 % 如果是4元锦旗赛制
    for i=1:numout
        r=randperm(numin,4);%选取四个
        [~,j]=max(fnow(r));
        seln(i)=r(j);
    end %选取四个 挑选最好的
end
    fnownew=fnow(seln);
    populationnew=population(seln,:);
end