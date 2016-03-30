clc
clear

Span = 6;
% LoadIntensity = [0 -5 -10 -15 -20 -25 -30]';
LoadIntensity = [0 -5 -10 -15 -20 -25 -30]';
TrialPanelShear(1) = 100. / 6. ;
TrialMoment(1) = 0. ;

% Boundary Condition
MomentAtSupport(1) = 0;
MomentAtSupport(2) = 0;

% Kernel = (1./6) * [1 4 1]';
Kernel = (1./24) * [2 20 2]';

NumberOfNodes = rows(LoadIntensity);
NumberOfPanels = NumberOfNodes - 1 ;
PanelLenght = Span / NumberOfPanels ;

LoadEquivalent = conv(LoadIntensity, Kernel, "same");
LoadEquivalent(1) = LoadIntensity(1) / 3. + LoadIntensity(2) / 6. ;
LoadEquivalent(NumberOfNodes) = LoadIntensity(NumberOfNodes) / 3. ...
  + LoadIntensity(NumberOfNodes - 1) / 6. ;

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

TrialPanelShear
TrialMoment
CorrectionInMoment
CorrectedMoment
CorrectedShear
