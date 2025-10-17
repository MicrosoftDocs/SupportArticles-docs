---
title: Issues with Microsoft Purview Information Protection scanner
description: Provides checks to verify the health of the scanner deployment and resolutions for scanner errors.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Microsoft Information Protection (MIP)
  - CSSTroubleshoot
  - CI 172966
ms.reviewer: meerak
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 05/05/2025
---

# Resolve issues with information protection scanner deployment

> [!NOTE]
> The Azure Information Protection unified labeling scanner is being renamed **Microsoft Purview Information Protection scanner**. At the same time, configuration (currently in preview) is moving to the Microsoft Purview compliance portal. Currently, you can configure the scanner in both the Azure portal and the compliance portal. Instructions in this article refer to both admin portals.

If you're having issues with the Microsoft Purview Information Protection scanner, verify whether your deployment is healthy by using the [Start-ScannerDiagnostics](/powershell/module/purviewinformationprotection/start-scannerdiagnostics) PowerShell cmdlet to start the scanner diagnostic tool:

```powershell
Start-ScannerDiagnostics
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

The `Start-ScannerDiagnostics` command doesn't run a complete prerequisites check. If you're having issues with the scanner, you must also ensure that your system complies with [scanner requirements](/microsoft-365/compliance/deploy-scanner-prereqs), and your [scanner configuration and installation](/microsoft-365/compliance/deploy-scanner-configure-install) is complete.
 
## Verify scanning details per scanner node and repository

Run the [Get-ScanStatus](/powershell/module/purviewinformationprotection/get-scanstatus) PowerShell cmdlet to get details about the current scan status and the list of nodes in your scanner cluster.

```powershell
PS C:\> Get-ScanStatus
```

```output
Cluster        : contoso-test
ClusterStatus  : Scanning
StartTime      : 12/22/2020 9:05:02 AM
TimeFromStart  : 00:00:00:37
NodesInfo      : {t-contoso1-T298-corp.contoso.com,t-contoso2-T298-corp.contoso.com}
```

Use the `NodesInfo` variable with the [Get-ScanStatus](/powershell/module/purviewinformationprotection/get-scanstatus) cmdlet to get further details about each node in the cluster:

```powershell
PS C:\WINDOWS\system32> $x=Get-ScanStatus
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
ScannerID               : t-contoso1-T298-corp.contoso.com
ScannedFiles            : 2280
FailedFiles             : 0
ScannedBytes            : 78478187
Classified              : 0
Labeled                 : 0
....
```

Use the `Verbose` parameter with the [Get-ScanStatus](/powershell/module/purviewinformationprotection/get-scanstatus) cmdlet to get data about a current scan.

```powershell
PS C:\> Get-ScanStatus -Verbose
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
|**Authentication errors**|<ul><li>[Authentication token not accepted](#authentication-token-not-accepted)</li> <li>[Authentication token missing](#authentication-token-missing)</li></ul>|
|**Policy errors**|<ul><li>[Policy missing](#policy-missing)</li> <li>[Policy doesn't include any automatic labeling condition](#policy-doesnt-include-automatic-labeling-conditions)</li></ul>|
|**DB / Schema errors**|<ul><li>[Database errors](#database-errors)</li> <li>[Mismatched or outdated schema](#mismatched-or-outdated-schema)</li></ul>|
|**Other errors**|<ul><li>[Underlying connection was closed](#underlying-connection-was-closed)</li> <li>[Stuck scanner processes](#stuck-scanner-processes)</li> <li>[Unable to connect to remote server](#unable-to-connect-to-remote-server)</li> <li>[Missing content scan job or profile](#missing-content-scan-job-or-profile)</li> <li>[No repositories configured](#no-repositories-configured)</li> <li>[No cluster found](#no-cluster-found)</li></ul>|

### Authentication token not accepted

**Error message**

> Microsoft.InformationProtection.Exceptions.AccessDeniedException: The service didn't accept the auth token.

**Description**

The [Set-Authentication](/powershell/module/purviewinformationprotection/set-authentication) command has failed.

**Resolution**

Verfy that the appropriate permissions are defined correctly in the Azure portal.

For more information, see [Create and configure Microsoft Entra applications for Set-Authentication](/powershell/azure/aip/setup-information-protection-client-powershell#create-and-configure-microsoft-entra-applications-for-set-authentication).

### Authentication token missing

**Error messages**

- > NoAuthTokenException: Client application failed to provide authentication token for HTTP request
- > Microsoft.InformationProtection.Exceptions.NoAuthTokenException: Client application failed to provide authentication token for HTTP request. Failed with: System.AggregateException: One or more errors occurred. ---> Microsoft.IdentityModel.Clients.ActiveDirectory.AdalException: user_interaction_required: One of two conditions was encountered: 1. The PromptBehavior.Never flag was passed, but the constraint could not be honored, because user interaction was required. 2. An error occurred during a silent web authentication that prevented the http authentication flow from completing in a short enough time frame
- > Failed to acquire a token using windows integrated authentication (No SSO)
- From the Azure portal, on the **Nodes** page:

  > Policy does not include any automatic labeling condition

**Description**

These authentication errors occur when the scanner runs non-interactively.

**Resolution**

You must authenticate by using a token by using the [Set-Authentication](/powershell/module/purviewinformationprotection/set-authentication) cmdlet.

When you run the Set-Authentication cmdlet, make sure you use the token parameter on behalf of the service account that's used to run the scanner service as shown in the following example:

```powershell
$pscreds = Get-Credential CONTOSO\scanner
Set-Authentication -AppId "77c3c1c3-abf9-404e-8b2b-4652836c8c66" -AppSecret "OAkk+rnuYc/u+]ah2kNxVbtrDGbS47L4" -DelegatedUser scanner@contoso.com -TenantId "9c11c87a-ac8b-46a3-8d5c-f4d0b72ee29a" -OnBehalfOf $pscreds
Acquired application access token on behalf of CONTOSO\scanner.
```

For more information, see [Get a Microsoft Entra token for the scanner](/microsoft-365/compliance/deploy-scanner-configure-install#get-an-azure-ad-token-for-the-scanner).

### Policy missing

**Error message**

> Policy is missing

**Description**

The scanner is unable to find your sensitivity label policy file.

**Resolution**

To verify that your policy file exists as expected, check in the following location: *%localappdata%\Microsoft\MSIP\mip\MSIP.Scanner.exe\mip\mip.policies.sqlite3*.

For more information about sensitivity labels and their label policies, see [Create and configure sensitivity labels and their policies](/microsoft-365/compliance/create-sensitivity-labels).

### Policy doesn't include automatic labeling conditions

**Error message**

> Policy is missing labeling conditions

**Description**

The labeling policy is missing automatic labeling conditions.

**Resolution**

Configure the following settings:

|Setting|Steps to configure settings|
|----------|-----------|
|**Content scan job settings**|In the Azure portal, do the following:<ul><li>[Set the **Info types to be discovered** to **All**](/microsoft-365/compliance/deploy-scanner-configure-install#use-the-scanner-with-alternative-configurations)</li><li>[Define a default label to be applied when scanning](/microsoft-365/compliance/deploy-scanner-configure-install#use-the-scanner-with-alternative-configurations)</li></ul>|
|**Labeling policy settings**|In the Microsoft Purview compliance portal, do the following:<ul><li>[Define a default sensitivity label](/microsoft-365/compliance/create-sensitivity-labels#publish-sensitivity-labels-by-creating-a-label-policy)</li><li>[Configure automatic / recommended labeling](/microsoft-365/compliance/apply-sensitivity-label-automatically)</li></ul>|

If the settings are already defined as expected, the policy file itself may be missing or inaccessible, such as when there's a timeout from the Microsoft Purview compliance portal.

To verify your policy file, check that the following file exists: *%localappdata%\Microsoft\MSIP\mip\MSIP.Scanner.exe\mip\mip.policies.sqlite3*

For more information, see [What is the Azure Information Protection unified labeling scanner?](/microsoft-365/compliance/deploy-scanner) and [Learn about sensitivity labels](/microsoft-365/compliance/sensitivity-labels).

### Database errors

**Error message**

> DB error

**Description**

The scanner is not able to connect to the database.

**Resolution**

Check the network connectivity between the scanner computer and the database.

Additionally, make sure that the service account being used to run scanner processes has all the permissions required to access the database.

### Mismatched or outdated schema

**Error message**

One of the following:

- > SchemaMismatchException

- In the Azure portal, on the **Nodes** page: 

  > DB schema is not up to date. Run Update-ScannerDatabase command to update the DB schema  
  Error: DB schema is not up to date

**Description**

The database schema is not up to date.

**Resolution**

Run the [Update-ScannerDatabase](/powershell/module/purviewinformationprotection/update-scannerdatabase) cmdlet to resynchronize your schema and ensure that it's up to date with any recent changes.

### Underlying connection was closed

**Error messages**

> System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException: Authentication failed because the remote party has closed the transport stream.

> [System.Net.Http.HttpRequestException: An error occurred while sending the request. ---> System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host.

**Description**

These errors indicate that TLS 1.2 isn't enabled.

**Resolution**

To enable TLS 1.2, see:

- [Firewalls and network infrastructure requirements](/azure/information-protection/requirements#firewalls-and-network-infrastructure)
- [How to enable TLS 1.2](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Enable TLS 1.1 and TLS 1.2 support in Office Online Server](/officeonlineserver/enable-tls-1-1-and-tls-1-2-support-in-office-online-server)

### Stuck scanner processes

**Error message**

There's no error message displayed but the scanner times out.

**Description**

The scanner is processing a single file for a longer time than expected or it stops unexpectedly while scanning a large number of files in a repository. The scanner process might be stuck.

**Resolution**

Modify one of the following settings:

- **Number of dynamic ports**. You may need to increase the number of dynamic ports for the operating system hosting the files. Server hardening for SharePoint can be one reason why the scanner exceeds the number of allowed network connections, and stops.

  For information about how to view the current port range and increase the range, see [Settings that can be Modified to Improve Network Performance](/biztalk/technical-guides/settings-that-can-be-modified-to-improve-network-performance).

- **List view threshold**. For large SharePoint farms, you may need to increase the list view threshold. By default, the list view threshold is set to **5,000**.

  For information on increasing the threshold, see [Manage large lists and libraries in SharePoint](https://support.microsoft.com/office/manage-large-lists-and-libraries-b8588dae-9387-48c2-9248-c24122f07c59).

If the issue still occurs, check the detailed report to determine whether the file is increasing in size.

If the file size continues to increase, then the scanner is still processing data, and you must wait until it's done.

If the file is no longer increasing in size, do the following:

1. Run the following cmdlets:

   - [Start-ScannerDiagnostics](/powershell/module/purviewinformationprotection/start-scannerdiagnostics) cmdlet: to run diagnostic checks on your scanner, and export and zip log files for any errors that are found.
   - [Export-DebugLogs](/powershell/module/purviewinformationprotection/export-debuglogs) cmdlet: to export and create a .zip version of the log files from the *%localappdata%\Microsoft\MSIP\Logs* directory.

2. Create a dump file for the MSIP Scanner service. In the Windows Task Manager, right-click the **MSIP Scanner service**, and select **Create dump file**.
3. In the Azure portal, stop the scan.
4. On the scanner machine, restart the service.
5. Open a support ticket and attach the dump files from the scanner process.

### Unable to connect to remote server

**Error message**

In the *MSIPScanner.iplog* file located under *%localappdata%\Microsoft\MSIP\Logs\\*:

> Unable to connect to the remote server ---> System.Net.Sockets.SocketException: Only one usage of each socket address (protocol/network address/port) is normally permitted IP:port

If there are multiple logs, then *MSIPScanner.iplog* file will be a .zip file. 

**Description**

The scanner has exceeded the number of allowed network connections.

**Resolution**

Increase the number of dynamic ports for the operating system hosting the files.

For information about how to view the current port range and increase the range, see [Settings that can be modified to improve network performance](/biztalk/technical-guides/settings-that-can-be-modified-to-improve-network-performance).

### Missing content scan job or profile

**Error message**

In the Azure portal, on the **Nodes** page:

> No content scan job found

**Description**

This error occurs when the content scan job or profile can't be found.

**Resolution**

Check your scanner configuration in the Azure portal.

For more information, see [Configuring and installing the Azure Information Protection unified labeling scanner](/microsoft-365/compliance/deploy-scanner-configure-install).

**Note:** A *profile* is a legacy scanner term that has been replaced by the scanner cluster and content scan job in newer versions of the scanner.

### No repositories configured

**Error message**

In the admin portal, on the **Nodes** page:

> No repositories are configured

**Description**

You may have a content scan job with no repositories configured.

**Resolution**

Check your content scan job settings and add at least one repository.

For more information, see [Create a content scan job](/microsoft-365/compliance/deploy-scanner-configure-install#configure-the-scanner-settings).

### No cluster found

**Error message**

In the admin portal, on the **Nodes** page:

> No cluster found

**Description**

No actual match found for one of the scanner clusters you've defined.

**Resolution**

Verify your cluster configuration and check it against your own system details for typos and errors.

For more information, see [Create a scanner cluster](/microsoft-365/compliance/deploy-scanner-configure-install#configure-the-scanner-settings).

## More information

[Best practices for deploying and using the AIP UL scanner](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/best-practices-for-deploying-and-using-the-aip-ul-scanner/ba-p/1878168).
