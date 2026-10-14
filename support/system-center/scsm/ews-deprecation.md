---
title: Impact of EWS deprecation in Exchange Online
description: Learn how EWS deprecation in Exchange Online affects Service Manager email notifications and Exchange Connector, and apply the fix to avoid disruption.
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: aakashb, khusmeno
ms.date: 10/01/2026
ai-usage: ai-assisted
---
# Impact of EWS deprecation in Exchange Online

> [!IMPORTANT]
> This article applies only to Microsoft System Center Service Manager (2022 and 2025) customers who use Exchange Online in Email Notifications or Exchange Connector. Customers who use Exchange Server on-premises aren't affected by the deprecation of Exchange Web Services (EWS) in Exchange Online.

## Summary

Microsoft is deprecating Exchange Web Services (EWS) in Exchange Online. This deprecation affects System Center Service Manager customers who use Exchange Online for Email Notifications or the Exchange Connector. This article describes the deprecation timeline, how it affects Service Manager, and the steps you can take to minimize disruption.

Starting on October 1, 2026, Microsoft will begin to globally disable EWS. EWS will be fully disabled in April 2027. For more information about the Exchange Online EWS deprecation timeline, see [Deprecation of Exchange Web Services in Exchange Online](/exchange/clients-and-mobile-in-exchange-online/deprecation-of-ews-exchange-online).

This deprecation can affect the following Service Manager features when they connect to Exchange Online:

- Email Notifications
- Exchange Connector

## Resolution

- For immediate relief, apply the [`Temporary Workaround`](#temporary-workaround-valid-until-april-2027) mentioned in the next section.

Then plan to apply the respective permanent solution. See the following list for options:

- If your Exchange Connectors are impacted, upgrade to [Exchange Connector 5.0](https://www.microsoft.com/download/details.aspx?id=101579).
- If your Email Notifications are impacted:
   - For System Center Service Manager 2022, apply [System Center Service Manager 2022 Update Rollup 4](https://support.microsoft.com/en-us/servicing/management-tools/service-manager/update/2026/09/update-rollup-4-for-system-center-2022-service-manager).
   - For System Center – Service Manager 2025, wait for System Center – Service Manager 2025 Update Rollup 2 to be released.
   - For System Center Service Manager 2019, there are currently no plans to provide a permanent solution. Please plan [upgrading to System Center Service Manager 2022](/system-center/scsm/upgrade-service-manager?view=sc-sm-2022) and then apply the latest System Center Service Manager 2022 Update Rollup.

## Temporary workaround (valid until April 2027)

> [!WARNING]
> This workaround temporarily postpones the impact of EWS deprecation. It doesn't work after Microsoft disables EWS in April 2027.

An Exchange Online admin must perform the following actions. Run all the following commands with Azure PowerShell.

1. Check whether the Exchange Online PowerShell module is installed.

   ```powershell
   Get-Module ExchangeOnlineManagement -ListAvailable
   ```

1. If the command doesn't return the module, install it for the current user.

   ```powershell
   Install-Module ExchangeOnlineManagement -Scope CurrentUser
   ```

1. Import the module and connect to Exchange Online.

   ```powershell
   Import-Module ExchangeOnlineManagement
   Connect-ExchangeOnline
   ```

1. Check the current EWS status.

   ```powershell
   Get-OrganizationConfig | Select-Object EwsEnabled
   ```

1. If `EwsEnabled` is `False` and the affected Service Manager features no longer work, set `EwsEnabled` back to `null`.

   ```powershell
   Set-OrganizationConfig -EwsEnabled:$null
   ```

Setting `EwsEnabled` to `null` temporarily allows EWS without restrictions until the final deprecation.
