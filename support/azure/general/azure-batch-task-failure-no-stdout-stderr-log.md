---
title: Azure Batch task fails without stdout or stderr
description: Explains the cause for Azure Batch tasks failure without stdout or stderr and provides some suggestions.
ms.date: 04/13/2023
author: AmandaAZ
ms.author: v-weizhu
ms.reviewer: biny
ms.service: batch
---

# Azure Batch task fails without stdout or stderr

This article provides the cause and some suggestions for Azure Batch tasks failure without stdout or stderr.

## Symptoms

Batch tasks fail with an exit code. But there are no standard output (stdout) and standard error (stderr).

> [!NOTE]
> Azure Batch automatically captures and writes stdout and stderr for the task into the stdout.txt or stderr.txt file in the task directory.

## Cause  

When a task executes a process, the Batch service populates the task's exit code property with the return code of the process. If the process returns a nonzero exit code, the Batch service marks the task as failed.

The Batch service doesn't determine a task's exit code. The process itself, or the operating system on which the process executed, determines the exit code.

## Recommended steps

Try to determine the cause based on the exit code.

If it's hard to identify the cause based on the exit code, perform more debugging by the following steps:

1. Use the Azure portal to download a Remote Desktop Protocol (RDP) file for Windows nodes, or obtain Secure Shell (SSH) connection information for Linux nodes.

1. Manually run the command or script that's used to run the failed task for debugging.  

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
