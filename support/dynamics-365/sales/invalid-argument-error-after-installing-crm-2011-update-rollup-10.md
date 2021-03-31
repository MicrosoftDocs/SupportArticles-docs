---
title: Invalid Argument error after applying CRM Update Rollup 10
description: You may see the Invalid Argument error after installing Microsoft Dynamics CRM 2011 Update Rollup 10. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Invalid Argument error after installing Microsoft Dynamics CRM 2011 Update Rollup 10

This article provides a resolution for the **Invalid Argument** error that may occur after you apply the Microsoft Dynamics CRM 2011 Update Rollup 10.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2748933

## Symptoms

After installing Microsoft Dynamics CRM 2011 Update Rollup 10, users see an **Invalid Argument** error when navigating around Microsoft Dynamics CRM.

> CRM Platform Trace Error:
>
> Crm Exception: Message: A non valid page number was received: 0, ErrorCode: -2147220989

## Cause

Microsoft Dynamics CRM's Fetch Throttling abilities have been disabled or modified from the default values.

## Resolution

Re-enable Microsoft Dynamics CRM's default Fetch Throttling settings.

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.

2. Locate and then select the following registry subkey:

   `HKEY_LOCAL_MACHINE\Software\Microsoft\MSCRM`

3. Locate and then delete the `MaxRowsPerPage` or the `TurnOffFetchThrottling` registry keys.
