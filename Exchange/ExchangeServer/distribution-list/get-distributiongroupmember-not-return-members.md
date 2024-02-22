---
title: The Get-DistributionGroupMember command does not return all the members of distribution group if there are multiple Active Directory domains in your topology environment
description: Resolves an issue that the Get-DistributionGroupMember command does not return all the members of distribution group if there are multiple Active Directory domains in your topology environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010
ms.reviewer: v-six
ms.date: 01/24/2024
---
# The Get-DistributionGroupMember command does not return all the members of distribution group if there are multiple Active Directory domains in your topology environment

_Original KB number:_ &nbsp; 975555

## Symptoms

Consider the following scenario:

- In a Microsoft Exchange Server topology environment, there is a parent Active Directory Domain (`Contoso.com`) and two child domains (`US.Contoso.com` and `Europe.Contoso.com`).
- One of the child domains (`US.Contoso.com`) has Exchange Server server roles installed.
- Another child domain (`Europe.Contoso.com`) has Exchange Server user mailboxes.
- The parent domain has no Exchange servers. In this scenario, when you run the [Get-DistributionGroupMember](/powershell/module/exchange/get-distributiongroupmember) command for a distribution group, the command does not return all the members of the distribution group from the other child domain. Instead, you may receive the following error message when you run the Get-DistributionGroupMember command:

   > The operation could not be performed because object '\<object name>' could not be found on 'Europe.Contoso.com'. + CategoryInfo : InvalidData: (:) [Get-DistributionGroupMember], ManagementObjectNotFoundException + FullyQualifiedErrorId : 6B6149EC,Microsoft.Exchange.Management.RecipientTasks.GetDistributionGroupMember

## Cause

To return the correct result, you must run the Get-DistributionGroupMember by setting the query scope to the whole forest if there are multiple Active Directory domains in your topology environment.

## Resolution

To resolve this issue, follow these steps:

1. Open Exchange Management Shell.
2. Type the following command at the command line:

    ```powershell
    Set-ADServerSettings -ViewEntireForest $True
    ```

    > [!NOTE]
    > The Set-ADServerSettings command is a new command in Exchange Server. By default, the ViewEntireForest parameter is set to **False**.

3. Run the Get-DistributionGroupMember command to retrieve all the members of the distribution group.