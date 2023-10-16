---
title: Back up and restore printers when upgrading
description: Describes how to back up the printers before you upgrade to Windows Server 2008 and then restore the printers when the upgrade process is complete.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-print-queue-backup-and-migration, csstroubleshoot
ms.technology: windows-server-printing
---
# Back up and then restore printers when you upgrade from Windows Server 2003 to Windows Server 2008

This article describes how to back up the printers before you upgrade to Windows Server 2008. It also describes how to restore the printers after you upgrade.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 938923

## Introduction

If incompatible printer queues are found when you upgrade from Windows Server 2003 or from Windows Server 2003 R2 to Windows Server 2008, all printer queues may be deleted during the upgrade process.

If article 938923 is referenced during the setup compatibility report, the server has incompatible printer queues. In this case, do not continue with the setup process until the printers are backed up.

> [!NOTE]
> Windows Vista is the first operating system to include the functionality to back up and to restore the print servers in the Print Management snap-in in Microsoft Management Console (MMC).

## More information

### How to install and to start the Print Management snap-in in Windows Vista

1. Click **Start**, type MMC in the **Start Search** box, and then click **MMC** in the **Programs** list.
2. On the **File** menu, click **Add/Remove Snap-in**.

3. In the **Available snap-ins** list, click **Print Management**, and then click **Add**. You may have to wait several seconds for the snap-in to be added.

4. In the **Configure Print Management** window, type the remote print server name, and then click **Add to List**.
5. Click **Finish**.

6. Click **OK**. The printers that you want to back up should be displayed in the **Print Servers** area of the console.

### How to back up the printers by using the Print Management snap-in in Windows Server 2008 or in Windows Vista

#### Windows Server 2008

1. Click **Start**, click **Administrative Tools**, and then double-click **Server Manager**.

2. In Server Manager, right-click **Roles**, and then click **Add Roles**.

3. Click to select the **Print Services** check box, and then click **Next**.

4. Click **Next** two times, and then click **Install**.

5. When the installation process is complete, click **Close**.

6. Click **Start**, click **Administrative Tools**, and then click **Print Management**.

7. In the **Print Management** window, right-click **Print Management**, and then click **Migrate Printers**.

8. Make sure that **Export printer queues and printer drivers to a file** is selected, and then click **Next**.
9. In the **Select a print server** window, click **A print server on the network**, type the remote print server name, and then click **Next**.

10. In the **Review the list of items to be exported** window, click **Next**.

11. In the **Select the file location** window, type a location to which you want to back up the printers. For example, type the following location: `system_drive:\backup\remoteservername.printerExport`  

12. Click **Finish**.

#### Windows Vista

1. In the Print Management snap-in, right-click the remote server, and then click **Export Printers to a file**.

2. In the **Select the file location** window, type a location to which you want to back up the printers in the **Export printer data to** field. For example, type the following location: `system_drive:\backup\remoteservername.printerExport`  
Then, click **Next**.

3. Click **Finish**.

### How to restore printers in Windows Server 2008

1. Click **Start**, click **Administrative Tools**, and then double-click **Server Manager**.

2. In Server Manager, right-click **Roles**, and then click **Add Roles**.

3. Click to select the **Print Services** check box, and then click **Next**.
4. Click **Next** two times, and then click **Install**.
5. When the installation process is complete, click **Close**.

6. Click **Start**, click **Administrative Tools**, and then click **Print Management**.

7. In the **Print Management** window, right-click **Print Management**, and then click **Migrate Printers**.
8. Click **Import printer queues and printer drivers from a file**, and then click **Next**.

9. In the **Select the File Location** window, type a location to which you want to restore the printers. For example, type the following location: `system_drive:\backup\remoteservername.printerExport`  

10. Click **Next** two times.

11. In the **Select a print server** window, make sure that the print server that is listed is the print server that hosts the printers, and then click **Next**.
12. In the **Select import options** window, click **Next**.
13. Click **Finish**.

> [!NOTE]
> We recommend that you review the Application events that have a PrintBRM source to determine whether any more actions are needed. The restored printers are shared in the same manner in which they were shared previously.

### How to migrate printers by using the command prompt in Windows Server 2008 or in Windows Vista

1. Start an elevated command prompt. To do this, click **Start**, type cmd in the **Start Search** box, right-click **cmd** in the **Programs** list, and then click **Run as administrator**.

    If you are prompted for an administrator password or for confirmation, type your password, or click **Continue**.

2. Perform a remote print backup. To do this, type the following command in the `%WINDIR%\System32\Spool\Tools` folder at the command prompt:  
 `Printbrm -s \\Universal Naming Convention (UNC) name of the source or destination computer -b -f File name for the printer settings file printerExport`  

3. Restore the printers. To do this, type the following command in the `%WINDIR%\System32\Spool\Tools` folder at the command prompt:  
 `Printbrm -s \\UNC name of the destination computer -r -f File name for the printer settings file.printerExport`  

> [!NOTE]
> To view the complete syntax for this command, type `Printbrm /?` at a command prompt.

We do not recommend that you create the backup by using the Printer Migration Wizard (PrintMig.exe). Additionally, the Printer Migration Wizard and the Printbrm.exe tool do not support .cab file backups that were created by using the Printer Migration Wizard.

For more information about how to install, to view, and to manage all the printers in your organization by using the Print Management snap-in, visit the following Microsoft TechNet Web site: [Microsoft documentation and learning for developers and technology professionals](https://technet.microsoft.com/windowsvista/aa905094.aspx)  
