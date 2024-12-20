---
title: UnknownIncomingEmailIntegrationError -2147220891 or 80040265
description: Provides a solution to an error that occurs within mailbox alerts in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/20/2024
ms.custom: sap:Email and Exchange Synchronization
---
# UnknownIncomingEmailIntegrationError -2147220891 or 80040265 appears in mailbox alerts in Microsoft Dynamics 365

This article provides a solution to an error that occurs within mailbox alerts in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4466423

## Symptoms

When [viewing the alerts section](/power-platform/admin/monitor-email-processing-errors#view-alerts) within a mailbox record in Dynamics 365, you see one of the following messages:

- > "An unknown error occurred while receiving email through the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try to receive email again later.
    >
    > **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220891 exception."

- > "An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks for the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try again later.
    >
    > **Email Server Error Code:**  Crm.80040265.ISV code aborted the operation."

## Cause

Error code 80040265 or -2147220891 indicates an IsvAborted error.

If you see the first message listed in the [Symptoms](#symptoms) section, it's typically caused by a workflow or custom plugin that runs when an email record is created.

If you see the second message listed in the [Symptoms](#symptoms) section, it's typically caused by a workflow or custom plugin that runs when an appointment, contact, or task record is created.

## Resolution

Check if any custom plugins or workflows are running synchronously when creating the record type (email, appointment, contact, or task) mentioned in the error. If a plugin or workflow is causing an error during record creation, server-side synchronization can't create the record successfully. The following steps can help you identify if there are any workflows or plugins in your organization that run during the creation of an email. Use the same steps for other entities like appointments and tasks by replacing the Entity with the appropriate record type.

### Workflow

1. In the Dynamics 365 web application, navigate to **Settings**, and then select **Processes**.
2. Change the view to **Activated Processes**.
3. Sort on the **Primary Entity** column and look for any rows with **Email** as the primary entity and **Workflow** as the category.

    Instead, you can use the filtering options in the grid to filter on **Category = Workflow** and **Primary Entity = Email**.

4. Open each workflow you find that meets the preceding criteria (if any).
5. If the **Start when** options have the **Record is created** option selected, and the **Run this workflow in the background (recommended)** option isn't selected, this workflow might be the cause.
6. Select the **Process Sessions** section on the left side of the page and look for any failures related to the email that wasn't created successfully.

### Plugin

1. In the Dynamics 365 web application, navigate to **Settings** > **Customizations**, and then select **Customize the System**.
2. Select **Sdk Message Processing Steps**.
3. Sort on the **Primary Object Type Code (SdkMessage Filter)** column and look for any rows for the **Email** entity.
4. If the **Execution Mode** in those rows is set to **Synchronous**, it might interfere with the email creation.

If you're able to reproduce the issue consistently, you can try disabling the workflow or plugin temporarily to determine if the workflow or plugin is the cause of the problem.
