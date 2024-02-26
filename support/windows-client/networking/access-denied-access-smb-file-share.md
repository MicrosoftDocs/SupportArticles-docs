---
title: Access Denied when you access Server Message Block (SMB) file share
description: Resolves an issue in which you can't access a shared folder through SMB2 protocol. This issue occurs in Windows 8.1, Windows Server 2012 R2, Windows 8, Windows Server 2012, Windows 7, Windows Server 2008 R2, Windows Vista, and Windows Server 2008.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Access Denied when you access an SMB file share in Windows

This article helps fix the **Access Denied** error that occurs when you access a Server Message Block (SMB) file share.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3035936

## Symptoms

When you try to access a specific folder that's located on a Network Appliance (NetApp) Filer or a Windows Server that supports SMB2 from a Windows-based system through the SMB Version 2 protocol, the access is denied. This issue occurs in the following version of Windows:

- Windows 8.1
- Windows Server 2012 R2
- Windows 8
- Windows Server 2012
- Windows 7
- Windows Server 2008 R2
- Windows Vista
- Windows Server 2008

> [!NOTE]
> This issue doesn't occur if you disable the SMB2 protocol on the client or use a Windows SMB client, such as Windows XP or Windows Server 2003.

## Cause

This issue occurs because the target folder on the SMB share is missing the SYNCHRONIZE access control entries.

## Resolution

To resolve this issue, use the [ICACLS utility](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753525(v=ws.10)) to set the desired permissions that contain the Synchronize bit.

For example, at a command prompt, type the following command, and then press ENTER:

```console
ICACLS h:\folder /grant domain\user:(RC,RD,REA,RA,X,S)
```

A comma-separated list in parentheses of specific rights:

- RC - read control
- RD - read data/list directory
- REA - read extended attributes
- RA - read attributes
- X - execute/traverse
- S - Synchronize

## Troubleshooting

You can use the following methods to verify and troubleshoot the issue.

1. Verify that the NetApp Filer has the Synchronize bit set on the folder.
2. A network trace can show the **DesiredAccess** error for the SMB2 CREATE process on the folder for the Request and Response packet.
3. The [AccessChk.exe tool](/sysinternals/downloads/accesschk) is available on [Windows Sysinternals](/sysinternals/) site for reading out the permission settings.

    For example, run the following command:

    ```console
    C:\tools\Sysinternals\accesschk.exe -ld
    ```

    Then, you can see the following result that shows the SYNCHRONIZE bit is set:

    ```output
    [2] ACCESS_ALLOWED_ACE_TYPE: BUILTIN\Users  
    [OBJECT_INHERIT_ACE]  
    [CONTAINER_INHERIT_ACE]  
    [INHERITED_ACE]  
    FILE_LIST_DIRECTORY  
    FILE_READ_ATTRIBUTES  
    FILE_READ_EA  
    FILE_TRAVERSE  
    SYNCHRONIZE  
    READ_CONTROL
    ```

    See the [behavior of the SYNCHRONIZE bit](/openspecs/windows_protocols/ms-smb2/a64e55aa-1152-48e4-8206-edd96444e7f7) on Windows SMB2 clients.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
