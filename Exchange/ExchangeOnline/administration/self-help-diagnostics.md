---
title: Self-help diagnostics for issues in Exchange Online and Outlook
description: Lists diagnostics to troubleshoot issues in Exchange Online and Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CI 148463
  - CSSTroubleshoot
ms.reviewer: mhaque, ninob
appliesto: 
  - Exchange Online
  - Outlook
search.appverid: MET150
ms.date: 01/23/2025
---
# Self-help diagnostics for issues in Exchange Online and Outlook

It's vital that administrators be able to diagnose and resolve issues quickly in Exchange Online and Outlook. To support this effort, the Exchange and Outlook support teams have released some new features in the Microsoft 365 admin center.

Currently, we provide diagnostics through text analytics. It's important to note that while these diagnostics can't make automatic changes to your tenant without your consent, they do offer insights into known issues, and provide instructions to fix those issues quickly. We also want to make it easier for you to find our diagnostics within the current experience. Therefore, we have created a new set of queries to help administrators.

> [!NOTE]
> These diagnostics aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

|Example for an Exchange Online issue|Example for an Outlook issue|
|----------|----------|
|:::image type="content" source="media/self-help-diagnostics/diagnostics-exchange.png" alt-text="Screenshot of the diagnostics for an Exchange Online issue.":::|:::image type="content" source="media/self-help-diagnostics/diagnostics-outlook.png" alt-text="Screenshot of the diagnostics for an Outlook issue.":::|

When IT admins run customer diagnostics in the Microsoft 365 admin center to resolve issues without logging support requests, Microsoft will make donations to global nonprofit organizations.

For more information, see [Diagnostics for Social Good](https://aka.ms/DiagnosticsforSocialGood).

## What scenarios are currently covered?

Several diagnostics currently cover the various areas within Exchange Online and Outlook. Each diagnostic is listed below together with a brief description of its function and shortcut command.

|Diagnostic|Description|Shortcut Link|Support article|
|---|---|---|---|
|Migration Exchange Web Services (EWS) throttling policy|Verify that the EWS throttling policy isn't too restrictive for a mailbox data migration that uses third-party tools. (Doesn't apply to Microsoft tools for Hybrid, IMAP, G Suite, or Public Folder migrations.)|[Run Tests: EWS Throttling](https://aka.ms/PillarEWSThrottling)||
|Exchange Online Accepted Domain diagnostics|Check if a domain is correctly configured as an Exchange Online accepted domain.|[Run Tests: Exchange accepted domains](https://aka.ms/EXOAcceptedDomain)|["You can't use the domain because it's not an accepted domain for your organization" error](/exchange/troubleshoot/move-or-migrate-mailboxes/issue-with-add-recipientpermission-cmdlet)|
|Test a user's Exchange Online RBAC permissions|If a user has issues running a specific PowerShell cmdlet or command, or gets an error indicating that they don't have the correct roles or permissions, run this diagnostic to check whether the user has permissions to run the cmdlet and the specific parameter.|[Run Tests: EXO RBAC test user](https://aka.ms/PillarEXORBACTest)||
|Compare Exchange Online RBAC permissions for two users|If one user has issues running a specific PowerShell cmdlet or command, or gets an error indicating that they don't have the correct roles or permissions, while another user doesn't have these problems, run this diagnostic to compare the RBAC roles of the two users.|[Run Tests: EXO RBAC compare users](https://aka.ms/PillarEXORBACCompare)||
|Recipient failure|Check the state of an Exchange Online recipient and resolve common issues.|[Run Tests: EXO Recipient Object Failures](https://aka.ms/PillarEXORecipients)|[Delays in provisioning of user/mailbox or synchronizing changes in Exchange Online](/exchange/troubleshoot/user-and-shared-mailboxes/delays-provision-mailbox-sync-changes)|
|Exchange Organization Object check|Check health and resolve issues related to your Exchange Online organization object. For example, Exchange Online tenant provisioning or RBAC-related issues (various commands aren't available even though users have permissions).|[Run Tests: Exchange organization object](https://aka.ms/PillarEXOOrgCheck)||
|Mailbox or message size|Check the size of a mailbox or the size of messages (including attachments).|[Run Tests: Mailbox Size](https://aka.ms/PillarMailboxSize)|[Increase or customize Exchange Online mailbox size](/exchange/troubleshoot/user-and-shared-mailboxes/increase-or-customize-mailbox-size)|
|Deleted mailbox diagnostics|Check the state of recently deleted mailboxes.|[Run Tests: Deleted Mailbox](https://aka.ms/PillarDeletedMailBox)|[Delete or restore user mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/delete-or-restore-mailboxes)|
|Exchange Remote PowerShell throttling policy|Update the Exchange Remote PowerShell throttling policy for the tenant.|[Run Tests: PowerShell Throttling](https://aka.ms/PillarEXOPSThrottle)||
|Email delivery troubleshooter|Check whether email messages are successfully delivered.| [Run Tests: Email Delivery](https://aka.ms/PillarEmailDelivery)|[Find and fix email delivery issues](/exchange/troubleshoot/email-delivery/email-delivery-issues)|
|Outlook user connectivity diagnostics|Diagnose Outlook connectivity issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|[Run Tests: Outlook User Connectivity](https://aka.ms/PillarOutlookConnectivity)|[Fix Outlook connectivity issue](/exchange/troubleshoot/outlook-issues/outlook-connection-issues)|
|Non-delivery report (NDR) diagnostics|Provide additional information about NDRs that are received through email messages.|[Run Tests: Email NDR](https://aka.ms/PillarEmailNDR)|[Email non-delivery reports in Exchange Online](/exchange/mail-flow-best-practices/non-delivery-reports-in-exchange-online/non-delivery-reports-in-exchange-online)|
|Archive mailbox diagnostics|Check and identify issues about mailbox archiving.|[Run Tests: Archive Mailbox](https://aka.ms/PillarArchiveMailbox)|[Enable archive mailboxes in the Microsoft Purview compliance portal](/microsoft-365/compliance/enable-archive-mailboxes)|
|Outlook user password prompt diagnostics|Diagnose Outlook password prompt issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|[Run Tests: Outlook Password Prompt](https://aka.ms/PillarOutlookPasswordPrompt)|[Fix Outlook password prompt issue](/outlook/troubleshoot/authentication/continually-prompts-password-office-365)|
|Retention policy diagnostics for a user mailbox|Check retention policy settings on a user mailbox.|[Run Tests: Retention Policy on a user mailbox](https://aka.ms/PillarRetentionPolicy)|[Retention tags and retention policies in Exchange Online](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies)|
|DomainKeys Identified Mail (DKIM) diagnostics|Validate that DKIM signing is configured correctly and the correct DNS entries have been published.|[Run Tests: DKIM](https://aka.ms/diagdkim)|[Use DKIM to validate outbound email sent from your custom domain](/microsoft-365/security/office-365-security/use-dkim-to-validate-outbound-email)|
|Compromised Account diagnostics|Identify suspicious activities against an account and return information that can be used to recover the account if compromised.|[Run Tests: Compromised Account](https://aka.ms/diagca)|[Responding to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account)|
|Email threat policies diagnostics for a recipient|List EOP/MDO threat policies and the inbound connector used for a received message.|[Run Tests: Email Threat Policies](https://aka.ms/diagmdopolicy)|[Order and precedence of email protection](/defender-office-365/how-policies-and-protections-are-combined)|
|Proxy address conflict diagnostics|Find the Exchange recipient that uses an email address. Helpful if you receive an "Email/proxy address is in use" or similar error message when you try to create an Exchange Online mailbox. | [Run Tests: Proxy address in use](https://aka.ms/PillarProxyInUse) | [Proxy address conflict when adding an email address in Exchange Online](/exchange/troubleshoot/email-alias/proxy-address-being-used) |
|Mailbox safe/blocked sender list diagnostics|Check and identify issues with the mailbox's safe senders and domains, blocked sender and domains in junk email settings.|[Run Tests: Mailbox Safe Blocked Sender List](https://aka.ms/safeblockdiag)| [Configure junk email settings on Exchange Online mailboxes](/defender-office-365/configure-junk-email-settings-on-exo-mailboxes)|

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
