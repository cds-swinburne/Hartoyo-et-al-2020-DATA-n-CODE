function ShowFigure(fparam, figtype)
%
%   ShowFigure(fparam, figtype)
%
%   plot figure figtype
%   using data in fparam
%

if nargin < 1
    error('Missing figure parameter structure');
end
if (nargin < 2)||isempty(figtype)
    figtype = '1';
end

switch(figtype)
    case 1
        ShowDifferentDegreeOfAlphaBlocking(fparam);
    case 2
        ShowReguralizedVSUnegularizedBestFits(fparam);
    case 3
        HowToShowFig3
    case 4
        ShowParameterRegularizedResponses(fparam);
    case 5
        ShowAlphaRhythmSensitivityToParameters(fparam);
    case 'A'
        ShowDegreeOfAlphaBlockingAcross82Subjects(fparam);
    case 'B'
        ShowParameterUnregularizedResponses(fparam);
    case 'C'
        ShowParameterManhattanDistancesAcrossSubjects(fparam);
    case 'D'
        ShowRegularizedFittingErrorCurve(fparam);
end






