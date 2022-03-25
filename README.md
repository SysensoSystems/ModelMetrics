# Simulink Model Size Metrics
getModelMetrics - Helps to find the size metrics of the given Model.

Use cases: This metric can be used to compare two models for its complicity in-terms of size and used for time estimation to work on the model.

Usage Instructions:
Note: Add the utils and its sub folders into MATLAB path before calling the getModelMetrics function.

Syntax:
>>modelMetrics = getModelMetrics(<'ModelName'>)

modelMetrics - structure contains following details.

modelMetrics.totalBlocksCount - number of blocks in the model

modelMetrics.subsystemCount - number of Subsystems in the model

modelMetrics.libraryBlockCount - number of libarary blocks in the model

modelMetrics.userDefinedBlockCount - number of User-Defined Libaray blocks in the model

modelMetrics.modelReferenceBlockCount - number of ModelReferenced blocks in the model

modelMetrics.portBlocksCount - number of PortBlocks in the model

modelMetrics.stateFlowBlockCount - number of StateFlow blocks in the model

modelMetrics.modelHierarchicalDepth - the HierarchicalDepth of the model

modelMetrics.totalEffectiveLines - number of EffectiveLines in the model

modelMetrics.modelParameters - list the model parameters from base, model and masked workspace

Example:
>>modelMetrics = getModelMetrics('sldemo_autotrans')
