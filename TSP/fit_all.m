function [f,results]=fit_all(xnow,data,Encode)
%% ½âÂë 
f=0;
for i=1:data.city-1
    f=f+data.distall(xnow(i),xnow(i+1));
end
f=f+data.distall(xnow(1),xnow(end));
results.f=f;
results.road=[xnow,xnow(1)];
