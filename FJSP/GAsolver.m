function [results,paintd]=GAsolver(para,Encode,fsolver,data)
%% 算法程序
% data 案例数据 para 算法参数 Encode 编码方式 fsolver目标函数
%% 预设一些变量内存
fnow=zeros(1,para.popsize);%每一代的种群
fmean=zeros(1,para.Generationnmax);%种群平均值内存
fbest=zeros(1,para.Generationnmax);%预设种群最佳值内存
fbestsofar=-inf;%至此代最佳目标值
solbestsofar=[];%至此代最佳解
%% 生成初始方案
population=rand_generate(para.popsize,Encode);% 随机产生方案
[fit,fitbest,~,~,index]=cacul(para.popsize,population,data,fsolver,Encode);% 计算目标值
fnow=fit;
if fbestsofar<fitbest % 至此代最佳目标值
    fbestsofar=fitbest;
    solbestsofar=population(index,:);
end 
%% 开始迭代
tic
Generation=0; %预设迭代 次数
while Generation<para.Generationnmax+1 && toc<=para.timelimit % 当时间及迭代次数满足要求时
    Generation=Generation+1; %迭代次数加 1
    %% Selection 形成新的种群
    [fnow,population]=selection(fnow,population,para.sel,para.popsize,para.popsize);
    %% crossover 形成新的种群
    [fnow,population]=crossover_GA(fnow,population,para,data,Encode,fsolver);%crossover
    [gbest,num]=max(fnow);%计算最佳此代目标值
    if fbestsofar<gbest
        fbestsofar=gbest;
        solbestsofar=population(num,:);
    end
    %% mutation 形成新的种群
    [fnow,population]=mution_GA(fnow,population,para,data,Encode,fsolver);%mutation
    [gbest,num]=max(fnow);%计算最佳此代目标值
    if fbestsofar<gbest
        fbestsofar=gbest;
        solbestsofar=population(num,:);
    end
    fbest(Generation)=fbestsofar;%stock the best resulut current
    fmean(Generation)=mean(fnow); %计算平均此代目标值
    Generation
end
fbest=fbest(1:Generation);
fmean=fmean(1:Generation);
[~,results]=fsolver.fitness(solbestsofar,data,Encode);

paintd.f_best=fbest.*fsolver.minmax;
paintd.f_mean=fmean.*fsolver.minmax;
paintd.f_fitness=fbest;
end

function  [fnownew,popnew]=crossover_GA(fnownew,popnew,para,data,Encode,fsolver)%交叉
for i=1:2:para.popsize % 每两个个体进行操作
    seln=popnew(i:i+1,:);%依次选取两个个体
    if rand<=para.pcrossover % 如果满足交叉概率
        %进入交叉
        % 确定交叉层级
        bufn=randperm(Encode.degree,1);
        bufn=randperm(Encode.degree,bufn);
        for j=bufn  % 对选中的编码层进行判断
            selncut=seln(:,sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)));% 选取对应个体里的对应编码层
            % 选择了哪一种交叉方式
            if Encode.dnum(j)==1%如果只有一个基因 只能采取选取一点
                style2=1;
            else
                [~,style2]=selection(para.pcr(:,2)',para.pcr(:,1),1,size(para.pcr,1),1);
            end% 
            selncut=crossd(selncut,Encode.dnum(j),Encode.style(j),style2);
            seln(:,sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)))=selncut;
        end
        popnew(i:i+1,:)=seln;
        [fnownew(i:i+1),~]=cacul(2,popnew(i:i+1,:),data,fsolver,Encode);
    end
end
end

function [fnownew,popnew]=mution_GA(fnownew,popnew,para,data,Encode,fsolver)%mutation
for i=1:para.popsize % 每两个个体进行操作
    seln=popnew(i,:);%依次选取两个个体
    if rand<=para.pmutation % 如果满足变异概率
        %进入变异
        % 确定变异层级
        bufn=randperm(Encode.degree,1);
        bufn=randperm(Encode.degree,bufn);
        for j=bufn  % 对选中的编码层进行判断
            selncut=seln(sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)));% 选取对应个体里的对应编码层
            if Encode.style(j)==0 ||  Encode.style(j)==1 % 若是整数或者实数
                [~,style2]=selection(para.pmtnum(:,2)',para.pmtnum(:,1),1,size(para.pmtnum,1),1);% 确定邻域结构
                [~,range]=selection(para.step(:,2)',para.step(:,1),1,size(para.step,1),1);%确定步长
                selncut=neihood(selncut,Encode.dnum(j),Encode.style(j),style2,Encode.bounds{j},range);%变化
            else% 若是顺序
                [~,style2]=selection(para.pmtseq(:,2)',para.pmtseq(:,1),1,size(para.pmtseq,1),1);% 确定邻域结构
                selncut=neihood(selncut,Encode.dnum(j),Encode.style(j),style2,[],[]);%变化
            end
            seln(sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)))=selncut;
        end
        popnew(i,:)=seln;
        [fnownew(i),~]=cacul(1,popnew(i,:),data,fsolver,Encode);%  将目标值转化成 适应度值
    end
end
end



