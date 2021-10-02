function data=preset(data)
%% 预处理
data.lenb=sum(data.volme);%总任务数
data.lenk=zeros(1,data.lenb);%每个任务的工序数量
data.nk=cell(1,data.lenb);%记录每个任务的每个工序与每个机器的可执行性
data.cnn=cell(1,data.lenb);%记录每个任务的每个工序之间的紧前关系
data.taskall=[];%记录所有的需求
n=0;
for i=1:data.pro
    buf=data.detail(data.detail(:,1)==i,:);
    lenk=size(buf,1);
    nk=buf(:,3:end);
    cnn=zeros(lenk, lenk);
    for j=1: lenk-1
        for z=j+1: lenk
            if buf(j,2)>buf(z,2) % z 是j的紧前任务
                cnn(j,z)=1;
            elseif buf(j,2)<buf(z,2) % j 是z的紧前任务
                cnn(z,j)=1;
            end
        end
    end
    for k=1:data.volme(i) %对于每个零部件而言
        n=n+1;
        data.lenk(n)=lenk;
        data.nk{n}=nk;
        data.cnn{n}=cnn;
        data.taskall=[data.taskall;[ones(data.lenk(n),1).*n,ones(data.lenk(n),1).*i,buf(:,2)]; ];
    end
end
data.lena=size(data.taskall,1);



end


