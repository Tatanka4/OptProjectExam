function [sensitivity] = calculateSpecificity(B, v, gamma)
  
  correctPoints = 0;
  
  for i = 1:size(B)(1)
  
    if (v'*B(i,:)') - gamma + 1  <= 0
      correctPoints = correctPoints + 1;
    endif
  
  end

  sensitivity = correctPoints/size(B)(1);
  
endfunction