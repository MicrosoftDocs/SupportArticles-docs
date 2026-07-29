---
title: Unexpected PublicFolderMailBoxes dynamic distribution groups are created
description: Describes how to fix an issue in which unexpected PublicFolderMailBoxes distribution groups exist in Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: batre, v-six
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 9947
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 07/28/2026
---

# Unexpected PublicFolderMailBoxes dynamic distribution groups in Exchange Server

_Original KB number:_ &nbsp; 4035952

## Summary

This article discusses the unexpected creation of multiple dynamic distribution groups in Exchange Server. The names of the distribution groups start with `PublicFolderMailBoxes`. The article provides a workaround for this issue.

## Symptoms

Consider the following scenario. Multiple dynamic distribution groups are created unexpectedly and the following conditions apply:

- You have an Active Directory site with more than one domain controller. The site is running Exchange Server 2016 with Cumulative Update 6 or later installed.
- The first public folder mailbox was created on Exchange Server 2016, Exchange Server 2019, or Exchange Server SE.

In this scenario, multiple dynamic distribution groups are created unexpectedly. The names of these dynamic distribution groups begin with `PublicFolderMailboxes`.

:::image type="content" source="media/publicfoldermailboxes-dynamic-distribution-groups/publicfoldermailboxes-groups.png" alt-text="Screenshot of unexpected PublicFolderMailBoxes dynamic distribution groups.":::

## Cause

Exchange Server creates a dynamic distribution group to sync the hierarchy of public folders. In an environment that has multiple domain controllers, the entry for the dynamic distribution group is created in one of the domain controllers. Immediately, a process looks up the dynamic distribution group from a different domain controller to verify whether the dynamic distribution group exists. However, because Active Directory replication hasn't happened yet, the dynamic distribution group isn't replicated to the other domain controllers. Because the process doesn't find the recently created dynamic distribution group, Exchange creates a new one.

Until Active Directory replication occurs, a new dynamic distribution group is created each time that the process runs (typically every 24 hours).

## Workaround

Temporarily configure a domain controller on the Exchange Server instance that hosts the primary hierarchy for the public folder mailbox so that the Exchange Server instance only communicates with one domain controller. This configuration is called setting up a static domain controller for the Exchange Server. After you complete these steps, return the Exchange Server configuration to its previous state.

1. Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange Server to open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell).

1. Remove the unexpected dynamic distribution groups by running the [Get-DynamicDistributionGroup](/powershell/module/exchangepowershell/get-dynamicdistributiongroup) cmdlet as shown in the following example:

    ```powershell
    Get-DynamicDistributionGroup -IncludeSystemObjects PublicFolderMailboxes* | Remove-DynamicDistributionGroup
    ```

1. In the Event Viewer application log, filter the log to display Event ID 2080.

1. Locate the latest entry for Event ID 2080. In the description, you should find more than one domain controller under `In-site`.

    For example:

    ```console
    DC01.domain.com CDG 1 7 7 1 0 1 1 7 1
    DC02.domain.com CDG 1 7 7 1 0 1 1 7 1
    ```

1. In the list of domain controllers, identify one that’s also a global catalog server and then copy its FQDN.

1. To configure the Exchange Server to use a static domain controller, in EMS, run the [Set-ExchangeServer](/powershell/module/exchangepowershell/set-exchangeserver) cmdlet as shown in the following example:

    ```powershell
    Set-ExchangeServer -Identity <name of Exchange server> -StaticDomainControllers <FQDN of DC> -StaticConfigDomainController <FQDN of DC> -StaticGlobalCatalogs <FQDN of DC>
    ```

   For example:

    ```powershell
    Set-ExchangeServer -Identity e161 -StaticDomainControllers DC01.domain.com  -StaticConfigDomainController DC01.domain.com  -StaticGlobalCatalogs DC01.domain.com
    ```

1. Wait 15 minutes or a little longer for Exchange topology discovery to happen. This is when the next Event ID 2080 entry is logged. In the description, you should see only one domain controller listed under `In-site`.

1. To display a list of public folder mailboxes on the server, in EMS, run the [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox) cmdlet as shown in the following example:

    ```powershell
    Get-Mailbox -PublicFolder | ?{$_.IsRootPublicFolderMailbox -eq "true"} | Update-PublicFolderMailbox
    ```

   You should see that only one dynamic distribution group was created.

1. Wait 15 or 20 minutes, and then run the [Get-DynamicDistributionGroup](/powershell/module/exchangepowershell/get-dynamicdistributiongroup) cmdlet to verify whether a single dynamic distribution group was created:

    ```powershell
    Get-DynamicDistributionGroup -IncludeSystemObjects PublicFolderMailboxes*
    ```

1. Reset the configuration of the Exchange Server so that it no longer only uses a static domain controller by running the [Set-ExchangeServer](/powershell/module/exchangepowershell/set-exchangeserver) cmdlet as shown in the following example:

    ```powershell
    Set-ExchangeServer -Identity <name of Exchange server> -StaticDomainControllers $null -StaticConfigDomainController $null -StaticGlobalCatalogs $null
    ```
