---
title: Error 347 when installing the DPM agent
description: Fixes an issue in which you receive error 347 when installing the DPM agent on Windows Server 2008 or Windows Server 2008 R2.
ms.date: 07/23/2020
ms.prod-support-area-path: 
ms.reviewer: DPMTechReview, jarrettr, delhan
---
# DPM agent installation fails with error 347

This article helps you work around an issue where you receive **Error 347: An error occurred when the agent operation attempted to create the DPM Agent Coordinator service** when you try to install the System Center 2016 Data Protection Manager (DPM) agent.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager  
_Original KB number:_ &nbsp; 4018028

## Symptoms

When you try to protect Windows Server 2008 or Windows Server 2008 R2 by installing the System Center 2016 Data Protection Manager agent, the installation fails, and you receive one of the following error messages:

- When you try to install the agent from the DPM console:

    > Install protection agent on *%servername%* failed:  
    > Error 347: An error occurred when the agent operation attempted to create the DPM Agent Coordinator service on *%servername%*.  
    > Error details: The service did not respond to the start or control request in a timely fashion
    > Recommended action: Verify that the Agent Coordinator service on *%servername%* is responding, if it is present. Review the error details, take the appropriate action, and then retry the agent operation.

- When you try to install the agent manually on the protected server:

    > The program can't start because mi.dll is missing from your computer. Try reinstalling the program to fix this problem.

## Cause

This issue typically occurs because a prerequisite isn't installed. Most frequently, Windows Management Framework (WMF) needs to be updated.

## Workaround

To work around this issue, follow these steps:

1. Upgrade [Windows Management Framework](https://docs.microsoft.com/powershell/scripting/windows-powershell/wmf/overview) on the production server to version 4.0.
2. Make sure all other [prerequisites](/system-center/dpm/prepare-environment-for-dpm#protected-workloads) are installed.
3. Again try to install the DPM agent.

## References

- [DPM server](/system-center/dpm/prepare-environment-for-dpm#dpm-server)
- [System Center DPM Release Notes](/system-center/dpm/dpm-release-notes)
