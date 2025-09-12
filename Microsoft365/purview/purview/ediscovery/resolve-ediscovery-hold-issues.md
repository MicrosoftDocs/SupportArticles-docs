---
title: Resolve eDiscovery hold errors
description: Resolve errors related to legal holds applied to custodial and noncustodial data sources in eDiscovery.
ms.date: 05/05/2025
f1.keywords: 
  - NOCSH
ms.author: v-six
author: simonxjx
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.collection: M365-security-compliance
search.appverid: 
  - MOE150
  - MET150
ms.custom: 
  - sap:eDiscovery
  - CI 157398
  - seo-marvel-apr2020
  - CSSTroubleshoot
---
# Resolve eDiscovery hold errors

This article discusses common issues that might occur with eDiscovery holds and how to resolve them. The article also includes recommended practices to help you mitigate or avoid these issues.

For eDiscovery search issues, see [Resolve search errors in eDiscovery (Standard)](resolve-ediscovery-issues.md).

## Recommended practices

To reduce the number of errors related to eDiscovery holds, we recommend the following practices:

- If a hold distribution is still pending, with a status of either `On (Pending)` or `Off (Pending)`, wait until the hold distribution is complete before you make any further updates.

- Check whether a hold policy is pending before you make any further updates to it. Run the following commands or save them to a PowerShell script.

    ```powershell
    $status = Get-CaseHoldPolicy -Identity <policyname> -DistributionDetail
    if($status.DistributionStatus -ne "Pending"){
        # policy no longer pending
        Set-CaseHoldPolicy -Identity <policyname> -AddExchangeLocation $user1
    }else{
        # policy still pending
        Write-Host "Hold policy still pending."
    }
   ```

- Merge your updates to an eDiscovery hold in a single bulk request rather than updating the hold policy repeatedly for each transaction. For example, to add multiple user mailboxes to an existing hold policy using the [Set-CaseHoldPolicy](/powershell/module/exchange/set-caseholdpolicy) cmdlet from [Security & Compliance PowerShell](/powershell/exchange/scc-powershell?view=exchange-ps&preserve-view=true), run the command, or add as a code block to a script, so that it runs only once to add multiple users.

  **Correct**

    ```powershell
    Set-CaseHoldPolicy -Identity "policyname" -AddExchangeLocation "User1", "User2", "User3", "User4", "User5"
    ```

  **Incorrect**

    ```powershell
    $users = "User1", "User2", "User3", "User4", "User5"
    ForEach($user in $users)
    {
        Set-CaseHoldPolicy -Identity "policyname" -AddExchangeLocation $user
    }
    ```

   In the previous incorrect example, the cmdlet is run five separate times to complete the task. For more information about the recommended practices for adding users to a hold policy, see the [More information](#more-information) section.

- Before contacting Microsoft Support about eDiscovery hold issues, check into what is causing the policy to fail by checking into the DistributionResults, based on the ResultCode:

   ```powershell
   Get-CaseHoldPolicy -Identity "policyname" -DistributionDetail | Select -ExpandProperty DistributionResults
   ```

   :::image type="content" source="media/resolve-ediscovery-hold-issues/hold-distribution-results.png" alt-text="Screenshot to check into the DistributionResults, based on the ResultCode." border="false":::

## Error: PolicySyncTimeout

If you see this error in the **ResultCode: PolicySyncTimeout** and the following error message, check the LastResultTime to see if it is longer than two hours since the sync reached the time-out.

> It's taking longer than expected to deploy the policy. It might take an additional 2 hours to update the final deployment status, so check back in a couple hours.

### Resolution

Run the `Set-CaseHoldPolicy -Identity "policyname" -RetryDistribution` to resolve the issue.

   ```powershell
   Set-CaseHoldPolicy "policyname" -RetryDistribution
   ```

Also in the case hold page in the Microsoft Purview portal, select **Retry** to redeploy the policy.

:::image type="content" source="media/resolve-ediscovery-hold-issues/retry-case-hold.png" alt-text="Screenshot to select the Retry option in the case hold page.":::

## Error: PolicyNotifyError

If you see this error in the **ResultCode: PolicyNotifyError** and the following error message, a datacenter issue interrupted the policy sync.

> Policy cannot be deployed to the content source due to a temporary Microsoft 365 datacenter issue. The current policy is not applied to any content in the source, so there's no impact from the blocked deployment. To fix this issue, please try redeploying the policy.

### Resolution

Run the `Set-CaseHoldPolicy -Identity "policyname" -RetryDistribution` to resolve the issue.

   ```powershell
   Set-CaseHoldPolicy "policyname" -RetryDistribution
   ```

Also in the case hold page in the Microsoft Purview portal, select **Retry** to redeploy the policy.

:::image type="content" source="./media/resolve-ediscovery-hold-issues/retry-case-hold.png" alt-text="Screenshot to retry a case hold.":::

## Error: InternalError

If you see this error in the **ResultCode: InternalError** and the following error message, this issue needs to be resolved by Microsoft.

> Policy deployment has been interrupted by an unexpected Microsoft 365 datacenter issue. Please contact Microsoft support to fix the deployment issue.

### Resolution

Contact Microsoft Support with the following information:

- Policy name
- Microsoft 365 service or feature
- Result code
- Result message
- Diagnostics

## Error: FailedToOpenContainer

If you see this error in the **ResultCode: FailedToOpenContainer** and the following error message when putting custodians and data sources on hold, use the following steps to resolve the issue.

> The mailbox or SharePoint site may not exist.  If this is incorrect, please contact Microsoft support.  Otherwise, please remove it from this policy.

### Resolution

- To check whether the user mailbox exists in your organization, run the [Get-Mailbox](/powershell/module/exchange/get-mailbox) command in Exchange Online PowerShell.

- To check whether the site exists in your organization, run the [Get-SPOSite](/powershell/module/sharepoint-online/get-sposite) command in SharePoint Online PowerShell.

- Check whether the site URL changed.

- Remove the mailbox or site from the policy if the object doesn't exist.

## Error: SiteInReadonlyOrNotAccessible

If you see this error in the **ResultCode: SiteInReadonlyOrNotAccessible** and the following error message, the SharePoint site is in read-only mode.

> The SharePoint site is read-only or not accessible. Please contact the site administrator to make the site writable, and then redeploy this policy.

### Resolution

Unlock the site (or ask an admin to unlock it) to resolve this issue. To learn more about how to change the lock state for a site, see [Lock and unlock sites](/sharepoint/manage-lock-status).

## Error: SiteOutOfQuota

If you see this error in the **ResultCode: SiteOutOfQuota** and the following error message, then the SharePoint site reached its storage quota.

> The SharePoint site does not have enough quota. Please allocate more quota to the site collection, and then redeploy this policy.

### Resolution

Add more storage to the site, or ask an admin to add more storage to the site collection. To learn how to manage the storage quotas for a site, see [Manage site collection storage limits](/sharepoint/manage-site-collection-storage-limits).

After more storage quota is added to the site, the policy must be redeployed.

   ```powershell
   Set-CaseHoldPolicy "policyname" -RetryDistribution
   ```

Also, in the case hold page in the Microsoft Purview portal, select **Retry** to redeploy the policy.

:::image type="content" source="./media/resolve-ediscovery-hold-issues/retry-case-hold.png" alt-text="Screenshot to retry a case hold.":::

## Error: RecipientTypeNotAllowed

If you see this error in the **ResultCode: RecipientTypeNotAllowed** and the following error message, an Exchange location that is a mailbox is assigned to the policy.

> The Recipient Type is not allowed for holds.

### Resolution

To check whether the address for the endpoint is a valid mailbox, run the [Get-Recipient](/powershell/module/exchange/get-recipient) command in Exchange Online PowerShell.

If the cmdlet determines that the SMTP address isn't a valid mailbox, remove it from the policy.

```powershell
Set-CaseHoldPolicy "policyname" -RemoveExchangeLocation "non-mailbox user"
```

## More information

The guidance about updating hold policies for multiple users in the "Recommended practices" section results from the fact that the system blocks simultaneous updates to a hold policy. When an updated hold policy is applied to new content locations and the hold policy is in a pending state, you can't add more content locations to the hold policy.

Here are some things to keep in mind to help you mitigate this issue:
  
- Every time a hold updated is updated, it immediately goes into a pending state. The pending state status means the hold is being applied to content locations.
  
- If you have a script that runs a loop and adds locations to policy one by one, the first content location such as a user mailbox initiates the sync process that triggers the pending state. That means you will see an error for the other users who are added to the policy in subsequent loops.
  
- If your organization is using a script that runs a loop to update the content locations for a hold policy, you must update the script so that it updates locations in a single bulk operation.
