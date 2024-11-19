---
title: UnknownIncomingEmailIntegrationError -2147220891
description: Provides a solution to an error that occurs within mailbox alerts in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# UnknownIncomingEmailIntegrationError -2147220891 exception error appears within mailbox alerts in Microsoft Dynamics 365

This article provides a solution to an error that occurs within mailbox alerts in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4466423

## Symptoms

When viewing the alerts section within a mailbox record in Dynamics 365, you see one of the following messages:

- > "An unknown error occurred while receiving email through the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try to receive email again later.
    >
    > **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220891 exception."

- > "An internal Microsoft Dynamics 365 error occurred while synchronizing appointments, contacts, and tasks for the mailbox "\<Mailbox Name>". The owner of the associated email server profile \<Profile Name> has been notified. The system will try again later.
    >
    > **Email Server Error Code:**  Crm.80040265.ISV code aborted the operation."

## Cause

Error code 80040265 and -2147220891 indicates an IsvAborted error.

If you see the first message listed in the [Symptoms](#symptoms) section, it's typically caused by a workflow or custom plugin that runs on the creation of an email record.

If you see the second message listed in the [Symptoms](#symptoms) section, it's typically caused by a workflow or custom plugin that runs on the creation of an appointment, contact, or task record.

## Resolution

Check to see if you have any custom plugins or workflows that run synchronously on the creation of the record type mentioned in the error (ex. email, appointment, contact, or task). If a plugin or workflow is causing an error during the creation of the record, Server-Side Synchronization can't create the record successfully. The steps below can help you identify if there are any workflows or plugins in your organization that run during creation of an email. The same steps can be used for other entities like appointment if it's the record type that is failing to be created:  

### Workflow

1. Within the Dynamics 365 web application, navigate to **Settings** and then select **Processes**.
2. Change the view to **Activated Processes**.
3. Sort on the **Primary Entity** column and look for any rows with **Email** as the primary entity and **Workflow** as the category.

    Instead, you can use the filtering options in the grid to filter on **Category = Workflow** and **Primary Entity = Email**

4. Open each workflow you find that meets the criteria above (if any).
5. If the **Start when** options have the **Record is created** option is selected, and the **Run this workflow in the background (recommended)** option isn't selected, this workflow could potentially be the cause.
6. Select the **Process Sessions** section on the left side of the page and look for any failures related to the email that wasn't created successfully.

### Plugins

1. Within the Dynamics 365 web application, navigate to **Settings**, **Customizations**, and then select **Customize the System**.
2. Select **Sdk Message Processing Steps**.
3. Sort on the **Primary Object Type Code (SdkMessage Filter)** column and look for any rows for the Email entity.
4. If you find any rows and the Execution Mode is Synchronous, it could potentially be interfering with the creation of the email.

If the issue reproduces consistently and it's possible to temporarily disable the workflow or plugin as a test, it can allow you to determine if the workflow or plugin is the cause.
