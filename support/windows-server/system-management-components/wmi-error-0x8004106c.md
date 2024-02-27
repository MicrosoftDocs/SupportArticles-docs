---
title: Error 0x8004106C while you run WMI queries
description: Provides a solution to fix the error 0x8004106C that occurs when you run WMI queries.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wmi, csstroubleshoot
---
# WMI Error: 0x8004106C Description: Quota violation, while you run WMI queries

This article helps fix the error 0x8004106C that occurs when you run WMI queries.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2404366

## Symptoms

You're unable to run WMI queries. You may receive an error similar to the following if you run a query. In this example, the following query was run from the root\\cimv2 namespace:  

```sql
Select * From Win32_LogicalDisk Where FreeSpace > 200000
```

The error returned was:  
> 0x8004106C  
Description: Quota violation.  

## Cause

This error can occur if the WMI Provider service has reached its quota limit.

## Resolution

Raise the memory quota of the WMI Provider service by carrying out the following steps:

1. Go to **Start** > **Run** and type *wbemtest.exe*.
2. Select **Connect**.
3. In the namespace text box, type *root*.
4. Select **Connect**.
5. Select **Enum Instances...**.
6. In the **Class Info** dialog box, enter Superclass Name as *__ProviderHostQuotaConfiguration* and press **OK**.  

    > [!Note]
    > The Superclass name includes a double underscore at the front.  

7. In the **Query Result** window, double-click **__ProviderHostQuotaConfiguration=@**.
8. In the **Object Editor** window, double-click whichever Property name you wish to modify the quota for.
9. In the **Value** dialog, type in 536870912 (512 MB) for XP and Windows 2003, for Vista a newer start with new value of 805306368 (768), then move to 1073741824 (1024) if still needing room. If this does not resolve quota violation issue, then need to troubleshoot cause of high memory usage.
10. Select **Save Property**.
11. Select **Save Object**.  
12. Close Wbemtest.  
13. Restart the computer.  

> [!Note]
> Windows XP and Windows Server 2003 have a memory quota per host of 128 MB with a limit of 512 MB.  Windows Vista and Windows Server 2008 have a memory quota per host of 512 MB that is not the imposed limit as with XP and 2003 and can increase this number higher.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
