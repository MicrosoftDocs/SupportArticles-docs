---
title: 
description: 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 172966
ms.reviewer: meerak
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 2/23/2023
---

# Resolve issues with information protection scanner deployment

> [!NOTE]
> The Azure Information Protection unified labeling scanner is being renamed **Microsoft Purview Information Protection scanner**. At the same time, configuration (currently in preview) is moving to the Microsoft Purview compliance portal. Currently, you can configure the scanner in both the Azure portal and the compliance portal. Instructions in this article refer to both admin portals.

If you're having issues with the Microsoft Preview Information Protection scanner, verify whether your deployment is healthy by using the [Start-AIPScannerDiagnostics](/powershell/module/azureinformationprotection/start-aipscannerdiagnostics) PowerShell cmdlet to start the scanner diagnostic tool:

```powershell
Start-AIPScannerDiagnostics
```

The diagnostics tool checks the following details and then creates a log file with the results:

- Whether the database is up to date
- Whether network URLs are accessible
- Whether there's a valid authentication token and the policy can be acquired
- Whether the profile is defined in the Azure portal
- Whether offline/online configuration exists and can be acquired
- Whether the rules configured are valid

> [!TIP]
> - If you're not running the tool by using the service account that is used to run the scanner service, you must use the `-OnBehalf` parameter. Else you will encounter errors.
> - To print the last 10 errors from the scanner log, add the `Verbose` parameter. If you want to print more errors, use the `VerboseErrorCount` to define the number of errors you want to print.

The `Start-AIPScannerDiagnostics` command doesn't run a complete prerequisites check. If you're having issues with the scanner, you must also ensure that your system complies with [scanner requirements](/microsoft-365/compliance/deploy-scanner-prereqs?view=o365-worldwide), and your [scanner configuration and installation](/microsoft-365/compliance/deploy-scanner-configure-install) is complete.

## Scan timed out

If the scanner stops unexpectedly while scanning a large number of files in a repository, you may need to modify one of the following settings:

- **Number of dynamic ports**. You may need to increase the number of dynamic ports for the operating system hosting the files. Server hardening for SharePoint can be one reason why the scanner exceeds the number of allowed network connections, and stops.

  For more information about how to view the current port range and increase the range, see [Settings that can be Modified to Improve Network Performance](/biztalk/technical-guides/settings-that-can-be-modified-to-improve-network-performance).

- **List view threshold**. For large SharePoint farms, you may need to increase the list view threshold. By default, the list view threshold is set to **5,000**.

  For more information, see [Manage large lists and libraries in SharePoint](https://support.microsoft.com/office/manage-large-lists-and-libraries-b8588dae-9387-48c2-9248-c24122f07c59).
  
## Verify scanning details per scanner node and repository

Run the [Get-AIPScannerStatus](/powershell/module/azureinformationprotection/get-aipscannerstatus) PowerShell cmdlet to get details about the current scan status and the list of nodes in your scanner cluster.

```powershell
PS C:\> Get-AIPScannerStatus
```

```output
Cluster        : contoso-test
ClusterStatus  : Scanning
StartTime      : 12/22/2020 9:05:02 AM
TimeFromStart  : 00:00:00:37
NodesInfo      : {t-contoso1-T298-corp.contoso.com,t-contoso2-T298-corp.contoso.com}
```

Use the `NodesInfo` variable with the [Get-AIPScannerStatus](/powershell/module/azureinformationprotection/get-aipscannerstatus) cmdlet to get further details about each node in the cluster:

```powershell
PS C:\WINDOWS\system32> $x=Get-AIPScannerStatus
PS C:\WINDOWS\system32> $x.NodesInfo
```

The output displays details for each node in a table as shown in the following example:

```output
NodeName                            Status    IsScanning    Summary
--------                            --------  ----------    -------
t-contoso1-T298-corp.contoso.com    Scanning        True    Microsoft.InformationProtection.Scanner.ScanSummaryData
t-contoso2-T298-corp.contoso.com    Scanning     Pending    Microsoft.InformationProtection.Scanner.ScanSummaryData
```

