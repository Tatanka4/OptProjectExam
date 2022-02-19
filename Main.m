clear;

load dataset8.mat;
[n,m] = size(X);

C_Grid = [1, 10, 100, 1000];
cStar_index = intmax();
#[vStar, gammaStar] = SVM(X, y, C_Grid(1));

#correctPoints = countCorrectPoints(X, y, vStar, gammaStar);
train_avg_metrics= zeros(1,5);
test_avg_metrics= zeros(1,5);

kFold10 = 0.9;
kFold5 = 0.8;

randn("seed",44)
rand("seed",44)

index = randperm(n);

for i = 1:10
  if i == 1
    xTrain = X(index(round((i)*(1-kFold10)*n)+1:n),:);
    yTrain = y(index(round((i)*(1-kFold10)*n)+1:n),:);
    xTest = X(index(1:round((1-kFold10)*n)),:);
    yTest = y(index(1:round((1-kFold10)*n)),:);
  elseif i == 10
    xTrain = X(index(1:round(kFold10*n)),:);
    yTrain = y(index(1:round(kFold10*n)),:);
    xTest = X(index(round(kFold10*n)+1:n),:);
    yTest = y(index(round(kFold10*n)+1:n),:);
  else
    xTrain = X(index(1:round((i-1)*(1-kFold10)*n)),:);
    yTrain = y(index(1:round((i-1)*(1-kFold10)*n)),:);
    xTrain = [xTrain; X(index(round((i+1)*(1-kFold10)*n)+1:n),:)];
    yTrain = [yTrain; y(index(round((i+1)*(1-kFold10)*n)+1:n),:)];
    xTest = X(round(i*(1-kFold10)*n)+1:round((i+1)*(1-kFold10)*n),:);
    yTest = y(round(i*(1-kFold10)*n)+1:round((i+1)*(1-kFold10)*n),:);
  endif
  for j = 1:5
    n1 = size(xTrain)(1);
    index1 = randperm(n1);
    if j == 1
      xTrain5 = xTrain(index1(round((j)*(1-kFold5)*n1)+1:n1),:);
      yTrain5 = yTrain(index1(round((j)*(1-kFold5)*n1)+1:n1),:);
      xTest5 = xTrain(index1(1:round((1-kFold5)*n1)),:);
      yTest5 = yTrain(index1(1:round((1-kFold5)*n1)),:);
    elseif j == 5
      xTrain5 = xTrain(index1(1:round(kFold5*n1)),:);
      yTrain5 = yTrain(index1(1:round(kFold5*n1)),:);
      xTest5 = xTrain(index1(round(kFold5*n1)+1:n1),:);
      yTest5 = yTrain(index1(round(kFold5*n1)+1:n1),:);
    else
      xTrain5 = xTrain(index1(1:round((j-1)*(1-kFold5)*n1)),:);
      yTrain5 = yTrain(index1(1:round((j-1)*(1-kFold5)*n1)),:);
      xTrain5 = [xTrain5; xTrain(index1((j+1)*round((1-kFold5)*n1)+1:n1),:)];
      yTrain5 = [yTrain5; yTrain(index1((j+1)*round((1-kFold5)*n1)+1:n1),:)];
      xTest5 = xTrain(round(j*(1-kFold5)*n1)+1:round((j+1)*(1-kFold5)*n1),:);
      yTest5 = yTrain(round(j*(1-kFold5)*n1)+1:round((j+1)*(1-kFold5)*n1),:);
    endif
    c_avg_accuracy = zeros(1,size(C_Grid)(2));
    for k = 1:size(C_Grid)(2)
      [vStar, gammaStar] = SVM(xTrain5, yTrain5, C_Grid(k),0);
      c_avg_accuracy(k) = c_avg_accuracy(k) + calculateCorrectness(xTest5,yTest5,vStar,gammaStar)
    endfor
    c_avg_accuracy = c_avg_accuracy / 5;
    cStar_index = find(c_avg_accuracy==min(c_avg_accuracy))(1);
    disp(cStar_index)
  endfor
  [vStar, gammaStar, performanceIndicatorsTrain] = SVM(xTrain, yTrain, C_Grid(cStar_index),1);
  #pause()
  [performanceIndicatorsTest] = SVM_Prediction(xTest, yTest, 1, vStar, gammaStar);
  #pause()
  train_avg_metrics = train_avg_metrics + performanceIndicatorsTrain;
  test_avg_metrics = test_avg_metrics + performanceIndicatorsTest;
endfor

train_avg_metrics = train_avg_metrics
test_avg_metrics = test_avg_metrics