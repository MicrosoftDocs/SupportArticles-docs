---
title: Error occurs on a mailbox record
description: Provides a solution to an error that occurs when you select the Test & Enable Mailbox button on a mailbox record in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Appointments, contacts, and tasks can't be synchronized error occurs when you select the Test & Enable Mailbox button on a mailbox record in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you select the **Test & Enable Mailbox** button on a mailbox record in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4014622

## Symptoms

When you select the **Test & Enable Mailbox** button on a mailbox record in Dynamics 365, the following alert is logged and Appointment, Contacts, and Tasks synchronization fails:  

> "Appointments, contacts, and tasks can't be synchronized because the email address of the mailbox \<Mailbox Name> is configured with another Microsoft Dynamics 365 organization. The best practice is to overwrite the configuration when you test and enable the mailbox in your primary organization. Also, change the synchronization method for your mailbox in non-primary organizations to None."  

## Cause

This error occurs under the following conditions:

- The mailbox is configured to use Server-Side Synchronization for Appointments, contacts, and tasks.
- The associated Exchange mailbox is already configured with another Dynamics 365 organization.  

A user can be a member of more than one Dynamics 365 organization, but an Exchange mailbox (email address) can only synchronize appointments, contacts, and tasks with one organization, and a user that belongs to that organization can only synchronize appointments, contacts, and tasks with one Exchange mailbox. Dynamics 365 stores the organization ID (OrgID) for the synchronizing organization and the last time the user synced in Exchange.  

For example: Your user record may exist in a Dynamics 365 organization used for production usage and your company may also have another organization used for something else such as training, testing, or development. Your Exchange mailbox can only be configured to use Server-Side Synchronization with one of the organizations.  

## Resolution

When you select the **Test & Enable Mailbox** button, the dialog box will include a checkbox labeled **Sync items with Exchange from this Dynamics 365 org only, even if Exchange was set to sync with a different Organization**. Using this option will overwrite the setting stored in Exchange if you want to change the primary synchronizing organization.

## More information

For more information about the option to Sync items with Exchange from this Dynamics 365 org only, even if Exchange was set to sync with a different Organization, see [When would I want to use this check box?](/power-platform/admin/when-would-want-use-check-box).
