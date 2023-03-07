---
title: Troubleshoot email archive and deletion issues with MRM
description: Explores some common issues that prevent messaging records management (MRM) from correctly deleting or archiving emails in Exchange Online. It also provides steps to identify the root cause and resolve the problem.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI172536
ms.reviewer: alexaca
appliesto: 
  - Exchange Online
  - Microsoft Purview
search.appverid: MET150
ms.date: 3/7/2023
---

# Resolve email archive and deletion issues with MRM

This article explores some common issues that prevent messaging records management (MRM) from correctly deleting or archiving emails in Exchange Online. It also provides steps to identify the root cause and resolve the problem.

> [!NOTE]
>
> - These troubleshooting steps also apply to Exchange hybrid deployments, where the primary mailbox is hosted on-premises and the archive mailbox is in Exchange Online. In such deployments, perform these steps by using the on-premises Exchange Management Shell.
> - In Exchange Online, the Managed Folder Assistant (MFA) is set to process mailboxes at least once every 7 days. While it usually processes mailboxes every day, sometimes it can take up to 7 days to complete the process. Instead of waiting for it to run, you can force the process by running the `Start-ManagedFolderAssistant <mailbox ID>` cmdlet.
> - MRM doesn't process mailboxes that are less than 10 MB in size.

## Common causes

There may be different reasons why MRM doesn't process a mailbox as expected, such as:

- The mailbox is placed on retention hold, that is, the *RetentionHoldEnabled* property of the mailbox is set to **True**. For example, the mailbox is migrated by using the PST Import service.
- The *ElcProcessingDisabled* property of the mailbox is set to **True**. When it's set to True, it prevents the Managed Folder Assistant (MFA) from processing the mailbox at all.
- The mailbox has a retention tag applied, but the tag is currently disabled, so messages in the mailbox will never be moved to archive or deleted.
- The mailbox to be processed contains a large number of items and has a large size. This can cause MFA to perform archiving or deletion at a slower rate.
- The retention policy that's applied to the mailbox includes only personal tags. If the user doesn't manually apply these tags, it can cause MRM to not process the mailbox.

## Troubleshooting

### Check the RetentionHoldEnabled property of the mailbox

Use the [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet to retrieve the *RetentionHoldEnabled* property of the mailbox. If the property is set to **True**, set it to **False**.

### Check the ElcProcessingDisabled property of the mailbox

Use the [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlet to retrieve the *ElcProcessingDisabled* property of the mailbox. If the property is set to **True**, set it to **False**. For more information about this property, see [Difference between ElcProcessingDisabled and RetentionHoldEnabled](/exchange/security-and-compliance/messaging-records-management/mailbox-retention-hold#difference-between-elcprocessingdisabled-and-retentionholdenabled).

### Review the retention policies and tags that are applied to the mailbox

You can use the [Get-RetentionPolicyTag](/powershell/module/exchange/get-retentionpolicytag?view=exchange-ps&preserve-view=true), [Get-RetentionPolicy](/powershell/module/exchange/get-retentionpolicy?view=exchange-ps&preserve-view=true) and [Get-Mailbox](/powershell/module/exchange/get-mailbox) cmdlets to check retention policies and tags that are assigned to the affected mailbox.

Here are some examples:

- To retrieve all retention policies on your Exchange Online tenant, use the following cmdlet:

  ```powershell
  Get-RetentionPolicy
  ```

- To check which policy tags are added to the MRM policy that's assigned to the mailbox, use the following cmdlet:

  ```powershell
  Get-RetentionPolicy -Identity <Name of the retention policy assigned to the mailbox> | select -ExpandProperty RetentionPolicyTagLinks
  ```

- To retrieve the *RetentionHoldEnabled* property of the mailbox and the assigned RetentionPolicy, use the following cmdlet:

  ```powershell
  Get-Mailbox <MailboxID> | fl *Retention*
  ```

- To check which personal retention tags the user has opted into in addition to those that are already included in the assigned retention policy, use the following cmdlet:

  ```powershell
  Get-RetentionPolicyTag -Mailbox <MailboxID> -OptionalInMailbox
  ```

- To review the details of a particular retention policy tag, use the following cmdlet:

  ```powershell
  Get-RetentionPolicyTag <Name of the tag> | fl
  ```

Pay attention to retention tags that are disabled or have the actions set to *never move to archive* or *never delete*. The duration assigned to a tag is a key factor in determining its priority. Therefore, check for tags with the longest time duration, such as *never move to archive* or *never delete*, as these tags take precedence over other tags that are applied.

> [!NOTE]
> The default archive policy tag that applies to the entire mailbox also applies to Calendar, Tasks, and Notes. You can't apply a personal archive tag with the *never move to archive* action to these folders, except for Notes which can be done using Outlook on the web. For more information, see [Default folders that support Retention Policy Tags](/exchange/security-and-compliance/messaging-records-management/default-folders).

### Check if a Default Archive or Default Retention policy tag is applied to the mailbox

If it is, make sure that:

- No personal archive or retention tags have been previously applied to folders with the *never move to archive* or *never delete* action.
- No disabled or default archive/retention tags have been applied to the entire mailbox.
- The Default Archive tag (or any other policy tags that have been applied) exists in the list of retention policy tags that are contained in the PR_ROAMING_XMLSTREAM property. If any tag is missing, delete the IPM.Configuration.MRM message that contains the PR_ROAMING_XMLSTREAM property, and use the [Start-ManagedFolderAssistant](/powershell/module/exchange/start-managedfolderassistant) cmdlet with the `-FullCrawl` switch for the affected mailbox. It'll regenerate the IPM.Configuration.MRM hidden message and update the PR_ROAMING_XMLSTREAM with the new policy tag.

You can use MFCMAPI to check the PR_ROAMING_XMLSTREAM property by following these steps:

1. Set up the affected mailbox in Outlook.
2. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases). If you use the 64-bit version of Outlook, download the 64-bit build. Otherwise, download the 32-bit build.
3. Open MFCMAPI, select **Tools** > **Options**, and then select **MAPI_NO_CACHE** and **MDB_ONLINE**.
4. Select **Session** > **Logon**, select the profile that contains the affected mailbox, and then select **OK**.
5. Double-click the affected mailbox, expand **Root Container** > **Top of Information Store**.
6. Under **Top of Information Store** (or its equivalent if the user mailbox is set to a language other than English), right-click **Inbox** and select **Open associated contents table**.
7. Sort the top pane by the **Message Class** column, and then select **IPM.Configuration.MRM**.
8. In the bottom pane, sort by the **Name** column and locate the **PR_ROAMING_XMLSTREAM** property.
9. Double-click **PR_ROAMING_XMLSTREAM**, copy the XML in the **Text** section, paste it in Notepad, and save as an .xml file.
10. Open the .xml file in a browser, it will show you the actual retention policy tags that are applied to the mailbox.

### Check if personal tags are applied to folders or individual items

You can also use MFCMAPI to check whether personal archive or retention tags are correctly applied to folders. To do this, use similar steps that are mentioned above, select the affected folder, and check its properties for archive tags or retention tags. This can also be done for individual emails.

If you're dealing with a Default Archive policy that applies to the entire mailbox, you won't see any archive policy properties, such as:

- PR_ARCHIVE_TAG
- PR_ARCHIVE_PERIOD
- PR_ARCHIVE_DATE
- PR_POLICY_TAG
- PR_RETENTION_DATE

These properties are only visible when a personal archive tag, default folder retention tag, or personal retention tag is applied.

### Collect the primary mailbox and archive mailbox folder statistics

To gather information about the oldest items and policies applied, use the following commands:

- For the primary mailbox:

  ```powershell
  Get-MailboxFolderStatistics -Identity <primary mailbox ID> -IncludeOldestAndNewestItems | Export-CSV -NoTypeInformation -Path .\primaryfolderstats.csv
  ```

- For the archive mailbox:

  ```powershell
  Get-MailboxFolderStatistics -Identity  <primary mailbox ID> -Archive -IncludeOldestAndNewestItems | Export-CSV -NoTypeInformation -Path .\archivefolderstats.csv
  ```

In the output, look for the item with the earliest received date in any given folder by using the following guidance:

- Check the *OldestItemReceivedDate* of all folders located under *Top of Information Store*, including Inbox, Sent Items, Junk Email, and any of their user-created subfolders. Exclude Deleted Items, Contacts, Calendar (recurring meetings only), and Tasks (recurring tasks only). Then, compare the *OldestItemReceivedDate* with the Retention Age specified in the policy that doesn't work.

  > [!NOTE]
  >
  > - For more information about Deleted Items, recurring calendar items and tasks, see [Determine the age of different types of items](/exchange/security-and-compliance/messaging-records-management/retention-age#determining-the-age-of-different-types-of-items).
  > - Contacts aren't processed by retention policies because they aren't stamped with a start date or an expiration date.

- For items under the Recoverable Items folder, check the *OldestItemLastModifiedDate* instead, and compare it with the *RetainDeletedItemsFor* property that's set on the affected mailbox.

In the output, also check what policies are applied to the folders, and determine whether any disabled personal tags, active personal tags, or even retention compliance policies override the expected policy. Review the following columns:

- DeletePolicy
- ArchivePolicy
- CompliancePolicy
- RetentionFlags

These columns indicate whether a default folder retention tag, a personal retention tag or personal archive tag is applied to the folders. The RetentionFlags column can also show:

- If an explicit retention tag or archive tag is applied. Explicit tags indicate that the policies aren't inherited but are manually applied.
- If the folder needs to be rescanned by the MFA.

> [!NOTE]
> Policies applied to folders in the archive mailbox are usually inherited from the folders in the primary mailbox. However, users can apply a different personal tag to a folder within the archive mailbox. For more information, see [Apply a retention tag to a folder in the archive](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies#applying-a-retention-tag-to-a-folder-in-the-archive).

### Check the MRM diagnostic logs

Use the following PowerShell command to collect the MRM diagnostic log:

```powershell
Export-MailboxDiagnosticLogs <mailboxID> -ComponentName MRM
```

Review the log to determine if any errors occurred when the MFA processed the mailbox. Check the date of the last error to determine its relevance to the current issue.

> [!NOTE]
> If the log contains "resource unhealthy" error messages, it means the mailbox processing is throttled. Due to the size of the mailbox and the number of items it contains, MRM is processing the mailbox very slowly. Unfortunately, throttling is unavoidable when dealing with large mailboxes. 

If you don't see any logs and receive an error message that says "no logs were found", it means that MRM has processed the mailbox without any errors.

There are some additional properties related to MFA processing that you need to check. They will tell you whether the MFA has processed the contents of the mailbox.

- ElcLastRunUpdatedItemCount: The number of individual items that were tagged or untagged by MFA in its last run.
- ElcLastRunTaggedWithArchiveItemCount: The number of items that MFA updated with an archive tag in its last run.
- ElcLastRunTaggedWithExpiryItemCount: The number of items that MFA updated with an expiry (delete) tag in its last run.
- ElcLastRunDeletedFromRootItemCount: The number of items from the Deleted Items folder that expired and were automatically moved to the Recoverable Items folder.
- ElcLastRunDeletedFromDumpsterItemCount: The number of items MFA deleted from the Recoverable Items folder in its last run.
- ElcLastRunArchivedFromRootItemCount: The number of items that were moved from Inbox or Top of Information Store of the primary mailbox to Inbox or Top of Information Store of the archive mailbox.
- ElcLastRunArchivedFromDumpsterItemCount: The number of items that were moved from the Recoverable Items folder of the primary mailbox to the Recoverable Items folder of the archive mailbox.
- ElcLastSuccessTimestamp: The last time when MFA processed the mailbox without any errors. In the case of MRM throttling, these errors may be temporary, which means that items will continue to be moved or deleted, but at a slower rate than usual.

To retrieve these properties, run the following PowerShell commands. These commands parse the XML and return the Email Life Cycle-related properties that begin with "Elc".

```powershell
$logProps = Export-MailboxDiagnosticLogs <mailboxID> -ExtendedProperties
$xmlprops = [xml]($logProps.MailboxLog)
$xmlprops.Properties.MailboxTable.Property | ? {$_.Name -like "ELC*"}
```

If you still can't resolve the issue, [contact support](https://support.microsoft.com/contactus/).

## Best practices

It's recommended to enable the archive mailbox for an account right after it's placed on Litigation Hold, especially if the user has a lot of email traffic. This can help prevent the Recoverable Items folder from becoming full and the users from being unable to further delete items from their primary mailbox. Additionally, it's recommended to enable [auto-expanding archiving](/microsoft-365/compliance/autoexpanding-archiving?view=o365-worldwide&preserve-view=true) depending on the user's [Microsoft 365 license](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance#email-archiving).

Please note that the Recoverable Items folder of the primary mailbox should not be at the maximum quota, as it can also prevent MRM from moving items into the archive. For more information about mailbox folder limits and mailbox storage limits, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).
