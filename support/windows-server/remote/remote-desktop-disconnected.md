---
title: Troubleshoot establishing Terminal Services session
description: Helps you understand the most common settings that affect establishing a Terminal Services session in an enterprise environment.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, gavinl
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
ms.technology: windows-server-rds
---
# Remote Desktop disconnected or can't connect to remote computer or Remote Desktop server (Terminal Server) that is running Windows Server 2003

This article helps you understand the most common settings that affect establishing a Terminal Services session in an enterprise environment.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 2477023

## Terminal Server

A Terminal Server is the server that hosts Windows-based programs or the full Windows desktop for Terminal Services clients. Users can connect to Terminal Server to run programs, to save files, and to use network resources on that server. Users can access a Terminal Server from within a corporate network or from the Internet.

## Remote Connections for Administrative Purposes

Terminal Services supports two concurrent remote connections to the computer. You do not need Terminal Services client access licenses (TS CALs) for these connections.

To allow more than two administrative connections or multiple user connections you must install the Terminal Services role and have appropriate TS CALs.

## Troubleshoot establishing a Terminal Services session

The following sections describe issues that you may encountered and provides solutions.

### You may be limited in the number of users who can connect simultaneously to a Terminal Services session

Limited number of RDP connections can be due to misconfigured Group Policy or RDP-Tcp properties in Terminal Services Configuration. By default, the connection is configured to allow an unlimited number of sessions to connect to the server. When you try to make a Remote Desktop Connection (RDC), you get the following error:

> Remote Desktop Disconnected.  
This computer can't connect to the remote computer.  
Try connecting again. If the problem continues, contact the owner of the remote computer or your network administrator.

#### Verify Remote Desktop is enabled

1. Start the System tool. To start the System tool, click **Start** > **Control Panel** > **System Icon** and then click **OK**.
2. Click the **Remote** tab. Under **Remote Desktop**, click the **Enable Remote Desktop on this computer** check box.

#### Verify Terminal Services **Limit number of connections** policy

1. Start the Group Policy snap-in, open the Local Security Policy or the appropriate Group Policy
2. Navigate to the location: **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Terminal Services Limit number of connections**.
3. Click **Enabled**.
4. In the TS **Maximum Connections allowed** box, type the maximum number of connections you want to allow, and then click **OK**.

#### Verify Terminal Services RDP-Tcp properties and set via Terminal Services Configuration

1. Click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Terminal Services Configuration.
2. In the console tree, click **Connections**.
3. In the details pane, right-click the connection for which you want to specify a maximum number of sessions, and then click **Properties**.
4. On the **Network Adapter** tab, click **Maximum connections**, type the maximum number of sessions that can connect to the server, and then click **Apply**.

#### Verify Terminal ServicesLogon rights and configure the Remote Desktop Users Group

The Remote Desktop Users group on a Terminal Server is used to give users and groups permission to remotely connect to a Terminal Server.

You can add users and groups to the Remote Desktop Users group in the following ways:

- Local Users and Groups snap-in
- On the Remote tab in the System Properties dialog box on an RD Session Host server
- Active Directory Users and Computers snap-in, if the RD Session Host server is installed on a domain controller

You can use the following procedure to add users and groups to the Remote Desktop Users group by using the Remote tab in the System Properties dialog box on the Terminal Server.

Membership in the local Administrators group, or equivalent, on the Terminal Server that you plan to configure, is the minimum required to complete this procedure.

#### Add users and groups to the Remote Desktop Users group by using the Remote tab

1. Start the System tool. To start the System tool, click **Start** > **Control Panel** > **System Icon** and then click **OK**.
2. In the **System Properties** dialog box, on the **Remote** tab, click **Select Remote Users**. Add the users or groups that need to connect to the Terminal Server. The users and groups that you add are added to the Remote Desktop Users group.

If you don't select **Allow users to connect remotely to this computer** on the **Remote** tab, no users will be able to connect remotely to this computer, even if they are members of the Remote Desktop Users group.

#### Add users and groups to the Remote Desktop Users group by using Local Users and Groups snap-in

1. Click **Start** > **Administrative Tools**, open Computer Management.
2. In the console tree, click the **Local Users and Groups** node.
3. In the details pane, double-click the **Groups** folder.
4. Double-click **Remote Desktop Users**, and then click **Add**.
5. In the **Select Users** dialog box, click **Locations** to specify the search location.
6. Click **Object Types** to specify the types of objects you want to search for.
7. Type the name you want to add in the **Enter the object names** to select (examples) box.
8. Click **Check Names**.
9. When the name is located, click **OK**.

> [!NOTE]
>
> - You cannot connect to a computer that is asleep or hibernating, so make sure the settings for sleep and hibernation on the remote computer are set to Never. (Hibernation isn't available on all computers.) For information about making those changes, see Change, create, or delete a power plan (scheme).
> - Members of the local Administrators group can connect even if they are not listed.

### You may have a Port assignment conflict

This problem could indicate that another application on the Terminal Server is using the same TCP port as the Remote Desktop Protocol (RDP). The default port assigned to RDP is 3389.

To resolve this issue, determine which application is using the same port as RDP. If the port assignment for that application cannot be changed, change the port assigned to RDP by editing the registry. After editing the registry, you must restart the Terminal Services service. After you restart the Terminal Services service, you should confirm that the RDP port has been correctly changed.

#### Terminal Server listener availability  

The listener component runs on the Terminal Server and is responsible for listening for and accepting new Remote Desktop Protocol (RDP) client connections, thereby allowing users to establish new remote sessions on the Terminal Server. There is a listener for each Terminal Services connection that exists on the Terminal Server. Connections can be created and configured by using the Terminal Services Configuration tool.

To perform these tasks, refer to the following sections.

#### Determine which application is using the same port as RDP

You can run the netstat tool to determine if port 3389 (or the assigned RDP port) is being used by another application on the Terminal Server.

1. On the Terminal Server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type `netstat -a -o` and then press ENTER.
3. Look for an entry for TCP port 3389 (or the assigned RDP port) with a status of Listening. This indicates another application is using this port. The PID (Process Identifier) of the process or service using that port appears under the PID column.

To determine which application is using port 3389 (or the assigned RDP port), use the tasklist command line tool along with the PID information from the netstat tool.

1. On the Terminal Server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. Type `tasklist /svc` and then press ENTER.
3. Look for an entry for the PID number that is associated with the port (from the netstat output). The services or processes associated with that PID will appear on the right.

#### Change the port assigned to RDP

You should determine if this application can use a different port. If you cannot change the application's port, you will have to change the port assigned to RDP.

> [!IMPORTANT]
> Microsoft doesn't recommend changing the port assigned to RDP.

If you have to change the port assigned to RDP, you must edit the registry.

To perform this procedure, you must have membership in the local Administrators group, or you must have been delegated the appropriate authority.

To change the port assigned to RDP, follow these steps:

> [!CAUTION]
> Incorrectly editing the registry might severely damage your system. Before making changes to the registry, you should back up any valued data.

1. On the Terminal Server, open Registry Editor. To open Registry Editor, click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations`

RDP-TCP is the default connection name. To change the port for a specific connection on the Terminal Server, select the connection under the WinStations key.

1. In the right-pane, double-click the **PortNumber** registry entry.
2. Type the port number that you want to assign to RDP in the Value data box. **PortNumber** is entered as a hexadecimal value.
3. Click **OK** to save the change, and then close Registry Editor.
4. Restart the Terminal Server.

#### Confirm that the RDP port has changed

To confirm that the RDP port assignment has been changed, use the netstat tool.

1. On the Terminal Server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. At the command prompt, type `netstat -a` then press ENTER.
3. Look for an entry for the port number that you assigned to RDP. The port should appear in the list and have a status of Listening. 

Remote Desktop Connection and the Terminal Server Web Client use port 3389, by default, to connect to a Terminal Server. If you change the RDP port on the Terminal Server, you will need to modify the port used by Remote Desktop Connection and the Terminal Server Web Client.

#### Verify that the listener on the Terminal Server is working properly

> [!NOTE]
> RDP-TCP is the default connection name and 3389 is the default RDP port. Use the connection name and port number specific to your Terminal Server configuration.

- Method 1: Use an RDP client, such as Remote Desktop Connection, to establish a remote connection to the Terminal Server.

- Method 2: Use the qwinsta tool to view the listener status on the Terminal Server.

    1. On the Terminal Server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type *qwinsta* and then press ENTER.
    3. The RDP-TCP session state should be **Listen**.

- Method 3: Use the netstat tool to view the listener status on the Terminal Server.

    1. On the Terminal Server, click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `netstat -a` then press ENTER.
    3. The entry for TCP port 3389 should be **Listening**.

- Method 4: Use the telnet tool to connect to the RDP port on the Terminal Server.

    1. From another computer, click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. At the command prompt, type `telnet <servername> 3389`, where \<servername> is the name of the Terminal Server, and then press ENTER.

    If telnet is successful, you will receive the telnet screen and a cursor.

    If telnet is not successful, you will receive this error:

    > Connecting To servername...Could not open connection to the host, on port 3389: Connect failed  

    The qwinsta, netstat, and telnet tools are also included in Windows XP. You can also download and use other troubleshooting tools, such as Portqry.

### You may have an incorrectly configured Authentication and Encryption setting

Configuring authentication and encryption using Terminal Services Configuration

1. In Administrative Tools, open Terminal Services Configuration.
2. In the console tree, click **Connections**.
3. In the **Details** pane, right-click the connection you want to modify, and then click **Properties**.
4. On the **General** tab, in Security layer, select a security method. The security method that you select determines whether the Terminal Server is authenticated to the client, and the level of encryption that you can use. You can select from these security methods:

    - The Negotiate method uses TLS 1.0 to authenticate the server, if TLS is supported. If TLS is not supported, the server is not authenticated.

    - The RDP Security Layer method uses native Remote Desktop Protocol encryption to secure communications between the client and server. If you select this setting, the server is not authenticated.

    - The SSL method requires the use of TLS 1.0 to authenticate the server. If TLS is not supported, the connection fails. This method is only available if you select a valid certificate, as described in Step 6.

        If you select Negotiate or SSL, for TLS to function correctly, you must also set the encryption level to **High**, or you must enable FIPS compliant encryption by using Group Policy or Terminal Server Configuration. Additional server and client configuration requirements must also be met. For more information about requirements and tasks for configuring Terminal Server to support TLS authentication, see Configuring authentication and encryption.

5. In Encryption level, click the level that you want. You can select **Low**, **Client Compatible**, **High**, or **FIPS Compliant**. For more information about these levels, see notes at the end of this topic.

6. To use TLS 1.0 to authenticate the server, in **Certificate**, click **Browse**, click **Select Certificate**, and then click the certificate that you want to use. The certificate must be an X.509 certificate with a corresponding private key. For instructions on how to verify whether the certificate has a corresponding private key, see notes at the end of this topic.

7. To specify that clients log on to the Terminal Server by typing their credentials in the default Windows logon dialog box, select the Use standard Windows logon interface check box.

> [!NOTE]
>
> - To perform this procedure, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security best practice, consider using Run As to perform this procedure.
> - To open Terminal Services Configuration, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Terminal Services Configuration**.
> - Any encryption level settings that you configure in Group Policy overrides the configuration that you set by using the Terminal Services Configuration tool. Also, if you enable the [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](/previous-versions/windows/it-pro/windows-server-2003/cc780081(v=ws.10)) Group Policy setting, this setting overrides the Set client connection encryption level Group Policy setting.
> - When you change the encryption level, the new encryption level takes effect the next time a user logs on. If you require multiple levels of encryption on one server, install multiple network adapters and configure each adapter separately.
> - To verify that the certificate has a corresponding private key, in Terminal Services Configuration, right-click the connection for which you want to view the certificate, click the **General** tab, click **Edit**, click the certificate that you want to view, and then click **View Certificate**. At the bottom of the **General** tab, the statement, **You have a private key that corresponds to this certificate** should appear. You can also view this information by using the Certificates snap-in.
> - The FIPS compliant setting (the System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing setting in Group Policy or the FIPS Compliant setting in Terminal Server Configuration) encrypts and decrypts data sent from the client to the server and from the server to the client, with the Federal Information Processing Standard (FIPS) 140-1 encryption algorithms, using Microsoft cryptographic modules. For more information, see [Terminal Services in Windows Server 2003 Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc787876(v=ws.10)).
> - The High setting encrypts data sent from the client to the server and from the server to the client by using strong 128-bit encryption.
> - The Client Compatible setting encrypts data sent between the client and the server at the maximum key strength supported by the client.
> - The Low setting encrypts data sent from the client to the server using 56-bit encryption.

#### You cannot completely disconnect a Terminal Server connection

After a Terminal Server client loses the connection to a Terminal Server, the session on the Terminal Server may not transition to a disconnected state, instead, it may remain active even though the client is physically disconnected from the Terminal Server. If the client logs back in to the same Terminal Server, a new session may be established, and the original session may still remain active.

To work around this issue, follow these steps:

1. Click **Start**, click **Run**, type *gpedit.msc*, and then click **OK**.
2. Expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, and then click **Terminal Services**.
3. In the right pane, double-click **Keep-Alive Connections**.
4. Click **Enabled**, and then click **OK**.
5. Close Group Policy Object Editor, click **OK**, and then quit Active Directory Users and Computers.

#### RDP Services is currently busy

The following issues may occur when in Windows Server 2003 SNP feature is turned on:

##### Symptoms

When you try to connect to the server by using a VPN connection, you receive the following error message:

> Error 800: Unable to establish connection.

- You cannot create a Remote Desktop Protocol (RDP) connection to the server.
- You cannot connect to shares on the server from a computer on the local area network.
- You cannot join a client computer to the domain.
- You cannot connect to the Exchange server from a computer that is running Microsoft Outlook.
- Inactive Outlook connections to the Exchange server may not be cleaned up.
- You experience slow network performance.
- You may experience slow network performance when you communicate with a Windows Vista-based computer.
- You cannot create an outgoing FTP connection from the server.
- The Dynamic Host Configuration Protocol (DHCP) server service crashes.
- You experience slow performance when you log on to the domain.
- Network Address Translation (NAT) clients that are located behind Windows Small Business Server 2003 or Internet Security and Acceleration (ISA) Server experience intermittent connection failures.
- You experience intermittent RPC communications failures.
- The server stops responding.
- The server runs low on nonpaged pool memory

### You may have a certificate corruption

Terminal Services clients may be repeatedly denied access to the Terminal Server. If you are using a Terminal Services client to log on to the Terminal Server, you may receive one of the following error messages:

- Error message 1  

    > Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.

- Error message 2  

    > Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).

To resolve this issue, back up and then remove the X509 Certificate registry keys, restart the computer, and then reactivate the Terminal Services Licensing server. To do this, follow these steps.

> [!NOTE]
> Perform the following procedure on each of the Terminal Servers.

1. Make sure that the Terminal Server registry has been successfully backed up.
2. Start Registry Editor.
3. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService\`
4. On the **Registry** menu, click **Export Registry File**.
5. Type exported-parameters in the **File name** box, then click **Save**.

    > [!NOTE]
    > If you have to restore this registry subkey in the future, double-click the Exported-parameters.reg file that you saved in this step.

6. Under the **Parameters** registry subkey, right-click each of the following values, click **Delete**, and then click **Yes** to confirm the deletion:

    - Certificate  
    - X509 Certificate  
    - X509 Certificate ID

7. Quit Registry Editor, and then restart the server.
8. Reactivate the Terminal Services Licensing server by using the Telephone connection method in the Licensing Wizard.

## References

- [How to limit the number of connections on a terminal server that runs Windows Server 2003](limit-connections-terminal-server.md)

- [Troubleshooting General Remote Desktop Error Messages](/previous-versions/windows/it-pro/windows-server-2003/cc780927(v=ws.10))

- [Because of a security error, the client could not connect to the Terminal Server](https://support.microsoft.com/help/329896)

If this article does not help you resolve the problem or if you experience symptoms that differ from those that are described in this article, search the [Microsoft Support](https://support.microsoft.com/). Then, type the text of the error message that you receive, or type a description of the problem in the Search Support (KB) box.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#remote-desktop-disconnection).
