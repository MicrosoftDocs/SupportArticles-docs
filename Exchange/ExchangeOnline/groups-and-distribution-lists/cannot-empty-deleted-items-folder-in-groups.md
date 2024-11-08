---
title: Can't empty Deleted Items folder in Microsoft 365 Groups
description: Resolves an issue in which you can't empty the Deleted Items folder in Microsoft 365 Groups.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
  - CI 171106
ms.reviewer: batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Can't empty Deleted Items folder in Microsoft 365 Groups

## Symptoms

You want to empty the Deleted Items folder for a group in Microsoft 365 Groups. However, the Deleted Items folder is missing in Microsoft Outlook and Outlook on the web.

## Cause

Outlook on the web doesn't show the built-in Microsoft 365 Groups folders, such as the Deleted Items folder, unless one or more user-created folders exist. You can't use the classic Outlook for Windows to view Microsoft 365 Groups folders.

## Resolution

To empty the Deleted Items folder, use one of the following methods.

Your choice of method might depend on the size of the Deleted Items folder. For example, if a Microsoft 365 group mailbox reaches the [default storage quota](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#storage-limits), and the Deleted Items folder is large, you might prefer Method 1 for a quick resolution. To determine how much of the group mailbox storage quota is occupied by the Deleted Items folder, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Get folder size information for the group mailbox by using the [Get-EXOMailboxFolderStatistics](/powershell/module/exchange/get-exomailboxfolderstatistics) cmdlet:

   ```powershell
   Get-EXOMailboxFolderStatistics -Identity "<group name>" -FolderScope NonIPMRoot | Where { $_.TargetQuota -like 'User' } | FT Name,FolderType,FolderAndSubfolderSize
   ```

## Method 1: Use Outlook on the web or the new Outlook for Windows

Create a Microsoft 365 group subfolder to access the Deleted Items folder. Follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following command to check whether folder creation is enabled:

   ```powershell
   Get-OrganizationConfig | FL IsGroupFoldersAndRulesEnabled
   ```

   If folder creation isn't enabled, run the following command to enable it:

   ```powershell
   Set-OrganizationConfig -IsGroupFoldersAndRulesEnabled $True
   ```

3. Sign in to Outlook on the web by using the *owner* credentials for the group, or open the new Outlook for Windows.

4. Locate the group under **Groups**.

5. Right-click the group, select **Create new subfolder**, enter any name for the folder, and then select **OK**.

   > [!NOTE]
   > If the **Create new subfolder** option is unavailable, check whether you used the group owner credentials to sign in to Outlook on the web. If you aren't an owner of the group, contact an owner for support to resolve this issue. Group owners can [grant permission](/microsoft-365/enterprise/manage-folders-and-rules-feature#enable-member-permission-option) for group members to create folders, rename folders, and delete messages.

6. After the built-in Deleted Items folder appears, select the folder, select **Select all messages** at the top of the message list, and then select **Empty folder**.

## Method 2: Use a retention policy or retention label policy

This method offers a long-term solution for management of the Deleted Items folder.

1. Create rules to manage retention and deletion of messages in the Deleted Items folder. Choose one of the following options:

   - Create a [retention label policy](/microsoft-365/compliance/retention#retention-labels-and-policies-that-apply-them), either in the [Microsoft Purview compliance portal](https://compliance.microsoft.com) or by using the [New-RetentionCompliancePolicy](/powershell/module/exchange/new-retentioncompliancepolicy), [New-ComplianceTag](/powershell/module/exchange/new-compliancetag), and [New-RetentionComplianceRule](/powershell/module/exchange/new-retentioncompliancerule) Exchange Online PowerShell cmdlets. You can apply this kind of policy to a specific folder or the entire mailbox.

   - Create a [messaging records management (MRM) retention policy](/exchange/security-and-compliance/messaging-records-management/create-a-retention-policy), either in the Microsoft Purview compliance portal or by using the [New-RetentionPolicyTag](/powershell/module/exchange/new-retentionpolicytag) and [New-RetentionPolicy](/powershell/module/exchange/new-retentionpolicy) Exchange Online PowerShell cmdlets. You can apply this kind of policy to a specific folder or the entire mailbox.

   - Create a [retention policy](/microsoft-365/compliance/retention#retention-policies), either in the Microsoft Purview compliance portal or by using the [New-RetentionCompliancePolicy](/powershell/module/exchange/new-retentioncompliancepolicy) and [New-RetentionComplianceRule](/powershell/module/exchange/new-retentioncompliancerule) Exchange Online PowerShell cmdlets. You can apply this kind of policy only to the entire mailbox.

   > [!NOTE]
   > Microsoft Purview can take up to one day to distribute a retention policy to a mailbox location. For more information about retention policy distribution, see [How long it takes for retention policies to take effect](/microsoft-365/compliance/create-retention-policies#how-long-it-takes-for-retention-policies-to-take-effect).

2. After Microsoft Purview distributes the retention policy, force the [Managed Folder Assistant](/exchange/policy-and-compliance/mrm/configure-managed-folder-assistant#use-the-exchange-management-shell-to-start-the-managed-folder-assistant-on-a-specific-mailbox) (MFA) to apply your retention policy on the specified mailbox. To do this, run the following command:

   ```powershell
   Start-ManagedFolderAssistant -Identity "<group name>"
   ```

   > [!NOTE]
   > The MFA typically processes mailboxes on a schedule. Scheduled mailbox processing can take a few days to finish. However, the [Start-ManagedFolderAssistant](/powershell/module/exchange/start-managedfolderassistant) cmdlet forces the MFA to immediately start processing the specified mailbox to expedite your retention policy.

3. Wait for the MFA to finish. To check whether the MFA has finished processing the mailbox, run the following commands:

   ```powershell
   $log=Export-MailboxDiagnosticLogs "<group name>" -ExtendedProperties
   $xml=[xml]($Log.MailboxLog)
   $xml.Properties.MailboxTable.Property | ?{$_.Name -like "ELC*"}
   ```

   If the MFA successfully finished processing the mailbox, the `ELCLastSuccessTimestamp` property has a timestamp value that's later than when you triggered the MFA.

   If you encounter any issues:

   - Check the mailbox settings that affect retention. To do this, run the following command:

     ```powershell
     Get-Mailbox -GroupMailbox "<group name>" | FL ELCProcessingDisabled,Retention*
     ```

     Verify the following property values:

     - `RetentionPolicy` should be the name of the retention policy that you created in step 1.

     - `RetentionHoldEnabled` should be `False`.

     - `ELCProcessingDisabled` should be `False`.

   - Check whether the MFA encountered any errors while processing the mailbox. To do this, run the following command to get the mailbox diagnostics log:

     ```powershell
     Export-MailboxDiagnosticLogs -Identity "<group name>" -ComponentName MRM
     ```

     Entries for the most recent errors are at the top of the log.

   For more information about the MFA and how to troubleshoot retention, see [Resolve email archive and deletion issues when using retention policies](/microsoft-365/troubleshoot/retention/troubleshoot-mrm-email-archive-deletion).
