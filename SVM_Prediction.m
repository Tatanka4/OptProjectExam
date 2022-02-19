function [performanceIndicators] = SVM_Prediction(X, y, draw, vStar, gammaStar)

[numPoints, numCol] = size(X);
numVar = numCol + 1 + numPoints; %n + 1 + m + k

setA = []; %Array for the set A points
setB = []; %Array for the set B points

for i = 1: numPoints
  
  if y(i) == +1 %When the class label is +1
    setA = [setA; 
            X(i,:)]; %append to the set A the point
  else %When the class label is +1
    setB = [setB; 
            X(i,:)]; %append to the set B the point
  end
  
end

if draw == 1
  drawPicture(setA, setB, vStar, gammaStar, X);
endif

disp("TEST SET PERFORMANCE INDICATOR");
sensitivity = calculateSensitivity(setA, vStar, gammaStar)
specificity = calculateSpecificity(setB, vStar, gammaStar)
accuracy = calculateCorrectness(X,y,vStar,gammaStar)
precision = calculatePrecision(setA,setB,vStar,gammaStar)
fScore = 2 * (sensitivity * precision) / (sensitivity + precision)

performanceIndicators = [sensitivity, specificity, accuracy, precision, fScore];

endfunction