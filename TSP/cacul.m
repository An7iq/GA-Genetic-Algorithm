function [fnow,fbest,fmean,resultall,index]=cacul(popsize,population,data,fsolver,Encode)
%%  ������Ӧ�ȣ� �Լ����ֵ��ƽ��ֵ��������Լ���ѽ�����
% popsize Ⱥ�����
%population ��������
% data ����
%fsolver Ŀ�귽��
%Encode ���뷽ʽ
%% ��Ӧ�ȼ���
fnow=zeros(1,popsize);
resultall=cell(1,popsize);
for i=1:popsize
    [fnow(i),resultall{i}]=fsolver.fitness(population(i,:),data,Encode);%Ŀ�꺯������
end
fnow=fnow*fsolver.minmax;%  ��Ŀ��ֵת���� ��Ӧ��ֵ
[fbest,index]=max(fnow);
fmean=mean(fnow);
end