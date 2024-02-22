---
title: Cannot browse groups in OWA
description: Describes an issue in which Exchange Online users cannot browse groups in Outlook Web App because the Browse groups option is missing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: chrispol, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange Online users can't browse groups in Outlook Web App

_Original KB number:_ &nbsp; 3059279

## Symptoms

Exchange Online users cannot browse groups in Microsoft Outlook Web App. When a user expands **Groups** in the navigation pane in Outlook Web App, the **Browse groups** option is missing.

## Cause

This problem occurs if you set up custom address book policies (ABPs) in Exchange Online, and the ABP to which the user or users is assigned doesn't contain the **All Groups** address list.

## Resolution

To resolve this problem, add the All Groups address list to the ABP that's assigned to the user. After you do this, wait approximately one hour for the changes to replicate. Then, have users access Outlook Web App again.

You can use the `Set-AddressBookPolicy` cmdlet to change the settings of an ABP. The following are examples of how to do this.

- The following command adds the All Groups address list to an ABP that's named *Staff*:

  ```powershell
  Set-addressbookpolicy staff.abp -addresslists "All Groups","\Mailbox of students","\All Distribution Lists","\All Staff
  ```

- The following command address the All Groups address list to an ABP that's named *Students*:

  ```powershell
  Set-addressbookpolicy students.abp -addresslists "All Groups", "\Mailbox of students"
  ```

> [!NOTE]
> If the administrator isn't assigned the Address Lists role, the `Set-AddressBookPolicy` cmdlet is not available. To create a role assignment, use a command such as the following:

```powershell
New-rolegroup -name ContosoChangeAddressLists -roles "Address Lists" -members CloudAdmin@constoso.com
```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/)
