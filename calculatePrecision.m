function [precision] = calculatePrecision(A, B, v, gamma)
  
  correctPointsA = 0;
  if A > 0
    for i = 1:size(A)(1)
  
      if (v'*A(i,:)') - gamma   >= 0
        correctPointsA = correctPointsA + 1;
      endif
  
    endfor
  endif

  missclassifiedPointsB = 0;
  
  if B > 0
    for i = 1:size(B)(1)
  
      if (v'*B(i,:)') - gamma   > 0
        missclassifiedPointsB = missclassifiedPointsB + 1;
      endif
  
    endfor
  endif

  precision = correctPointsA / (correctPointsA + missclassifiedPointsB);
  
endfunction