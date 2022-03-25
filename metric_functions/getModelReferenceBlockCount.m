function modelReferenceBlockCount = getModelReferenceBlockCount(fileName)
% Helps to find number of ModelReferenced blocks in the model.
%
% Syntax:
%    >>modelReferenceBlockCount = getModelReferenceBlockCount(<ModelName>)
% modelReferenceBlockCount - Number of ModelReferenced Block
%
% Example:
%    >>modelReferenceBlockCount = getModelReferenceBlockCount('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all blocks
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'type','block');
modelReferenceBlockCount = 0;

% Calculating Modelreferenced Blocks
for listIndex = 1:length(blocksList)
    block = blocksList(listIndex);
    blockType = get_param(block,'blockType');
    if strcmp(blockType,'ModelReference')
        modelReferenceBlockCount = modelReferenceBlockCount+1;
    end
end

end