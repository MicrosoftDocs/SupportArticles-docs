---
title: Slow performance in CRM 2011 client
description: This article discusses options to modify the time intervals that determine when background activities run and the Microsoft Dynamics CRM client for Outlook is used.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 
---
# Slow performance when you use the Microsoft Dynamics CRM 2011 client for Outlook

This article provides a solution to an issue where slow performance for Microsoft Dynamics CRM 2011 client for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2585157

## Symptoms

You find the performance slow for the Microsoft Dynamics CRM 2011 client. When you investigate Microsoft Dynamics CRM client and server network traffic, you find that there's traffic even if there's no Microsoft Dynamics CRM user activity that is occurring.

## Cause

The Microsoft Dynamics CRM client for Microsoft Outlook runs background polling activities that communicate to the server and react to server-side changes even if there's no client-side activity.

There are caches for various Microsoft Dynamics CRM features such as address book, reminders, and views. The default polling interval for MAPI caches is every 15 minutes.

The regular polling generates Microsoft Dynamics CRM background activity, and this activity may influence performance.

## Resolution

There's a set of registry values and subkeys that can be modified to tune the polling intervals.

The following table contains the list of Microsoft Dynamics CRM client for Outlook registry entries and subkeys that influence background CRM activity. Test and find the optimal values for your environment. As a starting point, there's a **Suggested Testing** column that doubles the default values.

|Registry Entry|Server/Client|Type|Unit of Measure|Default Duration/Value|Registry Subkey|Suggested Testing|
|---|---|---|---|---|---|---|
|NotificationPollInterval|Client|(DWORD Reg Key)|Msec|180000 (Decimal)| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`|Increment to 3600000 (Decimal)|
|StateManagerPollInterval|Client|(DWORD Reg Key)|Min|5 (Decimal)| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`|Increment to 10 (Decimal)|
|TagDisabled (this key disables Automatic Email Tagging)|Client|(DWORD Reg Key)|Not Applicable|0| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient\{ORGGUID}`|Set to 1|
|TagPollingPeriod|Client|(DWORD Reg Key)|Msec|300000 (Decimal)| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient\{ORGGUID}`|Increment to 600000 (Decimal)|
|TagMaxAggressiveCycles|Client|(DWORD Reg Key)|Not Applicable|2| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient\{ORGGUID}`|Set to 0|
|ActiveCachesUpdatingPeriodMilliseconds|Client|(DWORD Reg Key)|Msec|1500000 (Decimal)| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`|Increment to 3000000 (Decimal)|
|IncrementalDataCachesInclusionUpdatingPeriodMilliseconds|Client|(DWORD Reg Key)|Msec|300000 (Decimal)| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`|Increment to 6000000 (Decimal)|
|IncrementalDataCachesExclusionUpdatingPeriodMilliseconds|Client|(DWORD Reg Key)|Msec|300000 (Decimal)| `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`|Increment to 6000000 (Decimal)|

Additionally, you can also try to increase the Outlook synchronization interval. By default, this interval is set to 15 minutes. To increase the internal, follow these steps:

1. Open the CRM Web Client.
2. Select **Settings**, select **Administration**, and then select **System Settings**.
3. Select the **Outlook** tab, and then examine the **Minimum time between synchronizations** option.

A Microsoft Dynamics CRM user can adjust the synchronization value for this server setting up to the minimum value that is defined in the user's personal Microsoft Dynamics CRM options in Outlook. To update the Outlook minimum value, follow these steps:

1. Open Microsoft Outlook 2010.
1. Select **File**, select **CRM**, and then select **Options**.
1. Under the **Synchronization** tab, update the value for the **Synchronize the CRM items in my Outlook folder every 'x' minutes** option.
