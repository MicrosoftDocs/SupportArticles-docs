---
title: Can't migrate public folders to Exchange Online
description: Fixes an issue in which you receive an error message when you try to migrate public folders to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: vibour, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Public folder couldn't be mail-enabled when you migrate public folders to Exchange Online

_Original KB number:_ &nbsp; 3050726

## Problem

When you try to migrate public folders to Exchange Online, the migration fails and you receive an error message that resembles the following:

> MigrationPermanentException: Error: Public folder "/\<FolderName>" couldn't be mail-enabled. The error is as follows: "No MailPublicFolder entry was found in Active Directory with OnPremisesObjectId=‎'\<*OnPremisesObjectId*>‎' or LegacyExchangeDN=‎'/CN=Mail Public Folder/CN=Version_1_0/CN=e71f13d1-0178-42a78c4724206de84a77/CN=000000001A4473 90AA6611CD9BC800AA002FC45A0300E7243831D8E5
0446AB3A0E4E3AEBE23500000000715A0000‎'". This failure can happen when MailPublicFolder objects in Exchange Online are out of sync with your Exchange deployment. You may need to rerun the script Export-MailPublicFoldersForMigration.ps1 on your Exchange server, followed by the script Import-MailPublicFoldersForMigration.ps1 on Exchange Online to update MailPublicFolder objects in Active Directory.

## Cause

This problem occurs if the NON_IPM_SUBTREE system folder contains mail-enabled public folders. Public folders in the NON_IPM_SUBTREE folder don't have to be mail-enabled. They may have been previously mail-enabled because they were in a Microsoft Exchange 2000 Server environment that was running in mixed mode. In this situation, Exchange tries to mail-enable all public folders.

## Solution

Mail-disable all public folders that are mail-enabled in the NON_IPM_SUBTREE folder. For more information about how to mail-disable a public folder, see [Mail-enable or mail-disable a public folder](/exchange/collaboration-exo/public-folders/enable-or-disable-mail-for-public-folder).

To mail-disable public folders on NON_IPM_SUBTREE, run these commands:

### For public folders on Exchange Server 2010

List mail-enabled public folders from NON_IPM_SUBTREE:

```powershell
$pf=Get-PublicFolder \NON_IPM_Subtree -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) {$i }} 
```

Mail-disable the public folders:

```powershell
$pf=Get-PublicFolder \NON_IPM_Subtree -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) { Disable-MailPublicFolder $i -confirm:$False} }
```

### For public folders on Exchange Server 2013 and later versions

List Mail-Enabled public folders from NON_IPM_SUBTREE:

```powershell
$pf=Get-PublicFolder \NON_IPM_Subtree -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) {$i }}
```

Mail-disable the public folders:

```powershell
$pf=Get-PublicFolder \NON_IPM_Subtree -recurse -ResultSize Unlimited | ? { $_.MailEnabled }; ForEach ($i in $pf) {$mesoObj = Get-MailPublicFolder $i.identity; if ($mesoObj -eq $null) { Set-PublicFolder $i -MailEnabled:$false -confirm:$False} }
```

To locate the system public folders, open the Exchange Management Console, go to **Toolbox**, open the Public Folder Management Console, and then expand **System Public Folders**. Mail-disable any public folder that has a mail icon next to it.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
