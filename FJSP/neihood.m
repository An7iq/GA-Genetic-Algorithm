function   [newpp,buf]=neihood(newpp,len_n,style1,style2,bounds,range)
%% 搜索邻域：设置不同的邻域结构，来产生邻域解
% newpp 单个个体
% len_n 基因长度
%style1 编码类型
%style2 邻域搜索结构
% bounds 如果是数值编码， 则需要给出取值范围
% range 如果是数值编码，则需给出变化的区间（步长）
% 不同的编码方式（主要是顺序跟数值的区别），邻域结构不同
if style1==0 || style1==1 % 如果是整数类型
    if style2==1 %  1为单点
        buf=randperm(len_n,1);
    elseif style2==2%  2为双点
        buf=randperm(len_n,1);
    elseif style2==3%3 为选取n个位置 对应各自概率
        ab=randperm(len_n,1);
        buf=randperm(len_n,ab);
    end
    newpp(buf)=newpp(buf)+(bounds(2,buf)-bounds(1,buf)).*rands(1,numel(buf)).*range;
    newpp(buf)=Ksave(newpp(buf),1,numel(buf),{bounds(:,buf)},style1);
elseif style1==2% 如果是顺序类型
    if style2==1 % 如果采取第一种 双点交叉
        buf=randperm(len_n,2);% 随机选择一个
        newpp(buf(2:-1:1))=newpp(buf);
    elseif style2==2 % 如果采取第二种 单点，前后混乱
        buf=randperm(len_n,1);% 随机选择一个
        newpp=[newpp(buf+1:end),newpp(1:buf)];
    else% 如果采取第三种 多点，重新打乱
        ab=randperm(len_n,1);% 确定变异的数量
        buf=randperm(len_n,ab);% 确定变异的位置
        buff=randperm(ab);
        newpp(buf)=newpp(buf(buff));
    end
end
