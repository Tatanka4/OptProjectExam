function [vStar, gammaStar] = SVM(X, y, C)

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
A_ub = ones(numPoints, 1);
A_lb = [];

b=[];

%Upper bounds
ub = [];

%Lower bounds
lb = zeros(numVar, 1);
lb(1:numCol + 1) = -inf;

%Objective function
q = C * ones(numVar,1);

H = eye(403);
H = [ones(rows(H), 1), H];
H = [H; zeros(1, 404)];

[vStar, gammaStar] = qp (x0, H, q, A, b, lb, ub, A_lb, A_in, A_ub);
endfunction