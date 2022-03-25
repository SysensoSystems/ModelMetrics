function modelParameters = getModelParameterCount(fileName)
% Helps to find the model parameters from base, model and masked workspace
% of the model.
%
% Syntax:
%    modelParameters = getModelParameterCount(<ModelName>)
% modelParameteres - structure form of Modelparameters with its Name and
% Sourcetype
%
% Example:
%    >>modelParameters = getModelParameterCount('sldemo_autotrans')

% To handle model file extension.
[filePath,modelName] = fileparts(fileName);
load_system(modelName);

% Get all parameters
modelParameters = struct('Name',[],'SourceType',[]);
modelVariables = Simulink.findVars(modelName);
existingSourceTypes = {'base workspace','model workspace','mask workspace'};

% Set all the parameters according to its Sourcetype
for index = 1:length(modelVariables)
    sourceType = modelVariables(index).SourceType;
    variableName = modelVariables(index).Name;
    for sourceIndex = 1:length(existingSourceTypes)
        if strcmp(sourceType,existingSourceTypes{sourceIndex})
            modelParameters(index).Name = variableName;
            modelParameters(index).SourceType = sourceType;
        end
    end
end

end