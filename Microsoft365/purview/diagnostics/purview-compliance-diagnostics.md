---
title: Self-help diagnostics for issues in Microsoft Purview
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
  - CI 2772
ms.reviewer: lindabr, meerak, v-shorestris
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 12/09/2024
---

# Self-help diagnostics for issues in Microsoft Purview

Self-help diagnostics in the Microsoft 365 admin center can help you identify and resolve common issues in Microsoft Purview. Diagnostics provide insights and instructions for fixing common problems. In some cases, diagnostics can fix issues. However, they don't make changes to your tenant without your consent.

> [!NOTE]
> Microsoft Purview diagnostics aren't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

## Access diagnostics through shortcut links

The following diagnostics cover various areas in Microsoft Purview. To access a diagnostic, select the associated shortcut link. When you're prompted, sign in to the Microsoft 365 admin center as an administrator. 

| Diagnostic | Description | Shortcut link | Support article |
|-|-|-|-|
| Archive mailbox diagnostics | Check and identify issues related to mailbox archiving. | [Check archive mailbox](https://aka.ms/PillarArchiveMailbox) | [Enable archive mailboxes for Microsoft 365](/microsoft-365/compliance/enable-archive-mailboxes) |
| Retention policy diagnostics for a user mailbox | Check retention policy settings for a user mailbox. | [Check retention policy on a user mailbox](https://aka.ms/PillarRetentionPolicy) | [Retention tags and retention policies in Exchange Online](/exchange/security-and-compliance/messaging-records-management/retention-tags-and-policies) |
| Invalid retention or grace eDiscovery hold | Detect and remove an invalid retention or grace eDiscovery hold that prevents an administrator from deleting a site | [Check invalid retention hold](https://aka.ms/PillarInvalidRetention) | [Can't delete a site because of a retention policy or eDiscovery hold](/sharepoint/troubleshoot/sites/compliance-policy-blocking-site-deletion) |
| Compromised account diagnostics | Identify suspicious account activities and return information that can be used to recover the account if it's compromised. | [Check compromised account](https://aka.ms/diagca) | [Responding to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account) |
| eDiscovery RBAC check | Check whether the Search, Export, or Preview roles are assigned to the designated administrator account. | [Check eDiscovery RBAC](https://aka.ms/PillareDisRBACDiag) | [Resolve search errors in eDiscovery (Standard)](/microsoft-365/troubleshoot/ediscovery/resolve-ediscovery-issues) |
| DLP rule and policy configuration | Troubleshoot common issues that affect a DLP rule and its policy. Run this diagnostic to make sure that a DLP rule and its policy are correctly configured for use in these workloads:<ul><li>Exchange Online</li><li>Endpoint devices</li><li>SharePoint</li><li>OneDrive for Business</li></ul> | [Analyze DLP rule and policy configuration](https://aka.ms/PillarDLPPolicyConfig) | |
| DLP policy and rule configuration for policy tips | Troubleshoot common policy tip configuration issues that affect a DLP rule and its policy for Outlook desktop clients and Outlook on the web. | [Analyze DLP Policy and rule configuration for policy tips](https://aka.ms/PillarDLPPolicyTipsDiag) | [Resolve issues that affect DLP policy tips](/microsoft-365/troubleshoot/data-loss-prevention/data-loss-prevention-policy-tips) |
| Sensitivity label configuration | Troubleshoot common issues that affect a sensitivity label. Run this diagnostic to make sure that a sensitivity label is correctly configured for use in various workloads. | [Analyze sensitivity label configuration](https://aka.ms/PillarMipLabelDiag) | [Sensitivity labels are missing in Outlook, Outlook on the web, and other Office apps](/microsoft-365/troubleshoot/sensitivity-labels/sensitivity-labels-missing) |
| Validate Office Message Encryption (OME) configuration | Validate the tenant configuration for Office Message Encryption (OME) and identify issues in the configuration. Perform validation based on the OME and IRM configuration and the transport and journaling rules. | [Validate Microsoft Message Purview Encryption configuration](https://aka.ms/PillarOMEDiag) | [Resolve Microsoft Purview Message Encryption issues](/microsoft-365/troubleshoot/office-message-encryption/fix-message-encryption-issue-microsoft-purview) |

## Access diagnostics through text analytics

If you don't find an applicable diagnostic in the table, follow these steps:

1. Sign in to the [Microsoft 365 admin center](https://portal.office.com/AdminPortal/Home) as an administrator.

2. Select the **Help & support** floating button in the bottom-right corner of the screen to open the **Help** pane.

3. In the search box, enter a brief description of the issue that you want to resolve.

4. Select one of the listed options that are generated by text analytics.

5. If the selected option has an associated diagnostic, enter any requested information, and then select **Run Tests**.
