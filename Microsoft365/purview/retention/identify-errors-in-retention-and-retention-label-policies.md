---
title: Identify errors in Microsoft 365 retention and retention label policies
description: How to identify errors in Microsoft 365 retention and retention label policies.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kyrachurney, lindabr, meerak
ms.custom: 
  - sap:Retention
  - CI 171536
  - CSSTroubleshoot
appliesto: 
  - Microsoft Purview
search.appverid: MET150
ms.date: 05/05/2025
---

# Identify errors in Microsoft 365 retention and retention label policies

This article provides steps that you can follow to check for errors in Microsoft 365 retention or retention label policies. You can find these policies in the [Data Lifecycle Management](https://compliance.microsoft.com/informationgovernance) and [Records Management](https://compliance.microsoft.com/recordsmanagement) solutions within the [Microsoft Purview compliance portal](https://compliance.microsoft.com/).

Policy errors can occur during the policy sync and distribution process in [Microsoft Purview](/azure/purview/overview). This process is a prerequisite for policy enforcement. How a policy is enforced depends on the type of policy:

- For retention policies, the system creates rules to enforce policy settings, such as retain and delete behaviors.

- For published label policies, enforcement means that the system makes published labels available for use in user-defined locations. Users can then manually apply the published labels.

- For auto-apply label policies, enforcement means that the system applies labels to content according to user-defined criteria.

Policy errors can occur in both [static and adaptive scope](/microsoft-365/compliance/retention#adaptive-or-static-policy-scopes-for-retention) policies.

> [!IMPORTANT]
> Microsoft Purview doesn't support policies that contain errors. You must first resolve all policy errors. Otherwise, retention and retention label policies might not function as intended.

## How to check for policy errors

Use one of the following methods to check for policy errors.

### Method 1: Use the Microsoft Purview compliance portal

In the [Microsoft Purview compliance portal](https://compliance.microsoft.com/):

- Browse to **Data Lifecycle Management** \> **Microsoft 365**. For each policy on the **Retention policies** and **Label policies** tabs, select the policy, and then check the **Status** section in the policy details pane.

- Select **Records Management**. For each policy on the **Label policies** tab, select the policy, and then check the **Status** section in the policy details pane.

> [!NOTE]
> When you select the policy to open the policy details pane, make sure that you select the policy name and not the corresponding checkbox. Otherwise, the details pane won't open.

### Method 2: Use PowerShell

Use the following steps to check for errors in policies that target:

- Microsoft Exchange Online email
- Microsoft SharePoint sites
- Microsoft OneDrive accounts
- Microsoft 365 Groups
- Microsoft Skype for Business conversations
- Exchange Online public folders
- Microsoft Teams chat messages
- Teams channel messages

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Get policy information by using the [Get-RetentionCompliancePolicy cmdlet](/powershell/module/exchange/get-retentioncompliancepolicy). Run the following commands:

   ```powershell
   Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | FL DistributionStatus
   Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
   ```

   Any policy errors appear in the value that's returned by the `DistributionStatus` property. If there are policy errors, the value that's returned by the `DistributionResults` property contains more information about the errors.

Use the following steps to check for errors in policies that target:

- Teams private channel messages
- Microsoft Viva Engage user messages
- Viva Engage community messages

1. [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

2. Get policy information by using the [Get-AppRetentionCompliancePolicy cmdlet](/powershell/module/exchange/get-appretentioncompliancepolicy). Run the following commands:

   ```powershell
   Get-AppRetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | FL DistributionStatus
   Get-AppRetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | Select -ExpandProperty DistributionResults
   ```

   Any policy errors appear in the value that's returned by the `DistributionStatus` property. If there are policy errors, the value that's returned by the `DistributionResults` property contains more information about the errors.

## Recommended practices

To minimize retention policy errors, follow these practices:

- If you use PowerShell, choose appropriate cmdlets for the applicable policy type and workloads. Different cmdlets apply to different workloads. For more information about the available cmdlets, see [Identify the available PowerShell cmdlets for retention](/microsoft-365/compliance/retention-cmdlets).

- Check whether the sync and distribution status of a policy is pending before you make any further updates to the policy. If you use the Microsoft Purview compliance portal, check the **Status** section in the policy details pane. If you use PowerShell, run the following command:

  ```powershell
  Get-RetentionCompliancePolicy -Identity "<policy name>" -DistributionDetail | FL DistributionStatus
  ```

  > [!IMPORTANT]
  > Wait until the policy status is no longer "Pending" before you make further changes to the policy.

- Merge your updates to a policy in a single bulk request instead of repeatedly running each policy update command. For example, if you want to add multiple locations to a policy, use the [Set-RetentionCompliancePolicy](/powershell/module/exchange/set-retentioncompliancepolicy) cmdlet to add all locations in a single bulk request. The following example shows how to do this:

  ```powershell
  Set-RetentionCompliancePolicy -Identity "<policy name>" -AddExchangeLocation "User1", "User2", "User3", "User4", "User5" -AddSharePointLocation https://contoso.sharepoint.com/sites/teams/finance
  ```

## More information

- For information about how to troubleshoot common retention policy errors, see [Resolve errors in Microsoft 365 retention and retention label policies](resolve-errors-in-retention-and-retention-label-policies.md).

- For information about how to troubleshoot eDiscovery issues, see [Resolve common eDiscovery issues](/microsoft-365/troubleshoot/ediscovery/resolve-ediscovery-issues).
