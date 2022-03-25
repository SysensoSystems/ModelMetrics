function modelHierarchicalDepth = getModelHierarchicalDepth(fileName)
% Helps to find the HierarchicalDepth of the model.
%
% Syntax:
%   >>modelHierarchicalDepth = getModelHierarchicalDepth(<ModelName>)
% modelHierarchicalDepth - Numerical representation of how deep the
% model is.
%
% Example:
%    >>modelHierarchicalDepth = getModelHierarchicalDepth('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all blocks
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'type','block');
modelHierarchicalDepth = 0;

% Calculating HierarchicalDepth
for listIndex = 1:length(blocksList)
    block = blocksList{listIndex};
    noOfBackSlash = length(regexp(block,'\w/\w')) - 1;
    if noOfBackSlash > modelHierarchicalDepth
        modelHierarchicalDepth = noOfBackSlash;
    end
end

end
