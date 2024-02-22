---
title: Can't expand or view the content of a public folder in Outlook
description: Provides a resolution for an issue in which you can't expand or view the content of a public folder in Outlook because of a network connection problem.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 185087
ms.reviewer: batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Can't expand or view the content of a public folder in Outlook

## Symptoms

When you try to expand a public folder or view public folder content in Microsoft Outlook, you receive the following error message:

> Cannot display folder. Network problems are preventing connection to Microsoft Exchange.

## Cause

The issue occurs if too many users (more than 2,000) connect to the same public folder mailbox. The issue can occur for the following reasons:

- An unbalanced assignment of users to public folder mailboxes. By default, the [public folder mailbox that a user connects to](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-users-access-public-folders-and-what-to-do-when-they-cannot/ba-p/3963070) is automatically selected by an Exchange algorithm that load-balances users across public folder mailboxes. Too many user connections to the same public folder mailbox can occur if tenant administrators override the automatic public folder mailbox assignment.

- A heavily used public folder. Heavy usage can cause too many connections to be made to the public folder mailbox that hosts the public folder content.

## Resolution

To fix the issue, follow these steps:

1. Make sure that you have a balanced assignment of users to public folder mailboxes. Follow these steps:

   1. Determine the number of users who are assigned to each hierarchy-serving public folder mailbox. For an Exchange Online public folder mailbox, run the following commands in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

      ```PowerShell
      $mbxs = Get-EXOMailbox -ResultSize unlimited -Properties EffectivePublicFolderMailbox
      $mbxs | sort EffectivePublicFolderMailbox | group EffectivePublicFolderMailbox
      ```

      For an on-premises public folder, run the following PowerShell commands in the Exchange Management Shell (EMS):

      ```PowerShell
      $mbxs = Get-Mailbox -ResultSize unlimited
      $mbxs | sort EffectivePublicFolderMailbox | group EffectivePublicFolderMailbox
      ```

      The following example shows the command output for a balanced assignment of users to public folder mailboxes. Almost the same number of users are assigned to each public folder mailbox. Maintaining a balanced load is considered to be a best practice because it reduces the likelihood of having too many user connections to one public folder mailbox.

      ```output
      Count   Name    Group
      -----   ----    -----
      270     pfmbx1  { hross, nitya.patel, rperrera, sthakkar… }
      259     pfmbx2  { aida.kamaria, rflores, qamar.mounir, kcarter… }
      240     pfmbx3  { gabriel.diaz, nihad.samaha, kmclean, veronica.berg… }
      ```

      The following example shows the command output for an unbalanced assignment of users to public folder mailboxes. More than 90 percent of users are assigned to the same public folder mailbox. An unbalanced load increases the likelihood that some users will encounter connection issues if many users try to access that public folder mailbox around the same time.

      ```output
      Count   Name    Group
      -----   ----    -----
      2710    pfmbx2  { fabiopena, robert.anic, epereira, fadila.baz… }
      5       pfmbx3  { elizabeth.garcia, lponos, laura.cunha, joni.shah… }
      ```

   2. If you determined, in the previous step, that there's unbalanced assignment of users to public folder mailboxes, set the `DefaultPublicFolderMailbox` parameter value to null for each user mailbox. For an Exchange Online public folder mailbox, run the following command in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

      ```PowerShell
      Get-EXOMailbox -ResultSize unlimited | Set-Mailbox -DefaultPublicFolderMailbox $null
      ```

      For an on-premises public folder mailbox, run the following PowerShell command in the EMS:

      ```PowerShell
      Get-Mailbox -ResultSize unlimited | Set-Mailbox -DefaultPublicFolderMailbox $null
      ```

      After you run the command, the system automatically assigns a public folder mailbox for each user in a load-balanced manner.

2. If your organization has a heavily used public folder that more than 2,000 users might simultaneously access, follow these steps:

   1. Determine the public folder mailbox that contains the content of the heavily used public folder. Run the following PowerShell command:

      ```PowerShell
      Get-PublicFolder -Identity <public folder path and name> | FL ContentMailboxName
      ```

   2. Get a list of public folder mailboxes in your organization together with the public folders that they host. Run the following PowerShell commands:

      ```PowerShell
      $pfs = Get-PublicFolder -Recurse
      $pfs | sort ContentMailboxName | group ContentMailboxName
      ```

      The following example shows command output:

      ```output
      Count   Name    Group
      -----   ----    -----
      1       PFMBX   { IPM\_SUBTREE }
      7       PFMBX2  { HeavilyUsedPF, PF2, PF3… }
      2       PFMBX3  { PF4, PF5 }
      2       PFMBX4  { PF6, PF7 }
      ```

      Note: To only get a list of public folder mailboxes, run the following PowerShell cmdlet:

      ```PowerShell
      Get-Mailbox -PublicFolder
      ```

   3. From the list that you obtained in the previous step, identify two or more public folder mailboxes that don't have heavily used public folders. Create new public folders in those mailboxes to host the heavily used content. To create a public folder in a public folder mailbox, run the following PowerShell cmdlet:

      ```PowerShell
      New-PublicFolder -Name <public folder name> -Mailbox <public folder mailbox>
      ```

      For example, if the heavily used public folder exists in the public folder mailbox _PFMBX2_, and you have less heavily used content in public folder mailboxes _PFMBX3_ and _PFMBX4_, create the public folders there.

      > [!NOTE]
      > Don't create the public folders in the [primary hierarchy public folder mailbox](/exchange/collaboration-exo/public-folders/public-folders#public-folder-mailboxes).

   4. Use the Outlook desktop client to distribute the content of the heavily used public folder to the new public folders that you created in the previous step.

3. If the issue persists after you complete the preceding steps, it's possible that the existing public folder mailboxes are overloaded even though they're load-balanced. In that case, [create additional public folder mailboxes](/exchange/collaboration-exo/public-folders/create-public-folder-mailbox). After you create public folder mailboxes, the system will automatically load balance them.
