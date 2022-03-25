function subSystemCount = getSubsystemCount(fileName)
% Helps to find number of SubSystems in the model.
%
% Description:
% 1. Stateflow chart is considered as a subsyste,
%
% Syntax:
%   >>subSystemCount = getSubsystemCount(<ModelName>)
% subSystemCount - Number of SubSystems
%
% Example:
%   >>subSystemCount = getSubsystemCount('sldemo_autotrans')
%

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all blocks and filter only susbsystems
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'BlockType','SubSystem');
subSystemCount = 0;

% Counting the number of subsystems by fitering non-susbsystems.
for listIndex = 1:length(blocksList)
    block = blocksList{listIndex};
    linkStatus = get_param(block,'linkStatus');
    maskStatus = get_param(block,'mask');
    maskType = get_param(block,'masktype');
    blockReferencePath = get_param(block,'ReferenceBlock');
    
    if ~strcmp(linkStatus,'none') && isSimulinkLibraryBlock(blockReferencePath)
    elseif strcmp(maskStatus,'on') && isSimulinkMaskType(maskType)
    elseif isStateFlowObjectByType(block)
    elseif isEmptySubSystem(block)
    else
        subSystemCount = subSystemCount + 1;
    end
end

end

%--------------------------------------------------------------------------
function bool = isSimulinkMaskType(maskType)
bool = false;
% TODO: Have to filter simulink mask subsystems with empty mask type.
existingMaskTypes = {'Sigbuilder block'};

for index = 1:length(existingMaskTypes)
    existingMasktype = existingMaskTypes{index};
    if strcmp(maskType,existingMasktype)
        bool = true;
    end
end

end
%--------------------------------------------------------------------------
function bool = isSimulinkLibraryBlock(blockReferencePath)
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
function bool = isStateFlowObjectByType(subSystem)
bool = false;
% TODO: Add any Stateflow mask types.
existingSFBlockTypes = {'Chart','State Transition Table','Truth Table','MATLAB Function'};

try
    SFBlockType = get_param(subSystem,'SFBlockType');
catch
    SFBlockType = '';
end

for listIndex = 1:length(existingSFBlockTypes)
    existingSFBlockType = existingSFBlockTypes(listIndex);
    if strcmp(SFBlockType,existingSFBlockType)
        bool = true;
    end
end

end
%--------------------------------------------------------------------------
function bool = isEmptySubSystem(subSystem)
% To filter empty susbsystems. Some simulink blocks like "More Info" are
% empty subsystem.

bool = false;
childBlocks = find_system(subSystem,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'Type','block');
if length(childBlocks) == 1
    bool = true;
end


end