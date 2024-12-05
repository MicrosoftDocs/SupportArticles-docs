---
title: Error in Conversation Start topic prevents publishing of survey agent
description: Solves an error that occurs when you try to publish a survey agent in Microsoft Dynamics 365 Customer Service. 
ms.reviewer: nenellim
ms.author: srubinstein
ms.date: 12/05/2024
ms.custom: sap:Copilot Studio\End conversation
---

# Error in Conversation Start topic prevents publishing of survey agent

This article provides a solution to an issue that occurs when you try to publish the Copilot Studio survey agent. The publishing fails and the error points to the Conversation Start topic.

## Symptoms

As an admin, when you try to publish the Copilot Studio survey agent, the following error appears:

> "Cannot reference variable from component 'msdyn_dataverse_mcs_survey_connectionreference'"

:::image type="content" source="media/cant-reference-variable-publish-survey-agent/cant-reference-variable-from-component-error.png" alt-text="Screenshot that shows the error that you receive when you publish the Copilot Studio survey agent." lightbox="media/cant-reference-variable-publish-survey-agent/cant-reference-variable-from-component-error.png":::

## Cause

This issue is caused by an incorrectly configured connection reference.

## Resolution

To resolve this error, you need to manually recreate the step that has the error.

1. Remove the errored step, and then recreate it by selecting the connector with the following name:
   "`Perform an unbound action in selected environment`"

   :::image type="content" source="media/cant-reference-variable-publish-survey-agent/create-new-step-with-connector.png" alt-text="Screenshot that shows how to create a new step by using the Perform an unbound action in selected environment connector." lightbox="media/cant-reference-variable-publish-survey-agent/create-new-step-with-connector.png":::

2. Add the following details:

   - **Environment**: (Current)
   - **Action Name**: msdyn_SaveMicrosoftCopilotStudioSurveyResponse
   - **InputParams**: The variable: JsonPayload

   :::image type="content" source="media/cant-reference-variable-publish-survey-agent/connector-action-fields.png" alt-text="Screenshot that shows that fields that must be filled for the Connector action.":::

3. Save and publish the survey agent.

### Related information

[Configure feedback surveys using Copilot Studio](/dynamics365/contact-center/administer/configure-surveys)