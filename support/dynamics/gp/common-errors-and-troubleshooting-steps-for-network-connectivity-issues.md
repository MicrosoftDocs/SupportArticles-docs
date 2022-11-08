---
title: Common errors and troubleshooting steps for network connectivity problems
description: Discusses that you receive error messages that indicate that the database connection has been lost in Store Operations or in Headquarters. Provides several resolutions for the problem.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Common errors and troubleshooting steps for network connectivity problems in Store Operations or in Headquarters

This article provides resolutions for the network connectivity error messages in Microsoft Dynamics Retail Management System Store Operations or in Microsoft Dynamics Retail Management System Headquarters.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 930301

## Symptoms

You receive the following error messages in Microsoft Dynamics Retail Management System Store Operations or in Microsoft Dynamics Retail Management System Headquarters:

Error message 1

> Database connection lost, application will be closed Error #-2147467259 [DBNETLIB][ConnectionWrite (WrapperWrite()).]General network error. Check the network documentation. (Source: Microsoft OLE DB provider for SQL Server) (SQL State: 08S01) (Native Error: 11) No Help file Available SELECT GETDATE() AS CurrentDateTime

> [!NOTE]
> The actual Microsoft SQL Server **SELECT** statement at the end of this error message may be longer and more complex. This statement may refer to the Order table, the OrderEntry table, or the Customer table. You must include the final statement when you research and troubleshoot this problem because the statement can help you pinpoint this problem. The statement indicates the tables that the program was accessing when the disconnection occurred.

Error message 2

> SQL Server does not exist or access denied.

Error message 3

> ConnectionOpen (Connect())

Error message 4

> Error: cannot drop the table '#temp', because it does not exist in the system catalog.

Error message 5

> Run-time error '5': Invalid procedure call or argument

Error message 6

> 'General Network Error, Run-time error 5'

## Cause

Store Operations and Headquarters require reliable connections between the server and the client computers. The errors that are mentioned in the Symptoms section relate to network setup problems or to hardware setup problems. The errors do not relate to Store Operations or to Headquarters.

Network connectivity problems can have various causes. However, these problems typically have one or more of the following causes:

- Network adapters that are configured incorrectly
- Switches that are set incorrectly
- Faulty hardware
- Driver issuesSome connectivity symptoms are intermittent and do not clearly point to a specific cause.

The following list indicates common causes of network connectivity problems:

1. A damaged or unreliable cable connection, a failed network adapter, or a failed hub.
2. An incorrect network driver or incorrect network settings.
3. The installation of an earlier version of MDAC on each workstation than is on the server.
4. Energy saving features that turn off the network adapter when Microsoft Dynamics RMS is running.
5. An IP address conflict.
6. Settings in the Client Network Utility that are configured incorrectly.
7. Settings in the Server Network Utility that are configured incorrectly.
8. A lack of available network bandwidth because system resources are using all available network bandwidth.
9. Incorrect settings for a specific tender type, for a peripheral device, or for a register.
10. A wireless network configuration.
11. Conflicts with settings for third-party add-ins or for customizations.

## Resolution

To resolve this problem, use the resolution that corresponds to the appropriate network connectivity problem that is listed in the Cause section.

### Resolution 1

1. If this problem occurs only on a particular computer, the problem may involve the hardware on that particular computer. Examine the cable connection to make sure that the network cable is plugged in. If you must replace the network adapter, replace it by using the same adapter type.

2. If this problem occurs on more than one computer, examine the network components that are connecting the computers. Make sure that the router is on. Exchange the network cables, or replace the old cables with new cables.

3. On all workstations, verify that **File and Printer Sharing** settings are enabled. To verify the settings, follow these steps:
   1. Select **Start**, and then select **Control Panel**.
   2. Double-click **Network Connections**.
   3. Right-click **Local Area Network (LAN)**, and then select **Properties**.
   4. Make sure that the **File and Printer Sharing for Microsoft Networks** check box is selected.

### Resolution 2

Many adapters use drivers that try to automatically detect network settings. These settings include **media type**, **media connector**, and **duplex**. Occasionally, automatic settings are detected incorrectly. If this occurs, you may have to manually change the settings. The duplex setting typically requires manual changes. If the default driver settings do not work, try to manually change each parameter one at a time. View the results after each change.

### Resolution 3

Verify that the latest version of MDAC is installed on each workstation. You can determine the version of MDAC that you are running by examining the registry. The version information is found in the following registry subkey:

`HKEY_LOCAL_MACHINE\Software\Microsoft\DataAccess\FullInstallVer`

To examine the registry, follow these steps:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.
2. In the Navigation Pane, locate the following subkey:

   `HKEY_LOCAL_MACHINE\Software\Microsoft\DataAccess`

3. In the results pane, locate the **FullInstallVer** value and the **Version** value in the Name column. These keys have corresponding version information in the **Data** column.

    > [!NOTE]
    > An MDAC component could be damaged or missing. You may be able to resolve the problem by reinstalling MDAC.

### Resolution 4

Energy saving features in Microsoft Windows may turn off the network adapter when Store Operations or Headquarters is running. Periodically, the programs access the database server computer to update the program license and time stamps. Therefore, the programs require a network connection.

To resolve this problem, you must disable all energy saving features that are in the BIOS and in the operating system. Check the power settings of the computer and of the network adapter. Make sure that the computer is not set up to turn off the network adapter to save power. To access the power settings for the network adapter, follow these steps:

1. Select **Start**, and then select **Control Panel**.
2. Double-click **Administrative Tools**, and then double-click **Computer Management**.
3. Select **Device Manager**, expand the network adapter folder, right-click the adapter component, and then select **Properties**.
4. Select the **Power Management** tab.
5. Clear the **Allow the computer to turn off this device to save power** check box.

### Resolution 5

If you are using TCP/IP and a fixed IP address, make sure that no two computers on the network have the same IP address. Use the `ping` command or the `ipconfig /all` command to verify that you are not using the same IP address on more than one computer. To determine the IP address of the computers on the network, and to verify that you can ping between the server and client computers, follow these steps:

1. Select **Start**, select **Run**, type *cmd*, and then select **OK**.
2. Type *ipconfig /all*, and then select **OK**.
3. Ping the server from the computer that has connectivity errors by using both the IP address and the computer name. Ping the computer that has connectivity errors from the server by using both the IP address and the computer name. For example, at the command prompt, type ping *\<servername>*.

    > [!NOTE]
    >
    > - In this command, **\<servername>** represents the actual name of the computer that you are trying to ping.
    > - You can also use a `Ping -T` command to complete a constant ping over the network. You can run this command all day to log all ping packets that travel from the workstation to the server. To search for any timeouts, follow these steps:
    >
    >   1. Right-click anywhere in the Command Prompt window, and then select **Find**.
    >   2. In the **Find What** dialog box, type *Request Timed Out*.
    >
    >   The list of timeouts indicates how many connection drops occurred during the ping session. For example, at the command prompt, type *Ping -T \<servername>*. In this command, **\<servername>** represents the actual name of the computer that you are trying to ping.

### Resolution 6

Verify the settings in the Client Network Utility. To do this, follow these steps:

1. Select **Start**, point to **All Programs**, point to **Microsoft Dynamics RMS**, and then select **Client Network Utility**.
2. Examine the **General** tab. If TCP/IP is listed as a disabled protocol, move the TCP/IP listing to the enabled protocol pane. Additionally, make sure that TCP/IP is listed first.
3. We recommend that you add an alias to the **Alias** tab. To do this, follow these steps:
   1. Select the **Alias** tab, and then select **Add**.
   2. Locate the server that runs an instance of Microsoft SQL Server that listens for TCP/IP Sockets clients. Specify a unique name for this server. Verify that the **TCP/IP** check box is selected.
   3. In the **Server** box, specify the instance of SQL Server that listens for TCP/IP Sockets clients.

        > [!NOTE]
        > This name of this instance is typically the name of the server. However, the name will depend on the SQL setup that is on the server. If the name of an instance of SQL Server is the same as the name of the server, we recommend that you use the IP address of the server instead of the name.
  
   4. On the **Network Libraries** tab, locate a row that is named TCP/IP in the **Network Library** column, and then locate the Dbnetlib.dll file.

        > [!NOTE]
        > The Dbnetlib.dll file is the associated library file. If the Dbnetlib.dll file is missing, you can copy the file from another computer or you can download the file.

   5. Copy the Dbnetlib.dll file to the following folder on the hard disk of the client computer:

      C:\Windows\System32

        > [!NOTE]
        > You must unzip this file before you copy it to the System32 folder.

### Resolution 7

Verify the settings that are in the Server Network Utility on the server computer. To do this, follow these steps:

1. Select **Start**, select **Run**, and then type *svrnetcn*.
2. Examine the **General** tab. If TCP/IP is listed as a disabled protocol, move the TCP/IP listing to the enabled protocol pane.

### Resolution 8

Track the time of day when the errors occur. The errors may occur at a consistent time throughout the day or throughout the week for various reasons. For example, the database server may be very busy processing other tasks. Or the network bandwidth may be saturated. Determine whether other scheduled tasks, backups, updates, or cleanup tools are running on the system during this time. Monitor the server resource usage and the network resource usage to determine whether the problem is related to a heavy demand on system resources.

### Resolution 9

Track the processes that are being completed within Store Operations or within Headquarters when this problem occurs. Frequently, the disconnection errors appear during the tender process in Store Operations POS. The problem can involve a particular tender, any of the peripheral devices, or a peripheral device that is accessed by only one tender type.

Determine which peripheral devices are accessed during the failure. Disable all devices. Then, enable each device one-by-one until the errors appear again. During peak store hours, this kind of troubleshooting may be difficult to perform or may be inadvisable. However, this kind of troubleshooting may be the only way to find the cause of the problem.

Additionally, consider the following questions:

- Are all peripheral devices the same or different throughout the store?
- Does only one register experience disconnection error, or do the errors appear to occur consistently throughout all registers?
- Does the problem follow the peripheral devices or does it stay at the register?

If the errors appear to occur on only one register, try swapping the peripheral devices that are on that register with devices that are on another register and that do not have errors.

The power source of a device has been known to cause similar errors. Therefore, consider whether the device runs on an external power source or whether the device receives power from the computer. Depending on the computer, and whether the device uses the computer as a power source, some devices can exhaust the available power of the computer. This power drain slows down performance.

### Resolution 10

Consider whether Store Operations or Headquarters is set up in a wireless network environment.

> [!NOTE]
> We do not support using wireless networks together with Store Operations or together with Headquarters.

Certain wireless networks may not be as stable as wired networks. Because Store Operations and Headquarters require a constant connection to the database, the connection must be stable. We recommend that you substitute a wired network for a wireless network.

### Resolution 11

Third-party add-ins or customizations that are accessed prior to the transaction posting process, accessed during the transaction posting process, or accessed after the transaction posting process can damage or weaken network connectivity in Store Operations or in Headquarters. Consider the following possible software scenarios:

- Third-party products are installed that use hooks in Store Operations or in Headquarters. Errors can occur if the hooks display new windows at the point of sale, or if the hooks complete SQL scripts and triggers to pull transactional data into other databases or tables. If you can do this, remove or deactivate these products to see whether the errors stop. Alternatively, install Store Operations or Headquarters on a new computer. Do not include the add-ins or customizations.
- An HTML status bar is running. Errors can occur if an HTML status bar is running. To determine whether you have an HTML status bar, view the display properties at the point of sale by pressing Ctrl+F6. Select the **Transaction Screen** tab to see whether the **Display HTML** check box is selected. If you have an HTML status bar, consider the following questions:
  - Has the HTML status bar been customized? If the HTML status bar has been customized, clear the check box. Then monitor the system for several days to determine whether the errors have stopped.
  - Is the HTML status bar file on the hard disk of each client computer in the network, or is the file on a server? To verify the location of the HTML status bar, examine the **Register** tab in the Store Operations Administrator Configuration tool in the upper part of the POS screen. If the HTML status bar file is located on a server, move the file to the hard disk of each client computer.
  
> [!NOTE]
> We recommend that you consider all the causes and resolutions that are mentioned in this article. Network disconnections can cause data corruption or incomplete updates to the Store Operations database or the Headquarters database. Depending on when the disconnection occurs, not all tables will experience the problem. Consider the following scenario. A series of tables is updated during the transaction process. This series starts with the Transaction table and with the TransactionEntry table. The series ends with the Batch table and with the Journal table. A network disconnection occurs during the post process. After this problem occurs, the transaction appears in the Detailed Sales report because this report pulls most of its information from the Transaction table and from the TransactionEntry table. However, the transaction may not appear in the Z report because the Z report pulls all its information from the Batch table and from the Journal table.
