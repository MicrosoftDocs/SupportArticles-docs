---
title: Imported PST file content doesn't appear in archive mailbox
description: Provides a work around for an issue in which the content of an imported PST file doesn't appear in an archive mailbox in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - Exchange Online
  - CSSTroubleshoot
  - CI 178337
ms.reviewer: aabdelmoniem, haembab, lusassl, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Imported PST file content doesn't appear in archive mailbox

## Symptoms

You [import a PST file](/purview/use-network-upload-to-import-pst-files) into a user's archive mailbox in Microsoft Exchange Online. After the import finishes, you see that the used storage space of the archive mailbox has increased. However, the content of the imported PST file doesn't appear in Microsoft Outlook.

## Cause

When you import a PST file into an archive mailbox in Exchange Online, Exchange Online stores the imported content in the non-IPM folders of the mailbox if both of the following conditions apply:

- The imported PST file has default folders such as the Inbox, Sent Items, and Deleted Items.

- The [PST import mapping file](/purview/use-network-upload-to-import-pst-files#step-4-create-the-pst-import-mapping-file) that you used during the import process has a `TargetRootFolder` parameter value that is `/`.

**Note**: Non-IPM folders are hidden folders that aren't visible in Outlook.

## Workaround

To work around the issue, select one of the following methods.

### Method 1

1. Set the `TargetRootFolder` parameter value in the PST import mapping file to a value other than `/`. For example, if you leave the `TargetRootFolder` value blank, Exchange Online imports the PST file content to a new folder that's named `Imported` at the root level of the mailbox (the same level as the Inbox folder). For more information about the `TargetRootFolder` parameter, see [Create the PST import mapping file](/purview/use-network-upload-to-import-pst-files#step-4-create-the-pst-import-mapping-file).

2. Reimport the PST file.

### Method 2

> [!IMPORTANT]
> This workaround initially imports the PST file into the user's primary mailbox. Use this method only if the user's primary mailbox has sufficient space to store the content of the imported PST file.

1. Set the `IsArchive` parameter value in the PST import mapping file to `False`.

2. Reimport the PST file. This step imports the PST file into the user's primary mailbox.

3. Set up an [MRM retention policy](/exchange/security-and-compliance/messaging-records-management/create-a-retention-policy) that specifies a **Move Item To Archive** retention action for specific folders or the entire mailbox. This action moves mailbox items to the user's archive mailbox when the retention period expires. For more information about how to create a retention policy for an archive mailbox, see [Create the custom archive default policy tag](/purview/set-up-an-archive-and-deletion-policy-for-mailboxes#create-the-custom-archive-default-policy-tag).
