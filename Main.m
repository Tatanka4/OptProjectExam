#clear;

load dataset8.mat;
[n,m] = size(X);

C_Grid = [1, 10, 100, 1000];
#[vStar, gammaStar] = SVM(X, y, C_Grid(1));

correctPoints = 0;

for i = 1:400
  
  if y(i) == +1 && (vStar'*X(i)) - gammaStar - 1  >= 0
    correctPoints = correctPoints + 1;
    disp(i)
  endif
  
  if y(i) == -1 && (vStar'*X(i)) - gammaStar + 1  <= 0
    correctPoints = correctPoints + 1;
    disp(i)
  endif
  
end

correctPoints

kFold10 = 0.9;

randn("seed",44)
rand("seed",44)

index = randperm(n);

##for i = 1:10
##  if i == 1
##    xTrain = X(index((i)*round((1-kFold10)*400)+1:400),:);
##    yTrain = y(index((i)*round((1-kFold10)*400)+1:400),:);
##    xTest = X(index(1:round((1-kFold10)*400)),:);
##    yTest = y(index(1:round((1-kFold10)*400)),:);
##  elseif i == 10
##    xTrain = X(index(1:round(kFold10*400)),:);
##    yTrain = y(index(1:round(kFold10*400)),:);
##    xTest = X(index(round(kFold10*400)+1:400),:);
##    yTest = y(index(round(kFold10*400)+1:400),:);
##  else
##    xTrain = X(index(1:(i-1)*round((1-kFold10)*400)),:);
##    yTrain = y(index(1:(i-1)*round((1-kFold10)*400)),:);
##    xTrain = [xTrain; X(index((i+1)*round((1-kFold10)*400)+1:400),:)];
##    yTrain = [yTrain; y(index((i+1)*round((1-kFold10)*400)+1:400),:)];
##    xTest = X(i*round((1-kFold10)*400)+1:(i+1)*round((1-kFold10)*400),:);
##    yTest = y(i*round((1-kFold10)*400)+1:(i+1)*round((1-kFold10)*400),:);
##  endif
##  %pause()
##end
