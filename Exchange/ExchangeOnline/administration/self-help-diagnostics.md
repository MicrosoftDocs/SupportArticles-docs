---
title: Self-help diagnostics for issues in Exchange Online and Outlook
description: Lists diagnostics to troubleshoot issues in Exchange Online and Outlook.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro
ms.topic: article
ms.prod: exchange-server-it-pro 
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 148463
- CSSTroubleshoot
ms.reviewer: mhaque, ninob
appliesto:
- Exchange Online
- Outlook
search.appverid: MET150
---
# Self-help diagnostics for issues in Exchange Online and Outlook

It's vital that administrators be able to diagnose and resolve issues quickly in Exchange Online and Outlook. To support this effort, the Exchange and Outlook support teams have released some new features in the Microsoft 365 admin center.

Currently, we provide diagnostics through text analytics. It's important to note that while these diagnostics can't make automatic changes to your tenant without your consent, they do offer insights into known issues, and provide instructions to fix those issues quickly. We also want to make it easier for you to find our diagnostics within the current experience. Therefore, we have created a new set of queries to help administrators.

**Note:** This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

## How do I run these diagnostics?

**Note:** You must be a Microsoft 365 administrator to run diagnostics.

1. Go to [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home).
1. In the left pane, select **Show all** > **Support** > **New service request**.
1. In the **How can we help?** text box on the right side of the screen, you can briefly describe your issue (for example, "I want to increase the mailbox size"). Then, the system determines whether a diagnostic scenario matches your issue.

    **Note:** To access a specific diagnostic, you can also enter the corresponding shortcut command from the following [table](#what-scenarios-are-currently-covered) into the **How can we help?** text box.

    When you type search terms, a type-ahead query assists you to find the topics that you're searching for. See the following examples for Exchange Online and Outlook support issues.

    |Example for an Exchange Online issue|Example for an Outlook issue|
    |---|---|
    |:::image type="content" source="media/self-help-diagnostics/diagnostics-exchange.png" alt-text="Screenshot of the diagnostics for an Exchange Online issue.":::|:::image type="content" source="media/self-help-diagnostics/diagnostics-outlook.png" alt-text="Screenshot of the diagnostics for an Outlook issue.":::|
    |||

1. Type or select the information in the required fields.
1. Select **Run Tests**.  

## What scenarios are currently covered?

Several diagnostics currently cover the various areas within Exchange Online and Outlook. Each diagnostic is listed below together with a brief description of its function and shortcut command.

|Diagnostic|Description|Shortcut cmd|Support article|
|---|---|---|---|
|Migration Exchange Web Services (EWS) throttling policy|Verify that the EWS throttling policy isn't too restrictive for a mailbox data migration that uses third-party tools. (Tools are exclusive of Microsoft tools for Hybrid, IMAP, G Suite, or Public Folder migrations.)|Diag: EWS Throttling||
|Mailbox or message size|Check the size of a mailbox or check and increase the size of messages.|Diag: Mailbox or Message Size||
|Deleted mailbox diagnostics|Check the state of recently deleted mailboxes.|Diag: Deleted Mailbox|[Delete or restore user mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/delete-or-restore-mailboxes)|
|Exchange Remote PowerShell throttling policy|Update the Exchange Remote PowerShell throttling policy for the tenant.|Diag: PS Throttling||
|Email delivery troubleshooter|Check whether email messages are successfully delivered.|Diag: Troubleshoot Email Delivery||
|Outlook user connectivity diagnostics|Diagnose Outlook connectivity issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|Diag: Outlook User Connectivity|[About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)|
|Non-delivery report (NDR) diagnostics|Provide additional information about NDRs that are received through email messages.|Diag: Email NDR||
|Archive mailbox diagnostics|Check and identify issues about mailbox archiving.|Diag: Archive Mailbox||
|Outlook user password prompt diagnostics|Diagnose Outlook password prompt issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|Diag: Outlook Password Prompt|[About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)|
|Retention policy diagnostics|Check retention policy settings.|Diag: Retention Policy||
|||||

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
