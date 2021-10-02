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
para.Generationnmax=500;%���������� %���� ����0
para.pcrossover=0.5;% ���뽻�����Ӹ��� % 0 ��  1  ȡֵ��Χ С��
para.pmutation=0.2;% ����������Ӹ��� % 0 ��  1  ȡֵ��Χ С��
para.timelimit=20000;% �����ʱ�� ��λΪ�� 
%���Ӳ���
%ѡ������
para.sel=2;% ѡ������ 1���̶�  2  ��Ԫ�������� 3  ��Ԫ��������
%��������
para.pcr=[1 0.3
    2 0.9
    3 0.5];% �������� 1Ϊ���㽻�� 2 Ϊ˫�㽻�棨�����м����3 Ϊѡȡ�����λ�� ��Ӧ���Ը���
% ��������-˳��
para.pmtseq=[1 2.2
    2 0.3
    3 0.6];%  ������Ϊ˳�� 1 Ϊ���㻥��   2 ѡȡ1�����ǰ�󻥻�  3 ѡȡ n��λ�� �������  ��Ӧ���Ը���
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
Encode.style=1; %һά��������     --ÿ�λ�������������� 0������ֵ  1 Ϊʵ����ֵ    ��ֵҪ��ȡֵ��Χ  ˳��Ҫ����弯�� % ��������
% ÿ�������
Encode.dnum=data.lena*2;%һά��������     -- ÿ�α���Ļ���λ 
%ÿ��ȡֵ��Χ
Encode.bounds{1}=[0;1]*ones(1,data.lena*2); % ��������    --0 1.��ֵҪ��ȡֵ��Χ��ά���� 2 ��ֵҪ��һά����

%% 4�������Ŀ��ĺ���
fsolver.fitness=@fit_all; %����Ŀ��ĺ��� 
fsolver.minmax=-1;% 1 Ϊ�����    -1Ϊ����С

%% 5�����㷨
[result,paintd]=GAsolver(para,Encode,fsolver,data);

%% 6��ͼ
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
pp={'��Դ1','��Դ2','��Դ3','��Դ4','��Դ5','��Դ6','��Դ7','��Դ8','��Դ9'};
set(gca, 'XLim',[0 tm]); % X���������ʾ��Χ
% set(gca, 'XTick',[1:bufy(end)+1] ); % X��ļǺŵ�
% set(gca, 'XTicklabel',{'-pi','0','pi'}); % X��ļǺ�
set(gca, 'YLim',[0 tn*1.5]); % X���������ʾ��Χ
set(gca, 'YTick',0.5+[0:tn-1].*1.5 ); % X��ļǺŵ�
set(gca, 'YTicklabel',pp ); % X��ļǺŵ�
xlabel('ʱ��','FontSize',16);
set(gcf,'color','w')%���������óɰ�ɫ


