---
title: Importing a GPO using GPMC fails with an error (The Directory is not empty)
description: Provides solutions to an issue when you import a saved GPO using GPMC.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle, oweindl
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Importing a GPO using GPMC fails with "The Directory is not empty"

This article provides solutions to an issue where importing a saved GPO using Group Policy Management Console (GPMC) fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2667462

## Symptoms

Importing a saved GPO using Group Policy Management Console (GPMC) sporadically fails with an error dialog "The Directory is not empty".

## Cause

During Import of the Policy settings, GPMC creates several temporary directories (staging) and backups the old settings in separate folders.

As the Import is done on the SysVol share, DFSR replication might interfere with the import sequence and therefore show the above error.

## Resolution 1

To prevent the conflicting operations from occurring, use DFSRDIAG.EXE to suspend replication on the DC the GPMC import is happening on. The command requires the user to specify the Replication Group name, the Partner name (in this case the DC used for the import is the partner) and the amount of time in minutes to suspend replication. DFSR will automatically resume replication once the number of minutes specified has elapsed.

1. Open an administrative Command Prompt window.
2. Run this command: `DFSRDIAG StopNow /rgname:"Domain System Volume" /partner:<DcName> /time:<number of minutes to suspend replication>`.

    > [!NOTE]
    > In this command, \<*DcName*> represents the domain controller name, and \<*number of minutes to suspend replication*> represents how long replication is suspended.
3. Import the Group Policy.

> [!NOTE]
> DFSR will log event 5106 when replication is stopped and again when it resumes. You can use these events to monitor the service state.

Event 5106 when replication is paused:

> Log Name: DFS Replication  
Source: DFSR  
Event ID: 5106  
Task Category: None  
Level: Information  
Keywords: Classic  
User: N/A  
Description:  
The replication mode on the connection to partner \<Dc Name> has changed.
>
> Additional Information:  
Previous Replication Mode: Obey Configured Schedule  
Current Replication Mode: Stop Replication  
Current Bandwidth Usage: Full  
Duration, in minutes, for current mode: 5  
Connection ID: 79E6D60D-6044-4775-A9BE-D98DAF557BD6  
Replication Group ID: Domain System Volume

Event 5106 when replication is Resumed:

> Log Name: DFS Replication  
Source: DFSR  
Event ID: 5106  
Task Category: None  
Level: Information  
Keywords: Classic  
User: N/A  
Description:  
The replication mode on the connection to partner \<DC Name> has changed.
>
> Additional Information:  
Previous Replication Mode: Stop Replication  
Current Replication Mode: Obey Configured Schedule  
Current Bandwidth Usage: Obey Configured Schedule  
Duration, in minutes, for current mode:  
Connection ID: 79E6D60D-6044-4775-A9BE-D98DAF557BD6  
Replication Group ID: Domain System Volume

## Resolution 2

To resolve the issue, in case the import needs to happen more often, add a filter for DFSR to exclude the temporary directories from replication. These temporary directories are:

- MachineOld
- UserOld
- MachineStaging
- UserStaging
- AdmOld

To modify the DFSR filter, edit this object in AD as mentioned as follows:

CN=SYSVOL Share,CN=Content,CN=Domain System Volume,CN=DFSR-GlobalSettings,CN=System,DC=Contoso,DC=Com

and modify the msdfsr-directoryfilter attribute.

Append the five directories to the end of the already existing exclusions, it should look like this:

DO_NOT_REMOVE_NtFrs_PreInstall_Directory,NtFrs_PreExisting___See_EventLog,MachineOld,UserOld,MachineStaging,UserStaging,AdmOld

To make DFSR read the new settings from AD, run `dfsrdiag PollAD`.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
