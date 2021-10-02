function [results,paintd]=GAsolver(para,Encode,fsolver,data)
%% �㷨����
% data �������� para �㷨���� Encode ���뷽ʽ fsolverĿ�꺯��
%% Ԥ��һЩ�����ڴ�
fnow=zeros(1,para.popsize);%ÿһ������Ⱥ
fmean=zeros(1,para.Generationnmax);%��Ⱥƽ��ֵ�ڴ�
fbest=zeros(1,para.Generationnmax);%Ԥ����Ⱥ���ֵ�ڴ�
fbestsofar=-inf;%���˴����Ŀ��ֵ
solbestsofar=[];%���˴���ѽ�
%% ���ɳ�ʼ����
population=rand_generate(para.popsize,Encode);% �����������
[fit,fitbest,~,~,index]=cacul(para.popsize,population,data,fsolver,Encode);% ����Ŀ��ֵ
fnow=fit;
if fbestsofar<fitbest % ���˴����Ŀ��ֵ
    fbestsofar=fitbest;
    solbestsofar=population(index,:);
end 
%% ��ʼ����
tic
Generation=0; %Ԥ����� ����
while Generation<para.Generationnmax+1 && toc<=para.timelimit % ��ʱ�估������������Ҫ��ʱ
    Generation=Generation+1; %���������� 1
    %% Selection �γ��µ���Ⱥ
    [fnow,population]=selection(fnow,population,para.sel,para.popsize,para.popsize);
    %% crossover �γ��µ���Ⱥ
    [fnow,population]=crossover_GA(fnow,population,para,data,Encode,fsolver);%crossover
    [gbest,num]=max(fnow);%������Ѵ˴�Ŀ��ֵ
    if fbestsofar<gbest
        fbestsofar=gbest;
        solbestsofar=population(num,:);
    end
    %% mutation �γ��µ���Ⱥ
    [fnow,population]=mution_GA(fnow,population,para,data,Encode,fsolver);%mutation
    [gbest,num]=max(fnow);%������Ѵ˴�Ŀ��ֵ
    if fbestsofar<gbest
        fbestsofar=gbest;
        solbestsofar=population(num,:);
    end
    fbest(Generation)=fbestsofar;%stock the best resulut current
    fmean(Generation)=mean(fnow); %����ƽ���˴�Ŀ��ֵ
    Generation
end
fbest=fbest(1:Generation);
fmean=fmean(1:Generation);
[~,results]=fsolver.fitness(solbestsofar,data,Encode);

paintd.f_best=fbest.*fsolver.minmax;
paintd.f_mean=fmean.*fsolver.minmax;
paintd.f_fitness=fbest;
end

function  [fnownew,popnew]=crossover_GA(fnownew,popnew,para,data,Encode,fsolver)%����
for i=1:2:para.popsize % ÿ����������в���
    seln=popnew(i:i+1,:);%����ѡȡ��������
    if rand<=para.pcrossover % ������㽻�����
        %���뽻��
        % ȷ������㼶
        bufn=randperm(Encode.degree,1);
        bufn=randperm(Encode.degree,bufn);
        for j=bufn  % ��ѡ�еı��������ж�
            selncut=seln(:,sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)));% ѡȡ��Ӧ������Ķ�Ӧ�����
            % ѡ������һ�ֽ��淽ʽ
            if Encode.dnum(j)==1%���ֻ��һ������ ֻ�ܲ�ȡѡȡһ��
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
for i=1:para.popsize % ÿ����������в���
    seln=popnew(i,:);%����ѡȡ��������
    if rand<=para.pmutation % �������������
        %�������
        % ȷ������㼶
        bufn=randperm(Encode.degree,1);
        bufn=randperm(Encode.degree,bufn);
        for j=bufn  % ��ѡ�еı��������ж�
            selncut=seln(sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)));% ѡȡ��Ӧ������Ķ�Ӧ�����
            if Encode.style(j)==0 ||  Encode.style(j)==1 % ������������ʵ��
                [~,style2]=selection(para.pmtnum(:,2)',para.pmtnum(:,1),1,size(para.pmtnum,1),1);% ȷ������ṹ
                [~,range]=selection(para.step(:,2)',para.step(:,1),1,size(para.step,1),1);%ȷ������
                selncut=neihood(selncut,Encode.dnum(j),Encode.style(j),style2,Encode.bounds{j},range);%�仯
            else% ����˳��
                [~,style2]=selection(para.pmtseq(:,2)',para.pmtseq(:,1),1,size(para.pmtseq,1),1);% ȷ������ṹ
                selncut=neihood(selncut,Encode.dnum(j),Encode.style(j),style2,[],[]);%�仯
            end
            seln(sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j)))=selncut;
        end
        popnew(i,:)=seln;
        [fnownew(i),~]=cacul(1,popnew(i,:),data,fsolver,Encode);%  ��Ŀ��ֵת���� ��Ӧ��ֵ
    end
end
end



