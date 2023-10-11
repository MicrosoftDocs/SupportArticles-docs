---
title: The account does not have permission to impersonate the requested user error when selecting Test Connection
description: You may receive an error message that states the account does not have permission to impersonate the requested user. This issue occurs when you select Test Connection on an email server profile. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# The account does not have permission to impersonate the requested user error when selecting Test Connection in Microsoft Dynamics 365

This article provides a resolution to solve **The account does not have permission to impersonate the requested user** error that may occur when you select Test Connection in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4295275

## Symptoms

When you select Test Connection on an email server profile to connect Microsoft Dynamics 365 Online to Microsoft Exchange Server on-premises, you encounter the following error:

> The account does not have permission to impersonate the requested user

## Cause

This error can appear if the user account specified in the Email Server Profile record does not have impersonation permissions for the Exchange mailbox.

## Resolution

Make sure the user account provided in the Email Server Profile record has impersonation permissions to each associated Exchange mailbox.

For more information on configuring Exchange impersonation, see:

- [Configure impersonation](/exchange/client-developer/exchange-web-services/how-to-configure-impersonation)
- [Impersonation and EWS in Exchange](/exchange/client-developer/exchange-web-services/impersonation-and-ews-in-exchange)
