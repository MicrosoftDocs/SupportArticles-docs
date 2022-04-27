---
title: AI Builder actions are disabled/deactivated
description: Cause and resolution for an error that AI Builder actions are disabled/deactivated.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# AI Builder actions are disabled/deactivated

This article provides steps to activate AI Builder actions.

_Applies to:_ &nbsp; Power Automate and Power Apps

## Symptoms

AI Builder actions are disabled/deactivated.

## Cause

AI Builder can't be used if its actions have been deactivated.

## Resolution

To activate the actions, the administrator of the environment needs to perform the following steps.

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments).

1. Select the environment where the actions are deactivated.

1. Select **Settings** > **Resources** > **All legacy settings**.

1. From the **Settings** menu, select **Processes**.

1. Select to display **All Processes** and activate the following AI Builder processes.

    - IsPaiEnabled
    - Predict
    - PredictionSchema
    - Train
    - QuickTest
    - BatchPrediction
    - ScheduleTraining
    - SchedulePrediction
    - ScheduleRetrain
    - UnschedulePrediction
    - UnscheduleTraining
    - CancelTraining
    - PublishAIConfiguration
    - UnpublishAIConfiguration

## Resources

[Administer AI Builder](/ai-builder/administer)
