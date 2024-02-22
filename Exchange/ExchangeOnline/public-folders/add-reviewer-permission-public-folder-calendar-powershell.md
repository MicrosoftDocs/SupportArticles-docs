---
title: An item with the specified id wasn't found in the store error when adding reviewer permission to public folder calendar
description: This article provides three workarounds that help you fix an issue where you are unable to add Reviewer permission by using PowerShell commands.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 114868
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# "An item with the specified id wasn't found in the store" error when adding reviewer permission to public folder calendar

## Symptoms

When you try to add a reviewer permission to a public folder calendar by using Exchange Online PowerShell, you receive the following error message:

```powershell
Add-PublicFolderClientPermission -Identity "\publiccalendartest" -User "User" -AccessRights Reviewer
```

> An item with the specified id 'LgAAAAAaRHOQqmYRzZvIAKoAL8RaAwBUKPrqV1IcSb2sevrqOMn6AAAAAAAkAAAB' wasn't found in the store.  
    + CategoryInfo          : NotSpecified: (:) [Add-PublicFolderClientPermission], ObjectNotFoundException  
    + FullyQualifiedErrorId : [Server=<*ServerName*>,RequestId=<*RequestId*>,TimeStamp=3/12/2020
    6:09:26 AM] [FailureCategory=Cmdlet-ObjectNotFoundException] 3B5600ED,Microsoft.Exchange.Management.StoreTasks.AddPublicFolderClientPermission  
    + PSComputerName        : outlook.office365.com

## Workarounds

### Method 1

Use the Microsoft Outlook client to add the reviewer permission to the calendar. To do this, follow these steps:

1. Locate the public folder calendar that you want to add the permission to.
2. Right-click the calendar, and select **Properties**.
3. Under the **Permissions** tab, select **Add**.  
4. In the **Add** box, type a contact name or email address, and then select **OK** to add the contact.
5. In the calendar's **Properties** dialog box, select the contact's name or email address.
6. Under **Permission Level**, select **Reviewer**, and then select **OK**.

### Method 2

Use EAC to add the reviewer permission to the calendar. To do this, follow these steps:

1. Use your administrator account to sign in to EAC.
2. Go to **Public Folders** > **Public Folders**
3. Select the public folder calendar that you want to add the permission to.
4. In the details pane, go to **Folder Permissions** > **Manage**.
5. Select the Plus Sign (+) button, and then select **Browse** to select a user.
6. Under **Permission Level**, select the **Reviewer** permission, and then select **Save**.

### Method 3

Grant the **Folder Visible** access right. Actually, the **Reviewer** role will add the **Folder Visible** access right to the public folder. To do the same, run the following command:

```powershell
Add-PublicFolderClientPermission -Identity "\publiccalendartest" -User "User" -AccessRights ReadItems,FolderVisible
```

## Status

Microsoft is researching this problem and will post more information in this article when it becomes available.
