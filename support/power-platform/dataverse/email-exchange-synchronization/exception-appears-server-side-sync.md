---
title: UnknownIncomingEmailIntegrationError during server-side synchronization
description: Solves the UnknownIncomingEmailIntegrationError logged in a Microsoft Dynamics 365 mailbox record.
ms.reviewer: 
ms.date: 01/02/2025
ms.custom: sap:Email and Exchange Synchronization
---
# UnknownIncomingEmailIntegrationError logged in mailbox alerts in Microsoft Dynamics 365

This article helps you resolve the `UnknownIncomingEmailIntegrationError` error code logged in mailbox alerts in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471762, 4556408, 4551335, 4551320, 4471947, 4471980

## Symptoms

When [viewing the Alerts section](/power-platform/admin/monitor-email-processing-errors#view-alerts) within a mailbox record in Dynamics 365, you might see the following message:

> An unknown error occurred while receiving email through the mailbox "\<MailboxName>". The owner of the associated email server profile \<ProfileName> has been notified. The system will try to receive email again later.
>
> **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError \<ErrorCode> exception.

## Email server error codes

|Email server error code|Cause|Resolution|
|--|--|--|
|UnknownIncomingEmailIntegrationError -2147220956|This error code indicates an IsvUnexpected error. It typically means that a custom plugin or workflow throws an error, causing the item creation to fail.|[Check if any custom plugins or workflows are running synchronously when creating the record type (email, appointment, contact, or task) mentioned in the error](unknownincomingemailintegrationerror-2147220891.md#resolution).|
|UnknownIncomingEmailIntegrationError -2147220970|This error code might occur if [server-side synchronization](/power-platform/admin/server-side-synchronization) tries to retrieve emails but receives an unexpected error. This is typically a temporary issue, and the emails will be retrieved successfully in the next synchronization cycle (typically 15 minutes.)|<ul><li>If this message doesn't persist in the next synchronization cycle (typically 15 minutes), ignore this warning.</li> <li>If this message persists, contact Microsoft Support through the **Help + Support** experience in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/support).</li></ul>|
|UnknownIncomingEmailIntegrationError -2147218677|This error code occurs if an invalid email address is included in the **To** or **Cc** line of an email.|Review the email message that received this error and verify that all email addresses in the **To** and **Cc** lines are [valid](https://tools.ietf.org/html/rfc5322#section-3.4.1).|
|UnknownIncomingEmailIntegrationError -2147220192|This error code indicates the owner of the queue doesn't have sufficient privileges to work with the queue. The user might lack sufficient **Read** access to the `Queue` entity.|Verify that the user's Dynamics 365 security role has **Read** access to the `Queue` entity. Within a Dynamics 365 security role, privileges for the `Queue` entity are located on the **Core Records** tab. <br><br> **Note**: If you verify that the owner of the mailbox record has **Read** access to the `Queue` entity, check if there are other Dynamics 365 users or queues that receive the same email. You might also need to verify privileges for those users.|
|UnknownIncomingEmailIntegrationError -2147167669|This error code is logged if the owner of a mailbox record doesn't have a Dynamics 365 license assigned.|Verify that the owner of the mailbox has a Dynamics 365 license assigned.<br><br> **Note**: After you verify that the user has a license, check if there are other Dynamics 365 mailbox records with the same email address. If there's another mailbox with the same email address and the owner of that mailbox doesn't have a license, change the email address value in the other mailbox record.|
