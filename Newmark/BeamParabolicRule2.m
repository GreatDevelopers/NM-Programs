clc
clear

Span = 4;
% LoadIntensity = [0 -5 -10 -15 -20 -25 -30]';
%LoadIntensity = [0 -5 -10 -15 -20 -25 -30]';

NP = 4 ; % No of panels

%LoadInt1 = 0;
%LoadInt2 = -30;

%LoadIntensity = LoadInt1 : (LoadInt2 - LoadInt1) / NP : LoadInt2 ;
LoadIntensity = [-10 -12 -9 -7 -8];

LoadIntensity = LoadIntensity';
LoadIntensity

NumberOfNodes = rows(LoadIntensity)
NumberOfPanels = NumberOfNodes - 1 
PanelLenght = Span / NumberOfPanels 

%EI = ones(NumberOfNodes,1);

EI = [2 1.75 1.5 1.25 1]';
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
 
 LoadEquivalent'

for i=2 : NumberOfPanels
  TrialPanelShear(i) = TrialPanelShear(i-1) + LoadEquivalent(i);
end

for i = 2 : NumberOfNodes
  TrialMoment(i) = TrialMoment(i-1) + TrialPanelShear(i-1) * PanelLenght;
end

CorrectionAtSupport(1) = MomentAtSupport(1) - TrialMoment(1);
CorrectionAtSupport(2) = MomentAtSupport(2) - TrialMoment(NumberOfNodes);

CorrectionInMoment = CorrectionAtSupport(1) : ...
  ( CorrectionAtSupport(2) - CorrectionAtSupport(1) ) / NumberOfPanels ...
  : CorrectionAtSupport(2);
  
CorrectedMoment = TrialMoment + CorrectionInMoment ;

for i = 1 : NumberOfPanels
  CorrectedShear(i) = CorrectedMoment(i+1) - CorrectedMoment(i) ;
end

CorrectedShear = CorrectedShear / PanelLenght ;

TrialPanelShear
TrialMoment
CorrectionInMoment
CorrectedMoment
CorrectedShear


% 2nd part

%EI CorrectedMoment

EI

CurvatureIntensity = - CorrectedMoment ./ EI';

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

for i = 2 : NumberOfNodes
 TrialDeflection(i) = TrialDeflection(i-1) + TrialPanelSlope(i-1) * PanelLenght;
end

CorrectionAtSupport(1) = DeflectionAtSupport(1) - TrialDeflection(1);
CorrectionAtSupport(2) = DeflectionAtSupport(2)-TrialDeflection(NumberOfNodes);

CorrectionInDeflection = CorrectionAtSupport(1) : ...
  ( CorrectionAtSupport(2) - CorrectionAtSupport(1) ) / NumberOfPanels ...
  : CorrectionAtSupport(2);
  
CorrectedDeflection = TrialDeflection + CorrectionInDeflection ;

for i = 1 : NumberOfPanels
  CorrectedSlope(i) = CorrectedDeflection(i+1) - CorrectedDeflection(i) ;
end

CorrectedSlope = CorrectedSlope / PanelLenght ;

TrialPanelSlope
TrialDeflection
CorrectionInDeflection
CorrectedDeflection
CorrectedSlope
