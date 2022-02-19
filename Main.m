clear;

load dataset8.mat;
[n,m] = size(X);

C_Grid = [1, 10, 100, 1000];
cStar_index = intmax();
#[vStar, gammaStar] = SVM(X, y, C_Grid(1));

#correctPoints = countCorrectPoints(X, y, vStar, gammaStar);


kFold10 = 0.9;
kFold5 = 0.8;

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
  for j = 1:5
    n1 = size(xTrain)(1);
    index1 = randperm(n1);
    if j == 1
      xTrain5 = xTrain(index1((j)*round((1-kFold5)*n1)+1:n1),:);
      yTrain5 = yTrain(index1((j)*round((1-kFold5)*n1)+1:n1),:);
      xTest5 = xTrain(index1(1:round((1-kFold5)*n1)),:);
      yTest5 = yTrain(index1(1:round((1-kFold5)*n1)),:);
    elseif j == 5
      xTrain5 = xTrain(index1(1:round(kFold5*n1)),:);
      yTrain5 = yTrain(index1(1:round(kFold5*n1)),:);
      xTest5 = xTrain(index1(round(kFold5*n1)+1:n1),:);
      yTest5 = yTrain(index1(round(kFold5*n1)+1:n1),:);
    else
      xTrain5 = xTrain(index1(1:(j-1)*round((1-kFold5)*n1)),:);
      yTrain5 = yTrain(index1(1:(j-1)*round((1-kFold5)*n1)),:);
      xTrain5 = [xTrain5; xTrain(index1((j+1)*round((1-kFold5)*n1)+1:n1),:)];
      yTrain5 = [yTrain5; yTrain(index1((j+1)*round((1-kFold5)*n1)+1:n1),:)];
      xTest5 = xTrain(j*round((1-kFold5)*n1)+1:(j+1)*round((1-kFold5)*n1),:);
      yTest5 = yTrain(j*round((1-kFold5)*n1)+1:(j+1)*round((1-kFold5)*n1),:);
    endif
    c_avg_accuracy = zeros(1,size(C_Grid)(2));
    for k = 1:size(C_Grid)(2)
      [vStar, gammaStar] = SVM(xTrain5, yTrain5, C_Grid(k),0);
      c_avg_accuracy(k) = c_avg_accuracy(k) + calculateCorrectness(xTest5,yTest5,vStar,gammaStar)
    endfor
    c_avg_accuracy = c_avg_accuracy / 5;
    cStar_index = find(c_avg_accuracy==min(c_avg_accuracy));
  endfor
  [vStar, gammaStar] = SVM(xTrain, yTrain, C_Grid(cStar_index),1);
  %pause()
endfor
