clear all
clc

sem = @(x) std(x)/(sqrt(length(x))+1);

anonymTools
fittingTools

xFinal             =   [];
user = {};

for userCnt      =   2:3
    user{end+1}                 =   Subject_Analysis_Estimation_Mix_F01(userCnt, 2, 'Estimation');
    userCnt
end

for userCnt      =   [4:52 54:55 57:67]
    user{end+1}                 =   Subject_Analysis_Estimation_Mix_F01(userCnt, 1, 'Estimation');
    userCnt
end

