---
title: Account does not have permission to impersonate requested user error
description: Solves an error that occurs when you select Test Connection on an email server profile in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/06/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "The account does not have permission to impersonate the requested user" error when selecting Test Connection

This article helps resolve "The account does not have permission to impersonate the requested user" error that might occur when you select **Test Connection** in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4295275

## Symptoms

When you [select Test Connection on an email server profile](/power-platform/admin/connect-exchange-server-on-premises#create-an-email-server-profile) to connect Dynamics 365 Online to Microsoft Exchange Server (on-premises), you receive the following error:

> The account does not have permission to impersonate the requested user

## Cause

This error can occur if the user account specified in the email server profile record doesn't have impersonation permissions for the Exchange mailbox.

## Resolution

Make sure the user account specified in the email server profile record has impersonation permissions for each associated Exchange mailbox.

For more information on configuring Exchange impersonation, see:

- [Configure impersonation](/exchange/client-developer/exchange-web-services/how-to-configure-impersonation)
- [Impersonation and EWS in Exchange](/exchange/client-developer/exchange-web-services/impersonation-and-ews-in-exchange)
