---
title: MRM policy doesn't process or delete items in the Sync Issues folder in Outlook 2007 or 2010
description: Describes an issue in which a Messaging Records Management (MRM) policy doesn't process or delete items in the Sync Issues folder in Outlook 2007 or Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Messaging Policy and Compliance\Help Configuring MRM, Archive Mailbox, Retention
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: benwinz, v-kegunn, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Items in the Sync Issues folder aren't processed or deleted by a Messaging Records Management (MRM) policy in Outlook 2007 or Outlook 2010

_Original KB number:_ &nbsp;2686541

## Symptoms

When you use Microsoft Office Outlook 2007 or Microsoft Outlook 2010 in Cached Exchange mode, messages are being created in the Sync Issues folder. Exchange Administrators can create a retention policy tag (RPT) for the Sync Issues folder and can then add that RPT to an existing retention policy.

When you apply a Messaging Records Management (MRM) policy to the mailbox, the items in the Sync Issues folder may have an expiration date stamped on the items. However, MRM doesn't process or delete the items.

## Cause

MRM doesn't process the Sync Issues folder because the folder is a client-side folder only. If you use Microsoft Exchange Server Messaging API (MAPI) Editor to view the Sync Issues folder, you can notice that the items in that folder don't have an MRM policy tag stamped on the items. When the Managed Folder Assistant processes the mailbox, the items in this folder aren't acted upon.

The reason that the items are listed as expired is that Outlook in Cached Exchange mode pulls the policy tag information for the folder and then does the calculation for expiration itself.

## Workaround

To work around this issue, don't implement an RPT for the Sync Issues folder because no action will be taken on the contents of the Sync Issues folder itself. This retention tag is applied automatically to the contents of the subfolders under the Sync Issues folder.

Additionally, if you want to automatically empty the Sync Issues folder, you must use the Auto Archive functionality in Outlook.

## More information

### Synchronization errors folders

Here is an excerpt from the Synchronization error folders webpage:

```console
(The Sync Issues folder) contains all of the synchronization logs. In previous releases of Microsoft Outlook, these logs were stored in the Deleted Items folder. This folder is helpful if Outlook is having trouble synchronizing—for example, there is an item that you see in Outlook Web Access, but not in Outlook—or you are not getting new mail in some folders when using Cached Exchange Mode.
```

The information in this folder may help your organization's support team or Microsoft Exchange server administrator determine what is wrong. The contents of the Sync Issues folder aren't copied to your server, and you can't view the items in the Sync Issues folder from any other computer.

> [!IMPORTANT]
> Although the Sync Issues folder itself isn't acted upon according to when the RPT is applied, be aware that when the RPT is applied, the tag will automatically apply to the subfolders of the Sync Issues folder. Subfolders include Conflicts, Local Failures, and Server Failures. Any subfolder that contains content that's stored on the Exchange Server will be acted upon by MRM. Use caution when you apply this RPT because there may be items in the subfolders that indicate problems. Automatically deleting this content could result in data loss or could mask more serious issues with specific clients.

### Mail Item Expiration Date property

For more information about the Mail Item Expiration Date property, go to the following Microsoft Developer Network (MSDN) website:

[MailItem.RetentionExpirationDate Property](/dotnet/api/microsoft.office.interop.outlook._mailitem.retentionexpirationdate)

Microsoft Outlook calculates the value of this property based on the item retention start date and the retention period, if Outlook is in cached or offline mode. The Exchange Server specifies the value if Outlook is in online mode.

For more information about retention policies and retention tags, go to the following Microsoft Exchange Server website:

[Understanding Retention Tags and Retention Policies](/Exchange/policy-and-compliance/mrm/retention-tags-and-retention-policies)
