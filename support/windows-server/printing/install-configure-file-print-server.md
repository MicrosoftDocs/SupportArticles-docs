---
title: Install and configure a file and print server
description: Describes how to configure your Windows Server 2003 as a file and print server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-installing-print-drivers, csstroubleshoot
ms.subservice: printing
---
# How to install and configure a file and print server

This step-by-step article describes how to configure your Windows Server 2003 as a file and print server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325860

## Install File and Printer Sharing

By default, a Windows Server 2003-based computer is installed with Client for Microsoft Networks, File and Printer Sharing for Microsoft Networks, and TCP/IP.

> [!NOTE]
> You can view these services in the properties for the local area connection.

You can create a Windows Server 2003 file server and print server manually, or you can use the wizards that are provided in the Configure Your Server Wizard administrative tool.

### How to install a file server on Windows Server 2003 by using the Configure Your Server Wizard

1. Click **Start**, point to **Administrative Tools**, and then click **Configure Your Server Wizard**.
2. Click **Next**.
3. Click **Next**.
4. Click **File server** in the **Server role** box, and then click **Next**.
5. On the **File Server Disk Quotas** page, configure any quotas you need to control disk-space usage on the server, and then click **Next**.
6. On the **File Server Indexing Service** page, click the indexing configuration that is appropriate for your server, and then click **Next**.
7. Click **Next**.
8. Click **Finish**.
9. The Share a Folder Wizard starts. Click **Next**.
10. Click **Browse**, locate the folder that you want to share, and then click **OK**.
11. Click **Next**.
12. Type a share name for the folder, and then click **Next**.
13. Click one of the basic permissions for the folder, or click **Customize** to set custom permissions on the folder. Click **Finish**.
14. Click **Close**.

### How to manually install a file server on Windows Server 2003

1. Click **Start**, and then click Windows Explorer.
2. Locate the folder that you want to share.
3. Right-click the folder, and then click **Sharing and Security**.
4. Click **Share this folder**, and then accept the default name or type a different name for the share.
5. Optionally, configure the number of users who can connect, configure permissions for this folder, and then configure the caching options.
6. Click **OK**.
7. A little hand is displayed in the Windows Explorer window to indicate that the folder is being shared.
8. Quit Windows Explorer.

## Install a Windows Server 2003 Print Server

### How to install a print server on Windows Server 2003 by using the Configure Your Server Wizard

1. Click **Start**, point to **Administrative Tools**, and then click **Configure Your Server Wizard**.
2. Click **Next**.
3. Click **Next**.
4. Click **Print server** in the **Server role** box, and then click **Next**.
5. On the **Printers and Printer Drivers** page, click the types of Windows clients that your print server will support, and then click **Next**.
6. Click **Next**.
7. On the **Add Printer Wizard Welcome** page, click **Next**.
8. Click **Local printer attached to this computer**, click to clear the **Automatically detect and install my Plug and Play printer** check box, and then click **Next**.
9. Click the port for your printer, and then click **Next**.
10. Click the printer make and model or provide the drivers from the printer manufacturer media, and then click **Next**.

    > [!NOTE]
    > If you are prompted to keep or not keep your existing printer driver, either keep the existing driver or replace the existing driver. If you replace the driver, you must provide the manufacturer driver for this printer. Click **Next** to continue.
11. Accept the default name of the printer or provide a different name, and then click **Next**.
12. Click the **Share as** option, type the share name, and then click **Next**.

    > [!NOTE]
    > This step is optional because you can share the printer later.
13. You may provide the location of the printer and a comment to make it easier to locate. Click **Next** to continue.
14. Click the **Print a test page** option, click **Next**, and then click **Finish** to quit the **Add Printer Wizard**. Your printer appears in the **Printers and Faxes** folder.

### How to share a printer

1. Click **Start**, and then click **Printers and Faxes**.
2. Right-click the printer that you just installed, and then click **Sharing**.
3. Click **Share this printer**, and then type a share name for the printer.
4. Optionally, click **Additional Drivers**, click the operating systems of the client computers that may attach to this printer, and then click **OK**. By adding drivers for these operating systems, users on client computers can connect to the print server and automatically download the appropriate drivers for this model of printer without having to configure anything.
5. When you're prompted to do so, insert the Windows Server 2003 CD-ROM.
6. Click **OK** to close the printer properties.
7. Close the **Printers and Faxes** folder.

### How to manually install a print server on Windows Server 2003

1. Click **Start**, point to **Settings**, and then click **Printers**.
2. Double-click **Add Printer** to start the **Add Printer Wizard**.
3. To complete the **Add Printer Wizard**, repeat steps 7 through 14 in the "Install a Windows Server 2003 Print Server" section of this article.

> [!NOTE]
> The only difference between the manual installation of the print server and the use of the Configure Your Server Wizard to create the print server is how you start the Add Printer Wizard.
