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

|Example for an Exchange Online issue|Example for an Outlook issue|
|----------|----------|
|:::image type="content" source="media/self-help-diagnostics/diagnostics-exchange.png" alt-text="Screenshot of the diagnostics for an Exchange Online issue.":::|:::image type="content" source="media/self-help-diagnostics/diagnostics-outlook.png" alt-text="Screenshot of the diagnostics for an Outlook issue.":::|

## What scenarios are currently covered?

Several diagnostics currently cover the various areas within Exchange Online and Outlook. Each diagnostic is listed below together with a brief description of its function and shortcut command.

|Diagnostic|Description|Shortcut Link|Support article|
|---|---|---|---|
|Migration Exchange Web Services (EWS) throttling policy|Verify that the EWS throttling policy isn't too restrictive for a mailbox data migration that uses third-party tools. (Doesn't apply to Microsoft tools for Hybrid, IMAP, G Suite, or Public Folder migrations.)|[Run Tests: EWS Throttling](https://aka.ms/PillarEWSThrottling)||
|Mailbox or message size|Check the size of a mailbox or the size of messages (including attachments).|[Run Tests: Mailbox Size](https://aka.ms/PillarMailboxSize)||
|Deleted mailbox diagnostics|Check the state of recently deleted mailboxes.|[Run Tests: Deleted Mailbox](https://aka.ms/PillarDeletedMailBox)|[Delete or restore user mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/delete-or-restore-mailboxes)|
|Exchange Remote PowerShell throttling policy|Update the Exchange Remote PowerShell throttling policy for the tenant.|[Run Tests: PowerShell Throttling](https://aka.ms/PillarEXOPSThrottle)||
|Email delivery troubleshooter|Check whether email messages are successfully delivered.| [Run Tests: Email Delivery](https://aka.ms/PillarEmailDelivery)|[Find and fix email delivery issues](https://docs.microsoft.com/exchange/troubleshoot/email-delivery/email-delivery-issues)|
|Outlook user connectivity diagnostics|Diagnose Outlook connectivity issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|[Run Tests: Outlook User Connectivity](https://aka.ms/PillarOutlookConnectivity)|[About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)|
|Non-delivery report (NDR) diagnostics|Provide additional information about NDRs that are received through email messages.|[Run Tests: Email NDR](https://aka.ms/PillarEmailNDR)|[Email non-delivery reports in Exchange Online](https://docs.microsoft.com/exchange/mail-flow-best-practices/non-delivery-reports-in-exchange-online/non-delivery-reports-in-exchange-online)|
|Archive mailbox diagnostics|Check and identify issues about mailbox archiving.|[Run Tests: Archive Mailbox](https://aka.ms/PillarArchiveMailbox)|[Enable archive mailboxes in the Microsoft 365 compliance center](/microsoft-365/compliance/enable-archive-mailboxes)|
|Outlook user password prompt diagnostics|Diagnose Outlook password prompt issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|[Run Tests: Outlook Password Prompt](https://aka.ms/PillarOutlookPasswordPrompt)|[About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)|
|Retention policy diagnostics|Check retention policy settings.|[Run Tests: Retention Policy](https://aka.ms/PillarRetentionPolicy)||
|Enable Basic authentication in Exchange Online|Enable Basic authentication for legacy protocols in Exchange Online if previously disabled by Microsoft, or opt out of the disabling process if there is a need to use Basic authentication with specific legacy protocols.|[Run Tests: Basic Auth in EXO](https://aka.ms/PillarEXOBasicAuth)|[Basic Authentication and Exchange Online – June 2021 Update](https://techcommunity.microsoft.com/t5/exchange-team-blog/basic-authentication-and-exchange-online-june-2021-update/ba-p/2454827)|
|DomainKeys Identified Mail (DKIM) diagnostics|Validate that DKIM signing is configured correctly and the correct DNS entries have been published.|[Run Tests: DKIM](https://aka.ms/diagdkim)|[Use DKIM to validate outbound email sent from your custom domain](/microsoft-365/security/office-365-security/use-dkim-to-validate-outbound-email)|
|||||

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
