---
title: Self-help diagnostics for issues in Exchange Online and Outlook
description: Provides a list of diagnostics to troubleshoot issues in Exchange Online and Outlook.
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
ms.date: 08/12/2026
---
# Self-help diagnostics for issues in Exchange Online and Outlook

## Summary

As an administrator, you need to diagnose and quickly resolve issues in Exchange Online and Outlook. Both the Microsoft 365 admin center and the Exchange admin center (EAC) provide diagnostics that you can run to troubleshoot various scenarios. While these diagnostics can't make automatic changes to your tenant without your consent, they offer insights into known issues and provide instructions to fix those issues quickly.

> [!NOTE]
> The diagnostics in the Microsoft 365 admin center aren't available for the GCC High and DoD environments, and for Microsoft 365 operated by 21Vianet. However, a subset of these diagnostics can be accessed by using Exchange Online PowerShell or the Exchange admin center (EAC). These diagnostics might be available for the GCC High and DoD environments, and for Microsoft 365 operated by 21Vianet.

## Scenarios covered by the diagnostics in the Microsoft 365 admin center

In the Microsoft 365 admin center, select **Help & support** to launch the self-help diagnostics experience. Describe the problem that you want to resolve, and the appropriate diagnostics are surfaced through text analytics of the problem description. 

Several diagnostics currently cover the various areas within Exchange Online and Outlook. Each diagnostic is listed in the following table together with a brief description of its function and shortcut command.

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
|Email delivery troubleshooter|Check whether email messages are successfully delivered.| [Run Tests: Email Delivery](https://aka.ms/PillarEmailDelivery)|[Find and fix email delivery issues](/exchange/troubleshoot/email-delivery/email-delivery-issues)|
|Outlook user connectivity diagnostics|Diagnose Outlook connectivity issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|[Run Tests: Outlook User Connectivity](https://aka.ms/PillarOutlookConnectivity)|[Fix Outlook connectivity issue](/exchange/troubleshoot/outlook-issues/outlook-connection-issues)|
|Non-delivery report (NDR) diagnostics|Provide additional information about NDRs that are received through email messages.|[Run Tests: Email NDR](https://aka.ms/PillarEmailNDR)|[Email non-delivery reports in Exchange Online](/exchange/mail-flow-best-practices/non-delivery-reports-in-exchange-online/non-delivery-reports-in-exchange-online)|
|Archive mailbox diagnostics|Check and identify issues about mailbox archiving.|[Run Tests: Archive Mailbox](https://aka.ms/PillarArchiveMailbox)|[Enable archive mailboxes in the Microsoft Purview compliance portal](/microsoft-365/compliance/enable-archive-mailboxes)|
|Outlook user password prompt diagnostics|Diagnose Outlook password prompt issues for users by running several checks on possible service-side settings (root causes) so that a tenant admin can quickly fix the issues without involving the users.|[Run Tests: Outlook Password Prompt](https://aka.ms/PillarOutlookPasswordPrompt)|[Fix Outlook password prompt issue](/outlook/troubleshoot/authentication/continually-prompts-password-office-365)|
|DomainKeys Identified Mail (DKIM) diagnostics|Validate that DKIM signing is configured correctly and the correct DNS entries have been published.|[Run Tests: DKIM](https://aka.ms/diagdkim)|[Use DKIM to validate outbound email sent from your custom domain](/microsoft-365/security/office-365-security/use-dkim-to-validate-outbound-email)|
|Compromised Account diagnostics|Identify suspicious activities against an account and return information that can be used to recover the account if compromised.|[Run Tests: Compromised Account](https://aka.ms/diagca)|[Responding to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account)|
|Email threat policies diagnostics for a recipient|List threat policies in [the built-in security features for all cloud mailboxes](/defender-office-365/eop-about) and in [Microsoft Defender for Office 365](/defender-office-365/mdo-about) that apply to a received message or a recipient, and identify the inbound connector used for the message. | [Run Tests: Email Threat Policies](https://aka.ms/mdopolicy)|[Order and precedence of email protection](/defender-office-365/how-policies-and-protections-are-combined)|
|Proxy address conflict diagnostics|Find the Exchange recipient that uses an email address. Helpful if you receive an "Email/proxy address is in use" or similar error message when you try to create an Exchange Online mailbox. | [Run Tests: Proxy address in use](https://aka.ms/PillarProxyInUse) | [Proxy address conflict when adding an email address in Exchange Online](/exchange/troubleshoot/email-alias/proxy-address-being-used) |
|Mailbox safe/blocked sender list diagnostics|Check and identify issues with the mailbox's safe senders and domains, blocked sender and domains in junk email settings.|[Run Tests: Mailbox Safe Blocked Sender List](https://aka.ms/safeblockdiag)| [Configure junk email settings on Exchange Online mailboxes](/defender-office-365/configure-junk-email-settings-on-exo-mailboxes)|
|Tenant threat policies health check|Check for coverage gaps related to Safe Links, Safe Attachments, Zero-hour auto purge (ZAP), and Enhanced Filtering configuration.|[Run Tests: Tenant Health Check](https://aka.ms/thc)| [Tune Microsoft Defender for Office 365](/defender-office-365/step-by-step-guides/tune-microsoft-defender-for-office-365)|
| Blocked Sender History | View the detailed listing and delisting history for a sender, along with their MFA status. Useful when investigating why Defender for Office 365 restricted a sender. | [Run Tests: Sender History](https://aka.ms/senderhistory) | [Remove blocked users from the Restricted entities page](/defender-office-365/outbound-spam-restore-restricted-users) |

## Scenarios covered by the diagnostics in the EAC

In the EAC, select **Troubleshoot** > **Diagnostics** to see a list of available diagnostics. The diagnostics listed in the following table are available both in the EAC and in Exchange Online PowerShell.

|Diagnostic|Description|In Exchange Online PowerShell|
|---|---|---|
|[Accepted Domain](https://admin.exchange.microsoft.com/#/troubleshoot/diagnostics)| Investigate and resolve accepted domain setup and validation issues that can affect mail flow.|[Invoke-ProvisioningAcceptedDomainDiagnostic](/powershell/module/exchangepowershell/invoke-provisioningaccepteddomaindiagnostic)|
|[Company Object](https://admin.exchange.microsoft.com/#/troubleshoot/diagnostics)|Review and resolve tenant-level company object provisioning when organization settings are not applied as expected.|[Invoke-ProvisioningCompanyObjectDiagnostic](/powershell/module/exchangepowershell/invoke-provisioningcompanyobjectdiagnostic)|
|[RBAC User Compare](https://admin.exchange.microsoft.com/#/troubleshoot/diagnostics)|Compare RBAC assignments between users and identify permission differences.|[Invoke-ProvisioningVerifyRbacDiagnostic](/powershell/module/exchangepowershell/invoke-provisioningverifyrbacdiagnostic)|
|[Recipient](https://admin.exchange.microsoft.com/#/troubleshoot/diagnostics)|Troubleshoot and resolve recipient provisioning problems for a specific mailbox, contact, or group identity.|[Invoke-ProvisioningRecipientDiagnostic](/powershell/module/exchangepowershell/invoke-provisioningrecipientdiagnostic)|
|[Verify RBAC](https://admin.exchange.microsoft.com/#/troubleshoot/diagnostics)|Validate RBAC access for a cmdlet and understand why a user can or can't run it.|[Invoke-ProvisioningVerifyRbacDiagnostic](/powershell/module/exchangepowershell/invoke-provisioningverifyrbacdiagnostic)|
