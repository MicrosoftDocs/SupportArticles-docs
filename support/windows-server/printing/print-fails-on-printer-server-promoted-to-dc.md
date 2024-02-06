---
title: Fail to print with Type 4 or 3 printer drivers
description: Provides a solution to an issue where you can't print with Type 4 or Type 3 XPS printer drivers after the printer server is promoted to a Domain Controller.
ms.date: 04/20/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, match
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Not able to print with Type 4 or Type 3 XPS printer drivers after a Windows Server is promoted to a Domain Controller

This article provides a solution to an issue where you can't print with Type 4 or Type 3 XPS printer drivers after the printer server is promoted to a Domain Controller.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2762101

## Symptoms

Consider the following scenario:

- You have a Windows Server 2008 R2 or a Server 2012 print server.
- You have Type 4 printer drivers or Type 3 XPS printer drivers.
- You add the Domain Controller role to the print server.

After the print server has been promoted to a Domain Controller, print jobs do not print.

## Cause

This occurs because the security permissions change when a server is promoted to a Domain Controller. 

Before a print server is promoted to a Domain Controller, the Users group has Special Access permissions to the spool directory. This includes the following permissions:

- Read attributes
- Read extended attributes
- Create files / write data
- Create folders / append data

After a print server is promoted to a Domain Controller, the Users group will now have Read & execute, List folder contents, Read permissions. This includes the following permissions:

- Traverse folder / execute file
- List folder / read data
- Read attributes
- Read extended attributes
- Read permissions

Due to the permissions changes on a Domain Controller, users no longer have the ability to write to the \Windows\System32\Spool\PRINTERS folder. This causes print operations to fail with an "access denied" error.

## Resolution

Grant the Users group Create files / w rite data and Create folders / append data privileges to the PRINTERS directory:

\Windows\System32\Spool\PRINTERS

To grant users to have Create files / Write data privileges: 

1. Right-click on the \ PRINTERS directory and click Properties.
2. From the PRINTERS Properties window, click the Security tab.
3. Select the Users group from the top Window pane.
4. Click Advanced under " Permissions for Users " to bring up the Advanced Security Settings for PRINTERS.
5. Select Users and click Edit to bring up the Permission Entry for PRINTERS.
6. Click Show advanced permissions and check the option for Create files / write data and Create folders / append data.
7. Click OK.

If you have changed the default spool directory, you will need to grant the Users group Create files / Write data privileges and Create folders / append data permissions on that directory.

## More information

You can use Print Management to determine whether a printer driver is Type 4 or Type 3:

1. On Windows Server 2008 R2, you can access Print Management through the Administrative Tools menu. On Windows Server 2012, type in "Print Management" from the Windows start screen and press Enter. 
2. Expand "Print Servers" from the left-hand pane and select your server name and select "Drivers."
3. Right-click on a print driver and click "Properties."
4. The Type # under Version will tell you whether a print driver is Type 4 or Type 3:

    :::image type="content" source="./media/print-fails-on-printer-server-promoted-to-dc/verify-printer-driver-type.png" alt-text="Double checking the printer driver version that's shown in the Driver Properties.":::
