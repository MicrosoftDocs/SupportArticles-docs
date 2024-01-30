---
title: Use the FTP Utility
description: This article explains how to use the FTP utility.
ms.date: 03/23/2020
ms.custom: sap:FTP authentication and authorization
ms.reviewer: kevinz
ms.topic: how-to
ms.subservice: ftp-authentication-authorization
---
# Use the FTP Utility in a typical session

This article explains how to use the File Transfer Protocol (FTP) utility, which is included with Windows, in a typical FTP session.

_Original product version:_ &nbsp;  Windows  
_Original KB number:_ &nbsp; 240727

## Summary

This article covers the following topics:

- Opening an FTP site
- Browsing the list of files and folders
- Changing folders
- Copying a file from the FTP site to your local computer
- Copying a file from your local computer to the FTP site
- Ending an FTP session

> [!NOTE]
>
> - The FTP utility is run from the command prompt.
> - After each description of how to perform a step in the typical FTP session is sample screen output from that part of the session.
> - All FTP commands are case sensitive.

## Opening an FTP site

To open an FTP site, perform the following steps:

1. At the command prompt, type the following:

    ```console
    ftp ServerName
    ```

    > [!NOTE]
    > The prompt changes to **ftp>**.
2. Type anonymous when prompted for the user.
3. Type any password.

   > [!NOTE]
   > The anonymous user name is typically used to log on to FTP sites, particularly those that are not set up for users to copy files to. Usually, any text can be supplied for the password, including no text (just press the ENTER key when prompted for the password).

```console
C:\>ftp <ServerName>
Connected to <ServerName>.
220 <ServerName> Microsoft FTP Service (Version 4.0).
User (<ServerName>:(none)): anonymous
331 Anonymous access allowed, send identity (e-mail name) as password.
Password:
230 Anonymous user logged in.
ftp>
```

## Browsing the list of files and folders

To view the list of files and folders, type *dir* at the ftp prompt.

```console
ftp> dir
200 PORT command successful.
150 Opening ASCII mode data connection for /bin/ls.
08-29-99 08:11PM 35 File1.txt
08-29-99 08:11PM <DIR> Folder1
226 Transfer complete.
98 bytes received in 0.00 seconds (98000.00 Kbytes/sec)
ftp>
```

## Changing folders

To change to a different folder (also known as the working directory), use the `cd` command.

> [!NOTE]
> To change to the root folder, type either `cd /` or `cd \`. To change to the parent folder, use two periods (`cd ..`).

```console
ftp> cd folder1
250 CWD command successful.
ftp>
```

## Copying a file from the FTP site to your local computer

To copy a file from the FTP site to your local computer, use the `get` command.

```console
ftp> get file1.txt
200 PORT command successful.
150 Opening ASCII mode data connection for file1.txt(35 bytes).
226 Transfer complete.
35 bytes received in 0.16 seconds (0.22 Kbytes/sec)
ftp>
```

## Copying a file from your local computer to the FTP site

To copy a file from your local computer to the FTP site, use the put command.

> [!NOTE]
> Most sites only allow users to do this if they have logged on using a specific, preassigned user name, not the anonymous user.

```console
ftp> put myfile.txt
200 PORT command successful.
150 Opening ASCII mode data connection for MyFile.txt.
226 Transfer complete.
36 bytes sent in 0.00 seconds (36000.00 Kbytes/sec)
ftp>
```

## Ending an FTP session

To end the FTP session, use the `bye` command.

```console
ftp> bye
221

C:\>
```

## References

For a full list of the commands and parameters that can be used with the FTP utility, perform the following steps:

1. From the **Start** menu, select **Help**.
2. Select the **Index** tab, and then type *ftp utility*.
3. In the list box, double-click the ftp utility entry.
4. For a list of all FTP commands, double-click the **(untitled #0)** entry. For a list of parameters available when starting the ftp utility, double-click the **(untitled #0)** entry.
