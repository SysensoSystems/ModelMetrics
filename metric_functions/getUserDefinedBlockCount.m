function userDefinedBlockCount = getUserDefinedBlockCount(fileName)
% Helps to find number of User-Defined Libaray Blocks in the model.
%
% Syntax:
%    >>userDefinedBlockCount = getUserDefinedBlockCount(<ModelName>)
% userDefinedBlockCount = Number of User-Defined Libaray Blocks in the
% model
%
% Example:
%    >>portBlocksCount = getPortBlocksCount('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all blocks
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'type','block');
userDefinedBlockCount = 0;
userDefinedBlockTypes = {'CCaller','Fcn','FunctionCaller','MATLABFcn',...
    'M-S-Function','MATLABSystem','S-Function'};
exceptionalFunctionName = 'MATLAB Function';

% Calculating User-Defined Blocks
for listIndex = 1:length(blocksList)
    block = blocksList(listIndex);
    blockType = get_param(block,'blockType');
    for index = 1:length(userDefinedBlockTypes)
        existingType = userDefinedBlockTypes{index};
        try
            SFblockType = get_param(block,'SFblockType');
        catch
            SFblockType = nan;
        end
        if strcmp(blockType,existingType) || strcmp(SFblockType,exceptionalFunctionName)
            userDefinedBlockCount = userDefinedBlockCount+1;
        end
    end
end

end