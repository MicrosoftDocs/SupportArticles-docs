---
title: Description of the Windows Server Update Services 3.0 Service Pack 1 package
description: Describes the Windows Server Update Services 3.0 Service Pack 1 package.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, edwardr, danalb, mandarg, oscarlee, davidhen, sudheer, sivsha, bmoore, cecils
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Description of the Windows Server Update Services 3.0 Service Pack 1 package

This article provides some information about Windows Server Update Services 3.0 Service Pack 1 package.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 948014

## Introduction

Microsoft has released a service pack for Microsoft Windows Server Update Services 3.0 (WSUS). This article includes information about how to obtain the service pack and how to obtain a list of issues that the service pack fixes. Additionally, this article includes information about the issues that you may experience when you install the service pack and information about how to determine whether the service pack is installed.

## More information

### How to obtain and install WSUS 3.0 Service Pack 1 (SP1)

The following file is available for download from the Microsoft Download Center:  

:::image type="icon" source="media/description-of-windows-server-update-services-3/download-icon.png":::
 [Download the WSUS 3.0 Service Pack 1 package now.](https://www.catalog.update.microsoft.com/Search.aspx?q=Windows%20Server%20Update%20Services%203.0%20sp2)  

For more information about how to download Microsoft support files, click the following article number to view the article in the Microsoft Knowledge Base:  
[119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services
Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

### Removal information

You cannot use Add or Removed Programs in Control Panel to remove only WSUS 3.0 Service Pack 1 because it will remove all of WSUS 3.0 as well.

### Issues that the service pack fixes


- Bulk approval of updates now does not overwrite existing approvals. Instead, bulk approval now updates to a new target group. Bulk approval does not overwrite the existing approvals of the old target groups. By default, bulk approval will add to the existing set of approvals for an update that is not approved.

- Optional approvals are considered when computing effective approval for overlapping target groups. A required approval will override an optional approval in the following scenario:

  - A computer is a member of multiple target groups.
  - An update is approved for optional approval to one of the target groups.
  - The same update is approved for required approval to at least one of the other target groups that is at the same or greater depth in the target group tree.  
  > [!NOTE]
  > We recommend that you use the WSUS APIs to "optionally" approve updates for WSUS 3.0 SP1 and to approve updates that are not critical updates or security updates.

  For example, assume that you have a required approval on Update X for Group A and an optional approval for Group B. If a computer belongs to both Group A and Group B, the update would be listed as optional on the client computer. Because the target groups are at the same level, required approval should always "win."
- The Computer Detailed Status report to Excel works.
- The Configuration Wizard keeps a proxy server password if one is set before upgrade.
- Support is provided for a separate proxy server and port for SSL traffic.
- Provides improved performance by turning off AUTO SHRINK on SUSDB.
- Some client updates are based on Windows Error reporting (Watson).
- The Add Printer Wizard now works when you receive lots of drivers from Windows Update.

### How to determine whether the service pack is installed

Look for "Windows Server Update Services 3.0 SP1" in Add or Remove Programs in Control Panel or Program Files and Features in Control Panel. If "Windows Server Update Services 3.0 SP1" does not appear, the service pack is not installed.

### The improvements of WSUS 3.0 SP1

WSUS 3.0 SP1 includes the following improvements:

- Added support for Windows Server 2008.
- Added a new Client Servicing API:

  - Support client registration
  - Filter of updates by category and classification
  - Applicability rule extension mechanism
  - Package metadata and report update status for each client
- Added improvements for local publishing. Supports publishing of drivers within the enterprise by using vendor-provided catalogs. The API includes support for bundles and for prerequisites.
- Includes all the hotfixes that have been issued since the release of WSUS 3.0.
- Performance improvements. These include in-line data compression between the WSUS server and the remote administration console.

> [!NOTE]
> In Windows Server 2008, you must enable dynamic compression for Internet Information Services (IIS).

### The WSUS 3.0 SP1 Update Package

WSUS 3.0 SP1 is available on Windows Update. The package behavior is as follows:

- An upgrade occurs for all earlier versions of WSUS starting with WSUS 2.0 through the original version of WSUS 3.0. The original version of WSUS 3.0 runs on computers that are running Windows Server 2003 SP1 or later versions.
- All upgrades require user interaction.
- This service pack package supersedes previous updates for WSUS 3.0.
- Upgrades of all WSUS installations that use remote SQL Server installations are blocked. This is now a manual upgrade process.
- Upgrades of earlier versions of WSUS that are running on Windows Server 2008 are not supported.
- The original version of System Center Essentials 1.0 is not upgraded to WSUS 3.0 SP1. This will be handled by a future release of System Center Essentials.>  
>[!NOTE]
> "WSUS 2.0 SP1" and "WSUS 2.0 Client SelfUpdate Update for WSUS 2.0 SP1" packages will be expired. These updates are still available on the following Microsoft Web site: [https://www.microsoft.com/download/Search.aspx](https://www.microsoft.com/download/search.aspx) 

### Known issues with WSUS 3.0 SP1


- You receive an error message during the installation: "Failed to set SMTP_USERPASSWD property from SmtpUserPassword registry value (Error 0x800700EA: More data is available.)" 

Symptoms 

During the installation of this package, you may receive an error message that resembles the following in the %temp%\Wsussetup.log file:

>Error MWUSSetup CUpgradeDriver::PerformPresetupActions: Failed to set SMTP_USERPASSWD property from SmtpUserPassword registry value (Error 0x800700EA: More data is available.)
 
 Cause 

This problem occurs because a Simple Mail Transfer Protocol (SMTP) password that is greater than 11 characters fails. This causes the WSUS 3.0 SP1upgrade to fail. WSUS does not copy its local copy of the password.

Workaround 

To work around this issue, temporarily change the locally saved password, run the WSUS 3.0 SP1 upgrade, and then change the password back to the original password that is used by the SMTP account. To do this, follow these steps:

1. Click **Start**, click
 **Administrative Tools**, and then click **Microsoft Windows Update Server Services 3.0**.
  2. Click to select **Options**, and then click **E-Mail notification**.
  3. On the **E-Mail Server** tab, enter a password that is less than 12 characters.
  4. Click **OK** to save the password.

  > [!NOTE]
  > Do not use Test because this password would be invalid for the SMTP account.
  5. Exit the WSUS Administration tool.
  6. Run the WSUS 3.0 SP1 upgrade.
  7. After you successfully upgrade to WSUS 3.0 SP1, change the password back to the original password.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
