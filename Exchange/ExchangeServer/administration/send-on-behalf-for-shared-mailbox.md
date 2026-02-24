---
title: Can't assign Send on Behalf permissions for shared mailboxes in the EAC
description: Explains that the Send As and Send on Behalf permissions are not available for shared mailboxes in the EAC in Exchange Server. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kellybos, ninob, v-six
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2019
  - Exchange Server SE
ms.date: 02/19/2026
---
# Can't assign Send on Behalf permissions for shared mailboxes in the EAC

## Symptoms

When you sign in to the Exchange Admin Center (EAC) in Microsoft Exchange Server, you see limited options to set the permissions of a shared mailbox. The option to individually manage the **Send on Behalf** permissions is available for user mailboxes. However, only the option to manage full mailbox permissions is available for shared mailboxes.

## Cause

This issue occurs because the **Send on Behalf** permission can't be managed in the EAC.

## Workaround

To work around this issue, add the **Send on Behalf** permission by using the following [Set-Mailbox](/powershell/module/exchangepowershell/set-mailbox?view=exchange-ps) PowerShell command:

```powershell
Set-Mailbox -Identity <MailboxOrGroupIdentity> -GrantSendOnBehalfTo <Delegates>
```

For example, to assign the **Send on Behalf** permission for Sean Chai's mailbox to the delegate Holly Holt, run the following command:  

```powershell
Set-Mailbox -Identity seanc@contoso.com -GrantSendOnBehalfTo hollyh
```

[!NOTE]
If you use Microsoft 365, you can use the Microsoft 365 admin center to assign the Send on Behalf permission to shared mailboxes.
