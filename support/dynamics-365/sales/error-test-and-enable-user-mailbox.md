---
title: Error when you test and enable a user's mailbox
description: This article provides a resolution for the problem that occurs when you select Test and Enable on a user's Mailbox Profile.
ms.reviewer: taskar
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An error occurs on Test and Enable for a user's Mailbox Profile in Microsoft Dynamics CRM 2013 Server-Side-Synchronization

This article helps you resolve the problem that occurs when you select Test and Enable on a user's mailbox profile.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft Dynamics CRM 2013 Service Pack 1  
_Original KB number:_ &nbsp; 2993502

## Symptoms

When you select Test and Enable on a user's mailbox profile, a notification is given in Alerts stating the following:

> Email cannot be received for the mailbox because an error occurred while establishing a secure connection to the email server. The mailbox has been disabled for receiving email and the owner of the email server profile has been notified.  
The mailbox has been disabled for synchronizing appointments, contacts, and tasks for the mailbox because an error occurred while establishing a secure connection to the Microsoft Exchange server. The owner of the email server profile has been notified.

## Cause

The user account currently has a Kiosk license. When using a Kiosk license for a user account, the user's account does not have permissions to use Exchange Web Services to communicate to Exchange.

## Resolution

The user account will need a Standard, or Enterprise license for Exchange Online to use Exchange Web Services for Server-Side Synchronization.
