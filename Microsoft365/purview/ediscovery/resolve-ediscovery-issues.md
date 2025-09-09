---
title: Resolve Search Errors in eDiscovery (Standard)
description: Resolve common search errors in Microsoft Purview eDiscovery (Standard).
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: jkushwah, lindabr, meerak
ms.custom: 
  - sap:eDiscovery
  - Exchange Online
  - CI 174006
  - CSSTroubleshoot
appliesto: 
  - Microsoft Purview
  - Exchange Online
search.appverid: MET150
ms.date: 05/05/2025
---

# Resolve search errors in eDiscovery 

If you experience an issue or error that's related to searches in Microsoft Purview eDiscovery, retry the operation to rule out transient issues. For issues that persist, select the applicable description from the following list:

- [Search issue: Difference between estimated and downloaded search results](#search-issue-difference-between-estimated-and-downloaded-search-results)
- [Search error: "Location is ambiguous](#search-error-location-is-ambiguous)"
- [Search error: "Recipient not found](#search-error-recipient-not-found)"
- [Search error: CS007](#search-error-cs007)
- [Search error: "Internal server error (500)](#search-error-internal-server-error-500-occurred)"
- [Search or export error: "Maximum number of jobs for your organization are currently running](#search-or-export-error-maximum-number-of-jobs-for-your-organization-are-currently-running)"
- [Export error: "Item has been moved or deleted" or "Unable to retrieve item due to timeout](#export-error-item-has-been-moved-or-deleted-or-unable-to-retrieve-item-due-to-timeout)"
- [Export error: "File wasn't exported because it doesn't exist" or "File not found"](#export-error-file-wasnt-exported-because-it-doesnt-exist-or-file-not-found)
- [Export download issue: eDiscovery export doesn't download any files](#export-download-issue-ediscovery-export-doesnt-download-any-files)
- [Export download error: "Search result was not downloaded as it is a folder"](#export-download-error-search-result-was-not-downloaded-as-it-is-a-folder)

If none of these resolutions apply to your search issue, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=2189021). Depending on your issue, gather output by using the [Get-ComplianceSearch](/powershell/module/exchange/get-compliancesearch) or [Get-ComplianceSearchAction](/powershell/module/exchange/get-compliancesearchaction) PowerShell cmdlet before you create a support case. For information about other diagnostic information that Microsoft Support might need, see [Collect eDiscovery diagnostic information](/microsoft-365/compliance/ediscovery-diagnostic-info).

For eDiscovery hold issues, see [Resolve hold errors in eDiscovery (Standard)](resolve-ediscovery-hold-issues.md).

## Search issue: Difference between estimated and downloaded search results

### Symptoms

When you view the search result statistics in the *Export Summary \<timestamp\>.csv* file in the [downloaded eDiscovery search results](/microsoft-365/compliance/ediscovery-export-content) folder, you notice that the estimated and downloaded search result statistics differ. The estimated search result statistics are also shown in the details pane for the search in the Microsoft Purview compliance portal, and in the eDiscovery export tool.

### Cause

An estimate of the search results is just that: It's an estimate and not an actual count of items that meet the search query criteria. For more information about why estimated and downloaded search results can differ, see [Differences between estimated and actual eDiscovery search results](/microsoft-365/compliance/ediscovery-differences-between-estimated-and-actual-search-results).

[Back to top](#resolve-search-errors-in-ediscovery)

## Search error: "Location is ambiguous"

### Symptoms

When you run an [eDiscovery search](/microsoft-365/compliance/ediscovery-search-for-content), the search fails and returns the following error message:

> The compliance search contains the following invalid location(s): \<mailbox identifier\>. The location \<mailbox identifier\> is ambiguous.

### Cause

The locations that are specified in the error message are invalid. The mailbox identifier for each invalid location is used by duplicate or conflicting objects in Exchange Online Protection (EOP).

### Resolution

For each invalid location, follow these steps:

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Find the duplicate or conflicting objects that use a mailbox identifier. To search, run the following [Get-Recipient](/powershell/module/exchange/get-recipient) command:

   ```powershell
   Get-Recipient -Identity "<mailbox identifier from error message>"
   ```

3. Remove the duplicate or conflicting object.

[Back to top](#resolve-search-errors-in-ediscovery)

## Search error: "Recipient not found"

### Symptoms

Your [eDiscovery search](/microsoft-365/compliance/ediscovery-search-for-content) fails and returns the error message, "Recipient not found."

### Cause

The system can't find one of the [recipients](/powershell/module/exchange/new-mailboxsearch#-recipients) in your eDiscovery search because of synchronization delays in Exchange Online Protection (EOP).

### Resolution

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Check whether the recipients in the search query are synced in EOP by using the [Get-Recipient](/powershell/module/exchange/get-recipient) cmdlet. Run the following command:

   ```powershell
   Get-Recipient -Identity "<user identifier>" | FL
   ```

3. If the command doesn't return a user object for a recipient, wait 30 minutes for synchronization to finish, and then recheck.

4. After you verify that the recipient is synced in EOP, retry your search.

[Back to top](#resolve-search-errors-in-ediscovery)

## Search error: CS007

### Symptoms

Your [eDiscovery search](/microsoft-365/compliance/ediscovery-search-for-content) fails and returns a `CS007` error code.

### Cause

Either of the following issues can cause this error:

- A transient issue

- A search query that returns too many results for the system to process. For example, a query that uses several wildcards can return a large result set.

### Resolution

Retry your search. If your search still fails, split your search into smaller searches. For example, use date ranges or limit the number of search locations to return smaller result sets.

## Search error: "Internal server error (500) occurred"

### Symptoms

Your [eDiscovery search](/microsoft-365/compliance/ediscovery-search-for-content) fails and returns the error message, "Internal server error (500) occurred."

### Cause

- A search query that returns too many results for the system to process. For example, a query that uses several wildcards can return a large result set.

### Resolution

Retry your search. If your search still fails, split your search into smaller searches. For example, use date ranges or limit the number of search locations to return smaller result sets.

[Back to top](#resolve-search-errors-in-ediscovery)

## Search or export error: "Maximum number of jobs for your organization are currently running"

### Symptoms

When you try to [search](/microsoft-365/compliance/ediscovery-search-for-content) or [export eDiscovery search results](/microsoft-365/compliance/ediscovery-export-content), the operation fails and you receive the following error message:

> Your request can't be started because the maximum number of jobs for your organization are currently running.

### Cause

Your organization reached the [maximum limit of 50 concurrent jobs](/microsoft-365/compliance/ediscovery-limits-for-content-search). Because export jobs typically take longer to finish than search jobs, export jobs are more likely to fill the quota.

### Resolution

Use the following procedure to see which export jobs are currently running:

> [!NOTE]
> To use the following procedure, you must be a member of the eDiscovery Manager role group and be an eDiscovery administrator in that group. For more information about how to view or assign eDiscovery Administrators in your organization, see [Assign eDiscovery permissions](/microsoft-365/compliance/ediscovery-assign-permissions#assign-ediscovery-permissions), [Get-eDiscoveryCaseAdmin](/powershell/module/exchange/get-ediscoverycaseadmin), and [Add-eDiscoveryCaseAdmin](/powershell/module/exchange/add-ediscoverycaseadmin).

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Run the following script:

   ```PowerShell
   $date = Get-Date
   $exports = @(Get-ComplianceSearchAction -Export -ResultSize Unlimited)
   $cases = Get-ComplianceCase | ?{$_.status -like "Active"}
   $i = 1
   foreach ($case in $cases) {
     $exports += Get-ComplianceSearchAction -Export -Case $case.Name
     Write-Host "Processing case $($i) of $($cases.Count)"
     $i++
   }
   $inProgressExports = $exports | ?{$_.Results -eq $null -or (!$_.Results.Contains("Export status: Completed") -and !$_.Results.Contains("Export status: none"))}
   $inProgressExportsSince = $inProgressExports | ?{$_.JobStartTime -ge $date.AddDays(-7)} | Sort-Object JobStartTime -Descending
   Write-Host "In-progress export jobs:"
   $inProgressExports | Format-Table Name,JobStartTime,JobEndTime,Status | More
   Write-Host "In-progress export jobs started in the last 7 days:"
   $inProgressExportsSince | Format-Table Name,JobStartTime,JobEndTime,Status | More
   ```

To resolve the error, use the following procedure:

1. Reduce the number of jobs that are running. Use one or both of the following approaches:

   - Wait for one or more running jobs to finish.

   - Remove one or more running jobs that you no longer require by using the [Remove-ComplianceSearchAction](/powershell/module/exchange/remove-compliancesearchaction) PowerShell cmdlet.

2. Retry your search or export operation.

[Back to top](#resolve-search-errors-in-ediscovery)

## Export error: "Item has been moved or deleted" or "Unable to retrieve item due to timeout"

### Symptoms

After you [download eDiscovery search results](/microsoft-365/compliance/ediscovery-export-content), you see the following errors in the *Export Warnings and Errors.csv* file in the downloaded export folder:

- > FailedToExportItem_Microsoft.Exchange.EDiscovery.Export.ExportException: Export failed with error type: 'FailedToExportItem'. Message: Item has been moved or deleted.

- > FailedToExportItem_Microsoft.Exchange.EDiscovery.Export.ExportException: Export failed with error type: 'FailedToExportItem'. Message: Unable to retrieve item due to timeout after multiple retries.

### Cause

These "FailedToExportItem" error messages indicate that the system didn't export all search result items. The unexported items are temporary backups that the system created during mailbox archival. Although eDiscovery can search temporary backup items, these items aren't exportable.

### Resolution

Wait for the system to retrieve and export the original mailbox items that are associated with the temporary backups.

[Back to top](#resolve-search-errors-in-ediscovery)

## Export error: "File wasn't exported because it doesn't exist" or "File not found"

### Symptoms

After you [download eDiscovery search results](/microsoft-365/compliance/ediscovery-export-content), you see either of the following error messages in the *Export Warnings and Errors.csv*, *Skipped Items.csv*, or *trace.log* files in the downloaded export folder:

- > This file wasn't exported because it doesn't exist anymore. The file was included in the count of estimated search results because it's still listed in the index. The file will eventually be removed from the index, and won't cause an error in the future.

- > FailedToExportItem_Failed to download content. Additional diagnostic info : Microsoft.Office.Compliance.EDiscovery.ExportWorker.Exceptions.ContentDownloadTemporaryFailure: Failed to download from content \<document ID\> of type Document. Correlation Id: \<correlation ID\>. ServerErrorCode: -2147024894 ---\> Microsoft.SharePoint.Client.ServerException: File Not Found. at Microsoft.SharePoint.Client.ClientRequest.ProcessResponseStream(Stream responseStream) at Microsoft.SharePoint.Client.ClientRequest.ProcessResponse() --- End of inner exception stack trace ---

### Cause

You might see this error message if the eDiscovery search includes Microsoft SharePoint Online or Microsoft OneDrive for Business locations. eDiscovery relies on the SharePoint Online index to identify files in both those locations. The error occurs if a user renames, moves, or deletes a file in the search results after the search finishes but before the system updates the SharePoint Online index. You can check whether a file was renamed, moved, or deleted by looking for the file in the applicable SharePoint Online or OneDrive for Business location.

### Resolution

To resolve the issue, reindex the SharePoint Online or OneDrive for Business location by using one of the procedures that are provided in [Manually request crawling and reindexing of a site, a library or a list](/sharepoint/crawl-site-content). If you want the search results to include the renamed or moved files, rerun the eDiscovery search.

[Back to top](#resolve-search-errors-in-ediscovery)

## Export download issue: eDiscovery export doesn't download any files

### Symptoms

You run the eDiscovery export to [download eDiscovery search results](/purview/edisc-search-export). However, after the operation finishes, the **Estimated Total** field in the tool window shows that no files were downloaded.

### Cause

The issue can occur for any of the following reasons:

- Browser not configured to allow pop-ups.

- Some Network endpoints are not allowed for downloads in your organization.

### Resolution

If you're experiencing issues that affect the download, see [Best practices for downloading export packages](/purview/edisc-search-export).

[Back to top](#resolve-search-errors-in-ediscovery)

## Export download error: "Search result was not downloaded as it is a folder"

### Symptoms

After you [download eDiscovery search results](/microsoft-365/compliance/ediscovery-export-content), you see the following error message in the *Skipped Items.csv* file in the downloaded export folder:

> This search result was not downloaded as it is a folder or other artifact that can't be downloaded by itself, any items inside the folder or library will be downloaded.

### Cause

You might see this error message if your search includes Microsoft SharePoint Online or Microsoft OneDrive for Business locations. The *Skipped Items.csv* file lists all folders and other skipped items in the search results. The error message typically appears next to folder paths because they're not downloadable items.

### Resolution

No resolution is required. You can safely ignore the error message.

[Back to top](#resolve-search-errors-in-ediscovery)
