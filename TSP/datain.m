% ���� �������ݵĵط�
data.city=120;
data.coord=rand(data.city,2).*(ones(data.city,1)*[1000,1000]);% ÿ����Դ������
% data.coord=[1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556;3238 1229;...
%     4196 1044;4312  790;4386  570;3007 1970;2562 1756;2788 1491;2381 1676;...
%     1332  695;3715 1678;3918 2179;4061 2370;3780 2212;3676 2578;4029 2838;...
%     4263 2931;3429 1908;3507 2376;3394 2643;3439 3201;2935 3240;3140 3550;...
%     2545 2357;2778 2826;2370 2975];
% data.coord=[1 6734 1453
% 2 2233 10
% 3 5530 1424
% 4 401 841
% 5 3082 1644
% 6 7608 4458
% 7 7573 3716
% 8 7265 1268
% 9 6898 1885
% 10 1112 2049
% 11 5468 2606
% 12 5989 2873
% 13 4706 2674
% 14 4612 2035
% 15 6347 2683
% 16 6107 669
% 17 7611 5184
% 18 7462 3590
% 19 7732 4723
% 20 5900 3561
% 21 4483 3369
% 22 6101 1110
% 23 5199 2182
% 24 1633 2809
% 25 4307 2322
% 26 675 1006
% 27 7555 4819
% 28 7541 3981
% 29 3177 756
% 30 7352 4506
% 31 7545 2801
% 32 3245 3305
% 33 6426 3173
% 34 4608 1198
% 35 23 2216
% 36 7248 3779
% 37 7762 4595
% 38 7392 2244
% 39 3484 2829
% 40 6271 2135
% 41 4985 140
% 42 1916 1569
% 43 7280 4899
% 44 7509 3239
% 45 10 2676
% 46 6807 2993
% 47 5185 3258
% 48 3023 1942];
% data.coord(:,1)=[];
data.distall=dist(data.coord');% �ܹ���Ҫ���� �������� 
