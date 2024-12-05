---
title: UnknownIncomingEmailIntegrationError appears in server-side synchronization
description: Solves the UnknownIncomingEmailIntegrationError that occurs in a Microsoft Dynamics 365 mailbox record.
ms.reviewer: 
ms.date: 12/05/2024
ms.custom: sap:Email and Exchange Synchronization
---
# UnknownIncomingEmailIntegrationError appears in mailbox alerts in Microsoft Dynamics 365

This article provides a solution to an error that occurs within mailbox alerts in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471762

## Symptoms

When [viewing the alerts section](/power-platform/admin/monitor-email-processing-errors#view-alerts) within a mailbox record in Dynamics 365, you see one of the following messages:

- > "An unknown error occurred while receiving email through the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try to receive email again later.
    >
    > **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220891 exception."

- > "An unknown error occurred while receiving email through the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try to receive email again later.
    >
    > **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220956 exception."

- > "An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks for the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try again later.
    >
    > **Email Server Error Code:**  Crm.80040265.ISV code aborted the operation."

## Cause

The error code indicates an IsvUnexpected error. It typically indicates that a custom plugin or workflow throws an error and causing the creation of the item to fail.

## Resolution

To solve this issue, check if any custom plugins or workflows are running synchronously when creating the record type (email, appointment, contact, or task) mentioned in the error. If a plugin or workflow is causing an error during record creation, server-side synchronization can't create the record successfully.

The following steps use the example of an email record that fails to be created. If you see this error logged for another type of item such as an appointment, contact, or task, the same type of steps can be applied by replacing references to email with the type of record you're troubleshooting.

### Workflow

1. In the Dynamics 365 web application, navigate to **Settings** and then select **Processes**.
2. Change the view to **Activated Processes**.
3. Sort on the **Primary Entity** column and look for any rows with **Email** as the primary entity and **Workflow** as the category.

    Instead, you can use the filtering options in the grid to filter on **Category = Workflow** and **Primary Entity = Email**.

4. Open each workflow you find that meets the preceding criteria (if any).
5. If the **Start when** options have the **Record is created** option selected, and the **Run this workflow in the background (recommended)** option isn't selected, this workflow might be the cause.

    > [!NOTE]
    > If you're troubleshooting this type of error with an Appointment, Contact, or Task, also check if the workflow is configured to run during update of that type of record.

6. Select the **Process Sessions** section on the left side of the page and look for any failures related to the email that wasn't created successfully.

### Plugin

1. In the Dynamics 365 web application, navigate to **Settings** > **Customizations**, and then select **Customize the System**.
2. Select **Sdk Message Processing Steps**.
3. Sort on the **Primary Object Type Code (SdkMessage Filter)** column and look for any rows for the **Email** entity.
4. If you find any rows and the **Execution Mode** is **Synchronous**, it might interfere with the email creation.

If the issue reproduces consistently and it's possible to temporarily disable the workflow or plugin as a test, you can determine if the workflow or plugin is the cause.

## Other email server error codes

|Email Server Error Code|Cause|Resolution|
|--|--|--|
|-2147220970|This warning may appear if Server-Side Synchronization attempted to retrieve emails but encountered an unexpected error. This is typically a temporary issue and the emails will be retrieved successfully on the next synchronization cycle (typically 15 minutes).|If this message does not persist on the next synchronization cycle (typically 15 minutes), this warning can be ignored. If this message persists, you can contact Microsoft Support.|
|-2147218677|This error occurs if there was an invalid email address included on the To or Cc line of the email.|Review the email message that encountered this error and verify all email addresses on the To and Cc lines are [valid email addresses](https://tools.ietf.org/html/rfc5322#section-3.4.1).|
|-2147220192|Error -2147220192 indicates the owner of the queue does not have sufficient privileges to work with the queue. The user is likely missing sufficient Read access to the Queue entity.|Verify the user's Microsoft Dynamics 365 security role has Read access to the Queue entity. Within a Microsoft Dynamics 365 security role, privileges for the Queue entity are located on the Core Records tab. <br> **NOTE**: If you verify the owner of the mailbox record has Read access to the Queue entity, check if there are other Microsoft Dynamics 365 users or queues that received the same email. You may need to verify privileges for those users as well.|
|-2147167669|This warning is logged if the owner of the mailbox record does not have a Microsoft Dynamics 365 license assigned.|Verify the owner of the mailbox has a Microsoft Dynamics 365 license assigned.<br> **NOTE**: If you verify the user does have a license, verify there are not any other Microsoft Dynamics 365 mailbox records with the same email address. If there is another mailbox with the same email address and the owner of that mailbox does not have a license, change the email address value in the other mailbox record.|
