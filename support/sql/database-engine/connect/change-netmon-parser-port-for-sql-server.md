---
title: Modifying the NETMON parser port for SQL Server
description: This article explains how to change the port of the NETMON parser for SQL Server.
ms.date: 05/20/2024
ms.reviewer: jopilov, aartigoyle, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Change NETMON parser port for SQL Server

This article provides instructions to change the NETMON parser port in order to recognize servers that are running Microsoft SQL Server on your network but don't use default port 1433.

You should make this change only one time. This change assumes that the SQL Server-based computers have statically allocated ports (recommended) and that you aren't adding new servers to the network. In this process, you should also add Always-On Listener port numbers if they're different than the instance port numbers.

You must configure the NETMON parser to recognize these ports. To configure the parser, follow these steps:

1. Copy `C:\programdata\microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Base\tcp.npl` to a folder (for example, *c:\temp*).
1. Rename the original file to *tcp.npl.old*.
1. In Notepad, open *c:\temp\tcp.npl*, and then search on "1433" in the file.
1. Make sure that you set the **Open** dialog box to show **All Files (*.*)**.
1. Add the following additional port numbers:

    `case 1433:   // original SQL entry`
    `case 6020:   // additional SQL entry`
    `case 6021:   // additional SQL entry`

1. Save the file, and copy the port numbers to the following folder:

   *C:\programdata\microsoft\Network Monitor 3\NPL\NetworkMonitor Parsers\Base*

1. Run NETMON by using administrative access to rebuild the parser.

   You can also edit the file if you run your editor by using administrative access or give your user account explicit permissions to the *Network Monitor 3* folder and let the permissions be inherited by the subfolders and files.

1. In Windows Explorer, turn on **File name extensions** to make sure that the file isn't accidentally saved as *tcp.npl.txt*.

## More information

- [Collect data using Network Monitor](../../../windows-client/networking/collect-data-using-network-monitor.md)

- [Collect data to troubleshoot SQL Server connectivity issues](collect-data-to-troubleshoot-sql-connectivity-issues.md)