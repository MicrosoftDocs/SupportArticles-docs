---
title: Reset UI Flow service when in bad state
description: Provides a solution to an issue where you're consistently experiencing an error when doing a UI flow run, recording, or test.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# How to restart UI flows to recover from a bad state

This article provides a solution to an issue where you're consistently experiencing an error when doing a UI flow run, recording, or test.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555618

## Symptoms

If you're in a state where you're consistently experiencing an error when doing a UI flow run, recording or test, but nothing is actionable, it may help to restart UI flows by restarting the service.

You must be an admin on the machine to restart the service.

## Resolution

Before restarting the UI flow service, verify in the task manager that the UI flows agent (`Microsoft.Flow.Rpa.Agent`) isn't running. If it's running, select **End task**.

:::image type="content" source="media/reset-ui-flow-service-when-bad-state/select-end-task.png" alt-text="RPA Agent process in task manager screenshot.":::

Use the following methods to restart the UI flow service in the following order.

> [!NOTE]
> You must be an admin to restart the service.

- Method 1: Restart *UIFlowService*
  - Open the task manager and go to **the services tab**, then look for **UIFlowService**, right-click on it, and select **Restart**.
  
  :::image type="content" source="media/reset-ui-flow-service-when-bad-state/restart-uiflowservice.png" alt-text="UI flow service in task manager screenshot.":::

- Method 2: If method 1 returns an error, you can try to restart the service manually as follows:

  - Kill (end task) the UI flow service process (parent of the service) in the **process** tab of the task manager.
  
  :::image type="content" source="media/reset-ui-flow-service-when-bad-state/end-task-ui-flow-service-process.png" alt-text="UI flow service associated process in task manager screenshot.":::

- Then delete session.json located in

  - `C:\Windows\ServiceProfiles\UIFlowService for Windows 10`
  - `C:\Users\UIFlowService for Windows Server 2016 and Windows Server 2019`

- > [!NOTE]
  > The service should automatically restart after the task had ended.
