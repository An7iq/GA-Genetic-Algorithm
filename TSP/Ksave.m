function Xnow=Ksave(Xnow,degree,dnum,bounds,style)
%% 纠正取值范围
% Xnow 方案
% degree 编码层数
% dnum 每层编码的基因数
% bounds 每层编码内部的取值范围
% style 每层编码的编码方式

for j=1:degree    %对每个基因段
    buf=Xnow(sum(dnum(1:j-1))+1:sum(dnum(1:j)));
    buf(buf>bounds{j}(2,:))=bounds{j}(2,buf>bounds{j}(2,:));
    buf(buf<bounds{j}(1,:))=bounds{j}(1,buf<bounds{j}(1,:));
    if style(j)==0
        Xnow(sum(dnum(1:j-1))+1:sum(dnum(1:j)))=round(buf);
    else
        Xnow(sum(dnum(1:j-1))+1:sum(dnum(1:j)))=buf;
    end
end
