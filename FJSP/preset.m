function data=preset(data)
%% Ԥ����
data.lenb=sum(data.volme);%��������
data.lenk=zeros(1,data.lenb);%ÿ������Ĺ�������
data.nk=cell(1,data.lenb);%��¼ÿ�������ÿ��������ÿ�������Ŀ�ִ����
data.cnn=cell(1,data.lenb);%��¼ÿ�������ÿ������֮��Ľ�ǰ��ϵ
data.taskall=[];%��¼���е�����
n=0;
for i=1:data.pro
    buf=data.detail(data.detail(:,1)==i,:);
    lenk=size(buf,1);
    nk=buf(:,3:end);
    cnn=zeros(lenk, lenk);
    for j=1: lenk-1
        for z=j+1: lenk
            if buf(j,2)>buf(z,2) % z ��j�Ľ�ǰ����
                cnn(j,z)=1;
            elseif buf(j,2)<buf(z,2) % j ��z�Ľ�ǰ����
                cnn(z,j)=1;
            end
        end
    end
    for k=1:data.volme(i) %����ÿ���㲿������
        n=n+1;
        data.lenk(n)=lenk;
        data.nk{n}=nk;
        data.cnn{n}=cnn;
        data.taskall=[data.taskall;[ones(data.lenk(n),1).*n,ones(data.lenk(n),1).*i,buf(:,2)]; ];
    end
end
data.lena=size(data.taskall,1);



end


