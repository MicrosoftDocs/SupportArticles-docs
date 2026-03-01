---
title: Self-Help Diagnostics for Microsoft Purview
description: Describes how to run self-help diagnostics to find and resolve issues that affect compliance solutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom:
  - sap:Microsoft Purview Compliance
  - Microsoft Purview
  - CSSTroubleshoot
  - CI 2772, 1283, 5607, 8191, 8567
ms.reviewer: shadans, sathyana, meerak, v-shorestris
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 01/29/2026
---

# Self-help diagnostics for Microsoft Purview

You can run diagnostics to identify and resolve issues in Microsoft Purview. The diagnostics offer insights into known issues, and provide instructions to fix the issues. Although the diagnostics can fix some configuration issues, they don't make changes to your tenant without your consent.

Self-help diagnostics that relate to Microsoft Purview are available in the following locations:

- [Microsoft Purview portal](https://purview.microsoft.com/)

   - On **Solutions** pages
   - In the **Help** pane

- [Microsoft 365 admin center](https://admin.microsoft.com/)

   - In the **Help** pane

## Diagnostics on Solutions pages

The diagnostics on **Solutions** pages currently cover the following areas in Microsoft Purview:

- Sensitivity labels and label policies
- Email message encryption
- Data loss prevention (DLP) policies

You can find these diagnostics on the following portal pages:

- **Solutions** \> **Information Protection** \> **Diagnostics**
- **Solutions** \> **Data Loss Prevention** \> **Diagnostics**

> [!NOTE]
> Diagnostics on **Solutions** pages are being rolled out gradually and might not yet be available in your organization. 

### Available diagnostics

The following table lists the available diagnostics on **Solutions** pages. You can access the diagnostics by selecting the associated link in the fourth column. When you're prompted, sign in to the Microsoft Purview portal.

> [!NOTE]
> To run these diagnostics, you must meet the minimum requirements:
> - Be an administrator
> - Have the Organization Configuration role assigned to you

When you select a diagnostic on a Solutions page, the diagnostic runs the [Check-PurviewConfig](/powershell/module/exchangepowershell/check-purviewconfig) cmdlet to check your organization's configuration settings in Microsoft Purview. Then, the diagnostic calls the appropriate cmdlet that's listed in the following table to perform checks that are specific to your issue. 

When you run diagnostics from the Solution page, it executes the [Check-PurviewConfig](https://learn.microsoft.com/en-us/powershell/module/exchangepowershell/check-purviewconfig?view=exchange-ps) cmdlet in the background to perform the necessary checks and displays the results.

| **Issue** | **Checks performed** | **Commandlet Used** | **Solutions page** |
|-|-|-|-|
| Email encryption isn't working as expected. Are there any issues that affect my licenses or settings? | Checks license availability for sensitivity labels. Also checks information protection settings for your tenant, including Information Rights Management (IRM) and transport rule settings. Verifies encryption settings. | [Test-IrmConfiguration](/powershell/module/exchangepowershell/test-irmconfiguration)| [Information Protection diagnostics](https://purview.microsoft.com/informationprotection/diagnostics) |
| A user can't find the sensitivity label they need. Does the label policy apply to them? | Checks which sensitivity labels are available to the user. Diagnostic results include information such as the label names, settings, and where the labels are available. | [Get-label](/powershell/module/exchangepowershell/get-label) <br> [Get-LabelPolicy](/powershell/module/exchangepowershell/get-labelpolicy) | [Information Protection diagnostics](https://purview.microsoft.com/informationprotection/diagnostics) |
| Autolabeling isn’t applied to a SharePoint or OneDrive file. Was the file evaluated correctly, and did it meet the autolabeling conditions? | Checks a file’s properties and classification to determine whether autolabeling was applied. When entering the file path, make sure that you provide the full file path, not a sharing link. <br> <br> Tips for finding the correct path: <br> - In SharePoint or OneDrive, select the file, open **Details**, and copy the **Path** (if available). <br> - If **Path** isn’t shown, open the file, go to **File** > **Info**, then select **Copy path**. | [Test-DlpPolices](/purview/dlp-test-dlp-policies) | [Information Protection diagnostics](https://purview.microsoft.com/informationprotection/diagnostics) |
| A DLP rule isn't enforced for a particular user. Is this user included in the DLP policy? | Checks which DLP policies apply to a user. Diagnostic results include the policy names and where the policies apply.| [Get-DlpCompliancePolicy](/powershell/module/exchangepowershell/get-dlpcompliancepolicy) <br> [Get-DlpComplianceRule](/powershell/module/exchangepowershell/get-dlpcompliancerule) | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |
| Endpoint DLP isn’t working as expected. Are there any issues that affect policy sync on the device? | Check for policy sync issues, and provide recommendations for how to resolve them. |[Get-DlpCompliancePolicy](/powershell/module/exchangepowershell/get-dlpcompliancepolicy) | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |
| Alerts aren't working for a DLP rule. Are there any issues that affect the DLP rule configuration? | Check for alerts, and determine whether any issues affect the DLP rule configuration.| [Get-DlpCompliancePolicy](/powershell/module/exchangepowershell/get-dlpcompliancepolicy) <br> [Get-DlpComplianceRule](/powershell/module/exchangepowershell/get-dlpcompliancerule) | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |
| Can't find an alert for an activity or an audit event. | Check for the alert related to an activity or audit event, and investigate why the alert could be missing. | [Get-DlpCompliancePolicy](/powershell/module/exchangepowershell/get-dlpcompliancepolicy) <br> [Get-DlpComplianceRule](/powershell/module/exchangepowershell/get-dlpcompliancerule) | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |
| A DLP rule isn’t triggering for a file stored in SharePoint or OneDrive. Is the file evaluated by DLP, and is it in scope for the policy? | Check a file's properties and classification to review whether a DLP rule matched or didn't match. When entering the file path, make sure that you provide the full file path, not a sharing link. <br> <br> Tips for finding the correct path: <br> - In SharePoint or OneDrive, select the file, open Details, and copy the Path (if available). <br> - If **Path** isn’t shown, open the file, go to File > Info, then select **Copy path**. | [Test-DlpPolices](/purview/dlp-test-dlp-policies) | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |
| Policy tips don't appear in Outlook on the web. Are there issues that affect the DLP policy tips configuration? | [Analyzes the HTTP Archive (HAR) file](../data-loss-prevention/diagnose-dlp-policy-tip-display-issues.md) to investigate why policy tips don't appear in Outlook on the web. <br> <br> Steps for finding and exporting the HAR file: <br> - Open Outlook on the web, and press F12 to open Developer Tools. <br> - Select the **Network** tab, select **Preserve log**, reproduce the issue, and export the HAR file. | [Test-DlpPolices](/purview/dlp-test-dlp-policies) | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |

## Diagnostics on the Help pane

The diagnostics in the **Help** pane cover the following areas in Microsoft Purview:

- Archive mailboxes
- Mailbox retention
- eDiscovery holds and searches
- Email account security
- Sensitivity labels and label policies
- Email message encryption
- DLP policies

> [!NOTE]
> Diagnostics in the **Help** pane aren't available in the following environments: GCC High, DoD, and Microsoft 365 operated by 21Vianet.

### Find diagnostics through the Help menu

You can search for diagnostics by using the **Help** menu in the Microsoft Purview portal or the Microsoft 365 admin center.

#### Microsoft 365 admin center

1. Sign in to the [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home) as an administrator.

2. Select the **Help** icon in the upper-right corner of the portal to open the **Help** pane.

3. In the search box, enter a brief description of the issue that you want to resolve.

4. Select one of the listed options that are generated based on the issue that you described.

5. If the selected option has an associated diagnostic, enter any requested information, and then select **Run Tests** to start the diagnostic.

#### Microsoft Purview portal

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/) as an administrator.

2. Open the **Help and support** pane: Select the **Help** icon in the upper-right corner of the portal.

3. Open the **Help** pane: In the **Help and support** pane, select **Ask a question**.

4. In the search box, enter a brief description of the issue that you want to resolve.

5. Select one of the listed options that are generated based on the issue that you described.

6. If the selected option has an associated diagnostic, enter any requested information, and then select **Run Tests** to start the diagnostic.

### Available diagnostics

The following table lists the available diagnostics on the **Help** pane. You can access each diagnostic by selecting the associated link in the first column. When you're prompted, sign in to the Microsoft 365 admin center as an administrator.

**Note**: To run these diagnostics, you must meet the minimum role requirement that's listed in the table.

| **Diagnostics** | **Checks performed** | **Minimum role** | **Support article** |
|-|-|-|-|
| [Archive mailbox](https://aka.ms/PillarArchiveMailbox) | Checks for issues that are related to archive mailboxes. | Any Microsoft 365 admin role | [Enable archive mailboxes for Microsoft 365](/microsoft-365/compliance/enable-archive-mailboxes) |
| [Retention policy for a user mailbox](https://aka.ms/PillarRetentionPolicy) | Checks the retention policy settings for a user mailbox. | Any Microsoft 365 admin role | [Retention tags and retention policies in Exchange Online](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies) |
| [Mailbox holds](https://aka.ms/PillarMailboxHoldsDiag) | Lists all holds that are applied to a mailbox. Hold types include: retention, eDiscovery, app retention, delay, and delay release. | Compliance admin | [How to identify the type of hold placed on an Exchange Online mailbox](/purview/ediscovery-identify-a-hold-on-an-exchange-online-mailbox) |
| [Grace eDiscovery hold or invalid retention policy](https://aka.ms/PillarInvalidRetention) | Identifies items that prevent site deletion, specifically active holds, compliance tags ([retention labels](/purview/retention)), and invalid retention policies. Provides an option to remove any grace eDiscovery hold or invalid retention policy that's found. | Compliance admin | [Can't delete a site because of a retention policy or eDiscovery hold](/sharepoint/troubleshoot/sites/compliance-policy-blocking-site-deletion) |
| [Compromised account](https://aka.ms/diagca) | Identifies suspicious account activities, and provides information about how to recover a compromised account. | Any Microsoft 365 admin role | [Respond to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account) |
| [eDiscovery RBAC](https://aka.ms/PillareDisRBACDiag) | Checks eDiscovery role-based access control (RBAC) to determine whether the Search, Export, or Preview roles are assigned to the designated administrator account. | Any Microsoft 365 admin role | [Resolve search errors in eDiscovery (Standard)](/microsoft-365/troubleshoot/ediscovery/resolve-ediscovery-issues) |
| [DLP policy and rule configuration](https://aka.ms/PillarDLPPolicyConfig)<br> | Troubleshoots common issues that affect a DLP policy and rule configuration. Checks whether a DLP policy and rule are correctly configured for use in the following workloads:<ul><li>Exchange Online</li><li>Endpoint devices</li><li>SharePoint</li><li>OneDrive for work or school</li></ul> | Global admin | [Scenario-based troubleshooting guide for DLP issues](https://techcommunity.microsoft.com/blog/microsoft-security-blog/scenario-based-troubleshooting-guide---dlp-issues/3445489)<br> |
| [DLP policy and rule configuration for policy tips](https://aka.ms/PillarDLPPolicyTipsDiag)<br> | Troubleshoots common policy tip configuration issues that affect a DLP rule and its policy for Outlook desktop clients and Outlook on the web. | Global admin | [Resolve issues that affect DLP policy tips](/microsoft-365/troubleshoot/data-loss-prevention/data-loss-prevention-policy-tips) |
| [Sensitivity label configuration](https://aka.ms/PillarMipLabelDiag)<br> | Troubleshoots common issues that affect a sensitivity label. Checks whether a sensitivity label is correctly configured for use in various workloads. | Global admin | [Sensitivity labels are missing in Outlook, Outlook on the web, and other Office apps](/microsoft-365/troubleshoot/sensitivity-labels/sensitivity-labels-missing) |
| [Microsoft Purview Message Encryption configuration](https://aka.ms/PillarOMEDiag)<br> | Validates the tenant configuration for Microsoft Purview Message Encryption. Identifies any configuration issues. | Any Microsoft 365 admin role | [Resolve Microsoft Purview Message Encryption issues](/microsoft-365/troubleshoot/office-message-encryption/fix-message-encryption-issue-microsoft-purview) |
| [Validate Audit configuration](https://aka.ms/PillarAuditConfigDiag)<br> | Validates general Audit Configuration. Checks Audit logs for a user and identifies configuration issues. |Global Admin| [Export, configure, and view audit log records](/purview/audit-log-export-records) |

**Note**: Microsoft Support agents can't provide assistance for diagnostics that appear in the **Help** pane. If you encounter any issues, you can use the Feedback link within the diagnostic to report the issue.
