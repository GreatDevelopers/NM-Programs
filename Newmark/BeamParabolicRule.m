clc
clear

Span = 6;
% LoadIntensity = [0 -5 -10 -15 -20 -25 -30]';
%LoadIntensity = [0 -5 -10 -15 -20 -25 -30]';

NP = 6 ; % No of panels

LoadInt1 = 0;
LoadInt2 = -30;

LoadIntensity = LoadInt1 : (LoadInt2 - LoadInt1) / NP : LoadInt2 ;

LoadIntensity = LoadIntensity';
%"jello"
LoadIntensity %

% Show in a row to save space

NumberOfNodes = rows(LoadIntensity);
NumberOfPanels = NumberOfNodes - 1 ;
PanelLenght = Span / NumberOfPanels ;
xPanelPoints = 0 : PanelLenght : Span ;

EI = ones(NumberOfNodes,1);

TrialPanelShear(1) = 0. ; % 100. /6.
TrialMoment(1) = 0. ;

TrialPanelSlope(1) = 0. ; % 100. / 6.
TrialDeflection(1) = 0. ;

% Boundary Condition
DeflectionAtSupport(1) = 0;
DeflectionAtSupport(2) = 0;

% Boundary Condition
MomentAtSupport(1) = 0;
MomentAtSupport(2) = 0;

%Kernel = (1./6) * [1 4 1]';
Kernel = (1./24) * [2 20 2]';

LoadEquivalent = conv(LoadIntensity, Kernel, "same");
LoadEquivalent(1) = LoadIntensity(1) * 7. + LoadIntensity(2) * 6. ...
  -  LoadIntensity(3) ;
LoadEquivalent(NumberOfNodes) = LoadIntensity(NumberOfNodes) * 7. + ...
  LoadIntensity(NumberOfNodes - 1) * 6. -  LoadIntensity(NumberOfNodes - 2) ;

LoadEquivalent(NumberOfNodes) = LoadEquivalent(NumberOfNodes) /24. ;
LoadEquivalent(1) = LoadEquivalent(1) /24. ;

LoadEquivalent = PanelLenght * LoadEquivalent ;
 
 LoadEquivalent

for i=2 : NumberOfPanels
  TrialPanelShear(i) = TrialPanelShear(i-1) + LoadEquivalent(i);
end

TrialPanelShear = TrialPanelShear';

for i = 2 : NumberOfNodes
  TrialMoment(i) = TrialMoment(i-1) + TrialPanelShear(i-1) * PanelLenght;
end

TrialMoment = TrialMoment';

CorrectionAtSupport(1) = MomentAtSupport(1) - TrialMoment(1);
CorrectionAtSupport(2) = MomentAtSupport(2) - TrialMoment(NumberOfNodes);

CorrectionInMoment = CorrectionAtSupport(1) : ...
  ( CorrectionAtSupport(2) - CorrectionAtSupport(1) ) / NumberOfPanels ...
  : CorrectionAtSupport(2);
  
CorrectionInMoment = CorrectionInMoment';
  
CorrectedMoment = TrialMoment + CorrectionInMoment ;

for i = 1 : NumberOfPanels
  CorrectedShear(i) = CorrectedMoment(i+1) - CorrectedMoment(i) ;
end

CorrectedShear = CorrectedShear';

CorrectedShear = CorrectedShear / PanelLenght ;

TrialPanelShear
TrialMoment
CorrectionInMoment
CorrectedMoment
CorrectedShear


% 2nd part

%EI CorrectedMoment

EI

CurvatureIntensity = CorrectedMoment ./ EI;

CurvatureIntensity

CurvatureEquivalent = conv(CurvatureIntensity, Kernel, "same");
CurvatureEquivalent(1) = CurvatureIntensity(1) * 7. + ...
  CurvatureIntensity(2) * 6. -  CurvatureIntensity(3) ;
CurvatureEquivalent(NumberOfNodes) = CurvatureIntensity(NumberOfNodes) * 7. ...
  + CurvatureIntensity(NumberOfNodes - 1) * 6. - ...
  CurvatureIntensity(NumberOfNodes - 2) ;

CurvatureEquivalent(NumberOfNodes) = CurvatureEquivalent(NumberOfNodes) /24. ;
CurvatureEquivalent(1) = CurvatureEquivalent(1) /24. ;

CurvatureEquivalent = PanelLenght * CurvatureEquivalent ;
 
 CurvatureEquivalent

for i=2 : NumberOfPanels
  TrialPanelSlope(i) = TrialPanelSlope(i-1) + CurvatureEquivalent(i);
end

TrialPanelSlope = TrialPanelSlope';

for i = 2 : NumberOfNodes
 TrialDeflection(i) = TrialDeflection(i-1) + TrialPanelSlope(i-1) * PanelLenght;
end
TrialDeflection = TrialDeflection';

CorrectionAtSupport(1) = DeflectionAtSupport(1) - TrialDeflection(1);
CorrectionAtSupport(2) = DeflectionAtSupport(2)-TrialDeflection(NumberOfNodes);

CorrectionInDeflection = CorrectionAtSupport(1) : ...
  ( CorrectionAtSupport(2) - CorrectionAtSupport(1) ) / NumberOfPanels ...
  : CorrectionAtSupport(2);

CorrectionInDeflection = CorrectionInDeflection';
  
CorrectedDeflection = TrialDeflection + CorrectionInDeflection ;

for i = 1 : NumberOfPanels
  CorrectedSlope(i) = CorrectedDeflection(i+1) - CorrectedDeflection(i) ;
end
CorrectedSlope = CorrectedSlope';
CorrectedSlope = CorrectedSlope / PanelLenght ;

TrialPanelSlope
TrialDeflection
CorrectionInDeflection
CorrectedDeflection
CorrectedSlope

%% Plot 

xMidPanel = xPanelPoints(1:NumberOfPanels) + (PanelLenght /2.0);

plot_x(1) = 0;
plot_y(1) = 0;

for indexI = 1 : NumberOfPanels
  plot_x = [plot_x (xMidPanel(indexI) - PanelLenght / 2.0 )];
  plot_y = [ plot_y CorrectedShear(indexI) ];
  plot_x = [plot_x (xMidPanel(indexI) + PanelLenght / 2.0 )];
  plot_y = [ plot_y CorrectedShear(indexI) ];
end

plot_x = [plot_x Span 0];
plot_y = [ plot_y 0 0];


plotHandle1 = figure('visible', 'off')
 %plot(xPanelPoints(1:NumberOfPanels) + (PanelLenght /2.0), CorrectedShear,'-bo')
 %plot(plot_x, plot_y,'-b')
fill(plot_x, plot_y,'r')

%stem(plot_x, plot_y,'-b',"markersize",0)

saveas(plotHandle1, 'ShearForce.png','png')

plotHandle2 = figure('visible', 'off')
plot(xPanelPoints, CorrectedMoment,'-bo')

%plot(xPanelPoints, CorrectedMoment,'-b')

saveas(plotHandle2, 'BendingMoment.png','png')

plotHandle4 = figure('visible', 'off')
plot(xPanelPoints, CorrectedDeflection,'-bo')
saveas(plotHandle4, 'Deflection.png','png')
