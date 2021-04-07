---
title: Errors when sending on behalf of or sending as another user
description: This article explains why some errors may occur when using the Microsoft Dynamics CRM Email Router with Office 365 Exchange Online. And provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Errors occur when sending on behalf of or sending as another user when using Dynamics CRM Email Router with Exchange Online

This article provides a resolution for the issue that you may receive error messages when you use the Microsoft Dynamics CRM Email Router with Microsoft Office 365 Exchange Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2708727

## Symptoms

The following errors may occur when using the Microsoft Dynamics CRM Email Router with Microsoft Office 365 Exchange Online:

> The user account which was used to submit this request does not have the right to send mail on behalf of the specified sending account.

> The access credentials that you have specified have insufficient delegate permissions to send the e-mail message. Contact your Microsoft Exchange administrator to grant the required Permissions.

## Cause

These errors will occur when the Administrator user setup in the Outgoing Profile of the Microsoft Dynamics CRM Email Router does not have Send As or Delegate permissions on the mailbox being used to send the email. The Administrators and users in Office 365 Exchange Online by default do not have Send As or Delegate Access permissions.

## Resolution

To resolve this issue, the Administrator user setup in the Outgoing Profile of the Microsoft Dynamics CRM Email Router must be granted Send As permissions if Send As permission is marked. If Delegate Access is marked in the Outgoing Profile, Full Access permissions must be granted to the user for the mailbox, as Delegate access cannot be explicitly defined with Exchange Online. These are added with Windows PowerShell. For more information, see:

- [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell)
- [Manage permissions for recipients in Exchange Online](/exchange/recipients-in-exchange-online/manage-permissions-for-recipients)
