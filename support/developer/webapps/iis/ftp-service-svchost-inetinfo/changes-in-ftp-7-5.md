---
title: Changes in FTP 7.5
description: This article introduces the changes that were made for Microsoft FTP 7.5.
ms.date: 04/07/2020
ms.custom: sap:FTP service and Svchost or Inetinfo process operation
ms.subservice: ftp-service-svchost-inetinfo
ms.reviewer: kaorif, mlaing, robmcm, dougste
ms.topic: article
---
# Changes in Microsoft FTP 7.5

This article describes some of the changes that were introduced in Microsoft FTP 7.5.

_Original product version:_ &nbsp; Internet Information Services 8.0, 8.5  
_Original KB number:_ &nbsp; 2505047

## Some NLST command-line options don't work

In FTP 7.5, an FTP client can use only the `-C`, `-1`, `-l`, `-F`, `-a`, or `-A` command-line options with the NLST command. For example, the `-r` option (for the reverse sort direction) and the `-t` option (for sort by time of last write) no longer work. Because these command-line options are not documented in the RFC, Microsoft may change the implementation in the feature version of FTP.

## FTP data connections are established and disconnected asynchronously in the background

The establishing and disconnecting of the FTP data connection is processed in the background of the response for the control connection. FTP 7.5 starts a three-way handshake to establish the data connection before it returns **200 PORT command successful** as the response to the `PORT` command to the control connection. The **226 Transfer Complete** response returns as the response of the `LIST` and `RETR` commands to the control connection before the handshake to disconnect the data connection finishes.

## IisFtp.vbs isn't supported with FTP 7.5

Beginning in FTP 7.5, the *IisFtp.vbs* script is no longer supported and is not included as part of the FTP 7.5 installation package. Therefore some functionality that was possible using *IisFtp.vbs* requires different action to be taken starting in FTP 7.5. For example, the `IIsFtp.vbs /setadprop` command available in Internet Information Services (IIS) 6.0 to create an FTP site in Active Directory isolation Mode cannot be used in FTP 7.5. Instead, use ADSI Editor to set the `msIIS-FTPRoot` and `msIIS-FTPDir` properties to point to the home directories in Active Directory Isolation Mode.

ADSI Editor is a Lightweight Directory Access Protocol (LDAP) editor that you can use to manage objects and attributes in Active Directory. This is installed on Windows Server 2008 domain controllers by default and will have to be manually installed on member servers.

There are three main steps to configure the Isolate users in Active Directory mode:

- In IIS, create and configure the FTP sites to be isolated.
- Configure the file servers.
- Configure Active Directory.

To create and configure the FTP sites to be isolated, see [FTP Active Directory user isolation](/iis/configuration/system.applicationHost/sites/site/ftpServer/userIsolation/activeDirectory).

When you configure the file servers, you must create the shares and user directories for all the users who are permitted to connect to the FTP service, including the user configured to impersonate anonymous users. Before you complete this step, consider factors such as expected disk space usage, storage management, and network traffic.

To configure Active Directory, you can use ADSI Editor instead of *IisFtp.vbs*. To configure an FTP 7.5 site in Active Directory Isolation Mode, take the following steps:

1. Select **Start**, select **Run**, and enter **adsiedit.msc** to run ADSI Editor.
2. If necessary, connect to the FTP server's domain. By default, it connects to the domain that the domain controller belongs to.
3. In the console pane, expand the FTP server's domain, expand **%Domain Name%**, and then select **CN=Users**.
4. In the details pane, right-click **CN=%User%**, and then select **Properties**.
5. On the **Attribute Editor** tab, select **msIIS-FTPRoot** or **msIIS-FTPDir**, and then select **Edit**.
6. Edit, and then select **OK**.

## FTP 7.5 returns a 125 or 150 response when an FTP client sends a command needing the data connection in passive mode

In earlier versions of IIS, the FTP service returns a **125 Data connection already open; transfer starting** response for `APPE`, `STOU`, and `STOR` commands sent by FTP clients when the client and server are communicating over a passive mode connection. Additionally, FTP returns a **150 File status okay; about to open data connection.** response for the `APPE`, `STOU`, and `STOR` commands over active mode connections.

In FTP 7.5 and later versions, the response message does not depend on whether the request for the data connection is over passive mode or active mode. Instead, if the data connection is already established FTP 7.5 responds with **125 Data connection already open; transfer starting**. If the data connection is not already established, FTP responds with **150 File status okay; about to open data connection**.

> [!NOTE]
> FTP 7.5 does not start establishing the data connection for `PASV` or `EPSV` commands until the data connection for an earlier FTP request is disconnected.

## FTP 7.5 returns a 451 error response if an FTP client does not use a CRLF as the end-of-line

In earlier versions of IIS, the FTP service accepted both `CRLF` and `LF` as the end-of-line mark. Beginning in FTP 7.5, the use of `LF` as the end-of-line marker is no longer supported. According to RFC 959, FTP should follow the specifications of the Telnet protocol, where `CRLF` is the only valid end-of-line marker. If an FTP client tries to end a line with LF, FTP 7.5 will return the following error message:

> 451 The parameter is incorrect.

## FTP 7.5 resets the data connection if an FTP client tries to use a port lower than 1024 for the data connection

In earlier versions of IIS, an FTP client could choose to use a port lower than 1024 for the data connection, in both passive mode and active mode FTP communications. Beginning in FTP 7.5, when an FTP client tries to use a port lower than 1024 for the data connection, FTP 7.5 will reset the underlying TCP connection. For example, if an FTP client tries to do a passive-mode upload of a file using the `STOR` command, and tries to use a port lower than 1024 for the data connection, the upload will fail and entries similar to the following will be written to the FTP log:

```console
2012-01-15 02:08:16 123.456.789.0 user01 123.1.1.1 40063 DataChannelOpened - - 0 0
2012-01-15 02:08:16 123.456.789.0 user01 123.1.1.1 40063 DataChannelClosed - - 1236 38
2012-01-15 02:08:16 123.456.789.0 user01 123.1.1.1 21 STOR file.txt 425 1236 0
```

> [!NOTE]
> For an active-mode FTP upload using a data port less than 1024, the Win32 status will be 87 instead of 1236.

This behavior occurs because in FTP 7.5 ports in the range of 0-1023 are now reserved for system processes or for programs executed by privileged users.

## FTP RETR for open files

FTP 7.5 `RETR(GET)` for files that are already opened by a different process (not FTP Service (FTPSVC)) will fail with `ERROR_SHARING_VIOLATION`.

## More information

For more information about FTP 7.5, see the following articles:

- [What's new for Microsoft and FTP in IIS 7?](/iis/get-started/whats-new-in-iis-7/what39s-new-for-microsoft-and-ftp-in-iis-7)

- [Installing and configuring FTP in IIS 7](/iis/install/installing-publishing-technologies/installing-and-configuring-ftp-7-on-iis-7)

- [The FTP 7.0 status codes in IIS 7.0 and later versions](https://support.microsoft.com/help/969061)

- [How to configure FTP 7.5 for IIS 7.0 in a Windows Server failover cluster](https://support.microsoft.com/help/974603)

- [FTP extension - video walkthrough](/iis/publish/using-the-ftp-service/ftp-extension-video-walkthrough)

- [Error when creating an FTP site in IIS 7.0 and 7.5: There was an error while performing this operation](https://support.microsoft.com/help/2505017)
