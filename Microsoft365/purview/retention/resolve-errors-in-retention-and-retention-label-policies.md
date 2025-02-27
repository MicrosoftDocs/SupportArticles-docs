---
title: Resolve errors in Microsoft 365 retention and retention label policies
description: Resolves errors in Microsoft 365 retention and retention label policies.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kyrachurney, lindabr, meerak
ms.custom: 
  - sap:Retention Labels
  - CI 171536
  - CSSTroubleshoot
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 06/24/2024
---

# Resolve errors in Microsoft 365 retention and retention label policies

If you encounter an error that's related to Microsoft 365 retention or retention label policies, select the applicable error description from the following list:

- [Settings not found](#error-settings-not-found)
- [Something went wrong](#error-something-went-wrong)
- [The location is ambiguous](#error-the-location-is-ambiguous)
- [The location is out of storage](#error-the-location-is-out-of-storage)
- [The site is locked](#error-the-site-is-locked)
- [We're still processing your policy](#error-were-still-processing-your-policy)
- [We can't process your policy](#error-we-cant-process-your-policy)
- [We couldn't find this location](#error-we-couldnt-find-this-location)
- [We ran into a problem](#error-we-ran-into-a-problem)
- [You can't apply a hold here](#error-you-cant-apply-a-hold-here)
- [Your policy is stuck in PendingDeletion](#error-your-policy-is-stuck-in-pendingdeletion)

If none of the resolutions apply to your issue, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=2189021).

For information about how to identify retention policy errors, see [Identify errors in Microsoft 365 retention and retention label policies](identify-errors-in-retention-and-retention-label-policies.md).

> [!IMPORTANT]
> Microsoft Purview doesn't support policies that contain errors. You must first resolve all policy errors. Otherwise, retention and retention label policies might not function as intended.

## Error: Settings not found

### Symptoms

When you check the details pane for a retention policy in the Microsoft Purview compliance portal, you see the error message, "Settings not found."

### Cause

Your retention policy has no retention rules.

### Resolution

To resolve this issue, use either of the following methods.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy, and then select **Edit**.

3. In **Retention settings**, add [rules](/microsoft-365/compliance/retention-settings#settings-for-retaining-and-deleting-content) to your retention policy.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Use the applicable cmdlet for your workload to add rules to your retention policy.

   Use the [New-RetentionComplianceRule](/powershell/module/exchange/new-retentioncompliancerule) cmdlet for policies that target:

   - Microsoft Exchange Online email
   - Microsoft SharePoint sites
   - Microsoft OneDrive accounts
   - Microsoft 365 Groups
   - Microsoft Skype for Business conversations
   - Exchange Online public folders
   - Microsoft Teams chat messages
   - Teams channel messages

   For example, to add a rule that specifies an unlimited retention period, run the following command:

   ```powershell
   New-RetentionComplianceRule -Name "<new rule name>" -Policy "<existing policy name>" -RetentionDuration Unlimited
   ```

   Use the [New-AppRetentionComplianceRule](/powershell/module/exchange/new-appretentioncompliancerule) cmdlet for policies that target:

   - Teams private channel messages
   - Microsoft Viva Engage user messages
   - Viva Engage community messages

   For example, to add a rule that specifies an unlimited retention period, run the following command:

   ```powershell
   New-AppRetentionComplianceRule -Name "<new rule name>" -Policy "<existing policy name>" -RetentionDuration Unlimited
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: Something went wrong

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "Something went wrong."

If you run the following command, you see `PolicyNotifyError` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

An unspecified error occurred in the notification pipeline of the policy sync and distribution process.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

3. In the policy details pane, select **Retry**. The policy enters a pending state until policy sync and distribution finishes.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: The location is ambiguous

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "The location is ambiguous."

If you run the following command, you see `MultipleInactiveRecipientsError` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

The system returned more than one result for the specified location. For the system to apply a policy, each applicable location must have one match.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane that opens when you select the policy name.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy, and then select **Edit**.

3. Remove the duplicate locations from the policy.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Remove the duplicate locations from the policy by using the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet. For example, to remove an Exchange location use the `RemoveExchangeLocation` switch.

3. Retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: The location is out of storage

### Symptoms

When you try to create or update a policy in the Microsoft Purview compliance portal, the operation fails. In the details pane for the policy, you see the error message, "The location is out of storage."

If you run the following command, you see `SiteOutOfQuota` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

The location doesn't have enough available storage for the system to apply your policy or policy update.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. Increase the storage quota for the specified location. Contact the site administrator or global SharePoint administrator to manage the quota for the location. You can also delete unnecessary items to increase available storage.

2. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

3. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

4. In the policy details pane, select **Retry**. The policy enters a pending state until policy sync and distribution finishes.

#### Method 2: Use PowerShell

1. Increase the storage quota. Contact the site administrator or global SharePoint administrator to manage the quota for the location. You can also delete unnecessary items to increase available storage.

2. After you increase the storage quota, [connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

3. Retry policy sync and distribution. To redeploy the policy, use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: The site is locked

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "The site is locked."

If you run the following command, you see `SiteInReadOnlyOrNotAccessible` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

An administrator locked the site, or the system temporarily locked the site during an automated process. During an automated process, updates aren't permitted.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. Contact the site administrator or global SharePoint administrator to [unlock the site](/sharepoint/manage-lock-status), and then redeploy this policy.

2. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

3. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

4. In the policy details pane, select **Retry**. The policy enters a pending state until policy sync and distribution finishes.

#### Method 2: Use PowerShell

1. To [unlock the site](/sharepoint/manage-lock-status), contact the site administrator or global SharePoint administrator, and then redeploy this policy

2. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

3. When the site is unlocked, retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: We're still processing your policy

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "We're still processing your policy."

If you run the following command, you see `PolicySyncTimeout` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

The policy sync didn't finish within the expected timeframe.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

3. In the policy details pane, select **Retry**. The policy enters a pending state until policy sync and distribution finishes.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: We can't process your policy

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "We can't process your policy."

If you run the following command, you see `ActiveDirectorySyncError` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

The policy didn't sync with Microsoft Entra ID.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

3. In the policy details pane, select **Retry**. The policy enters a pending state until policy sync and distribution finishes.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: We couldn't find this location

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "We couldn't find this location."

If you run the following command, you see `FailedToOpenContainer` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

The policy can't sync to a location because the location doesn't exist. The location might have existed previously.

> [!NOTE]
> If this error occurs, the system requires that you remove the problematic locations as part of your next update to the policy.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

3. Remove the problematic locations from the policy.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Remove the problematic locations from the policy by using the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet. For example, to remove an Exchange location use the `RemoveExchangeLocation` switch.

3. Retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: We ran into a problem

### Symptoms

When you check the details pane for a policy in the Microsoft Purview compliance portal, you see the error message, "We ran into a problem."

If you run the following command, you see `InternalError` in the value that's returned by the `DistributionResults` property:

```powershell
Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
```

### Cause

An unspecified error occurred in the policy sync and distribution process.

### Resolution

To resolve this issue, use either of the following methods. If you use method 1, check for additional resolution options in the policy details pane.

#### Method 1: Use the Microsoft Purview compliance portal

1. In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/), search for the policy on the following tabs:

   - **Data Lifecycle Management** \> **Microsoft 365** \> **Retention policies**
   - **Data Lifecycle Management** \> **Microsoft 365** \> **Label policies**
   - **Records Management** \> **Label policies**

2. Select the policy to open the policy details pane. Make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

3. In the policy details pane, select **Retry**. The policy enters a pending state until policy sync and distribution finishes.

#### Method 2: Use PowerShell

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Retry policy sync and distribution. Use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet together with the `RetryDistribution` switch to redeploy the policy:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<policy name>" -RetryDistribution
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: You can't apply a hold here

### Symptoms

When you try to add a location to a policy in the Microsoft Purview compliance portal, the operation fails and you see the error message, "You can't apply a hold here."

If you try to add a location to a policy by using PowerShell, you receive the `RecipientTypeNotAllowed` error message.

### Cause

You tried to add a mailbox location to a policy, but the policy doesn't support the mailbox type. This error occurs only when a location is added to a policy.

### Resolution

To resolve this issue, use either of the following methods.

#### Method 1: Use the Microsoft Purview compliance portal

1. Go back to the step in which you specified the policy locations, and then remove the problematic locations from the policy.

2. Retry your update.

#### Method 2: Use PowerShell

1. In the script or command that you used to add locations, remove the problematic locations. The applicable PowerShell cmdlets are:

   - [New-RetentionCompliancePolicy](/powershell/module/exchange/new-retentioncompliancepolicy)
   - [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy)
   - [New-AppRetentionCompliancePolicy](/powershell/module/exchange/new-appretentioncompliancepolicy)
   - [Set-AppRetentionCompliancePolicy](/powershell/module/exchange/set-appretentioncompliancepolicy)

2. Retry your update.

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## Error: Your policy is stuck in PendingDeletion

### Symptoms

When you try to delete a policy, the operation fails.

### Cause

An unspecified error occurred when you tried to delete the policy.

### Resolution

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Remove the policy. Use the [Remove-RetentionCompliancePolicy](/powershell/module/exchange/remove-retentioncompliancepolicy) cmdlet together with the `ForceDeletion` switch:

   ```powershell
   Remove-RetentionCompliancePolicy -Identity "<policy name>" -ForceDeletion
   ```

[Back to top](#resolve-errors-in-microsoft-365-retention-and-retention-label-policies)

## More information

For information about how to troubleshoot eDiscovery issues, see [Resolve common eDiscovery issues](/microsoft-365/troubleshoot/ediscovery/resolve-ediscovery-issues).
