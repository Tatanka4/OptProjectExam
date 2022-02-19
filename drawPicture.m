function drawPicture(setA, setB, v, gamma, dataset)

xxMin = min(dataset(:,1));
xxMax = max(dataset(:,1));

yyMin = min(dataset(:,2));
yyMax = max(dataset(:,2));

zzMin = min(dataset(:,3));
zzMax = max(dataset(:,3));

clf;
if setA > 0
  scatter3(setA(:,1), setA(:,2), setA(:,3), 'b','o','filled');
endif

hold on;

if setB > 0
  scatter3(setB(:,1), setB(:,2), setB(:,3), 'r','o','filled');
endif

[X,Y] = meshgrid(xxMin:0.1:xxMax, yyMin:0.5:yyMax);
Z = (gamma - v(1)*X - v(2)*Y) / v(3);
surf(X,Y,Z);

hold on;
Z = (gamma + 1 - v(1)*X - v(2)*Y) / v(3);
surf(X,Y,Z);

hold on;
Z = (gamma - 1 - v(1)*X - v(2)*Y) / v(3);
surf(X,Y,Z);


  
endfunction