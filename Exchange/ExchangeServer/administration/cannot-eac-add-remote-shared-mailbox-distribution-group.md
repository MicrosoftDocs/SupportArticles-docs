---
title: Can't use EAC to add remote shared mailbox to distribution group
description: Resolves an issue in which you can't use EAC to add remote shared mailbox to delivery management of distribution group.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: meerak, akashb, ninob, v-lianna
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
---
# Can't use EAC to add remote shared mailbox to delivery management of distribution group

In a Microsoft Exchange Server 2019 or 2016 hybrid environment, you can use the [Exchange admin center](/exchange/architecture/client-access/exchange-admin-center) (EAC) to add a user mailbox to the [delivery management](/exchange/recipients/distribution-groups#delivery-management) section of a distribution group. However, you can't use the EAC to add a remote shared mailbox instead of a user mailbox. To add a remote shared mailbox as a recipient, you have to run a script in [Exchange Management Shell](/powershell/exchange/exchange-management-shell). By using a script, you can add either one remote shared mailbox or multiple mailboxes.

**Note**: In the following scripts, replace \<DistributionGroupName> with the name of your distribution group, and \<New remote shared mailbox Identity> with the name, alias, or email address of the remote shared mailbox.

## Add one remote shared mailbox

```powershell
$groupname = "<DistributionGroupName>"
Set-DistributionGroup $groupname  -AcceptMessagesOnlyFrom((Get-DistributionGroup  $groupname).AcceptMessagesOnlyFrom + "<New remote shared mailbox Identity>")
```

## Add multiple remote shared mailboxes

Each remote shared mailbox to be added must be listed in a text file that uses a separate line for each entry. In the following example, the file is named remotesharedmailboxes.txt.

```powershell
$groupname = "<DistributionGroupName>"
$remotesharedmailboxes = Get-Content C:\ remotesharedmailboxes.txt
Set-DistributionGroup $groupname  -AcceptMessagesOnlyFrom((Get-DistributionGroup  $groupname).AcceptMessagesOnlyFrom + $remotesharedmailboxes)
```
