---
title: Backup fails with VSS event ID 12292 and 11
description: Fixes an issue in which backup operation using Windows Server Backup or a third-party backup application fails.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Volume Shadow Copy Service (VSS) , csstroubleshoot
---
# Backup fails with VSS event ID 12292 and 11 on Windows Server

This article discusses an issue where backup operation using Windows Server Backup or a third-party backup application fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2009513

## Symptoms

A backup operation using Windows Server Backup or a third-party backup application fails on Windows Server.

In the System event log, the following event is logged:

> Log Name: System  
Source: Service Control Manager  
Event ID:      7023  
Level:         Error  
Description:  
The Microsoft Software Shadow Copy Provider service terminated with the following error:  
The system cannot find the file specified.

In the Application event log, the following events are logged:

> Log Name:      Application  
Source:        VSS  
Event ID:      12292  
Level:         Error  
Description:  
Volume Shadow Copy Service error: Error creating the Shadow Copy Provider COM class with CLSID {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a} [0x80080005].  
Operation:  
   Obtain a callable interface for this provider  
   Obtaining provider management interface  
Context:  
   Provider ID: {b5946137-7b9f-4925-af80-51abd60b20d5}  
   Class ID: {00000000-0000-0000-0000-000000000000}  
   Snapshot Context: -1  
   Provider ID: {b5946137-7b9f-4925-af80-51abd60b20d5}  
Log Name:      Application  
Source:        VSS  
Event ID:      11  
Level:         Error  
Description:  
Volume Shadow Copy Service information: The COM Server with CLSID {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a} and name SW_PROV cannot be started. Most likely the CPU is under heavy load. [0x80080005]  
Operation:  
   Obtain a callable interface for this provider  
   Obtaining provider management interface  
Context:  
   Provider ID: {b5946137-7b9f-4925-af80-51abd60b20d5}  
   Class ID: {00000000-0000-0000-0000-000000000000}  
   Snapshot Context: -1  
   Provider ID: {b5946137-7b9f-4925-af80-51abd60b20d5}  

On Windows Server 2008, if Windows Server Backup was used to perform the backup, the backup operation fails with one of the following errors:

> Failed to create the shadow copy on the storage location.  
ERROR - Volume Shadow Copy Service operation error (0x8004230f)  
The shadow copy provider had an unexpected error while trying to process the specified operation.  

Or

> The creation of the shadow copy on the backup destination failed.  
The volume shadow copy operation failed with error 0x8004230F.  
View the event log for more information.  

On Windows Server 2008 R2, if Windows Server Backup was used to perform the backup, the backup operation fails with one of the following errors:
> Windows Backup failed to create the shadow copy on the storage location.

Or

> The creation of the shadow copy on the backup storage destination failed.

## Cause

This issue can occur if the ServiceDll registry value for Swprv is missing or incorrect.

## Resolution

To resolve this issue, perform the following steps:

1. Click **Start**, type *regedit* in the Start Search box, and hit Enter.
2. Locate and then click the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\swprv\Parameters`  
    > [!Note]
    > If the Parameters registry key is missing, perform the following steps:
    Right-click the swprv registry key, select **New**, select **Key**, type *Parameters* and hit Enter.
3. Once the Parameters registry key is selected, verify that the ServiceDll registry value has the following value:

     %Systemroot%\\System32\\swprv.dll  
    > [!Note]
    > If the ServiceDll registry value is missing, perform the following steps:
    >
    > 1. Right-click the Parameters registry key, select **New**, and then select **Expandable String Value**.
    > 2. For the value name, type *ServiceDll* and hit Enter.
    > 3. Double-click the **ServiceDll** registry value.
    > 4. In the **Value Data** box, type *%Systemroot%\\System32\\swprv.dll*, and then click **OK**.

4. Perform a backup operation to verify that the issue is resolved.
