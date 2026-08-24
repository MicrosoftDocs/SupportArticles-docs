---
title: IDispatch error 3603 during content distribution
description: Resolve IDispatch error 3603, which occurs when Configuration Manager can't distribute content because required IIS 6 compatibility role services are missing.
ms.date: 08/20/2026
ms.custom: sap:Content Management\Distribution Point Installation, Upgrade or Configuration
ms.reviewer: kaushika
ai-usage: ai-assisted
ms.topic: troubleshooting-problem-resolution

#customer intent: As a Configuration Manager administrator, I want to resolve IDispatch error 3603 so that I can distribute content to a distribution point.
---
# IDispatch error 3603 when you distribute content to a Configuration Manager distribution point

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4509132

## Summary

This article helps you resolve **IDispatch error 3603**, an error that occurs when Configuration Manager can't create Internet Information Services (IIS) objects during content distribution to a distribution point because required IIS 6 compatibility role services are missing.

## Symptoms

Content distribution to a distribution point fails. The **DistMgr.log** file on the site server contains entries that resemble the following example:

```output
CWmi::PutObject(): PutInstance() failed. - 0x80041013
ERROR CreateApplicationPool: Failed with error = IDispatch error #3603
ERROR CreateVirtualDirectory: Failed to update virtual directory SMS_DP_SMSPKG$. error = IDispatch error #3603
vdHelper.CreateVirtualDirectory() - Failed to CreateVirtualDirectory SMS_DP_SMSPKG$ for DP <DP_server_name>. Will retry in 5 seconds
```

## Cause

The distribution point is missing one or both of the following required IIS role services:

- **IIS 6 Metabase Compatibility**
- **IIS 6 WMI Compatibility**

Distribution Manager uses IIS management Windows Management Instrumentation (WMI) to create the **SMS Distribution Points Pool** application pool and virtual directories such as `SMS_DP_SMSPKG$`. If the compatibility role services aren't available, IIS returns the COM error and Distribution Manager can't complete the configuration.

## Solution

Install the missing IIS role services on the server that hosts the distribution point:

1. In **Server Manager**, select **Manage** > **Add Roles and Features**.
1. Advance to the **Server Roles** page, and then expand **Web Server (IIS)** > **Management Tools** > **IIS 6 Management Compatibility**.
1. Select **IIS 6 Metabase Compatibility** and **IIS 6 WMI Compatibility**.
1. Complete the wizard, and restart the server if you're prompted.
1. Retry the content distribution, or wait for Distribution Manager to retry it. Verify in **DistMgr.log** that Configuration Manager creates the application pool and the `SMS_DP_SMSPKG$` virtual directory successfully.

Alternatively, run the following Windows PowerShell command in an elevated session on the distribution point server:

```powershell
Install-WindowsFeature Web-Metabase, Web-WMI
```

For the complete list of required roles and features, see [Site and site system prerequisites for Configuration Manager](/intune/configmgr/core/plan-design/configs/site-and-site-system-prerequisites#distribution-point).

## Get support

If the error continues after you install the required role services, collect **DistMgr.log** from the site server and [contact Microsoft Support](https://support.microsoft.com/contactus/).
