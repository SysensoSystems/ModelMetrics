function totalEffectiveLines = getTotalEffectiveLines(fileName)
% Helps to find number of EffectiveLines in the model
%
% Syntax:
%    >>totalEffectiveLines = getTotalEffectiveLines(<ModelName>)
% totalEffectiveLines = Number of Lines in the model
% - From and Goto lines are excluded
%
%
% Example:
%    >>totalEffectiveLines = getTotalEffectiveLines('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all Lines
lineHandles = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'findall','on','type','line');
totalEffectiveLines = 0;
% Calculating Effective lines (excluding From and Goto lines)
for index = 1:length(lineHandles)
    handle = lineHandles(index);
    dstBlockHandle = get_param(handle,'DstBlockHandle');
    blockType = get_param(dstBlockHandle,'BlockType');
    if length(dstBlockHandle) > 1
        % To filter branched line.
    elseif strcmp(blockType,'Goto')
        % To avoid duplicated count for From-Goto pair.
    else
        totalEffectiveLines = totalEffectiveLines+1;
    end
end

end