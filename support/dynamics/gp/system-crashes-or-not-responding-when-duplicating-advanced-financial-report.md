---
title: System crashes or not responding when duplicating Advanced Financial report
description: Microsoft Dynamics GP crashes or not responding when you try to copy or duplicate Advanced Financial (AFA) Reports.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# System crashes or not responding when you duplicate an Advanced Financial report in General Ledger

This article provides a resolution for the crash or not responding issue when you duplicate an Advanced Financial report in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2472399

## Symptoms

Microsoft Dynamics GP crashes or not responding when you try to copy or duplicate Advanced Financial (AFA) Reports. The system also crashed when you try to make a change to the report.

## Cause

This issue is caused by a corrupt dictionary such as the *Reports.dic* or *Forms.dic*.

## Resolution

Use the steps below to test if the dictionaries are corrupt:

1. Ask all users to exit Microsoft Dynamics GP and make a current restorable backup.
2. Rename both dictionaries to determine if one or both of these are causing the issue. Navigate to the GP code folder and right-click on the *Reports.dic* and rename it to *ReportsOld.dic* and right-click on the *Forms.dic* and rename it to *FormsOld.dic*.

    > [!NOTE]
    > The default installation path is: C:\Program Files\Microsoft Dynamics\GP

    More detailed steps are provided in the articles below:

    - [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-reports-dic-file-in-microsoft-dynamics-gp-8a85339e-92ed-03ed-5ca8-f538a5c502a7)
    - [How to re-create the Forms.dic file in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-forms-dic-file-in-microsoft-dynamics-gp-4cbd73e5-20c9-0baf-af55-3ea467eb1d0c)

3. Now test duplicating the AFA report again to see if the issue still happens. If Microsoft Dynamics GP continues to crash or not respond, then one or both of these dictionaries are corrupt. (If one of the dictionaries isn't causing the issue, you can put it back.)

4. If the issue still persists, you can also test to see if the *Dynamics.dic* is corrupt. To do this, rename the *Dynamics.dic* to *DynamicsOld.dic* and then copy over the *Dynamics.dic* from a different workstation, or install a new Microsoft Dynamics GP code folder to test with.
