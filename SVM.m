function [vStar, gammaStar] = SVM(X, y, C)

#clear;

#load dataset8.mat;

x0 = []; %Starting point

[numPoints, numCol] = size(X);
numVar = numCol + 1 + numPoints; %n + 1 + m + k

A_in = zeros(numPoints, numVar); %Constraint matrix

A = [];

setA = []; %Array for the set A points
setB = []; %Array for the set B points

numPosPoints = 0; %m
numNegPoints = 0; %k

for i = 1: numPoints
  
  if y(i) == +1 %When the class label is +1
    numPosPoints = numPosPoints + 1; %m++
    setA = [setA; 
            X(i,:)]; %append to the set A the point
  else %When the class label is +1
    numNegPoints = numNegPoints + 1; %k++
    setB = [setB; 
            X(i,:)]; %append to the set B the point
  end
  
  %Filling the constraint matrix
  
  A_in(i,1:numCol) = y(i) * X(i,:); %v
  A_in(i,numCol+1) = -y(i); %gamma
  A_in(i,numCol+1+i) = 1; %phi
  
  cType(i) = "L"; 
  
end

%Right side of the constraint matrix
A_ub = [];
A_lb = ones(numPoints, 1);

b=[];

%Upper bounds
ub = [];

%Lower bounds
lb = zeros(numVar, 1);
lb(1:numCol + 1) = -inf;
#C = 1;
%Objective function

q = [zeros(numCol + 1,1); C * ones(numPoints,1)];

H = eye(numVar);
##H = [ones(rows(H), 1), H];
##H = [H; zeros(1, numVar)];

[xStar, fStar] = qp (x0, H, q, A, b, lb, ub, A_lb, A_in, A_ub);

vStar = xStar(1:numCol);
gammaStar = xStar(numCol+1);

drawPicture(setA, setB, vStar, gammaStar, X);

endfunction