function   newpp=crossd(newpp,len_n,style1,style2)
%% �����½⣺ Ⱥ���໥����-��������
% newpp ��������
% len_n ���򳤶�
%style1 ��������
%style2 ���淽ʽ
% ��ͨ�����淽ʽ��ȷ������Ƭ�� �ٸ��ݲ�ͬ�ı��뷽ʽ���в�������Ҫ��˳�����ֵ������
if style2==1 % �����1Ϊ���㽻��
    a=randperm(len_n,1);
    selet=1:a;
elseif style2==2 % �����2 Ϊ˫�㽻�棨�����м����
    a=randperm(len_n,2);
    selet=min(a):max(a);
elseif style2==3 % �����3 Ϊѡȡ�����λ��
    a=randperm(len_n,1);
    b=randperm(len_n,a);
    selet=b;
end
if style1<=1 % �������ֵ
    buf=newpp(1,selet);
    newpp(1,selet)=newpp(2,selet);
    newpp(2,selet)=buf;
elseif style1==2 % �����˳��
    lent=numel(selet);
    indexnew=zeros(1,lent);
    bufy=1:len_n;
    for z=1:lent
        bufe=find(newpp(2,bufy)==newpp(1,selet(z)));% �ҵ���Ӧ��λ��
        indexnew(z)=bufy(bufe(1));
        bufy(bufy==indexnew(z))=[];
    end
    indexnew=sort(indexnew);% �ҵ���Ӧλ�ú��������򣬽����滻
    bufu=newpp(1,selet); % ����
    newpp(1,selet)=newpp(2,indexnew);
    newpp(2,indexnew)=bufu;
end
    