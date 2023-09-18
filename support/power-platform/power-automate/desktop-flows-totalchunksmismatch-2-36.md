---
title: TotalChunksMismatch error after installing Power Automate for desktop version 2.36
description: Workaround for TotalChunksMismatch error on 2.36
ms.subservice: power-automate-desktop-flows
---
# TotalChunksMismatch error on Power Automate version 2.36

This article provides a solution for when you consistently receive a TotalChunksMismatch error executing an attended or unattended run for a particular script after upgrading to Power Automate for desktop version 2.36

## Symptoms

After installing Power Automate version 2.36, all your attended or unattended runs for a particular script fail with the error code TotalChunksMismatch.

## Resolution

To resolve this failure, you will need administrator permissions. First, stop runs from executing on the machine. Then, you will need to  delete the contents of the following folders:

* C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\metadata
* C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\storage

You can do this by creating an administrator command prompt and typing the following:

`del "C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\metadata\*" /f /s /q`

`del "C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\storage\* /f /s /q`
