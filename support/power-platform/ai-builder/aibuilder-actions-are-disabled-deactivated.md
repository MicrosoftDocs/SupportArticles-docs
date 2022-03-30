---
title: AI Builder actions are disabled/deactivated
description: 
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
---

# AI Builder actions are disabled/deactivated

This article provides steps to activate AI Builder actions

_Applies to:_ &nbsp; Other


## Symptoms

AI Builder actions are disabled/deactivated


## Cause

AI Builder can't be used if its actions have been deactivated.


## Resolution

To activate them, the administrator of the environment needs to perform the following steps:

1. Sign in to the Power Platform Admin Center.
2. Select the environment where the actions are deactivated and select Settings > Resources > All legacy settings.
3. Select Processes from the Settings menu.
4. Select to display All Processes and activate all the following AI Builder processes:
IsPaiEnabled
Predict
PredictionSchema
Train
QuickTest
BatchPrediction
ScheduleTraining
SchedulePrediction
ScheduleRetrain
UnschedulePrediction
UnscheduleTraining
CancelTraining
PublishAIConfiguration
UnpublishAIConfiguration

