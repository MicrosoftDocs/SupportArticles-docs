---
title: Modifying the NETMON parser port for SQL Server
description: This article explains how to change the port of the NETMON parser port for SQL Server.
ms.date: 01/17/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Change NETMON Parser Port for SQL Server

This article provides instructions for changing the NETMON parser to recognize SQL Servers on your network that don't use the default port 1433.

This change should only be made once, assuming that the SQL Server computers that have SQL Server  installed have statically allocated ports (recommended) and you aren't adding new servers to the network. Also, add Always-On Listener port numbers if they're different than the instance port numbers.

You must configure the NETMON parser to recognize these ports. To configure the parser, follow these steps:

1. Copy `C:\programdata\microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Base\tcp.npl` to a folder, for example, *c:\temp*.
1. Rename the original file to *tcp.npl.old*.
1. Open *c:\temp\tcp.npl* in Notepad and search for *1433*.
1. Make sure you set the **Open** dialog to show **All Files (*.*)**.
1. Add the following additional port numbers:

    `case 1433:   // original SQL entry`
    `case 6020:   // additional SQL entry`
    `case 6021:   // additional SQL entry`

1. Save the file and copy the numbers back to the *C:\programdata\microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Base* folder.
1. Run NETMON with administrative access to rebuild the parser.

   You can also edit the file if you run your editor with administrative access or give your user account explicit permissions to the Network Monitor 3 folder and let the permissions be inherited by the sub folders and files.

1. Turn on **File name extensions** in **Windows Explorer** to make sure the file isn't accidentally saved as *tcp.npl.txt*.

## See also

Collect data using Network Monitor