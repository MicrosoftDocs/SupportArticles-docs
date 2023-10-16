---
title: AI Builder processes and plug-in steps are turned off in default solution
description: Provides a resolution for the issue that AI Builder processes and plug-in steps are turned off in default solution.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# AI Builder processes and plug-in steps are turned off in default solution

This article provides steps to turn on AI Builder processes and plug-in steps in default solution.

_Applies to:_ &nbsp; AI Builder home page

## Symptoms

You're not able to use AI Builder processes and plug-ins.

## Cause

AI Builder can't be used if its plug-in steps and processes have been turned off.

## Resolution

1. Sign in to [Power Apps](https://make.preview.powerapps.com/).
1. On the top-right corner, select the environment.
1. In the left pane, select **Solutions**.
1. Select **Default Solution** > **Edit**.
1. On the left list, select **Plug-in steps** and ensure all listed steps are turned on.

    - PreValidate: AlmHandler. (required for import/export).
    - PreValidate: isPaiEnabled.
    - ValidateAIConfiguration
    - PostOperation: CancelTraining
    - PostOperation: PublishAIConfiguration
    - PostOperation: PublishAIConfiguration Async
    - PostOperation: ScheduleRetrain
    - PostOperation: ScheduleTraining
    - PostOperation: Train
    - PostOperation: UnpublishAIConfiguration
    - PostOperation: UnscheduleTraining
    - all the Microsoft.Dynamics.AI.Plugins

   These must show the status as **On**. You can select the ones that are turned off, right-click and then select **Turn On**.

1. On the left pane, select **Processes**.
1. Select AlmHandler, and then select **Turn On**.
1. Select **IsPaiEnabled** > **Turn On**.
1. Check all those processes that are required for AI Builder to ensure they're turned on.

    - AlmHandler
    - AnalyzeSentiment
    - BatchPrediction
    - CancelTraining
    - CategorizeText
    - DetectLanguage
    - ExtractKeyPhrases
    - ExtractTextEntities
    - GetJobStatus
    - IsPaiEnabled
    - Predict
    - PredictByReference
    - PredictionSchema
    - PublishAIConfiguration
    - QuickTest
    - RecognizeText
    - SchedulePrediction
    - ScheduleRetrain
    - ScheduleTraining
    - Train
    - UnpublishAIConfiguration
    - UnschedulePrediction
    - UnscheduleTraining
    - ValidateAIConfiguration
