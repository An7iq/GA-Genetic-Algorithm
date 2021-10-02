function [f,results]=fit_all(xnow,data,Encode)
%% 计算目标
sequencea=xnow(1:Encode.dnum(1)/2);
machinea=xnow(1+Encode.dnum(1)/2:end);
cnn=data.cnn;% 工序的安排顺序
len_a=data.lena;% 工序数
len_b=data.lenb;%任务数
status_ma=cell(1,data.machi);
for i=1:data.machi
    status_ma{i}=[0,inf,0];
end%机器的状态


taskrecord=zeros(len_a,6);%记录每个工序的状态
status_pro=zeros(3,len_b);%任务的状态
status_pro(2,:)=ones(1,len_b);
task_a=zeros(1,2);
for i=1:len_a
    %% 选择哪一个任务里的哪个工序
    % 找出哪些任务,候选集合
    buf=find(status_pro(2,:)>0);

    buf2=buf(round(sequencea(i)*(numel(buf)-1))+1);
    task_a(1)=buf2;task_a(2)=status_pro(2,buf2);% 确定了要做哪一个工序
    
    buf=data.nk{task_a(1)}(task_a(2),:);% 选择了哪一个
    buf1=find(buf>0);
    task_b=buf1(round(machinea(i)*(numel(buf1)-1))+1);% 确定了要做哪一个机器
    % 更新机器状态
    t1=status_pro(3,task_a(1));% 任务可以开始的时间
    t2=buf(task_b);%需要的时间
    tall=status_ma{task_b};% 机器
    t3=tall(:,1);
    t3(t3<t1)=t1;
    buf=find( tall(:,2)-(t3+t2)>=0);%找出满足的最小
    buf=buf(1);% 选择的时间段
    t4=t3(buf);%开始时间
    t5=t4+t2;%结束时间
    %% 更新
    % 机器
    buf1=tall(buf,:);
    buf2=zeros(3,3);
    buf2(1,:)=[buf1(1),t4,0];
    buf2(2,:)=[t4,t5,1];
    buf2(3,:)=[t5,buf1(2),0];
    tall=[tall(1:buf-1,:);buf2;tall(1+buf:end,:)];
    tall((tall(:,2)-tall(:,1))<=0,:)=[];
    tall(tall(:,3)==1,:)=[];
    status_ma{task_b}=tall;
    
    % 更新工序
    taskrecord(i,:)=[i,task_a,t4,t5,task_b];
    % 更新安排顺序
    buf=cnn{task_a(1)};
    buf(:,task_a(2))=0;
    buf(task_a(2),:)=1;
    cnn{task_a(1)}=buf;
    % 更新任务
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
