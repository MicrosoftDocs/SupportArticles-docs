---
title: Error in Conversation Start topic prevents publishing of survey agent
description: Solves an error that occurs when you try to publish a survey agent in Microsoft Dynamics 365 Customer Service. 
ms.reviewer: nenellim
ms.author: srubinstein
ms.date: 12/09/2024
ms.custom: sap:Copilot Studio\End conversation
---
# "Cannot reference variable" error when publishing a Copilot Studio survey agent

This article provides a solution to an issue that occurs when you try to publish a Microsoft Copilot Studio survey agent. The publishing fails and the error points to the [Conversation Start](/microsoft-copilot-studio/authoring-system-topics?tabs=webApp#conversation-start) topic.

## Symptoms

As an administrator, when you try to publish a Copilot Studio survey agent, the following error appears:

> Cannot reference variable from component 'msdyn_dataverse_mcs_survey_connectionreference'

:::image type="content" source="media/cant-reference-variable-publish-survey-agent/cant-reference-variable-from-component-error.png" alt-text="Screenshot that shows the error that you receive when you publish the Copilot Studio survey agent." lightbox="media/cant-reference-variable-publish-survey-agent/cant-reference-variable-from-component-error.png":::

## Cause

This issue is caused by an incorrectly configured connection reference.

## Resolution

To resolve this error, follow these steps to manually recreate the step with the error:

1. Remove the erroneous step, and then recreate it using the **Perform an unbound action in selected environment** connector.

   :::image type="content" source="media/cant-reference-variable-publish-survey-agent/create-new-step-with-connector.png" alt-text="Screenshot that shows how to create a new step by using the Perform an unbound action in selected environment connector." lightbox="media/cant-reference-variable-publish-survey-agent/create-new-step-with-connector.png":::

2. Add the following details:

   - **Environment**: (Current)
   - **Action Name**: msdyn_SaveMicrosoftCopilotStudioSurveyResponse
   - **InputParams**: The variable JsonPayload

   :::image type="content" source="media/cant-reference-variable-publish-survey-agent/connector-action-fields.png" alt-text="Screenshot that shows fields that must be filled for the Connector action.":::

3. Save and publish the survey agent.

### More information

[Configure feedback surveys using Copilot Studio (preview)](/dynamics365/contact-center/administer/configure-surveys)
