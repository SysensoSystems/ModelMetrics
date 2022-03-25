function portBlocksCount = getPortBlocksCount(fileName)
% Helps to find number of PortBlocks in the model
%
% Syntax:
%    >>portBlocksCount = getPortBlocksCount(<ModelName>)
% portBlocksCount = Number of PortBlocks in the model
%
% Example:
%    >>portBlocksCount = getPortBlocksCount('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all Blocks
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'type','block');
portBlocksCount = 0;
portTypes = {'Inport','Outport','EnablePort','TriggerPort','ActionPort'};

% Calculating PortBlocks
for listIndex = 1:length(blocksList)
    block = blocksList(listIndex);
    blockType = get_param(block,'blockType');
    for index = 1:length(portTypes)
        portType = portTypes(index);
        if strcmp(blockType,portType)
            portBlocksCount = portBlocksCount+1;
        end
    end
end

end