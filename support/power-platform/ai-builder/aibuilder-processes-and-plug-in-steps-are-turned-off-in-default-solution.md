---
title: AI Builder processes and plug-in steps are turned off in default solution
description: 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# AI Builder processes and plug-in steps are turned off in default solution

This article provides steps to turn on AI Builder processes and plug-in steps in default solution.

_Applies to:_ &nbsp; AI Builder home page



## Cause

AI Builder can't be used if its plug-in steps and processes have been turned off.


## Resolution


1. To turn them on, sign in to Power Apps, and select the appropriate environment from the top-right corner.
2. In the left pane, select Solutions.
3. Select Default Solution, then select Edit.
4. On the left list, select Plug-in steps, and ensure all listed steps are turned on:
PreValidate: AlmHandler. (required for import/export).
PreValidate: isPaiEnabled.
ValidateAIConfiguration
PostOperation: CancelTraining
PostOperation: PublishAIConfiguration
PostOperation: PublishAIConfiguration Async
PostOperation: ScheduleRetrain
PostOperation: ScheduleTraining
PostOperation: Train
PostOperation: UnpublishAIConfiguration
PostOperation: UnscheduleTraining
all the Microsoft.Dynamics.AI.Plugins
These must show the status as On. You can select the ones that are turned off, right-click and then Turn On.
5. In the left pane, select Processes.
6. Select AlmHandler, and then select Turn On.
7. Select IsPaiEnabled, and then Turn On.
8. Additionally, check all those processes that are required for AI Builder to ensure they are turned on:
AlmHandler
AnalyzeSentiment
BatchPrediction
CancelTraining
CategorizeText
DetectLanguage
ExtractKeyPhrases
ExtractTextEntities
GetJobStatus
IsPaiEnabled
Predict
PredictByReference
PredictionSchema
PublishAIConfiguration
QuickTest
RecognizeText
SchedulePrediction
ScheduleRetrain
ScheduleTraining
Train
UnpublishAIConfiguration
UnschedulePrediction
UnscheduleTraining
ValidateAIConfiguration

