---
title: Resolve issues with information protection scanner deployment
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

To drill down further into each node, use the `NodesInfo` variable again, with the node integer starting with **0**.

```powershell
PS C:\Windows\system32> $x.NodesInfo[0].Summary
```

The output displays the details about the scans on the selected node as shown in the following example:

```output
PowerShellCopy
ScannerID               : t-contoso1-T298-corp.contoso.com
ScannedFiles            : 2280
FailedFiles             : 0
ScannedBytes            : 78478187
Classified              : 0
Labeled                 : 0
....
```

Use the `Verbose` parameter with the [Get-AIPScannerStatus](/powershell/module/azureinformationprotection/get-aipscannerstatus) cmdlet to get data about a current scan.

```powershell
PS C:\> Get-AIPScannerStatus -Verbose
```

```output
ScannedFiles    MBScanned    CurrentScanSummary                                         RepositoriesStatus
------------    ---------    ------------------                                         ------------------
        2280    78478187     Microsoft.InformationProtection.Scanner.ScanSummaryData    {{ Path = C:\temp, Status = Scanning }
```

Use the `RepositoriesStatus` or the `CurrentScanSummary` variables to drill down further for more details about the status of the repositories.

Possible repository status values include:

- **Skipped**, if the repository was skipped
- **Pending**, if the current scan hasn't yet started scanning the repository
- **Scanning**, if the current scan is running on the repository
- **Finished**, if the current scan has completed running on the repository

**Example: use the RepositoriesStatus variable**

```powershell
PS C:\Windows\system32> $x.Get-AIPScannerStatus -Verbose
PS C:\Windows\system32> $x.RepositoriesStatus
```

```output
Path        Status
----        ------
C:\temp     Scanning
```

**Example: use the CurrentScanSummary variable**

```powershell
PS C:\Windows\system32> $x.CurrentScanSummary
```

```output
ScannerID               : 
ScannedFiles            : 2280
FailedFiles             : 0
ScannedBytes            : 78478187
Classified              : 0
Labeled                 : 0
....
```

This output shows only a single repository. If there are multiple repositories, each one will be listed separately.

## Scanner error reference

The following table provides information about specific error messages that are generated by the scanner, and provides actions to fix the associated issue:

|Error type|Troubleshooting|
|----------|-----------|
|Authentication errors|<ul><li>[Authentication token not accepted](#authentication-token-not-accepted)</li> <li>Authentication token missing</li></ul>|
|Policy errors|<ul><li>Policy missing</li> <li>Policy doesn't include any automatic labeling condition</li></ul>|
|DB / Schema errors|<ul><li>Database errors</li> <li>Mismatched or outdated schema</li></ul>|
|Other errors|<ul><li>Underlying connection was closed</li> <li>Stuck scanner processes</li> <li>Unable to connect to remote server</li> <li>Missing content scan job or profile</li> <li>No repositories are configured</li> <li>No cluster found</li> <li>Scanner diagnostics errors</li></ul>|

### Authentication token not accepted

**Error message**

> Microsoft.InformationProtection.Exceptions.AccessDeniedException: The service didn't accept the auth token.

**Description**

This error occurs if the [Set-AIPAuthentication](/powershell/module/azureinformationprotection/set-aipauthentication) command fails.

**Resolution**

Make sure to define the permissions correctly in the Azure portal.

For more information, see [Create and configure Azure AD applications for Set-AIPAuthentication](/azure/information-protection/rms-client/clientv2-admin-guide-powershell#create-and-configure-azure-ad-applications-for-set-aipauthentication).

### Authentication token missing

**Error messages**

- > NoAuthTokenException: Client application failed to provide authentication token for HTTP request
- > Microsoft.InformationProtection.Exceptions.NoAuthTokenException: Client application failed to provide authentication token for HTTP request. Failed with: System.AggregateException: One or more errors occurred. ---> Microsoft.IdentityModel.Clients.ActiveDirectory.AdalException: user_interaction_required: One of two conditions was encountered: 1. The PromptBehavior.Never flag was passed, but the constraint could not be honored, because user interaction was required. 2. An error occurred during a silent web authentication that prevented the http authentication flow from completing in a short enough time frame
- > Failed to acquire a token using windows integrated authentication (No SSO)
- From the Azure portal, on the Nodes page:

  > Policy does not include any automatic labeling condition

**Description**

These authentication errors occur when the scanner runs non-interactively.

**Resolution**

For scenarios in which the scanner runs non-interactively, you must authenticate by using a token by using the [Set-AIPAuthentication](/powershell/module/azureinformationprotection/set-aipauthentication) cmdlet.

When you run the [Set-AIPAuthentication](/powershell/module/azureinformationprotection/set-aipauthentication) cmdlet, make sure you use the token parameter on behalf of the service account that's used to run the scanner service as shown in the following example:

```powershell
$pscreds = Get-Credential CONTOSO\scanner
Set-AIPAuthentication -AppId "77c3c1c3-abf9-404e-8b2b-4652836c8c66" -AppSecret "OAkk+rnuYc/u+]ah2kNxVbtrDGbS47L4" -DelegatedUser scanner@contoso.com -TenantId "9c11c87a-ac8b-46a3-8d5c-f4d0b72ee29a" -OnBehalfOf $pscreds
```

```output
Acquired application access token on behalf of CONTOSO\scanner.
```

For more information, see [Get an Azure AD token for the scanner](/azure/information-protection/deploy-aip-scanner-configure-install#get-an-azure-ad-token-for-the-scanner).

### Policy missing

**Error message**

> Policy is missing

**Description**

The scanner is unable to find your sensitivity label policy file.

**Resolution**

To verify that your policy file exists as expected, check in the following location: *%localappdata%\Microsoft\MSIP\mip\MSIP.Scanner.exe\mip\mip.policies.sqlite3*.

For more information about sensitivity labels and their label policies, see [Create and configure sensitivity labels and their policies](/microsoft-365/compliance/create-sensitivity-labels) in the Microsoft Purview documentation.

### Policy doesn't include automatic labeling conditions

**Error message**

> Policy is missing labeling conditions

**Description**

The labeling policy is missing automatic labeling conditions.

**Resolution**

Configure the following settings:

|Setting|Steps to configure settings|
|----------|-----------|
|**Content scan job settings**|In the Azure portal, do the following:<ul><li>[Set the **Info types to be discovered** to **All**](/azure/information-protection/deploy-aip-scanner-configure-install#identify-all-custom-conditions-and-known-sensitive-information-types)</li><li>[Define a default label to be applied when scanning](/azure/information-protection/deploy-aip-scanner-configure-install#apply-a-default-label-to-all-files-in-a-data-repository)</li></ul>|
|**Labeling policy settings**|In the Microsoft Purview compliance portal, do the following:<ul><li>[Define a default sensitivity label](/microsoft-365/compliance/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy)</li><li>[Configure automatic / recommended labeling](/microsoft-365/compliance/apply-sensitivity-label-automatically)</li></ul>|

If your settings are already defined as expected, the policy file itself may be missing or inaccessible, such as when there's a timeout from the Microsoft Purview compliance portal.

To verify your policy file, check that the following file exists: *%localappdata%\Microsoft\MSIP\mip\MSIP.Scanner.exe\mip\mip.policies.sqlite3*

For more information, see [What is the Azure Information Protection unified labeling scanner?](/microsoft-365/compliance/deploy-scanner) and [Learn about sensitivity labels](/microsoft-365/compliance/sensitivity-labels).

### Database errors

**Error message**

> DB error

**Description**

The scanner may not be able to connect to the database.

**Resolution**

Check the network connectivity between the scanner computer and the database.

Additionally, make sure that the service account being used to run scanner processes has all the permissions required to access the database.



