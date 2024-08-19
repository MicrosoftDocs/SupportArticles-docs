---
title: Unexpected PublicFolderMailBoxes groups are created
description: After you install cumulative update 6, unexpected PublicFolderMailBoxes distribution groups exist in Exchange Server 2016 or 2019.
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
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2019
ms.date: 01/24/2024
---
# Unexpected PublicFolderMailBoxes dynamic distribution groups in Exchange Server 2016 or 2019

_Original KB number:_ &nbsp; 4035952

## Symptoms

Consider the following scenario:

- You have an Active Directory site that has more than one domain controller.
- The Exchange Server 2016 server in the site has Cumulative Update 6 or later installed.
- The first public folder mailbox is created on Exchange Server 2016 or 2019.

In this scenario, multiple dynamic distribution groups are created unexpectedly. The names of these dynamic distribution groups begin with PublicFolderMailboxes.

:::image type="content" source="media/publicfoldermailboxes-dynamic-distribution-groups/publicfoldermailboxes-groups.png" alt-text="Screenshot of unexpected PublicFolderMailBoxes dynamic distribution groups.":::

## Cause

Exchange Server creates a dynamic distribution group for hierarchy sync of public folders. In an environment that has multiple domain controllers, the entry for the dynamic distribution group is created in one of the domain controllers. Immediately, a process looks up the dynamic distribution group from a different domain controller to verify whether the dynamic distribution group exists. Because Active Directory replication hasn't happened yet, the dynamic distribution group is not replicated. Therefore, it is not found and is created again. Until replication occurs, a new dynamic distribution group is created each time that the process runs (typically every 24 hours).

## Workaround

To work around this issue, hard code a domain controller on the Exchange Server that hosts the primary hierarchy public folder mailbox so that the Exchange Server only communicates to the domain controller. To do this, follow these steps:

1. Remove the unexpected dynamic distribution groups by running the following command in the Exchange Management Shell:

    ```powershell
    Get-DynamicDistributionGroup -IncludeSystemObjects PublicFolderMailboxes* | Remove-DynamicDistributionGroup
    ```

2. In the Application log in Event Viewer, filter the log to show **Event ID 2080**.

3. Locate the latest Event ID 2080. In the description, you should find more than one domain controller listed under In-site.

    Example:

    ```console
    DC01.domain.com CDG 1 7 7 1 0 1 1 7 1
    DC02.domain.com CDG 1 7 7 1 0 1 1 7 1
    ```

4. Copy the FQDN of a listed domain controller that is also a global catalog server.

5. Run the following command in the Exchange Management Shell:

    ```powershell
    Set-ExchangeServer -Identity <name of Exchange server> -StaticDomainControllers <FQDN of DC> -StaticConfigDomainController <FQDN of DC> -StaticGlobalCatalogs <FQDN of DC>
    ```

    Example:

    ```powershell
    Set-ExchangeServer -Identity e161 -StaticDomainControllers DC01.domain.com  -StaticConfigDomainController DC01.domain.com  -StaticGlobalCatalogs DC01.domain.com
    ```

6. Wait 15 minutes or a little longer for Exchange topology discovery to happen. This is when the next Event ID 2080 is logged. In the description of the Event ID 2080, you should see only one domain controller listed under In-site.

7. Run the following command in the Exchange Management Shell:

    ```powershell
    Get-Mailbox -PublicFolder | ?{$_.IsRootPublicFolderMailbox -eq "true"} | Update-PublicFolderMailbox
    ```

8. You should see only one dynamic distribution group created. Wait for 15 or 20 minutes, and then run the following command to verify whether a single dynamic distribution group was created:

    ```powershell
    Get-DynamicDistributionGroup -IncludeSystemObjects PublicFolderMailboxes*
    ```

9. Remove the hard coding of the domain controller by running the following command:

    ```powershell
    Set-ExchangeServer -Identity <name of Exchange server> -StaticDomainControllers $null -StaticConfigDomainController $null -StaticGlobalCatalogs $null
    ```

## Status

Microsoft is investigating the problem and will update as more information becomes available.
