clear;

load dataset8.mat;
[n,m] = size(X);

C_Grid = [1, 10, 100, 1000];
%[vStar, gammaStar] = SVM(X, y, C_Grid(1));

kFold10 = 0.9

randn("seed",44)
rand("seed",44)

index = randperm(n);

for i = 1:10
  
 xTrain = X(index(1:round(kFold10*400)),:); 
 xTest = X(index(round(kFold10*400)+1:end),:);
 yTrain = y(index(1:round(kFold10*400)),:); 
 yTest = y(index(round(kFold10*400)+1:end),:);
  