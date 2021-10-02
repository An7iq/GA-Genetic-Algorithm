%% �㷨������
% clear the record
close all;
clear all;
clc;
%% 1�������� ��  ���� Ԥ���� 
run datain.m %��������
data=preset(data);% Ԥ���� 

%% 2���ò���
%�������
para.popsize=300;% ��Ⱥ��С  %����2 ����
para.Generationnmax=2000;%���������� %���� ����0
para.pcrossover=0.6;% ���뽻�����Ӹ��� % 0 ��  1  ȡֵ��Χ С��
para.pmutation=0.1;% ����������Ӹ��� % 0 ��  1  ȡֵ��Χ С��
para.timelimit=50;% �����ʱ�� ��λΪ�� 
%���Ӳ���
%ѡ������
para.sel=2;% ѡ������ 1���̶�  2  ��Ԫ�������� 3  ��Ԫ��������
%��������
para.pcr=[1 0.3
    2 0.9
    3 0.5];% �������� 1Ϊ���㽻�� 2 Ϊ˫�㽻�棨�����м����3 Ϊѡȡ�����λ�� ��Ӧ���Ը���
% ��������-˳��
para.pmtseq=[1 2.2
    2 0.4
    3 0.1];%  ������Ϊ˳�� 1 Ϊ���㻥��   2 ѡȡ1�����ǰ�󻥻�  3 ѡȡ n��λ�� �������  ��Ӧ���Ը���
% ��������-��ֵ-�仯λ��
para.pmtnum=[1 0.2
    2 0.3
    3 0.5];%  ������Ϊ��ֵ  1Ϊ���� 2Ϊ˫�� 3 Ϊѡȡn��λ�� ��Ӧ���Ը���
% ��������-��ֵ-�仯����
para.step=[0.3 0.6
    0.6 0.3
    0.8 0.2];%%  ������Ϊ��ֵ ��ʾ��ֵ���͵���ȡֵ��Χ�ڵĲ�������

%%  3 ���뷽ʽ
% �������
Encode.degree=1;%��������   --������� 
% ��������
Encode.style=2; %һά��������     --ÿ�λ�������������� 0������ֵ  1 Ϊʵ����ֵ    ��ֵҪ��ȡֵ��Χ  ˳��Ҫ����弯�� % ��������
% ÿ�������
Encode.dnum=data.site;%һά��������     -- ÿ�α���Ļ���λ 
%ÿ��ȡֵ��Χ
Encode.bounds{1}=[1:data.site]; % ��������    --0 1.��ֵҪ��ȡֵ��Χ��ά���� 2 ��ֵҪ��һά����

%% 4�������Ŀ��ĺ���
fsolver.fitness=@fit_all; %����Ŀ��ĺ��� 
fsolver.minmax=-1;% 1 Ϊ�����    -1Ϊ����С

%% 5�����㷨
[result,paintd]=GAsolver(para,Encode,fsolver,data);

%% 6��ͼ
figure
plot(paintd.f_best)



figure
detail=result.detail;
hold on
for i=1:size(detail,2)
    bug=detail{i};
    for j=1:size(bug,2)-1
        plot(data.coorall(bug(j:j+1),1)',data.coorall(bug(j:j+1),2)','color','r')
    end
end
