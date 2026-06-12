---
title: The Get-DistributionGroupMember command doesn't return all the members of distribution group in multiple Active Directory domains
description: Resolves an issue in which the Get-DistributionGroupMember command doesn't return all the members of a distribution group if multiple Active Directory domains exist in your topology.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipient Management
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11996
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.reviewer: v-six, v-kccross
ms.date: 06/05/2026
---

# The Get-DistributionGroupMember command doesn't return all the members of distribution group if there are multiple Active Directory domains in your topology

_Original KB number:_ &nbsp; 975555

## Summary

The `Get-DistributionGroupMember` cmdlet might not return all members of a distribution group in environments that have multiple Active Directory domains. This issue occurs because the default query scope is limited to the local domain. Therefore, members from other domains in the forest aren’t included, and you might receive an "object could not be found" error message. To resolve the issue, set the query scope to the entire forest by using `Set-ADServerSettings -ViewEntireForest $True`, and then rerun the `Get-DistributionGroupMember` cmdlet to return all members.

## Symptoms

Consider the following scenario:

- A Microsoft Exchange Server deployment has a parent Active Directory domain (`Contoso.com`) and two child domains (`US.Contoso.com` and `Europe.Contoso.com`).
- One of the child domains (`US.Contoso.com`) has Exchange Server server roles installed.
- Another child domain (`Europe.Contoso.com`) has Exchange Server user mailboxes.
- The parent domain has no Exchange servers.

In this scenario, if you run the [Get-DistributionGroupMember](/powershell/module/exchange/get-distributiongroupmember) cmdlet for a distribution group, the result doesn't include all the members of the distribution group from the other child domain. Instead, you receive the following error message:

```console
   The operation could not be performed because object <object name> could not be found on Europe.Contoso.com. + CategoryInfo : InvalidData: (:) [Get-DistributionGroupMember], ManagementObjectNotFoundException + FullyQualifiedErrorId : 6B6149EC,Microsoft.Exchange.Management.RecipientTasks.GetDistributionGroupMember
```

## Cause

To obtain the correct result, you must set the query scope for the `Get-DistributionGroupMember` cmdlet to the whole forest if multiple Active Directory domains exist in your topology environment.

## Resolution

To resolve this issue, follow these steps:

1. Open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell). Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange server.

1. Set the scope to the whole forest for the current session by using the [Set-ADServerSettings](/powershell/module/exchangepowershell/set-adserversettings) cmdlet. By default, the `ViewEntireForest` parameter is set to **False**.

    ```powershell
    Set-ADServerSettings -ViewEntireForest $True
    ```

1. Retrieve all members of the distribution group by running the [Get-DistributionGroupMember](/powershell/module/exchange/get-distributiongroupmember) cmdlet.
