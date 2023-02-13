---
title: Troubleshooting common eDiscovery issues
description: Learn about basic troubleshooting steps you can take to resolve common issues in Microsoft Purview eDiscovery.
f1.keywords: 
  - NOCSH
ms.author: v-six
author: simonxjx
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 157398
  - CSSTroubleshoot
  - seo-marvel-apr2020
ms.collection: 
  - Strat_O365_IP
  - M365-security-compliance
search.appverid: 
  - MOE150
  - MET150
siblings_only: true
ms.date: 3/31/2022
---
# Resolve common eDiscovery issues

[!include[Purview banner](../../../includes/purview-rebrand.md)]

This article covers basic troubleshooting steps that you can take to identify and resolve issues that you might encounter during an eDiscovery search or elsewhere in the eDiscovery process. Resolving some of these scenarios requires help from Microsoft Support. Information about when to contact Microsoft Support is included in the resolution steps.

## Error/issue: Ambiguous location

If you try to add a user's mailbox location to a search, and there are duplicate or conflicting objects that have the same userID in the Exchange Online Protection (EOP) directory, you receive this error message:

> The compliance search contains the following invalid location(s): `useralias@contoso.com`. The location `useralias@contoso.com` is ambiguous.

### Resolution

Check for duplicate users or distribution lists that have the same user ID.

1. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Run the following command to retrieve all instances of the username:

    ```powershell
    Get-Recipient <username>
    ```

   The output for "useralias@contoso.com" will resemble the following:

   > |Name|RecipientType|
   > |---|---|
   > |Alias, User|MailUser|
   > |Alias, User|User|

3. If multiple users are returned, locate and fix the conflicting object.

## Error/issue: Search fails on specific locations

An eDiscovery or content search might yield the following error:

> This search completed with (#) errors.  Would you like to retry the search on the failed locations?

:::image type="content" source="media/resolve-ediscovery-issues/search-fails-error.png" alt-text="Screenshot of search-specific location fails error.":::

### Resolution

If you receive this message, we recommend that you verify the locations that failed in the search, and then rerun the search on the failed locations only.

1. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell) and then run the following command:

   ```powershell
   Get-ComplianceSearch <searchname> | FL
   ```

2. From the PowerShell output, view the failed locations in the errors field or from the status details in the error message from the search output.

3. Retry the eDiscovery search on the failed locations only.

4. If you continue to receive these errors, see [Retry failed locations](/Office365/SecurityCompliance/retry-failed-content-search) for more troubleshooting steps.

## Error/issue: File not found

When running an eDiscovery search that includes SharePoint Online and OneDrive for Business locations, you might receive a "File Not Found" error message although the file is located on the site. This message will be posted in the export warnings and errors.csv or skipped items.csv. This might occur if the file can't be found on the site or if the index is out-of-date. Here's the text of an actual error message (with emphasis added):

> 28.06.2019 10:02:19_FailedToExportItem_Failed to download content. Additional diagnostic info : Microsoft.Office.Compliance.EDiscovery.ExportWorker.Exceptions.ContentDownloadTemporaryFailure: Failed to download from content 6ea52149-xyxy-xyxy-b5bb-82ca6a3ec9be of type Document. Correlation Id: 3bd84722-xyxy-xyxy-b61b-08d6fba9ec32. ServerErrorCode: -2147024894 ---> Microsoft.SharePoint.Client.ServerException: ***File Not Found***. at Microsoft.SharePoint.Client.ClientRequest.ProcessResponseStream(Stream responseStream) at Microsoft.SharePoint.Client.ClientRequest.ProcessResponse()
--- End of inner exception stack trace ---

### Resolution

1. Check the location that's identified in the search to make sure that the location of the file is correct and added in the search locations.

2. To reindex the site, use the procedures that er provided in [Manually request crawling and reindexing of a site, a library, or a list](/sharepoint/crawl-site-content).

## Error/issue: This file wasn't exported because it doesn't exist anymore. The file was included in the count of estimated search results because it's still listed in the index. The file will eventually be removed from the index, and won't cause an error in the future

You might see that error when running an eDiscovery search that includes SharePoint Online and OneDrive for Business locations. eDiscovery relies on the SPO index to identify the file locations. If the file was deleted but the SPO index was not yet updated this error might occur.

### Resolution 

Open the SPO location, and verify that this file is, indeed, not there. The suggested solution is to manually reindex the site, or wait until the site reindexes through the automatic background process.

## Issue: This search result was not downloaded as it is a folder or other artifact that can't be downloaded by itself, any items inside the folder or library will be downloaded

You might see this error message when you run an eDiscovery search that includes SharePoint Online and OneDrive for Business locations. It means that we were going to try to export the item that's reported in the index, but the item turned out to be a folder. Therefore, we did not export it. As mentioned in the error message, we don't export folders, but we do export their contents.

## Error/issue: Search fails because recipient is not found

An eDiscovery search fails and returns a "recipient not found" error message. This error might occur if the user object cannot be found in Exchange Online Protection (EOP) because the object has not synced.

### Resolution

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the following command to check whether the user is synced to Exchange Online Protection:

   ```powershell
   Get-Recipient <userId> | FL
   ```

3. There should be a mail user object for the user question. If nothing is returned, investigate the user object. Contact Microsoft Support if the object can't be synced.

## Error/issue: Search fails with error CS007

When performing a Content search or a search associated with a eDiscovery (Standard) case, a transient error occurs and the search fails with a CS007 error.

### Resolution

1. Update the search and reduce the complexity of the search query.  For example, a wildcard search might return too many results for the system to process, which causes a CS007 error.

2. Rerun the updated search.

## Error/issue: Exporting search results is slow

When exporting search results from eDiscovery (Standard) or Content search in the Microsoft Purview compliance portal, the download takes longer than expected.  You can check to see the amount of data to be download and possibly increase the export speed.

### Resolution

1. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell), and then run the following command:

   ```powershell
   Get-ComplianceSearch <searchname> | FL
   ```

2. Find the amount of data that's to be downloaded in the SearchResults and SearchStatistics parameters.

3. Run the following command:

   ```powershell
   Get-ComplianceSearchAction | FL
   ```

4. In the results field, find the data that has been exported, and then view any errors that were encountered.

5. Check for any errors in the Trace.log file located in the directory that you exported the content to.

6. If you still have issues, consider dividing searches that return a large set of results into smaller searches. For example, you can use date ranges in search queries to return a smaller set of results that can be downloaded faster.

## Error/issue: Export process not progressing or is stuck

When you export search results from eDiscovery (Standard) or Content search in the Microsoft Purview compliance portal, the export process is not progressing or appears to be stuck.

### Resolution

1. If necessary, rerun the search. If the search last ran more than seven days ago, you have to rerun the search.

2. Restart the export.

## Error/issue: "Internal server error (500) occurred"

When you run an eDiscovery search, if the search continually fails and returns an error message that resembles "Internal server error (500) occurred," you might have to rerun the search on specific mailbox locations only.

> (500) Internal Server Error.

:::image type="content" source="media/resolve-ediscovery-issues/internal-server-error-500.png" alt-text="Screenshot of Internal server error (500).":::

### Resolution

1. Break the search into smaller searches, and run the search again. Try using a smaller date range or limit the number of locations that are searched.

2. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell), and then run the following command:

   ```powershell Set-CaseHoldPolicy <policyname> -RetryDistribution
   Get-ComplianceSearch <searchname> | FL
   ```

3. Examine the output for results and errors.

4. Examine the Trace.log file in the same folder that you exported the search results to.

5. Contact Microsoft Support.

## Error/issue: Holds don't sync

eDiscovery Case Hold Policy Sync Distribution error. The error reads:

> "Resources: It's taking longer than expected to deploy the policy. It might take an additional 2 hours to update the final deployment status, so check back in a couple hours."

### Resolution

1. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell) and then run the following command for an eDiscovery case hold:

   ```powershell
   Get-CaseHoldPolicy <policyname> - DistributionDetail | FL
   ```

    For a retention policy, run the following command:

   ```powershell
   Get-RetentionCompliancePolicy <policyname> - DistributionDetail | FL
   ```

2. Examine the value in the DistributionDetail parameter for errors like the following:

   > Error: Resources: It's taking longer than expected to deploy the policy. It might take an additional 2 hours to update the final deployment status, so check back in a couple hours."

3. Try running the RetryDistribution parameter on the policy in question:

   For eDiscovery case holds:

   ```powershell
   Set-CaseHoldPolicy <policyname> -RetryDistribution
   ```

   For retention policies:

   ```powershell
   Set-RetentionCompliancePolicy <policyname> -RetryDistribution
   ```

4. Contact Microsoft Support.

## Error/issue: Holds stuck in PendingDeletion

eDiscovery Case Hold Policies may be stuck in PendingDeletion and can't be removed.

### Resolution

1. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell).
1. Try running the RetryDistribution parameter on the policy in question:

   For eDiscovery case holds:

   ```powershell
   Set-CaseHoldPolicy <policyname> -RetryDistribution
   ```

   For retention policies:

   ```powershell
   Set-RetentionCompliancePolicy <policyname> -RetryDistribution
   ```
   
2. Try to delete the policy using PowerShell and the `-ForceDeletion` parameter:
   
   For eDiscovery case holds, use the [Remove-CaseHoldPolicy](/powershell/module/exchange/remove-caseholdpolicy?view=exchange-ps&preserve-view=true) cmdlet:
   
   ```powershell
   Remove-CaseHoldPolicy <policyname> -ForceDeletion
   ```
  
   For retention policies, use the [Remove-RetentionCompliancePolicy](/powershell/module/exchange/remove-retentioncompliancepolicy?view=exchange-ps&preserve-view=true) cmdlet:
  
   ```powershell
   Remove-RetentionCompliancePolicy <policyname> -ForceDeletion
   ```  
  
3. Contact Microsoft Support.

## Error/issue: "The condition specified using HTTP conditional header(s) is not met"

When downloading search results using the eDiscovery Export Tool, you might receive the following error message:

> System.Net.WebException: The remote server returned an error: (412) The condition specified using HTTP conditional header(s) is not met.

This is a transient error that typically occurs in the Azure Storage location.

### Resolution

To resolve this issue, retry [downloading the search results](/microsoft-365/compliance/export-search-results#step-2-download-the-search-results). This will restart the eDiscovery Export Tool.

## Error/issue: Downloaded export shows no results

After a successful export, the completed download through the export tool shows zero files in the results.

### Resolution

This is a client-side issue. To remediate it, follow these steps:

1. Try using another client to download.

2. Remove old searches that are no longer required. To do this, run the [Remove-ComplianceSearch](/powershell/module/exchange/remove-compliancesearch) cmdlet.

3. Make sure to download to a local drive.

4. Make sure that the virus scanner is not running.

5. Make sure that no other export is downloading to the same folder or any parent folder.

6. If the previous steps don't work, disable zipping and de-duplication.

7. If step 7 works, then the issue occurs because of a local virus scanner or a disk issue.

## Error: "Your request can't be started because the maximum number of jobs for your organization are currently running"

Your organization has reached the limit for the maximum number of concurrent export jobs. All new export jobs are being throttled.

### Resolution

To discover how many export jobs that were started in the last seven days are still running, follow these steps:

1. Connect to [Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. To collect information about the current export jobs that are triggering the throttle, run the following cmdlets as an eDiscovery administrator.

    **Note**: An eDiscovery administrator is a member of the eDiscovery Manager role group, and can view all eDiscovery cases. You can use the [Get-eDiscoveryCaseAdmin](/powershell/module/exchange/get-ediscoverycaseadmin) cmdlet to check for eDiscovery administrators, and use the [Add-eDiscoveryCaseAdmin](/powershell/module/exchange/add-ediscoverycaseadmin) cmdlet to add an eDiscovery administrator. The cmdlets might take some time to finish, depending on the number of cases.

   ```powershell
   $date = Get-Date
   $Exports = @(Get-ComplianceSearchAction -export -ResultSize Unlimited)
   $cases = Get-ComplianceCase | ?{$_.status -like "Active"}
     
   $i = 1
   foreach ($case in $cases)
   {
   $Exports += Get-ComplianceSearchAction -export -case $case.name
   write-host "Processing case $($i) of $($cases.count)"
   $i++
   }
     
   $inprogressExports = $exports | ?{$_.Results -eq $null -or (!$_.Results.Contains("Export status: Completed") -and !$_.Results.Contains("Export status: none"))};
   $exportJobsRunning = $inprogressExports | ?{$_.JobStartTime -ge $date.AddDays(-7)} | Sort-Object JobStartTime -Descending

   ```

3. Run the following cmdlet to display a list of export jobs that are currently running.

   **Note**: If the cmdlet returns 10 or more exports jobs, your organization has reached the limit for the number of concurrent export jobs. For more information, see [Limits for eDiscovery search](/microsoft-365/compliance/limits-for-content-search).

   ```powershell
   $exportJobsRunning | Format-Table Name, JobStartTime, JobEndTime, Status | More;
   ```

4. Wait for existing export jobs to finish, or use the [Remove-ComplianceSearchAction](/powershell/module/exchange/remove-compliancesearchaction) cmdlet to remove export jobs that are no longer required.

## Error: "Hit tolerable error, will retry: The process cannot access the file 'ExportData.db' because it is being used by another process."

The export process may get stuck, or produce zero-byte files.

### Resolution

This can be a client-side issue. To remediate it, follow these steps:

1. Try using another client to download.

2. Remove old searches that are no longer required by running the [Remove-ComplianceSearch](/powershell/module/exchange/remove-compliancesearch) cmdlet.

3. Make sure to download to a local drive.

4. Make sure that the virus scanner isn't running.

5. Make sure that no other export is downloading to the same folder or any parent folder.

6. If the previous steps don't work, disable zipping and de-duplication.

7. If step 6 works, then the issue occurs because of a local virus scanner or a disk issue.

If none of these steps solve the problem, gather the output of `Get-ComplianceSearch` and `Get-ComplianceSearchAction` before creating a support case.

## Issue: Problem retrieving mailbox items while archiving

The following errors are displayed in Export Warnings.csv and Errors.csv during content search and the eDiscovery standard export workflow.

> "FailedToExportItem_Microsoft.Exchange.EDiscovery.Export.ExportException: Export failed with error type: 'FailedToExportItem'. Message: Item has been moved or deleted."
> "FailedToExportItem_Microsoft.Exchange.EDiscovery.Export.ExportException: Export failed with error type: 'FailedToExportItem'. Message: Unable to retrieve item due to timeout after multiple retries."

These errors indicate that certain items found during search couldn’t be retrieved. These might be temporary backup copies that are created during archival. While these temporary backups are accessible to search and thus can be matched, they are not accessible for retrieval. However eDiscovery can match and retrieve the original items which are exact copies of the backups.

### Resolution

No action is needed to address these errors. The original items associated with the same mailbox will be retrieved and subsequently exported or added to a review set.

## Error/issue: Export process opens a new blank page

When you export search results from eDiscovery (Standard) or Content search in the Microsoft Purview compliance portal, the export process opens a new blank page and the eDiscovery Export Tool (UnifiedExportTool) isn't downloaded.

### Resolution

To fix the issue, allow pop-ups from the Microsoft Purview compliance portal, and then restart the export process.

In Microsoft Edge:

1. Select the **Settings and more** icon (...) in the upper-right corner of the browser.
1. Select **Settings** > **Cookies and site permissions**.
1. Under **All permissions**, select **Pop-ups and redirects**.
1. Under **Allow**, select **Add**.
1. In the pop-up window, enter *https://compliance.microsoft.com*, and then select **Add**.

If you're using another browser, follow the browser's documentation to allow pop-ups from the Microsoft Purview compliance portal.
