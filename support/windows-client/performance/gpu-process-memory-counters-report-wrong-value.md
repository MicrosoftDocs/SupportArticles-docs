---
title: GPU Process Memory counters report incorrect value
description: Discusses an issue where Graphics Processing Unit (GPU) process memory counters show memory leaks for running applications and report incorrect values.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tea, winsrv, v-jesits
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# GPU process memory counters report incorrect values

This article discusses an issue where Graphics Processing Unit (GPU) process memory counters show memory leaks for running applications and report incorrect values.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4490156

## Symptoms

Graphics Processing Unit (GPU) process memory counters appear to show memory leaks for running applications in Windows 10, version 1709 and later. This issue affects the following counters:

- Performance Monitor: **GPU Process Memory**  
- Task Manager, **Details** pane: **Dedicated GPU memory**  

    > [!Note]
    > Some GPUs do not use dedicated GPU memory. In those cases, the **Dedicated GPU memory** counter is either not available or has a value of "0." The issue that this article describes does not occur.

### Steps to reproduce the issue  

> [!Note]
> Theses steps use an Office application as an example.

1. Right-click the Task bar, and then select **Task Manager**.
2. In Task Manager, select **Details**. On the **Details** pane, right-click a column head, select **Show columns**, and then select **Dedicated GPU memory**.
3. Start any Office application, create a blank document, and then maximize the application window.
4. Start any other application, and then maximize that application window in the same monitor as the Office application (so that the new application hides the Office application).
5. Wait approximately 30 seconds for the Office application to enter "Low Resource Mode."
    > [!Note]
    > In this mode, the Office application flushes its discardable caches, including the GPU resources.

6. On the Task Manager **Details** pane, check the **Dedicated GPU memory** value for the Office application. You should notice that the value has dropped by approximately 100MB.
7. Bring the Office application window back to the monitor foreground.
   - **Expected behavior:** As the Office application re-creates its resources, its **Dedicated GPU memory** value should return to approximately the same value that it had the last time that the application was active.
   - **Actual behavior:** On systems that are affected by this issue, the new **Dedicated GPU memory** value is larger by approximately 100MB (or more) than the last time that the application was active. Every time that you hide the Office application, wait for it to flush its caches, and then reactivate it, the value increases by another 100MB (or more). However, the **Dedicated GPU memory** value that is visible on the Task Manager **Performance** pane continues to show the expected value. Additionally, tools such as Windows Performance Recorder (WPR) and Windows Performance Analyzer (WPA) show the expected value.

## More information

This is a known issue in Windows 10. To monitor dedicated GPU memory on affected systems, use the **Performance** pane of Task Manager, WPR, or WPA.
For more information about the GPU process memory counters, see [GPUs in the Task Manager](https://devblogs.microsoft.com/directx/gpus-in-the-task-manager/).
For more information about WPR and WPA, see [Windows Performance Toolkit](/windows-hardware/test/wpt/).
