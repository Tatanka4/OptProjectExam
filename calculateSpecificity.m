function [specificity] = calculateSpecificity(B, v, gamma)
  
  correctPoints = 0;
  specificity = 0;
  if (B > 0)
    for i = 1:size(B)(1)
    
      if (v'*B(i,:)') - gamma + 1  <= 0
        correctPoints = correctPoints + 1;
      endif
    
    endfor

    specificity = correctPoints/size(B)(1);
  endif
  
endfunction