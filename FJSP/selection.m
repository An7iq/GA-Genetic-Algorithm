function [fnownew,populationnew]=selection(fnow,population,parasel,numin,numout)
%% ѡ�񣺸���ѡ����򣬴�������Ⱥ��ѡȡ�ض������ĸ���
% fnow  ��Ӧ��ֵ 
% population ��
% parasel ѡ������
% numin ��������ݸ���
% numout  ��������ݸ���
% ����ѡ������� ������ ���numout��ѡ��ĸ��壨���ظ���
seln=zeros(1,numout);
if parasel==1 % ��������̶�
    f_z=fnow-min(fnow)+1;
    f_z=f_z./sum(f_z);
    cumsump=cumsum(f_z);
    for i=1:numout
        r=rand;
        prand=cumsump-r;
        j=find(prand>=0);
        seln(i)=j(1);
    end %gambel , the better solution have the better prob to be selected
elseif parasel==2 % ����Ƕ�Ԫ��������
    for i=1:numout
        r=randperm(numin,2);%ѡȡ����
        [~,j]=max(fnow(r));
        seln(i)=r(j);
    end %ѡȡ���� ��ѡ��õ�
elseif parasel==3 % �����4Ԫ��������
    for i=1:numout
        r=randperm(numin,4);%ѡȡ�ĸ�
        [~,j]=max(fnow(r));
        seln(i)=r(j);
    end %ѡȡ�ĸ� ��ѡ��õ�
end
    fnownew=fnow(seln);
    populationnew=population(seln,:);
end