---
title: Impact of EWS deprecation in Exchange Online
description: Describes how the deprecation of Exchange Web Services (EWS) in Exchange Online affects Service Manager email notifications and the Exchange Connector.
ms.reviewer: aakashb, khusmeno
ms.date: 09/16/2026
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

- If your Exchange Connectors are impacted, upgrade to [Exchange Connector 5.0](https://www.microsoft.com/download/details.aspx?id=101579).
- If your Email Notifications are impacted, apply the `Temporary Workaround` mentioned in the next section after October 1, 2026. For a permanent solution, wait for Update Rollups.

## Temporary workaround (valid until April 2027)

> [!WARNING]
> This workaround temporarily postpones the impact of EWS deprecation. It doesn't work after Microsoft disables EWS in April 2027.

An Exchange Online administrator must perform the following actions:

1. Check whether the Exchange Online PowerShell module is installed:

   ```powershell
   Get-Module ExchangeOnlineManagement -ListAvailable
   ```

1. If the command doesn't return the module, install it for the current user:

   ```powershell
   Install-Module ExchangeOnlineManagement -Scope CurrentUser
   ```

1. Import the module and connect to Exchange Online:

   ```powershell
   Import-Module ExchangeOnlineManagement
   Connect-ExchangeOnline
   ```

1. Check the current EWS status:

   ```powershell
   Get-OrganizationConfig | Select-Object EwsEnabled
   ```

1. If `EwsEnabled` is `False` and the affected Service Manager features no longer work, set `EwsEnabled` back to `null`:

   ```powershell
   Set-OrganizationConfig -EwsEnabled:$null
   ```

Setting `EwsEnabled` to `null` temporarily allows EWS without restrictions until the final deprecation.
