function Xnow=Ksave(Xnow,degree,dnum,bounds,style)
%% ����ȡֵ��Χ
% Xnow ����
% degree �������
% dnum ÿ�����Ļ�����
% bounds ÿ������ڲ���ȡֵ��Χ
% style ÿ�����ı��뷽ʽ

for j=1:degree    %��ÿ�������
    buf=Xnow(sum(dnum(1:j-1))+1:sum(dnum(1:j)));
    buf(buf>bounds{j}(2,:))=bounds{j}(2,buf>bounds{j}(2,:));
    buf(buf<bounds{j}(1,:))=bounds{j}(1,buf<bounds{j}(1,:));
    if style(j)==0
        Xnow(sum(dnum(1:j-1))+1:sum(dnum(1:j)))=round(buf);
    else
        Xnow(sum(dnum(1:j-1))+1:sum(dnum(1:j)))=buf;
    end
end
