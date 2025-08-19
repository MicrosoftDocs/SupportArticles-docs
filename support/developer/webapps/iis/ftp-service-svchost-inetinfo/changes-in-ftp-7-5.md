---
title: Changes in Microsoft FTP
description: This article describes some of the changes that were introduced in Microsoft FTP 7.5 and later versions.
ms.date: 12/18/2024
ms.custom: sap:FTP Service and Svchost or Inetinfo Process Operation\Service configuration
ms.reviewer: kaorif, mlaing, robmcm, dougste, zixie
---
# Changes in Microsoft FTP

This article describes some of the changes that were introduced in Microsoft FTP 7.5 and later versions.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2505047

## Some NLST command-line options don't work

In the current version of FTP, an FTP client can use only the `-C`, `-1`, `-l`, `-F`, `-a`, or `-A` command-line options with the NLST command. For example, the `-r` option (for the reverse sort direction) and the `-t` option (for sort by time of last write) no longer work. Because these command-line options aren't documented in the RFC, Microsoft might change the implementation in the future version of FTP.

## FTP data connections are established and disconnected asynchronously in the background

The establishing and disconnecting of the FTP data connection is processed in the background of the response for the control connection. The current version of FTP starts a three-way handshake to establish the data connection before it returns **200 PORT command successful** as the response to the `PORT` command to the control connection. The **226 Transfer complete** response returns as the response of the `LIST` and `RETR` commands to the control connection before the handshake to disconnect the data connection finishes.

## IisFtp.vbs isn't supported with FTP

In the current version of FTP, the **IisFtp.vbs** script is no longer supported and isn't included as part of the FTP installation package. Therefore, a functionality that uses *IisFtp.vbs* requires different actions in the current version of FTP. For example, the `IIsFtp.vbs /setadprop` command available in Internet Information Services (IIS) 6.0 to create an FTP site in Active Directory isolation Mode can't be used in the current version of FTP. Instead, use ADSI Editor to set the `msIIS-FTPRoot` and `msIIS-FTPDir` properties to point to the home directories in Active Directory Isolation Mode.

ADSI Editor is a Lightweight Directory Access Protocol (LDAP) editor that you can use to manage objects and attributes in Active Directory. It's installed on Windows Server domain controllers by default and has to be manually installed on member servers.

There are three main steps to configure the Isolate users in Active Directory mode:

- In IIS, create and configure the FTP sites to be isolated.
- Configure the file servers.
- Configure Active Directory.

To create and configure the FTP sites to be isolated, see [FTP Active Directory user isolation](/iis/configuration/system.applicationHost/sites/site/ftpServer/userIsolation/activeDirectory).

When you configure the file servers, you must create the shares and user directories for all the users who are permitted to connect to the FTP service, including the user configured to impersonate anonymous users. Before you complete this step, consider factors such as expected disk space usage, storage management, and network traffic.

To configure Active Directory, you can use ADSI Editor instead of **IisFtp.vbs**. To configure an FTP site in Active Directory Isolation Mode, follow these steps:

1. Select **Start**, select **Run**, and enter **adsiedit.msc** to run ADSI Editor.
2. If necessary, connect to the FTP server's domain. By default, it connects to the domain that the domain controller belongs to.
3. In the console pane, expand the FTP server's domain, expand **%Domain Name%**, and then select **CN=Users**.
4. In the details pane, right-click **CN=%User%**, and then select **Properties**.
5. On the **Attribute Editor** tab, select **msIIS-FTPRoot** or **msIIS-FTPDir**, and then select **Edit**.
6. Edit, and then select **OK**.

## FTP returns a 125 or 150 response when an FTP client sends a command needing the data connection in passive mode

In earlier versions of IIS, the FTP service returns a **125 Data connection already open; transfer starting** response for `APPE`, `STOU`, and `STOR` commands sent by FTP clients when the client and server are communicating over a passive mode connection. Additionally, FTP returns a **150 File status okay; about to open data connection** response for the `APPE`, `STOU`, and `STOR` commands over active mode connections.

In the current version of FTP, the response message doesn't depend on whether the request for the data connection is over passive mode or active mode. Instead, if the data connection is already established, FTP responds with **125 Data connection already open; transfer starting**. If the data connection isn't already established, FTP responds with **150 File status okay; about to open data connection**.

> [!NOTE]
> The current version of FTP does not start establishing the data connection for `PASV` or `EPSV` commands until the data connection for an earlier FTP request is disconnected.

## FTP returns a 451 error response if an FTP client doesn't use a CRLF as the end-of-line

In earlier versions of IIS, the FTP service accepted both `CRLF` and `LF` as the end-of-line mark. In the current version of FTP, the use of `LF` as the end-of-line marker is no longer supported. According to RFC 959, FTP should follow the specifications of the Telnet protocol, where `CRLF` is the only valid end-of-line marker. If an FTP client tries to end a line with LF, FTP returns the following error message:

> 451 The parameter is incorrect.

## FTP resets the data connection if an FTP client tries to use a port lower than 1024 for the data connection

In earlier versions of IIS, an FTP client could choose to use a port lower than 1024 for the data connection, in both passive mode and active mode FTP communications. In the current version of FTP, when an FTP client tries to use a port lower than 1024 for the data connection, FTP resets the underlying TCP connection. For example, if an FTP client tries to do a passive-mode upload of a file using the `STOR` command, and tries to use a port lower than 1024 for the data connection, the upload fails and the following entries are written to the FTP log:

```console
2012-01-15 02:08:16 123.456.789.0 user01 123.1.1.1 40063 DataChannelOpened - - 0 0
2012-01-15 02:08:16 123.456.789.0 user01 123.1.1.1 40063 DataChannelClosed - - 1236 38
2012-01-15 02:08:16 123.456.789.0 user01 123.1.1.1 21 STOR file.txt 425 1236 0
```

> [!NOTE]
> For an active-mode FTP upload using a data port less than 1024, the Win32 status is 87 instead of 1236.

This behavior occurs because in the current version of FTP, ports in the range of 0 to 1023 are now reserved for system processes or for programs executed by privileged users.

## FTP RETR for open files

In the current version of FTP, `RETR(GET)` for files that are already opened by a different process (not FTP Service (FTPSVC))  fails with `ERROR_SHARING_VIOLATION`.

## More information

For more information about the current version of FTP, see the following articles:

- [What's new for Microsoft and FTP in IIS 7?](/iis/get-started/whats-new-in-iis-7/what39s-new-for-microsoft-and-ftp-in-iis-7)

- [Installing and configuring FTP in IIS 7](/iis/install/installing-publishing-technologies/installing-and-configuring-ftp-7-on-iis-7)

- [The FTP status codes in IIS 7.0 and later versions](https://support.microsoft.com/help/969061)

- [How to configure FTP for IIS in a Windows Server failover cluster](https://support.microsoft.com/help/974603)

- [FTP extension - video walkthrough](/iis/publish/using-the-ftp-service/ftp-extension-video-walkthrough)

- [Error occurs when you create an FTP site in Internet Information Services: There was an error while performing this operation](https://support.microsoft.com/help/2505017)
