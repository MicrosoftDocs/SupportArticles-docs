---
title: TotalChunksMismatch error after installing Power Automate for desktop version 2.36
description: Provides a workaround for the TotalChunksMismatch error that occurs after you install Microsoft Power Automate for desktop version 2.36.
ms.subservice: power-automate-desktop-flows
ms.date: 09/18/2023
ms.reviewer: madiazor, alarnaud, fredg, guco
ms.author: johndund 
author: johndund
---
# TotalChunksMismatch error on Power Automate version 2.36

This article provides a solution to the "TotalChunksMismatch" error that occurs when you execute an attended or unattended run for a particular script after upgrading to Power Automate for desktop version 2.36

## Symptoms

After installing Power Automate version 2.36, all your attended or unattended runs for a particular script fail with the "TotalChunksMismatch" error code.

## Resolution

To resolve this issue, you need administrator permissions. First, stop the runs from executing on the machine. Then, you need to delete the files from the following folders:

- _C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\metadata_
- _C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\storage_

You can also use the `del` command to delete the files as an administrator:

`del "C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\metadata\*" /f /s /q`

`del "C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\storage\* /f /s /q`
