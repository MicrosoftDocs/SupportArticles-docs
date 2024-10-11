---
title: IDispatch error for content distribution
description: Describes an issue in which content distribution to Configuration Manager distribution points fails with IDispatch error because of missing IIS components.
ms.date: 12/05/2023
ms.custom: sap:Content Management\Distribution Point Installation, Upgrade or Configuration
ms.reviewer: kaushika
---
# IDispatch error #3603 when you distribute content to DPs in Configuration Manager

This article fixes an issue in which you can't distribute content to Configuration Manager distribution points and receive **IDispatch error #3603**.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4509132

## Symptoms

Content distribution to distribution points in Configuration Manager fails, and the following error messages are logged in DistMgr.log on the parent site server:

> CWmiRegistry::GetStr: Failed to get string value SCFSSLPortList  
> CWmiRegistry::GetStr: Failed to get string value SMSSSLPortList  
> CWmiRegistry::GetStr: Failed to get string value SMSCWSPortList  
> CWmiRegistry::GetStr: Failed to get string value SMSCWSSSLPortList  
> CWmi::PutObject(): PutInstance() failed. - 0x80041013~  
> ~ERROR CreateApplicationPool: Failed with error = IDispatch error #3603~  
> ~ERROR CreateVirtualDirectory: Failed to update virtual directory SMS_DP_SMSPKG$. error = IDispatch error #3603~  
> vdHelper.CreateVirtualDirectory() - Failed to CreateVirtualDirectory SMS_DP_SMSPKG$ for DP <DP_Server_Name>. Will retry in 5 seconds~  
> Failed to configure IIS module, GLE - 1168  
> ConfigureIISModules failed to configure IIS module  
> ~ERROR CreateVirtualDirectory: Failed to update virtual directory SMS_DP_SMSPKG$. error = IDispatch error #3603~

## Cause

This issue occurs if IIS configuration on the distribution point server is changed incorrectly, so that some required IIS components are missing, such as the **IIS 6 Metabase Compatibility** and **IIS 6 WMI Compatibility** components.

## Resolution

To fix the issue, verify IIS configuration within **Server Manager**, on the server that hosts the distribution point, and make sure that all required IIS components are installed.

For more information about the prerequisites for distribution point, see [Distribution point](/mem/configmgr/core/plan-design/configs/site-and-site-system-prerequisites#bkmk_2012dppreq).
