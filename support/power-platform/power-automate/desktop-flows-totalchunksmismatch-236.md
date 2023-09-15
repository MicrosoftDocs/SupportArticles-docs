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

To resolve this failure, you will need to need administrator permissions. First, stop runs from executing on the machine. Then, navigate to the following two folders and delete the contents:

* C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\metadata
* C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Microsoft\Power Automate Desktop\Cache\storage
