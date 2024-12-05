---
title: Can't publish Copilot Survey bot with error points to the Conversation Start topic
description: Solves an error that occurs when you try to publish a Copilot Survey bot in Microsoft Dynamics 365 Customer Service. 
ms.reviewer: nenellim
ms.author: srubinstein
ms.date: 12/05/2024
ms.custom: sap:Copilot Studio\End conversation
---
# Unable to publish Copilot Survey bot due to an error with the Conversation Start topic

This article provides a solution to an issue where publishing of the Copilot Survey bot fails and the error points to the Conversation Start topic.

## Symptoms

As an admin, you notice that there is an error when publishing the Copilot Survey bot. The error says "Cannot refernce variable from compoennet 'msdyn_dataverse_mcs_survey_connectionreference'

:::image type="content" source="media/cannot-refernce-variable-publish-copilot-survey-bot/cannot-refernce-variable-from-compoennet-error.png" alt-text="Screenshot that shows the error that you receive when you publish the Copilot Survey bot." lightbox="media/cannot-refernce-variable-publish-copilot-survey-bot/cannot-refernce-variable-from-compoennet-error.png":::

## Cause

This issue is caused by the connection reference not correctly configured.

## Resolution

To resolve this error, you need to manually recreate the errored step.

1. Remove the errored step, then create a new step. The connector name is "Perform an unbound action in selected environment".

   :::image type="content" source="media/cannot-refernce-variable-publish-copilot-survey-bot/create-new-step-with-connector.png" alt-text="Screenshot that shows how to create a new step by using the Perform an unbound action in selected environment connector." lightbox="media/cannot-refernce-variable-publish-copilot-survey-bot/create-new-step-with-connector.png":::

2. After the step UI shows up,  fill it with the below:

   1. Environment: (Current)
   2. Action Name: msdyn_SaveMicrosoftCopilotStudioSurveyResponse
   3. InputParams: The variable: JsonPayload

   :::image type="content" source="media/cannot-refernce-variable-publish-copilot-survey-bot/connector-action-fields.png" alt-text="Screenshot that shows that fields that must be filled for the Connector action.":::

3. Save and publish the bot.
