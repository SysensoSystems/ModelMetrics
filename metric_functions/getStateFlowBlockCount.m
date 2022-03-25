function stateFlowBlockCount = getStateFlowBlockCount(fileName)
% Helps to find number of StateFlow blocks in the model
%
% Syntax:
%    >>stateFlowBlockCount = getStateFlowBlockCount(<ModelName>)
% stateFlowBlockCount = Number of StateFlow Objects in the model
%
% Example:
%    >>stateFlowBlockCount = getStateFlowBlockCount('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all blocks and Filtering Subsystems
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'type','block');
stateFlowBlockCount = 0;
existingSFBlockTypes = {'Chart','State Transition Table','Truth Table'};

% Calculating StateFlow objects
for listIndex = 1:length(blocksList)
    block = blocksList(listIndex);
    try
        SFBlockType = get_param(block,'SFBlockType');
    catch
        SFBlockType = '';
    end
    for Index = 1:length(existingSFBlockTypes)
        existingSFBlockType = existingSFBlockTypes(Index);
        if strcmp(SFBlockType,existingSFBlockType)
            stateFlowBlockCount = stateFlowBlockCount+1;
        end
    end
end

end