---
title: Exception appears within Server-Side Sync
description: Provides a solution to UnknownIncomingEmailIntegrationError that occurs within a Microsoft Dynamics 365 mailbox record.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# UnknownIncomingEmailIntegrationError -2147220956 exception appears within Server-Side Synchronization alert in Microsoft Dynamics 365

This article provides a solution to an error that occurs within a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471762

## Symptoms

A warning level alert like the following message appears within a Dynamics 365 mailbox record:

> "An unknown error occurred while receiving email through the mailbox "[Mailbox Name] ". The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.
>
> **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220956 exception."

## Cause

Error code -2147220956 indicates an IsvUnexpected error. Which typically indicates a custom plug-in or workflow is throwing an error and causing the creation of the item to fail.

## Resolution

The following steps use the example of an email record that is failing to be created. If you're seeing this error logged for another type of item such as an Appointment, Contact, or Task, the same type of steps can be applied by replacing references to email with the type of record you're troubleshooting.

Check to see if you have any custom plugins or workflows that run synchronously on the creation of an email. If a plugin or workflow is causing an error, Server-Side Synchronization won't create the email. The steps below can help you identify if there are any workflows or plugins in your organization that run during creation of an email:

### Workflow

1. Within the Dynamics 365 web application, navigate to **Settings** and then select **Processes**.
2. Change the view to **Activated Processes**.
3. Sort on the **Primary Entity** column and look for any rows with **Email** as the primary entity and **Workflow** as the category.

    Instead, you can use the filtering options in the grid to filter on Category = Workflow and Primary Entity = Email
4. Open each workflow you find that meets the criteria above (if any).
5. If the **Start when** options have the **Record is created** option is selected, and the **Run this workflow in the background (recommended)** option isn't selected, this workflow could potentially be the cause.

    > [!NOTE]
    > If you're troubleshooting this type of error with an Appointment, Contact, or Task, also check if the workflow is configured to run during update of that type of record.

6. Select the **Process Sessions** section on the left side of the page and look for any failures related to the email that wasn't created successfully.

### Plugins

1. Within the Dynamics 365 web application, navigate to **Settings,** **Customizations,** and then select **Customize the System**.
2. Select **Sdk Message Processing Steps**.
3. Sort on the **Primary Object Type Code (SdkMessage Filter)** column and look for any rows for the Email entity.
4. If you find any rows and the Execution Mode is Synchronous, it could potentially be interfering with the creation of the email.

If the issue reproduces consistently and it's possible to temporarily disable the workflow or plugin as a test, which can allow you to determine if the workflow or plugin is the cause.
