---
title: Error when you send tracked email message to another user
description: This article provides a resolution for the problem that occurs when you attempt to send a tracked email message by using the Microsoft CRM 2011 for Outlook client to another CRM user.
ms.reviewer: jowells
ms.topic: troubleshooting
ms.date: 
---
# Error message when attempting to send tracked email message to another user in Microsoft Dynamics CRM 2011

This article helps you the problem that occurs when you attempt to send a tracked email message by using the Microsoft CRM 2011 for Outlook client to another CRM user.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2639569

## Symptoms

You may receive an error message when attempting to send a tracked email message using the Microsoft Dynamics CRM 2011 for Outlook client to another Microsoft Dynamics CRM user:

> The owner of this queue does not have sufficient privileges to work with the queue. Do you want to send the e-mail? If you click Yes, the e-mail will be sent out, but no corresponding activity will be created in Microsoft Dynamics CRM

## Cause

This is caused due to the user that is in the recipient line of the email message not having the privReadQueue permission applied to their security role.

## Resolution

To resolve the error message, apply the privReadQueue permission to any user in CRM that may receive tracked email messages.

1. In the CRM web client, click **Settings**, click **Administration**, click **Users**.
2. Select the user that needs to be updated and click **Edit**.
3. Click to select **Security Roles**.
4. Click to open the appropriate **Security Role**.
5. Click **Core Records** tab to see the details.
6. Find Queue in the list and apply Read permissions by clicking the circle in the appropriate column. At a miminum user level permission is required.
7. Click **Save** and **Close**.

By adjusting the Security Role for a user, it will also apply the change to all users that have the same Security Role applied to their user account

Each click will increment the security level until it is at Organization level (full green), clicking beyond that point will return the security level to none
