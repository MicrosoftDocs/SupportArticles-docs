---
title: An update is available that integrates Windows Server Update Services (WSUS) 3.0 into Server Manager
description: Fixes a problem in which you cannot use the Server Manager snap-in to install WSUS, or WSUS does not appear in the Server Manager snap-in
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# An update is available that integrates Windows Server Update Services (WSUS) 3.0 into Server Manager

This article helps to fix a problem in which you cannot use the Server Manager snap-in to install WSUS, or WSUS does not appear in the Server Manager snap-in.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 940518

## Introduction

The Server Manager snap-in is a new feature in Windows Server 2008 that guides administrators through installing, configuring, and managing Windows Server 2008 roles and features.

By default, Windows Server 2008 includes several server roles. Server Manager enables integration of additional roles and features that are available from the Microsoft Download Center and from Windows Update Web sites as optional updates to Windows Server 2008. One role that is available as an update is Windows Server Update Services (WSUS) 3.0 with Service Pack 1 (SP1). This update for Server Manager in Windows Server 2008 fully integrates WSUS 3.0 SP1 into Server Manager. This update lets you use the Server Manager snap-in and wizards to install, configure, and manage WSUS 3.0 SP1.

If you do not plan to install the WSUS 3.0 SP1 Full server installation that includes the Administration Console or if you plan to install WSUS 3.0 SP1 Administration Console only, do not apply this update. If the WSUS 3.0 SP1 Full server installation that includes the Administration Console is installed on the computer, this update lets you use Server Manager to manage WSUS.

## More information

#### Update information

The following files are available for download from the Microsoft Download Center:  

Windows Server 2008

:::image type="icon" source="media/update-available-integrates-wsus-into-server-manager/download-icon.png":::
 [Download the update for Windows Server 2008 Server Manager (KB940518) package now.](https://www.catalog.update.microsoft.com/Search.aspx?q=940518)  

For more information about how to download Microsoft support files, click the following article number to view the article in the Microsoft Knowledge Base:  
 [119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services
Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

#### How to determine whether the service pack is installed

Look for **Update for Windows (KB940518)** in the **View installed updates** item or in the **Programs and Features** item in Control Panel. If **Update for Windows (KB940518)** does not appear, the update is not installed.

#### Installation instructions

To avoid restarting the computer, verify that the Initial Configuration Tasks, Server Manager, and the Servermanagercmd.exe process are not running during the installation process. You must also log on to the computer as an administrator to install this update.

1. On a computer that is running Windows Server 2008, download the update package from the Microsoft Web site that is listed in the "Update information" section.
2. Double-click the download package to start the Setup wizard. Follow the instructions in the wizard to complete the installation.

3. Use one of the following methods to open Server Manager:

    - Click **Start**, right-click **Computer**, and then click **Manage**.
    - Click **Start**, point to **Administrative Tools**, and then click **Server Manager**.
    - Click the Quick Launch bar, and then click **Server Manager**.

    > [!NOTE]
    > If WSUS 3.0 SP1 is already installed on your computer, you do not have to complete the remaining steps.

4. On the Server Manager home page, click **Add Roles** in the **Roles Summary** section.

5. On the **Select Roles** page of the **Add Roles Wizard**, click to select **Windows Server Update Services** from the list of available roles.

6. Follow the instructions in the Add Roles Wizard to complete installation.


#### Removal information

To uninstall Server Manager, follow these steps:
1. Click **Start**, click **Control Panel**, and then click **Programs**.

2. Under **Programs and Features**, click **View installed updates**.
3. In the list of updates to install under the Microsoft Windows group, double-click **Update for Windows (KB940518)**, and then follow the instructions to remove the update for Server Manager.


#### Known issues

If you install this update and WSUS 3.0 SP1 Admin Console only, you cannot install any other roles using Server Manager Add Role Wizard 

To work around this issue, remove the Update for Windows Server 2008 Server Manager (KB940518).
> [!NOTE]
> This issue is fixed in Windows Server 2008 SP2 and higher.

Server Manager incorrectly reports an installation failure 

Server Manager reports an installation failure in the following scenarios:
- You have used Server Manager to install WSUS 3.0 SP1, and you must restart the computer to finish the installation.
- You have restarted the computer after you installed WSUS 3.0 SP1. In this scenario, Server Manager incorrectly reports that the installation has failed and that it has generated the following error message:  
    >The update was found but could not be downloaded.  

No action is required to work around this issue. After you close the Add Roles Wizard, Server Manager shows that WSUS 3.0 SP1 was installed.

On a computer that is running Windows Web Server 2008 with Update for Windows Server 2008 Server Manager (KB940518) installed, the server roles and role services listed below appear in addition to Windows Server Update Services. However, installation of these server roles is not supported on Windows Web Server 2008 and only the Web Server role should be installed. 
- Application Server
- Application Server Foundation
- Web Server (IIS) Support
- COM+ Network Access
- TCP Port Sharing
- Windows Process Activation Service Support
  - HTTP Activation
  - Message Queuing Activation
  - TCP Activation
  - Named Pipes Activation
- Distributed Transactions
  - Incoming Remote Transactions
  - Outgoing Remote Transactions
  - WS-Atomic Transactions
- File Services
- Distributed File System
  - DFS Replication  

Additionally, the File Server Resource Manager (FSRM) feature and the Indexing Service feature appear as role services of the File Services role. You can install these features by using the Add Roles Wizard.

- File Services
- File Server Resource Manager
- Windows Server 2003 File Services
  - Indexing Service
> [!NOTE]
> If you choose to install File Server Resource Manager, the installation of File Server Resource Manager does succeed. However, you receive an error message because the configuration cannot be applied to this feature on Windows Web Server 2008. File Server Resource Manager is still fully functional as a feature despite this error message.

#### System requirements

You must be running a release version of Windows Server 2008 that has an installation option other than Server Core.

#### Restart requirements

To avoid restarting the computer, make sure that the Initial Configuration Tasks, Server Manager, and the Servermanagercmd.exe process are not running during the installation process.

#### Language features

This installation package is designed for all language versions of Windows Server 2008. These include English versions, localized versions, and language interface packs.

The installation package for the update for Server Manager automatically installs the update for the Server Manager language pack that matches the locale that is selected for the operating system.

The Server Manager update is fully localized in all the languages that are supported by Windows Server 2008. These languages are as follows:
- Chinese-Simplified

- Chinese-Traditional

- Czech

- Dutch

- Hungarian

- English

- French

- German

- Italian

- Japanese

- Korean

- Portuguese

- Russian

- Spanish

- Swedish

- Turkish


## References

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[948014](https://support.microsoft.com/help/948014) Description of the Windows Server Update Services 3.0 Service Pack 1 package  

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
