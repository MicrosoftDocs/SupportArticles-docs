---
title: UnknownIncomingEmailIntegrationError during server-side synchronization
description: Solves the UnknownIncomingEmailIntegrationError that's logged in a Microsoft Dynamics 365 mailbox record.
ms.reviewer: 
ms.date: 12/26/2024
ms.custom: sap:Email and Exchange Synchronization
---
# UnknownIncomingEmailIntegrationError logged in mailbox alerts in Microsoft Dynamics 365

This article provides a solution to the `UnknownIncomingEmailIntegrationError` error code that's logged in mailbox alerts in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471762

## Symptoms

When [viewing the Alerts section](/power-platform/admin/monitor-email-processing-errors#view-alerts) within a mailbox record in Dynamics 365, you might see the following message:

> An unknown error occurred while receiving email through the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try to receive email again later.
>
> **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220956 exception.

## Cause

The error code indicates an IsvUnexpected error. It typically means that a custom plugin or workflow throws an error, causing the item creation to fail.

## Resolution

To solve this issue, check if any custom plugins or workflows are running synchronously when creating the record type (email, appointment, contact, or task) mentioned in the error. If a plugin or workflow causes an error during record creation, [server-side synchronization](/power-platform/admin/server-side-synchronization) can't create the record successfully.

The following steps can help you identify any workflows or plugins in your organization running during email creation. By replacing `Entity` with the appropriate record type, these steps can also be used for other entities like appointments and tasks.

### Workflow

1. In the Dynamics 365 web application, navigate to **Settings**, and then select **Processes**.
2. Change the view to **Activated Processes**.
3. Sort on the **Primary Entity** column and look for any rows with **Email** as the primary entity and **Workflow** as the category.

    Instead, you can use the filtering options in the grid to filter on **Category = Workflow** and **Primary Entity = Email**.

4. Open each workflow you find that meets the preceding criteria (if any).
5. If the **Start when** options have the **Record is created** option selected, and the **Run this workflow in the background (recommended)** option isn't selected, this workflow might be the cause.

    > [!NOTE]
    > If you're troubleshooting this type of error with an appointment, contact, or task, also check if the workflow is configured to run during the update of that type of record.

6. Select **Process Sessions** on the left side of the page and look for failures related to the email that wasn't created successfully.

### Plugin

1. In the Dynamics 365 web application, navigate to **Settings** > **Customizations**, and then select **Customize the System**.
2. Select **Sdk Message Processing Steps**.
3. Sort on the **Primary Object Type Code (SdkMessage Filter)** column and look for any rows for the **Email** entity.
4. If the **Execution Mode** in those rows is set to **Synchronous**, it might interfere with the email creation.

If you're able to reproduce the issue consistently, you can try disabling the workflow or plugin temporarily to determine if it's the cause of the problem.

## Other email server error codes

|Email server error code|Cause|Resolution|
|--|--|--|
|UnknownIncomingEmailIntegrationError -2147220970|This error might occur if [server-side synchronization](/power-platform/admin/server-side-synchronization) tries to retrieve emails but receives an unexpected error. This is typically a temporary issue, and the emails will be retrieved successfully in the next synchronization cycle (typically 15 minutes.)|<ul><li>If this message doesn't persist in the next synchronization cycle (typically 15 minutes), ignore this warning.</li> <li>If this message persists, contact Microsoft Support through the **Help + Support** experience in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/support).</li></ul>|
|UnknownIncomingEmailIntegrationError -2147218677|This error occurs if an invalid email address is included in the **To** or **Cc** line of an email.|Review the email message that received this error and verify that all email addresses in the **To** and **Cc** lines are [valid](https://tools.ietf.org/html/rfc5322#section-3.4.1).|
|UnknownIncomingEmailIntegrationError -2147220192|This error indicates the owner of the queue doesn't have sufficient privileges to work with the queue. The user might lack sufficient **Read** access to the `Queue` entity.|Verify that the user's Dynamics 365 security role has **Read** access to the `Queue` entity. Within a Dynamics 365 security role, privileges for the `Queue` entity are located on the **Core Records** tab. <br><br> **Note**: If you verify that the owner of the mailbox record has **Read** access to the `Queue` entity, check if there are other Dynamics 365 users or queues that receive the same email. You might also need to verify privileges for those users.|
|UnknownIncomingEmailIntegrationError -2147167669|This error is logged if the owner of a mailbox record doesn't have a Dynamics 365 license assigned.|Verify that the owner of the mailbox has a Dynamics 365 license assigned.<br><br> **Note**: After you verify that the user has a license, check if there are other Dynamics 365 mailbox records with the same email address. If there's another mailbox with the same email address and the owner of that mailbox doesn't have a license, change the email address value in the other mailbox record.|
