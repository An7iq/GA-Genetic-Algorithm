function   [newpp,buf]=neihood(newpp,len_n,style1,style2,bounds,range)
%% �����������ò�ͬ������ṹ�������������
% newpp ��������
% len_n ���򳤶�
%style1 ��������
%style2 ���������ṹ
% bounds �������ֵ���룬 ����Ҫ����ȡֵ��Χ
% range �������ֵ���룬��������仯�����䣨������
% ��ͬ�ı��뷽ʽ����Ҫ��˳�����ֵ�����𣩣�����ṹ��ͬ
if style1==0 || style1==1 % �������������
    if style2==1 %  1Ϊ����
        buf=randperm(len_n,1);
    elseif style2==2%  2Ϊ˫��
        buf=randperm(len_n,1);
    elseif style2==3%3 Ϊѡȡn��λ�� ��Ӧ���Ը���
        ab=randperm(len_n,1);
        buf=randperm(len_n,ab);
    end
    newpp(buf)=newpp(buf)+(bounds(2,buf)-bounds(1,buf)).*rands(1,numel(buf)).*range;
    newpp(buf)=Ksave(newpp(buf),1,numel(buf),{bounds(:,buf)},style1);
elseif style1==2% �����˳������
    if style2==1 % �����ȡ��һ�� ˫�㽻��
        buf=randperm(len_n,2);% ���ѡ��һ��
        newpp(buf(2:-1:1))=newpp(buf);
    elseif style2==2 % �����ȡ�ڶ��� ���㣬ǰ�����
        buf=randperm(len_n,1);% ���ѡ��һ��
        newpp=[newpp(buf+1:end),newpp(1:buf)];
    else% �����ȡ������ ��㣬���´���
        ab=randperm(len_n,1);% ȷ�����������
        buf=randperm(len_n,ab);% ȷ�������λ��
        buff=randperm(ab);
        newpp(buf)=newpp(buf(buff));
    end
end
