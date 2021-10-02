function population=rand_generate(popsize,Encode)
%%  生成随机：随机在设定的取值范围内产生解
% popsize 产生的个体数
% Encode 编码方式
population=zeros(popsize,sum(Encode.dnum));%预设种群的区间
for j=1:Encode.degree    %对每个基因段 % 对每一段编码
    buf = rand(popsize,Encode.dnum(j)); % 产生对应的随机数 ---- 对于混沌映射  可以修改此处
    range=sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j));
    if Encode.style(j)==0  % 0 整数数值 编码
        population(:,range)=round(buf.*(ones(popsize,1)*(Encode.bounds{j}(2,:)-Encode.bounds{j}(1,:)))+ones(popsize,1)*Encode.bounds{j}(1,:));
    elseif Encode.style(j)==1 % 1 为实数数值  编码
        population(:,range)=buf.*(ones(popsize,1)*(Encode.bounds{j}(2,:)-Encode.bounds{j}(1,:)))+ones(popsize,1)*Encode.bounds{j}(1,:);
    elseif Encode.style(j)==2 % 2顺序 编码
        [~,index]=sort(buf,2);
        population(:,range)=Encode.bounds{j}(index);
    end
end
end