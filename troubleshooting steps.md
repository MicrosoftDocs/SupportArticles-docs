# Unable to publish Copilot Survey Bot due to an error with the Conversation Start Topic
This article provides a solution to an issue where publishing of the Copilot Survey bot fails and the error points to the Conversation Start topic. 

## Symptoms 
As an admin, you notice that there is an error when publishing the Copilot Survey bot. The error says "Cannot refernce variable from compoennet 'msdyn_dataverse_mcs_survey_connectionreference'

## Cause
This issue is caused by the connection reference not correctly configured 

## Resolution
To resolve this error, you need to manually recreate the errored step.
1. Remove the errored step, then create a new step. The connector name is "Perform an unbound action in selected environment”
2. After the step UI shows up,  fill it with the below:
   1. Environment: (Current)
   2. ActionName: msdyn_SaveMicrosoftCopilotStudioSurveyResponse
   3. InputParams: The variable: JsonPayload
3. Save and publish the bot
