---
title: Troubleshoot Remote desktop disconnected errors
description: Provides troubleshooting information for Remote desktop disconnected errors.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
adobe-target: true
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Troubleshoot Remote desktop disconnected errors

This article helps you understand the most common settings that are used to establish a Remote Desktop session in an enterprise environment, and provides troubleshooting information for Remote desktop disconnected errors.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2477176

> [!NOTE]
> This article is intended for use by support agents and IT professionals.

## Remote Desktop Server

A Remote Desktop Session Host server is the server that hosts Windows-based programs or the full Windows desktop for Remote Desktop Services clients. Users can connect to an RD Session Host server to run programs, to save files, and to use network resources on that server. Users can access an RD Session Host server from within a corporate network or from the Internet.

Remote Desktop Session Host (RD Session Host) was formerly known as the Remote Desktop server role service, and Remote Desktop Session Host (RD Session Host) server was formerly known as Remote Desktop server.

## Remote connections for administration

Remote Desktop supports two concurrent remote connections to the computer. You do not have to have Remote Desktop Services client access licenses (RDS CALs) for these connections.

To allow more than two administrative connections or multiple user connections, you must install the RD Session Host Role and have appropriate RDS CALs.

## Symptom 1: Limited Remote Desktop session or Remote Desktop Services session connections

When you try to make a Remote Desktop Connection (RDC) to a remote computer or to a Remote Desktop server (Terminal Server) that is running Windows Server 2008 R2, you receive one of the following error messages:

> Remote Desktop Disconnected.  
> This computer can't connect to the remote computer.  
> Try connecting again. If the problem continues, contact the owner of the remote computer or your network administrator.

Also, you are limited in the number of users who can connect simultaneously to a Remote Desktop session or Remote Desktop Services session. A limited number of RDP connections can be caused by misconfigured Group Policy or RDP-TCP properties in Remote Desktop Services Configuration. By default, the connection is configured to allow an unlimited number of sessions to connect to the server.

## Symptom 2: Port assignment conflict

You experience a port assignment conflict. This problem might indicate that another application on the Remote Desktop server is using the same TCP port as the Remote Desktop Protocol (RDP). The default port assigned to RDP is 3389.

## Symptom 3: Incorrectly configured authentication and encryption settings

After a Remote Desktop server client loses the connection to a Remote Desktop server, you experience one of the following symptoms:

- You cannot make a connection by using RDP.
- The session on the Remote Desktop server does not transition to a disconnected state. Instead, it remains active even though the client is physically disconnected from the Remote Desktop server.

If the client logs back in to the same Remote Desktop server, a new session may be established, and the original session may remain active.

Also, you receive one of the following error messages:

- Error message 1

    > Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.

- Error message 2

    > Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

## Symptom 4: License certificate corruption

Remote Desktop Services clients are repeatedly denied access to the Remote Desktop server. If you are using a Remote Desktop Services client to log on to the Remote Desktop server, you may receive one of the following error messages.

- Error message 1

    > Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.

- Error message 2

    > Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

- Error message 3

    > Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.  
    > Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

Additionally, the following event ID messages may be logged in Event Viewer on the Remote Desktop server.

- Event message 1  

  ```output
  Event ID: 50  
  Event Source: TermDD  
  Event Description: The RDP protocol component X.224 detected an error in the protocol stream and has disconnected the client.
  ```

- Event message 2

  ```output
  Event ID: 1088
  Event Source: TermService
  Event Description: The terminal services licensing grace period has expired and the service has not registered with a license server. A terminal services license server is required for continuous operation. A terminal server can operate without a license server for 90 days after initial start up.
  ```

- Event message 3

  ```output
  Event ID: 1004  
  Event Source: TermService  
  Event Description: The terminal server cannot issue a client license.
  ```

- Event message 4

  ```output
  Event ID: 1010  
  Event Source: TermService  
  Event Description: The terminal services could not locate a license server. Confirm that all license servers on the network are registered in WINS/DNS, accepting network requests, and the Terminal Services Licensing Service is running.
  ```

- Event message 5

  ```output
  Event ID: 28  
  Event Source: TermServLicensing  
  Event Description: Terminal Services Licensing can only be run on Domain Controllers or Server in a Workgroup. See Terminal Server Licensing help topic for more information.
  ```

## Resolution for Symptom 1

To resolve this problem, use the following methods, as appropriate.

### Verify Remote Desktop is enabled

1. Open the **System** item in Control Panel. To start the System tool, click Start, click **Control Panel**, click **System**, and then click **OK**.
2. Under **Control Panel Home**, click **Remote settings**.
3. Click the **Remote** tab.
4. Under **Remote Desktop**, select either of the available options, depending on your security requirements:

    - **Allow connections from computers from computers running any version of Remote Desktop (less secure)**

    - **Allow connections from computers only from computers running Remote Desktop with Network Level Authentication (more secure)**

If you select **Don't allow connections to this computer** on the **Remote** tab, no users will be able to connect remotely to this computer, even if they are members of the Remote Desktop Users group.

### Verify Remote Desktop Services Limit number of connections policy

1. Start the Group Policy snap-in, and then open the Local Security Policy or the appropriate Group Policy.
2. Locate the following command:

    **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Connections Limit number of connections**

3. Click **Enabled**.
4. In the **RD Maximum Connections allowed** box, type the maximum number of connections that you want to allow, and then click **OK**.

### Verify Remote Desktop Services RDP-TCP properties

Follow these steps, depending on your operating system version.

Setting via Remote Desktop Services Configuration

Configure the number of simultaneous remote connections allowed for a connection:

1. On the RD Session Host server, open Remote Desktop Session Host Configuration. To open Remote Desktop Session Host Configuration, click **Start**, point to **Administrative Tools**, point to **Remote Desktop Services**.

2. Under **Connections**, right-click the name of the connection, and then click **Properties**.

3. On the **Network Adapter** tab, click **Maximum connections**, enter the number of simultaneous remote connections that you want to allow for the connection, and then click **OK**.

4. If the **Maximum connections** option is selected and dimmed, the **Limit number of connections** Group Policy setting has been enabled and has been applied to the RD Session Host server.

### Verify Remote Desktop Services Logon rights

Configure the Remote Desktop Users Group.

The Remote Desktop Users group on an RD Session Host server grants users and groups permission to remotely connect to an RD Session Host server. You can add users and groups to the Remote Desktop Users group by using the following tools:

- Local Users and Groups snap-in
- The **Remote** tab in the **System Properties** dialog box on an RD Session Host server
- Active Directory Users and Computers snap-in, if the RD Session Host server is installed on a domain controller

You can use the following procedure to add users and groups to the Remote Desktop Users group by using the Remote tab in the System Properties dialog box on an RD Session Host server.

Membership in the local Administrators group, or equivalent, on the RD Session Host server that you plan to configure, is the minimum required to complete this procedure.

#### Add users and groups to the Remote Desktop Users group by using the Remote tab

1. Start the System tool. To do this, click Start, click Control Panel, click the **System** icon, and then click **OK**.

2. Under **Control Panel Home**, click **Remote settings**.

3. On the **Remote** tab in the **System Properties** dialog box, click **Select Users**. Add the users or groups that have to connect to the RD Session Host server by using Remote Desktop.

> [!NOTE]
> If you select the **Don't allow connections to this computer** option on the **Remote** tab, no users will be able to connect remotely to this computer, even if they are members of the Remote Desktop Users group.

#### Add users and groups to the Remote Desktop Users group by using Local Users and Groups snap-in

1. Click **Start**, click **Administrative Tools**, and then click **Computer Management**.
2. In the console tree, click the **Local Users and Groups** node.
3. In the details pane, double-click the **Groups** folder.
4. Double-click **Remote Desktop Users**, and then click **Add**.
5. In the **Select Users** dialog box, click **Locations** to specify the search location.
6. Click **Object Types** to specify the types of objects that you want to search for.
7. In the **Enter the object names to select (examples)** box, type the name you want to add.
8. Click **Check Names**.
9. When the name is located, click **OK**.

> [!NOTE]
>
> - You can't connect to a computer that's asleep or hibernating, so make sure the settings for sleep and hibernation on the remote computer are set to Never. (Hibernation isn't available on all computers.) For information about making those changes, see Change, create, or delete a power plan (scheme).
> - You can't use Remote Desktop Connection to connect to a computer using Windows 7 Starter, Windows 7 Home Basic, or Windows 7 Home Premium.
> - Members of the local Administrators group can connect even if they are not listed.

## Resolution for Symptom 2

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see
 [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem, determine which application is using the same port as RDP. If the port assignment for that application cannot be changed, change the port assigned to RDP by changing the registry. After you change the registry, you must restart the Remote Desktop Services service. After you restart the Remote Desktop Services service, you should verify that the RDP port has been changed correctly.

### Remote Desktop server listener availability

The listener component runs on the Remote Desktop server and is responsible for listening for and accepting new Remote Desktop Protocol (RDP) client connections, thereby allowing users to establish new remote sessions on the Remote Desktop server. There is a listener for each Remote Desktop Services connection that exists on the Remote Desktop server. Connections can be created and configured by using the Remote Desktop Services Configuration tool.

To perform these tasks, refer to the following sections.

#### Determine which application is using the same port as RDP

You can run the netstat tool to determine whether port 3389 (or the assigned RDP port) is being used by another application on the Remote Desktop server:

1. On the Remote Desktop server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type `netstat -a -o` and then press Enter.
3. Look for an entry for TCP port 3389 (or the assigned RDP port) with a status of **Listening**. This indicates another application is using this port. The PID (Process Identifier) of the process or service using that port appears under the PID column.

To determine which application is using port 3389 (or the assigned RDP port), use the tasklist command-line tool along with the PID information from the netstat tool:

1. On the Remote Desktop server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. Type `tasklist /svc` and then press Enter.
3. Look for an entry for the PID number that is associated with the port (from the netstat output). The services or processes that are associated with that PID appear on the right.

#### Change the port assigned to RDP

You should determine whether this application can use a different port. If you cannot change the application's port, you must change the port that is assigned to RDP.

> [!IMPORTANT]
> We recommend that you do not change the port that is assigned to RDP.

If you have to change the port assigned to RDP, you must change the registry. To do this, you must be a member of the local Administrators group, or you must have been granted the appropriate permissions.

To change the port that is assigned to RDP, follow these steps:

1. On the Remote Desktop server, open Registry Editor. To open Registry Editor, click **Start**, click **Run**, type *regedit*, and then click **OK**.

2. If the **User Account Control** dialog box appears, verify that the action it displays is what you want, and then click **Continue**.

3. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Desktop server\WinStations`

RDP-TCP is the default connection name. To change the port for a specific connection on the Remote Desktop server, select the connection under the **WinStations** key:

1. In the details pane, double-click the **PortNumber** registry entry.
2. Type the port number that you want to assign to RDP.
3. Click **OK** to save the change, and then close Registry Editor.

#### Restart the Remote Desktop Services service

For the RDP port assignment change to take effect, stop and start the Remote Desktop Services service. To do this, you must be a member of the local Administrators group, or you must have been granted the appropriate permissions.

To stop and start the Remote Desktop Services service, follow these steps:

1. On the Remote Desktop server, open the Services snap-in. To do this, click **Start**, point to **Administrative Tools**, and then click **Services**.

2. If the **User Account Control** dialog box appears, verify that the action it displays is what you want, and then click **Continue**.

3. In the **Services** pane, right-click **Remote Desktop Services**, and then click **Restart**.

4. If you are prompted to restart other services, click **Yes**.

5. Verify that the **Status** column for the Remote Desktop Services service displays a **Started** status. 

#### Verify that the RDP port has changed

To verify that the RDP port assignment has been changed, use the netstat tool:

1. On the Remote Desktop server, click **Start**, click **Run**, type *cmd*, and then click **OK**.

2. At the command prompt, type `netstat -a` then press Enter.

3. Look for an entry for the port number that you assigned to RDP. The port should appear in the list and have a status of **Listening**.

> [!IMPORTANT]
> Remote Desktop Connection and the Terminal server Web Client use port 3389, by default, to connect to a Remote Desktop server. If you change the RDP port on the Remote Desktop server, you will have to modify the port used by Remote Desktop Connection and the Remote Desktop server Web Client. For more information, see [Change the listening port for Remote Desktop on your computer](/windows-server/remote/remote-desktop-services/clients/change-listening-port).

#### Verify that the listener on the Remote Desktop server is working

To verify that the listener on the Remote Desktop server is working correctly, use any of the following methods.

> [!NOTE]
> RDP-TCP is the default connection name and 3389 is the default RDP port. Use the connection name and port number specific to your Remote Desktop server configuration.

- Method 1

    Use an RDP client, such as Remote Desktop Connection, to establish a remote connection to the Remote Desktop server.

- Method 2

    Use the qwinsta tool to view the listener status on the Remote Desktop server:

    1. On the Remote Desktop server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type *qwinsta*, and then press Enter.
    3. The RDP-TCP session state should be **Listen**.

- Method 3

    Use the netstat tool to view the listener status on the Remote Desktop server:

    1. On the Remote Desktop server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `netstat -a` then press Enter.
    3. The entry for TCP port 3389 should be **Listening**.

- Method 4

    Use the telnet tool to connect to the RDP port on the Remote Desktop server:

    1. From another computer, click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `telnet <servername> 3389` , where \<servername> is the name of the Remote Desktop server, and then press Enter.

    If telnet is successful, you receive the telnet screen and a cursor.

    If telnet is not successful, you receive the following error message:

    > Connecting To **servername**... Could not open connection to the host, on port 3389: Connect failed

    The qwinsta, netstat, and telnet tools are also included in Windows XP and Windows Server 2003. You can also download and use other troubleshooting tools, such as Portqry.

## Resolution for Symptom 3

To resolve the issue, configure authentication and encryption.

To configure authentication and encryption for a connection, follow these steps:

1. On the RD Session Host server, open Remote Desktop Session Host Configuration. To open Remote Desktop Session Host Configuration, click **Start**, point to **Administrative Tools**, point to **Remote Desktop Services**, and then click **Remote Desktop Session Host Configuration**.

2. Under **Connections**, right-click the name of the connection, and then click **Properties**.

3. In the **Properties** dialog box for the connection, on the **General** tab, in **Security layer**, select a security method.

4. In **Encryption level**, click the level that you want. You can select **Low, Client Compatible, High, or FIPS Compliant**. See Step 4 above for **Windows Server 2003** for **Security layer** and **Encryption level** options.

> [!NOTE]
>
> - To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security best practice, consider using Run as to perform this procedure.
> - To open Remote Desktop Services Configuration, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Remote Desktop Services Configuration**.
> - Any encryption level settings that you configure in Group Policy override the configuration that you set by using the Remote Desktop Services Configuration tool. Also, if you enable the [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](/previous-versions/windows/it-pro/windows-server-2003/cc780081(v=ws.10)) Group Policy setting, this setting overrides the **Set client connection encryption level** Group Policy setting.
> - When you change the encryption level, the new encryption level takes effect the next time a user logs on. If you require multiple levels of encryption on one server, install multiple network adapters and configure each adapter separately.
> - To verify that certificate has a corresponding private key, in Remote Desktop Services Configuration, right-click the connection for which you want to view the certificate, click the **General** tab, click **Edit**, click the certificate that you want to view, and then click **View Certificate**. At the bottom of the **General** tab, the statement, **You have a private key that corresponds to this certificate**, should appear. You can also view this information by using the Certificates snap-in.
> - The **FIPS compliant** setting (the **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** setting in Group Policy or the **FIPS Compliant** setting in Remote Desktop server Configuration) encrypts and decrypts data sent from the client to the server and from the server to the client, with the Federal Information Processing Standard (FIPS) 140-1 encryption algorithms, using Microsoft cryptographic modules. For more information, see [Terminal Services in Windows Server 2003 Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc787876(v=ws.10)).
> - The **High** setting encrypts data sent from the client to the server and from the server to the client by using strong 128-bit encryption.
> - The **Client Compatible** setting encrypts data sent between the client and the server at the maximum key strength supported by the client.
> - The Low setting encrypts data sent from the client to the server using 56-bit encryption.

### Additional troubleshooting step: Enable CAPI2 event logs

To help troubleshoot this problem, enable CAPI2 event logs on both the client and server computers. This command is shown in the following screenshot.

:::image type="content" source="./media/troubleshoot-remote-desktop-disconnected-errors/enable-log-option.svg" alt-text="Expand CAPI2, right-click Operational, and then select the Enable Log option." border="false":::

### Workaround for the issue (You cannot completely disconnect a Remote Desktop server connection) described in Symptom 3

To work around this problem, follow these steps:

1. Click **Start**, click **Run**, type *gpedit.msc*, and then click **OK**.
2. Expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, expand **Remote Desktop Services**, expand **Remote Desktop Session Host**, and then click **Connections**.
3. In the right pane, double-click **Configure keep-alive connection interval**.
4. Click **Enabled**, and then click **OK**.
5. Close Group Policy Object Editor, click **OK**, and then quit Active Directory Users and Computers.

## Resolution for Symptom 4

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [322756 How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve this problem, back up and then remove the **X509 Certificate** registry keys, restart the computer, and then reactivate the Remote Desktop Services Licensing server. To do this, follow these steps.

> [!NOTE]
> Perform the following procedure on each of the Remote Desktop servers.

1. Make sure that the Remote Desktop server registry has been successfully backed up.

2. Start Registry Editor.

3. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\RCM`

4. On the **Registry** menu, click **Export Registry File**.

5. Type exported- Certificate in the **File name** box, and then click **Save*.

    > [!NOTE]
    > If you have to restore this registry subkey in the future, double-click the Exported-parameters.reg file that you saved in this step.

6. Right-click each of the following values, click **Delete**, and then click **Yes** to verify the deletion:

    - **Certificate**
    - **X509 Certificate**
    - **X509 Certificate ID**
    - **X509 Certificate2**

7. Exit Registry Editor, and then restart the server.

## References

For more information about Remote Desktop Gateway, see the following articles:

- [967933 Error message when a remote user tries to connect to a resource on a Windows Server 2008-based computer through TS Gateway by using the FQDN of the resource: "Remote Desktop Disconnected"](https://support.microsoft.com/help/967933)

- [329896 Because of a security error, the client could not connect to the Remote Desktop server](https://support.microsoft.com/help/329896)

- [Group Policy Settings for Remote Desktop Services in Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791928(v=ws.10))

- [Troubleshooting General Remote Desktop Error Messages](/previous-versions/windows/it-pro/windows-server-2003/cc780927(v=ws.10))

If this article does not help you resolve the problem, or if you experience symptoms that differ from those that are described in this article, visit the [Microsoft Support](https://support.microsoft.com/) for more information. To search your issue, in the **Search support for help** box, type the text of the error message that you received, or type a description of the problem.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#remote-desktop-disconnection).
