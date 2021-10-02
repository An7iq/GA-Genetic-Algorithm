function [f,results]=fit_all(xnow,data,Encode)
%% ����Ŀ��
sequencea=xnow(1:Encode.dnum(1)/2);
machinea=xnow(1+Encode.dnum(1)/2:end);
cnn=data.cnn;% ����İ���˳��
len_a=data.lena;% ������
len_b=data.lenb;%������
status_ma=cell(1,data.machi);
for i=1:data.machi
    status_ma{i}=[0,inf,0];
end%������״̬


taskrecord=zeros(len_a,6);%��¼ÿ�������״̬
status_pro=zeros(3,len_b);%�����״̬
status_pro(2,:)=ones(1,len_b);
task_a=zeros(1,2);
for i=1:len_a
    %% ѡ����һ����������ĸ�����
    % �ҳ���Щ����,��ѡ����
    buf=find(status_pro(2,:)>0);

    buf2=buf(round(sequencea(i)*(numel(buf)-1))+1);
    task_a(1)=buf2;task_a(2)=status_pro(2,buf2);% ȷ����Ҫ����һ������
    
    buf=data.nk{task_a(1)}(task_a(2),:);% ѡ������һ��
    buf1=find(buf>0);
    task_b=buf1(round(machinea(i)*(numel(buf1)-1))+1);% ȷ����Ҫ����һ������
    % ���»���״̬
    t1=status_pro(3,task_a(1));% ������Կ�ʼ��ʱ��
    t2=buf(task_b);%��Ҫ��ʱ��
    tall=status_ma{task_b};% ����
    t3=tall(:,1);
    t3(t3<t1)=t1;
    buf=find( tall(:,2)-(t3+t2)>=0);%�ҳ��������С
    buf=buf(1);% ѡ���ʱ���
    t4=t3(buf);%��ʼʱ��
    t5=t4+t2;%����ʱ��
    %% ����
    % ����
    buf1=tall(buf,:);
    buf2=zeros(3,3);
    buf2(1,:)=[buf1(1),t4,0];
    buf2(2,:)=[t4,t5,1];
    buf2(3,:)=[t5,buf1(2),0];
    tall=[tall(1:buf-1,:);buf2;tall(1+buf:end,:)];
    tall((tall(:,2)-tall(:,1))<=0,:)=[];
    tall(tall(:,3)==1,:)=[];
    status_ma{task_b}=tall;
    
    % ���¹���
    taskrecord(i,:)=[i,task_a,t4,t5,task_b];
    % ���°���˳��
    buf=cnn{task_a(1)};
    buf(:,task_a(2))=0;
    buf(task_a(2),:)=1;
    cnn{task_a(1)}=buf;
    % ��������
    status_pro(3,task_a(1))=t5;
    if status_pro(2,task_a(1))+1<=data.lenk(task_a(1))
        status_pro(2,task_a(1))=status_pro(2,task_a(1))+1;
    else
        status_pro(2,task_a(1))=0;
    end
%     if sum(sum(buf,2)==0)==0
%         status_pro(1,task_a(1))=1;
%     end
end
f=max(taskrecord(:,5));
results.f=f;
results.taskrecord=taskrecord;
