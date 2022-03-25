function libraryBlockCount = getLibraryBlockCount(fileName)
% Helps to find number of SubSystems and LibraryBlocks in the model.
%
% Syntax:
%   >>libraryBlockCount = getLibraryBlockCount(<ModelName>)
% libraryBlockCount - Number of libraray blocks
%
% Example:
%   >>libraryBlockCount = getLibraryBlockCount('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all blocks and filter only susbsystems
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'BlockType','SubSystem');
libraryBlockCount = 0;
% Counting the LibraryBlocks, exclude blocks from Simulink Library Browser.
for listIndex = 1:length(blocksList)
    block = blocksList{listIndex};
    linkStatus = get_param(block,'linkStatus');
    if ~(strcmp(linkStatus,'none'))
        blockReferencePath = get_param(block,'ReferenceBlock');
        if ~isSimulinkReferenceBlock(blockReferencePath) || ~isStateFlowReferenceBlock(blockReferencePath)
            libraryBlockCount = libraryBlockCount + 1;
        end
    end
end

end
%--------------------------------------------------------------------------
function bool = isSimulinkReferenceBlock(blockReferencePath)
bool = false;
splitedPath = split(blockReferencePath,'/');

for index = 1:length(splitedPath)
    path = splitedPath{index};
    if strcmp(path,'simulink')
        bool = true;
    end
end

end
%--------------------------------------------------------------------------
function bool = isStateFlowReferenceBlock(blockReferencePath)
bool = false;
splitedPath = split(blockReferencePath,'/');

for index = 1:length(splitedPath)
    path = splitedPath{index};
    if strcmp(path,'sflib')
        bool = true;
    end
end

end
