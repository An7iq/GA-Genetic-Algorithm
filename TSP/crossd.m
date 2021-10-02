function   newpp=crossd(newpp,len_n,style1,style2)
%% 搜索新解： 群体相互作用-交叉搜索
% newpp 两个个体
% len_n 基因长度
%style1 编码类型
%style2 交叉方式
% 先通过交叉方式来确定交叉片段 再根据不同的编码方式进行操作（主要是顺序跟数值的区别）
if style2==1 % 如果是1为单点交叉
    a=randperm(len_n,1);
    selet=1:a;
elseif style2==2 % 如果是2 为双点交叉（交叉中间基因）
    a=randperm(len_n,2);
    selet=min(a):max(a);
elseif style2==3 % 如果是3 为选取随机的位置
    a=randperm(len_n,1);
    b=randperm(len_n,a);
    selet=b;
end
if style1<=1 % 如果是数值
    buf=newpp(1,selet);
    newpp(1,selet)=newpp(2,selet);
    newpp(2,selet)=buf;
elseif style1==2 % 如果是顺序
    lent=numel(selet);
    indexnew=zeros(1,lent);
    bufy=1:len_n;
    for z=1:lent
        bufe=find(newpp(2,bufy)==newpp(1,selet(z)));% 找到对应的位置
        indexnew(z)=bufy(bufe(1));
        bufy(bufy==indexnew(z))=[];
    end
    indexnew=sort(indexnew);% 找到对应位置后，重新排序，进行替换
    bufu=newpp(1,selet); % 交换
    newpp(1,selet)=newpp(2,indexnew);
    newpp(2,indexnew)=bufu;
end
    