---
title: Messaging Records Management (MRM) and Retention Policies in Microsoft 365.
description: Describes the retention policy in Microsoft 365 dedicated/ITAR.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Retention
  - CSSTroubleshoot
ms.reviewer: kerbo
appliesto: 
  - Exchange Online
  - Microsoft Exchange Online Dedicated
search.appverid: MET150
ms.date: 05/05/2025
---

# Messaging Records Management (MRM) and Retention Policies in Microsoft 365

_Original KB number:_&nbsp;4032361

## Summary

Microsoft 365 provides a default **retention policy** (also known as **Default MRM Policy**). To check for these policies in your environment, run the following cmdlet:

```powershell
Get-RetentionPolicy | fl Name
```  

For example, the output of this cmdlet resembles the following:

```console
Name : Default MRM Policy
Name : Contoso-Default-Retention-Policy
```

To see which policy is set on a mailbox, run the following cmdlet:

```powershell
Get-mailbox <SMTP> | fl RetentionPolicy
```

For example, the output of this cmdlet resembles the following:

```console
RetentionPolicy: Contoso-Default-Retention-Policy
```

To change or set a retention policy for a user, run the following cmdlet:

```powershell
Set-Mailbox <SMTP> -RetentionPolicy "Contoso-Default-Retention-Policy"
```

To view the **retention policy tags**  that are associated with the plan, run the following cmdlet:

```powershell
(Get-RetentionPolicy "Contoso-Default-Retention-Policy").RetentionPolicyTagLinks | Format-Table name
```

The output of this cmdlet resembles the following:

```console
Name
----
1 Month Delete
1 Year Delete
3 Year Delete
6 Month Delete
Never Delete
Voice Mail Deletion
1 Week Archive
1 Month Archive
1 Year Archive
Never Archive
2 Year Archive
3 Month Archive
6 Month Archive
3 Year Archive
```

To view the details for a specific **retention policy tag**, run the following cmdlet:

```powershell
Get-RetentionPolicyTag "1 Week Delete" | Format-list Name,Type,AgeLimitForRetention,MessageClass,RetentionAction
```

The output of this cmdlet resembles the following:

```console
Name : 1 Week Delete
Type : Personal
AgeLimitForRetention : 7.00:00:00
MessageClass : *
RetentionAction : DeleteAndAllowRecovery
```

To view the details for all **retention policy tag**, run the following cmdlet:

```powershell
Get-RetentionPolicyTag | Format-Table Name,Type,AgeLimitForRetention,MessageClass,RetentionAction
```

The output of this cmdlet resembles the following:

```console
 Name Type AgeLimitForRetention MessageClass RetentionAction
---- ---- -------------------- ------------ ---------------
1 Week Delete Personal 7.00:00:00 * DeleteAndAllowRecovery
1 Month Delete Personal 30.00:00:00 * DeleteAndAllowRecovery6 Month Delete Personal 180.00:00:00 * DeleteAndAllowRecovery1 Year Delete Personal 365.00:00:00 * DeleteAndAllowRecoveryNever Delete Personal * DeleteAndAllowRecovery ...
```

## Troubleshooting

If a retention policy is not working as expected, review the following articles first to make sure that you understand how the policy processes items in your mailbox.

- Issue: Items are not expiring as expected.

  [How retention age is calculated in Exchange 2016](/Exchange/policy-and-compliance/mrm/retention-age)

- Issue: Managed Folder Assistant seems not to be processing my items.

  [Understanding of Managed Folder Assistant with retention policies](/archive/blogs/anya/understanding-of-managed-folder-assistant-with-retention-policies)

  > [!NOTE]
  > If you must start the Managed Folder Assistant immediately, see [Start-ManagedFolderAssistant](/powershell/module/exchange/start-managedfolderassistant).

- Information about expiring contacts, calendar items, and tasks.
- How to recover items that may have been processed by Managed Folder Assistant.

## More Information

### For end users

To view and apply **retention policy tag** in Outlook, right-click a folder, and then select the desired tag.

:::image type="content" source="media/mrm-and-retention-policy/folder-policy.png" alt-text="Screenshot shows steps to select the tag in the Folder Policy.":::

Depending on a user's Group Policy, they may be able to change this list (add/delete) through OWA under **Options** > **Mail** > **Retention Policies**.

:::image type="content" source="media/mrm-and-retention-policy/retention-policies.png" alt-text="Screenshot of the Retention Policies page through O W A.":::

Check the **retention policy** option that applies to the folder in which the items are stored. To do this, right-click the folder, and then scroll down to **Assign policy**.

:::image type="content" source="media/mrm-and-retention-policy/assign-policy.png" alt-text="Screenshot shows steps to check the retention policy option on the Assign policy page.":::

Check **Retention Policy** and **Expire**  fields to see whether an item is set an expiration date.

:::image type="content" source="media/mrm-and-retention-policy/expiration-date-set-page.png" alt-text="Screenshot to check Retention Policy and Expire fields.":::

Use the search bar to quickly find items that are set to expire. For example: "expires:<=the next month".

For more information, see [Learn to narrow your search criteria for better searches in Outlook](https://support.office.com/article/D824D1E9-A255-4C8A-8553-276FB895A8DA).

Use **Customer Search Folder** to do a more extensive search. To do this, under **Advance** setting, use the **Expire** field. For more information, see [Create a Search Folder](https://support.office.com/article/C1807038-01E4-475E-8869-0CCAB0A56DC5).

:::image type="content" source="media/mrm-and-retention-policy/customer-search-folder-page.png" alt-text="Screenshot to use the Expire field under the Advance setting.":::

Set a specific expiration date. For detailed steps, see [Set a message expiration date](https://support.office.com/article/FCAE213F-8D38-4318-A17B-42D83AC209ED).

### For administrators

Administrators can create new retention tags and policies by using the correct permission through the Exchange admin center (EAC) or PowerShell. For detailed steps, see [Create a Retention Policy](/exchange/security-and-compliance/messaging-records-management/create-a-retention-policy).

#### New Retention Tag

:::image type="content" source="media/mrm-and-retention-policy/new-retention-tag.png" alt-text="Screenshot of creating the New Retention Tag page.":::

#### New Retention Policy (using new or existing tags)

:::image type="content" source="media/mrm-and-retention-policy/new-retention-policy.png" alt-text="Screenshot of creating the New Retention Policy page.":::

**Retention tags** are used to apply retention settings to messages and folders in user mailboxes. There are three types of retention tags:

- **Default policy tag (DPT)** is a retention tag that applies to all items in a mailbox that doesn't already have a retention tag applied. You can have only one DPT in a retention policy.
- **Retention policy tag (RPT)** is a retention tag that applies to default folders, such as Inbox and Deleted Items.
- **Personal tag** is used to make retention settings to custom folders and individual items, such as email messages. It's available to Outlook Web App, Outlook 2010, and later versions.

For more information, see the following articles:  

- [Messaging records management](/exchange/security-and-compliance/messaging-records-management/messaging-records-management)
- [Messaging records management terminology](/exchange/messaging-records-management-terminology-in-exchange-2013-exchange-2013-help)
- [Retention tags and retention policies](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies)

#### Help users recover missing message

- Check whether an item was deleted, and then recover the item if it's necessary. To do this, see [Recover deleted messages in a user's mailbox in Exchange Online](/exchange/recipients-in-exchange-online/manage-user-mailboxes/recover-deleted-messages).

- Search and investigate missing items. To do this, see the following articles:
  - [How to use mailbox audit logs in Microsoft 365 dedicated](https://support.microsoft.com/help/4021960/how-to-use-mailbox-audit-logs-in-office-365-dedicated)
  - [Search-Mailbox](/powershell/module/exchange/search-mailbox)
  - [Create an In-Place eDiscovery search](/microsoft-365/compliance/content-search)
