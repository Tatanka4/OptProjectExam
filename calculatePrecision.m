function [precision] = calculatePrecision(A, B, v, gamma)
  
  correctPointsA = 0;
  
  for i = 1:size(A)(1)
  
    if (v'*A(i,:)') - gamma - 1  >= 0
      correctPointsA = correctPointsA + 1;
    endif
  
  end

  missclassifiedPointsB = 0;
  
  for i = 1:size(B)(1)
  
    if (v'*B(i,:)') - gamma + 1  > 0
      missclassifiedPointsB = missclassifiedPointsB + 1;
    endif
  
  end

  precision = correctPointsA / (correctPointsA + missclassifiedPointsB)
  
endfunction