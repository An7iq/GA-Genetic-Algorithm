function population=rand_generate(popsize,Encode)
%%  ���������������趨��ȡֵ��Χ�ڲ�����
% popsize �����ĸ�����
% Encode ���뷽ʽ
population=zeros(popsize,sum(Encode.dnum));%Ԥ����Ⱥ������
for j=1:Encode.degree    %��ÿ������� % ��ÿһ�α���
    buf = rand(popsize,Encode.dnum(j)); % ������Ӧ������� ---- ���ڻ���ӳ��  �����޸Ĵ˴�
    range=sum(Encode.dnum(1:j-1))+1:sum(Encode.dnum(1:j));
    if Encode.style(j)==0  % 0 ������ֵ ����
        population(:,range)=round(buf.*(ones(popsize,1)*(Encode.bounds{j}(2,:)-Encode.bounds{j}(1,:)))+ones(popsize,1)*Encode.bounds{j}(1,:));
    elseif Encode.style(j)==1 % 1 Ϊʵ����ֵ  ����
        population(:,range)=buf.*(ones(popsize,1)*(Encode.bounds{j}(2,:)-Encode.bounds{j}(1,:)))+ones(popsize,1)*Encode.bounds{j}(1,:);
    elseif Encode.style(j)==2 % 2˳�� ����
        [~,index]=sort(buf,2);
        population(:,range)=Encode.bounds{j}(index);
    end
end
end