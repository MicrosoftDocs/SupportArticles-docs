---
title: How to connect clients to Terminal Services in Windows Server 2003
description: Describes how to connect a Windows Server 2003-based terminal services client to a terminal server by using Remote Desktop Connection.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Session connectivity, csstroubleshoot
---
# How to connect clients to Terminal Services in Windows Server 2003

This step-by-step article describes how to connect a Windows Server 2003-based terminal services client to a terminal server by using Remote Desktop Connection.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 814585

## More information

### Open Remote Desktop Connection

To open Remote Desktop Connection, select **Start** > **All Programs** > **Accessories** > **Communications**, and then select **Remote Desktop Connection**.

[back to the top](#more-information)  

### Create a Terminal Services connection

To create a Terminal Services connection, follow these steps:

1. Open Remote Desktop Connection.
2. In the **Computer** box, type the computer name or the IP address of a terminal server or a computer that has Remote Desktop enabled.
    > [!NOTE]
    > To connect to the console session of the remote computer, type **computername or IP address**/console.
3. Select **Connect**.
4. In the logon dialog box, type your user name, password, and domain (if necessary), and then select **OK**.  

    [back to the top](#more-information)  

### Save connection settings

You can save a connection as a Remote Desktop protocol (.rdp) file. An `.rdp` file contains all the information for a connection to a terminal server, including the Options settings that were configured when the file was saved. You can customize any number of `.rdp` files, including files for connecting to the same server with different settings. For example, you can save a file that connects to MyServer in full screen mode and another file that connects to the same computer in 800×600 screen size.

To save your connection settings, follow these steps:

1. Open Remote Desktop Connection, and then select **Options**.
2. Specify the connection settings that you want for this connection.
3. On the **General** tab, select **Save As**.
4. In the **File name** box, type a file name for the saved connection file, and then select **Save**.

> [!NOTE]
> To edit an .rdp file to change the connections settings it contains, select **Start** > **My Documents**, right-click the file, and then select **Edit**.

[back to the top](#more-information)  

### Open a saved connection

To open a saved connection, follow these steps:

1. Open Remote Desktop Connection, and then select **Open**.
2. Double-click the `.rdp` file for the connection that you want to open.  

    [back to the top](#more-information)  

### Copy files between the local computer and the remote computer

1. Open Remote Desktop Connection.
2. Type the computer name or the IP address of a terminal server or a computer that has Remote Desktop enabled.
3. Select the **Local Resources** tab, select the **Disk Drives** check box, and then select **Connect**.
4. Select **Start** on the task bar of the remote computer, and then select **My Computer**. Or double-click the **My Computer** icon on the desktop of the remote computer.

    > [!NOTE]
    > The drives on the remote server appear with the drives on your local computer. Your local drives appear as *driveletter* on *tsclient*, where *tsclient* is the name assigned to your (local) computer.
5. Locate the file that you want to copy, right-click the file, and then select **Copy**.
6. Locate the folder where you want to paste the file, and then select **Paste**.

    [back to the top](#more-information)  

### Log off and end the session

To log off and end a session, follow these steps:

1. In the Remote Desktop Connection window, select **Start**, and then select **Shut Down**.
2. In the **Shut Down Windows** dialog box, select **log off \<username>**, and then select **OK**.

    [back to the top](#more-information)  
