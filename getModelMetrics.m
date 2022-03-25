function modelMetrics = getModelMetrics(fileName)
% Helps to find the size metrics of the given Model.
%
% Syntax:
%    >>modelMetrics = getModelMetrics(<'ModelName'>)
% modelMetrics - structure contains following details.
% modelMetrics.totalBlocksCount - number of blocks in the model
% modelMetrics.subsystemCount - number of Subsystems in the model
% modelMetrics.libraryBlockCount - number of libarary blocks in the model
% modelMetrics.userDefinedBlockCount - number of User-Defined Libaray blocks in the model
% modelMetrics.modelReferenceBlockCount - number of ModelReferenced blocks in the model
% modelMetrics.portBlocksCount - number of PortBlocks in the model
% modelMetrics.stateFlowBlockCount - number of StateFlow blocks in the model
% modelMetrics.modelHierarchicalDepth - the HierarchicalDepth of the model
% modelMetrics.totalEffectiveLines - number of EffectiveLines in the model
% modelMetrics.modelParameters - list the model parameters from base, model and masked workspace
%
% Example:
%   >>modelMetrics = getModelMetrics('sldemo_autotrans')
%
% Developed by: Sysenso Systems, https://sysenso.com/
% Contact: contactus@sysenso.com
%
% Version:
% 1.0 - Initial Version.

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% To get list of blocks in model
blocksList = find_system(modelName,'LookUnderMasks','all',...
    'FollowLinks','on','Variants','AllVariants',...
    'type','block');

% Call the utility functions to collect the model metrices info.
subsystemCount = getSubsystemCount(fileName);
libraryBlockCount = getLibraryBlockCount(fileName);
userDefinedBlockCount = getUserDefinedBlockCount(fileName);
modelReferenceBlockCount = getModelReferenceBlockCount(fileName);
stateFlowBlockCount = getStateFlowBlockCount(fileName);
portBlocksCount = getPortBlocksCount(fileName);
modelHierarchicalDepth = getModelHierarchicalDepth(fileName);
totalEffectiveLines = getTotalEffectiveLines(fileName);
modelParameters = getModelParameterCount(fileName);
totalBlocksCount = length(blocksList) - (subsystemCount+libraryBlockCount+...
    userDefinedBlockCount+modelReferenceBlockCount+...
    stateFlowBlockCount+portBlocksCount);

% Return the model information in a structure format
modelMetrics.totalBlocksCount = totalBlocksCount;
modelMetrics.subsystemCount = subsystemCount;
modelMetrics.libraryBlockCount = libraryBlockCount;
modelMetrics.userDefinedBlockCount = userDefinedBlockCount;
modelMetrics.modelReferenceBlockCount = modelReferenceBlockCount;
modelMetrics.portBlocksCount = portBlocksCount;
modelMetrics.stateFlowBlockCount = stateFlowBlockCount;
modelMetrics.modelHierarchicalDepth = modelHierarchicalDepth;
modelMetrics.totalEffectiveLines = totalEffectiveLines;
modelMetrics.modelParameters = modelParameters;

end
