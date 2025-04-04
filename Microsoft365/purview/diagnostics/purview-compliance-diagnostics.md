---
title: Self-Help Diagnostics for Issues in Microsoft Purview
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
  - CI 2772, 1283
ms.reviewer: shadans, sathyana, meerak, v-shorestris
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 04/04/2025
---

# Self-help diagnostics for Microsoft Purview

<!-- This article has been reviewed and approved for the specific use of global admin perms.  -->

You can run diagnostics to identify and resolve issues in Microsoft Purview. The diagnostics offer insights into known issues and provide instructions to fix them. Although the diagnostics can fix some configuration issues, they don't make changes to your tenant without your consent.

Self-help diagnostics that relate to Microsoft Purview are available in the following locations:

- [Microsoft Purview portal](https://purview.microsoft.com/)

   - On **Solutions** pages
   - On the **Help** pane

- [Microsoft 365 admin center](https://admin.microsoft.com/)

   - On the **Help** pane

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

The following table lists the available diagnostics. You can access diagnostics by selecting the associated link in the third column. When you're prompted, sign in to the Microsoft Purview portal.

**Note**: To run these diagnostics, you must be a Microsoft 365 global administrator.

| **Issue** | **Checks performed** | **Solutions page** |
|-|-|-|
| Email encryption isn't working as expected. Are there any issues with my licenses or settings? | Checks license availability for sensitivity labels. Also checks information protection settings for your tenant, including Information Rights Management (IRM) and transport rule settings. Validates encryption settings. | [Information Protection diagnostics](https://purview.microsoft.com/informationprotection/diagnostics) |
| A user can't find the sensitivity label they need. Does the label policy apply to them? | Checks which sensitivity labels are available to the user. Diagnostic results include information such as the label names, settings, and where the labels are available. | [Information Protection diagnostics](https://purview.microsoft.com/informationprotection/diagnostics) |
| A DLP rule isn't enforced for a particular user. Is this user included in the DLP policy? | Checks which DLP policies apply to a user. Diagnostic results include the policy names and where the policies apply. | [DLP diagnostics](https://purview.microsoft.com/datalossprevention/diagnostics) |

## Diagnostics on the Help pane

The diagnostics on the **Help** pane cover the following areas in Microsoft Purview:

- Archive mailboxes
- Mailbox retention
- eDiscovery holds and searches
- Email account security
- Sensitivity labels and label policies
- Email message encryption
- DLP policies

> [!NOTE]
> Diagnostics on the **Help** pane aren't available in the following environments: GCC High, DoD, and Microsoft 365 operated by 21Vianet.

### Find diagnostics through the Help menu

You can search for diagnostics by using the **Help** menu in the Microsoft Purview portal or the Microsoft 365 admin center.

#### Microsoft 365 admin center

1. Sign in to the [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home) as an administrator.

2. Select the **Help** icon in the upper-right corner of the portal to open the **Help** pane.

3. In the search box, enter a brief description of the issue that you want to resolve.

4. Select one of the listed options that are generated based on the issue that you described.

5. If the selected option has an associated diagnostic, enter any requested information, and then select **Run Tests**.

#### Microsoft Purview portal

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/) as an administrator.

2. Select the **Help** icon in the upper-right corner of the portal to open the **Help and support** pane.

3. In the **Help and support** pane, select **Ask a question** to open the **Help** pane.

4. In the search box, enter a brief description of the issue that you want to resolve.

5. Select one of the listed options that are generated based on the issue that you described.

6. If the selected option has an associated diagnostic, enter any requested information, and then select **Run Tests**.

### Available diagnostics

The following table lists the available diagnostics. You can access each diagnostic by selecting the associated link in the first column. When you're prompted, sign in to the Microsoft 365 admin center as an administrator.

**Note**: To run these diagnostics, you must meet the minimum role requirement.

| **Diagnostics** | **Checks performed** | **Minimum role** | **Support article** |
|-|-|-|-|
| [Archive mailbox](https://aka.ms/PillarArchiveMailbox) | Checks for issues that are related to archive mailboxes. | Any Microsoft 365 admin role | [Enable archive mailboxes for Microsoft 365](/microsoft-365/compliance/enable-archive-mailboxes) |
| [Retention policy for a user mailbox](https://aka.ms/PillarRetentionPolicy) | Checks the retention policy settings for a user mailbox. | Any Microsoft 365 admin role | [Retention tags and retention policies in Exchange Online](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies) |
| [Invalid retention policy or grace eDiscovery hold](https://aka.ms/PillarInvalidRetention) | Checks for and removes any invalid retention policy or grace eDiscovery hold that prevents an administrator from deleting a site. | Any Microsoft 365 admin role to check holds. Compliance admin role to remove a hold. | [Can't delete a site because of a retention policy or eDiscovery hold](/sharepoint/troubleshoot/sites/compliance-policy-blocking-site-deletion) |
| [Compromised account](https://aka.ms/diagca) | Identifies suspicious account activities, and provides information about how to recover a compromised account. | Any Microsoft 365 admin role | [Respond to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account) |
| [eDiscovery RBAC](https://aka.ms/PillareDisRBACDiag) | Checks eDiscovery role-based access control (RBAC) to determine whether the Search, Export, or Preview roles are assigned to the designated administrator account. | Any Microsoft 365 admin role | [Resolve search errors in eDiscovery (Standard)](/microsoft-365/troubleshoot/ediscovery/resolve-ediscovery-issues) |
| [DLP rule and policy configuration](https://aka.ms/PillarDLPPolicyConfig)<br> | Troubleshoots common issues that affect a DLP rule and its policy configuration. Checks whether a DLP rule and its policy are correctly configured for use in the following workloads:<ul><li>Exchange Online</li><li>Endpoint devices</li><li>SharePoint</li><li>OneDrive for work or school</li></ul> | Global admin | [Scenario-based troubleshooting guide for DLP issues](https://techcommunity.microsoft.com/blog/microsoft-security-blog/scenario-based-troubleshooting-guide---dlp-issues/3445489)<br> |
| [DLP policy and rule configuration for policy tips](https://aka.ms/PillarDLPPolicyTipsDiag)<br> | Troubleshoots common policy tip configuration issues that affect a DLP rule and its policy for Outlook desktop clients and Outlook on the web. | Global admin | [Resolve issues that affect DLP policy tips](/microsoft-365/troubleshoot/data-loss-prevention/data-loss-prevention-policy-tips) |
| [Sensitivity label configuration](https://aka.ms/PillarMipLabelDiag)<br> | Troubleshoots common issues that affect a sensitivity label. Checks whether a sensitivity label is correctly configured for use in various workloads. | Global admin | [Sensitivity labels are missing in Outlook, Outlook on the web, and other Office apps](/microsoft-365/troubleshoot/sensitivity-labels/sensitivity-labels-missing) |
| [Microsoft Purview Message Encryption configuration](https://aka.ms/PillarOMEDiag)<br> | Validates the tenant configuration for Microsoft Purview Message Encryption. Identifies any configuration issues. | Any Microsoft 365 admin role | [Resolve Microsoft Purview Message Encryption issues](/microsoft-365/troubleshoot/office-message-encryption/fix-message-encryption-issue-microsoft-purview) |
