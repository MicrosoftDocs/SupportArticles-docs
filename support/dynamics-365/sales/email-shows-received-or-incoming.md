---
title: Email shows as Received/Incoming
description: Email sent from Outlook with CRM for Outlook client installed, shows as Received/Incoming when using Server-Side Sync in Microsoft Dynamics CRM 2013.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Email sent from Outlook with CRM for Outlook client installed, shows as Received/Incoming when using Server-Side Sync in Microsoft Dynamics CRM 2013

This article provides a solution to an issue where Email shows as Received/Incoming that are sent from Outlook with CRM for Outlook client installed.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2979346

## Symptoms

Email sent from Outlook with CRM for Outlook client installed, shows as Received/Incoming when using Server-Side Sync in Microsoft Dynamics CRM 2013

## Cause

Server-Side Synchronization processes all folders of the users' email and promotes them as received emails (direction code of incoming). It includes tracked items sent from Outlook that stay in the Sent folder on Exchange. It has been identified as product limitation in Microsoft Dynamics CRM 2013.

## Resolution

There are a few options to work around this issue.

Option 1:

Use the CRM for Outlook Client or Email Router for the Incoming and Outgoing email access type for these users

Option 2:

Set the OrgDbOrgSettings SendEmailSynchronously setting to 1 and restart the Outlook clients. This setting forces the email promotion to occur at the time the email is sent. For more information about changing this value, see [OrgDBOrgSettings tool for Microsoft Dynamics CRM](https://support.microsoft.com/help/2691237).

## More information

It's being reviewed and will be changed in a future release of Microsoft Dynamics CRM.
