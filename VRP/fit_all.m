function [f,results]=fit_all(xnow,data,Encode)
%% 解码
nn=0;% 车的数量
detail=cell(0);
loadall=[];
distall=[];
while numel(xnow)>0
    nn=nn+1;
    road=1;
    load=0;
    disty=0;
    mm=1;
    while numel(xnow)>0 && mm==1
        if data.required(xnow(1))+load<=data.capcity
            disty=disty+data.distall(road(end),xnow(1)+1);
            road=[road,xnow(1)+1];
            load=load+data.required(xnow(1));
            xnow(1)=[];
        else
            disty=disty+data.distall(road(end),1);
            road=[road,1];
            mm=0;
        end
    end
    if mm==1
        disty=disty+data.distall(road(end),1);
        road=[road,1];
        
    end
    detail{nn}=road;
    loadall(nn)=load;
    distall(nn)=disty;
end
f=sum(distall);
results.f=f;
results.detail=detail;
results.loadall=loadall;
results.distall=distall;

