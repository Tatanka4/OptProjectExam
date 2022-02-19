clear;

load toy3D.mat;
[n,m] = size(X);

C_Grid = [1, 10, 100, 1000];
[vStar, gammaStar] = SVM(X, y, C_Grid(1));

#correctPoints = countCorrectPoints(X, y, vStar, gammaStar);


kFold10 = 0.9;

randn("seed",44)
rand("seed",44)

index = randperm(n);

for i = 1:10
  if i == 1
    xTrain = X(index((i)*round((1-kFold10)*n)+1:n),:);
    yTrain = y(index((i)*round((1-kFold10)*n)+1:n),:);
    xTest = X(index(1:round((1-kFold10)*n)),:);
    yTest = y(index(1:round((1-kFold10)*n)),:);
  elseif i == 10
    xTrain = X(index(1:round(kFold10*n)),:);
    yTrain = y(index(1:round(kFold10*n)),:);
    xTest = X(index(round(kFold10*n)+1:n),:);
    yTest = y(index(round(kFold10*n)+1:n),:);
  else
    xTrain = X(index(1:(i-1)*round((1-kFold10)*n)),:);
    yTrain = y(index(1:(i-1)*round((1-kFold10)*n)),:);
    xTrain = [xTrain; X(index((i+1)*round((1-kFold10)*n)+1:n),:)];
    yTrain = [yTrain; y(index((i+1)*round((1-kFold10)*n)+1:n),:)];
    xTest = X(i*round((1-kFold10)*n)+1:(i+1)*round((1-kFold10)*n),:);
    yTest = y(i*round((1-kFold10)*n)+1:(i+1)*round((1-kFold10)*n),:);
  endif
  %pause()
end
