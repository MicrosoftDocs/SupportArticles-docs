---
title: Windows Server Update Services 3.0 SP2 Dynamic Installer for Server Manager
description: Describes the Windows Server Update Services 3.0 SP2 Dynamic Installer for Server Manager.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# Windows Server Update Services 3.0 SP2 Dynamic Installer for Server Manager

This article describes the Windows Server Update Services 3.0 SP2 Dynamic Installer for Server Manager.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 972493

## Introduction

Microsoft has released the Windows Server Update Services (WSUS) 3.0 Service Pack 2 (SP2) Dynamic Install for Windows Server 2008. WSUS enables information technology administrators to fully manage the distribution of updates that are released through Microsoft Update to computers in their network.

This article includes information about the contents of the service pack, links to instructions and system requirements for installation on supported Windows Server 2008 operating systems by using Server Manager, and how to determine whether the service pack is installed.

## Feature improvements and important software updates in Service Pack 2

- Integration with Windows Server 2008 R2
- Support for the BranchCache feature on Windows Server 2008 R2
- Support for Windows 7 clients

## WSUS feature improvements

- Auto-approval rules: Auto-approval rules now include the ability to specify the approval deadline date and time for all computers or specific computer groups.
- Update files and languages: Improved handling of language selection for downstream servers includes a new warning dialog box that appears when you decide to download updates only for specified languages.
- Easy upgrade: WSUS 3.0 SP2 can be installed as an in-place upgrade from earlier versions of WSUS and preserves all settings and approvals. The user interface is compatible between WSUS 3.0 SP1 and SP2 on the client and the server.
- Reports: New Update and Computer Status reports let you filter on updates that are approved for installation. You can run these reports from the WSUS console or use the API to incorporate this functionality into your own reports.

## Software updates

- Stability and reliability fixes for the WSUS 3.0 server, such as support for IPv6 addresses that are longer than 40 characters.
- The approval dialog now sorts computer groups alphabetically by group name.
- Computer status report sorting icons are now functional in x64 environments.
- A new release of Windows Update Agent is included with WSUS 3.0 SP2. This new release provides improvements and fixes, such as support for APIs that are called by a nonlocal system callnoninteractiveteractive session.

## More information

By default, Windows Server 2008 SP2 includes the ability to install the WSUS Role Service by using Server Manager. This role lets you use the MMC Server Manager snap-in and wizards to install, configure, and manage WSUS 3.0 SP2. The dynamic package for WSUS 3.0 SP2 will only install by using Server Manager.

The WSUS 3.0 SP2 package has the following Microsoft Update detection logic and characteristics:

- Classification: Update
- Supersedes: WSUS 3.0 SP1
- This package is applicable only to the following Windows Server operating systems with the WSUS-Server Manager integration:

  - Windows Server 2008 SP1 with Server Manager

       For more information, click the following article number to view the article in the Microsoft Knowledge Base: [940518](https://support.microsoft.com/help/940518) An update is available that integrates Windows Server Update Services (WSUS) 3.0 into Server Manager in Windows Server 2008  

  - Windows Server 2008 SP2
  - Windows Server 2008 R2, x64 edition only  

- Applicability rules:

  - Is installed = No
  - Is installable  

- Download Center:

  - The WSUS 3.0 SP2 Download Center Web site includes the RTM Microsoft user license terms.
  - Pre-3.0 SP1 versions of WSUS 3.0 are no longer available for download.

After WSUS 3.0 is detected as installed by Server Manager, it can be configured and managed within the Server Manager user interface or the WSUS 3.0 snap-in. To install WSUS 3.0 SP2 on a server that runs Windows Server 2008 SP2 that is being updated by a WSUS 3.0 server, approve the Windows Server Update Services 3.0 SP2 Dynamic Install for Windows Server 2008, and then install WSUS role by using Server Manager.

## How to determine whether the service pack is installed

Look for "Windows Server Update Services 3.0 SP2" in **Add or Remove Programs** or **Program Files and Features** in Control Panel. If "Windows Server Update Services 3.0 SP2" doesn't appear, the service pack isn't installed.

## Removal information

You can't use **Add or Remove Programs** in Control Panel to remove only WSUS 3.0 Service Pack 2 because it will also remove all WSUS 3.0.

To remove WSUS 3.0 SP2 by using Server Manager, follow these steps:

1. Log on to the server on which you plan to remove WSUS 3.0 SP2 by using an account that is a member of the local Administrators group.
2. Click **Start**, point to **Administrative Tools**, and then click **Server Manager**.
3. In the right side pane of the **Server Manager** window, in the **Roles Summary** section, click **Remove Roles**.
4. If the **Before You Begin** page appears, click **Next**.
5. On the **Select Server Roles** page, clear the **Windows Server Update Services** check box.
6. On the **Windows Server Update Services** page, click **Next**.
7. On the **Confirm Installation Selections** page, click **Remove**.
8. On the **Remove Windows Server Update Services 3.0 SP2** page, select any additional items to be removed, and then click **Next**.
9. Click **Finish** to exit the wizard when the WSUS 3.0 SP2 Removal Wizard is finished.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
