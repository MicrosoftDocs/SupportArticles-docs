---
title: SSIS Checkpoints are not honored for For Loop items
description: This article provides workarounds for the problem where SSIS Checkpoints are not honored for For Loop or Foreach Loop container items.
ms.date: 09/02/2020
ms.custom: sap:Integration Services
---
# SSIS Checkpoints are not honored for For Loop or Foreach Loop container items

This article helps you work around the problem where SQL Server Integration Services (SSIS) Checkpoints are not honored for `For Loop` or `Foreach Loop` container items.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2624458

## Symptoms

Consider the following scenario:

- You install Microsoft SQL Server Integration Services on a computer.
- You create an SSIS package that contains a For Loop Container item that is followed by a Sequence Container.
- Both the For Loop Container and the Sequence Container items have either of the following:

  - An Execute SQL Task (OR)
  - Two or more Execute SQL Task (s) that run in parallel.
- You enable the Checkpoint setting for the SSIS package.
- You run the SSIS package
- The For Loop Container completes and package execution comes to the Sequence Container.
- You take one of the actions below:

  - For packages having a single Execute SQL Task, you stop the package execution while the task is still running.
  - For packages running multiple Execute SQL Tasks, you either stop the package execution or you experience a failure in one of those tasks while other Execute SQL task (s) are still running
- The SSIS package runs again.

In this scenario, Package starts from `For Loop` Container instead of the `Sequence` Container.

> [!NOTE]
> This issue is not tied to Execute SQL Task. This may occur with other tasks as well.

## Cause

This behavior is by design. The checkpoint data is not saved for the `For Loop` Container  and `Foreach Loop` container items. If a child container in the loop runs successfully, it is not recorded in the checkpoint file. So, when the package is restarted, the tasks in each of these container items are executed again.

## Workaround

To work around the issue, wrap the `For Loop` or the `Foreach Loop` container inside a `Sequence` Container.
