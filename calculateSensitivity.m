function [sensitivity] = calculateSensitivity(A, v, gamma)
  
  correctPoints = 0;
  
  for i = 1:size(A)(1)
  
    if (v'*A(i,:)') - gamma - 1  >= 0
      correctPoints = correctPoints + 1;
    endif
  
  end

  sensitivity = correctPoints/size(A)(1);
  
endfunction