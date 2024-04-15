---
title: Increased CPU usage in explorer.exe
description: Describes an issue that causes CPU usage to increase when you access a SQL Server FileTable share from Windows Explorer. Occurs in a Windows Server 2012 and 2008 environment. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, stevepar
ms.custom: sap:Windows Desktop and Shell Experience\File Explorer (app only, folders, Quick Access, File Explorer search), csstroubleshoot
---
# Increased CPU usage when you access a SQL Server FileTable share from Windows Explorer

This article provides a solution to an issue that causes CPU usage to increase when you access a SQL Server FileTable share from Windows Explorer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3092936

## Symptoms

Consider the following scenario:

- You have implemented a SQL Server [FileTable](https://msdn.microsoft.com/library/ff929144.aspx).
- The FileTable exposes an SMB share.
- You access the SMB share through Windows Explorer (explorer.exe) by using a mapped drive or UNC path.

In this scenario, you may notice increased CPU usage in explorer.exe and also in the SQL Server and System processes. This symptom reflects an increase in SMB directory change notify traffic.

## Cause

SQL Server FileTable shares do not support directory change notifications. Therefore, the server that's running SQL Server responds to these requests with a STATUS_NOT_SUPPORTED value. Because explorer.exe cannot handle this response value synchronously, it continues to try to register directory change notifications while the FileTable SMB share is open in one or more explorer.exe windows. After these windows are closed, the change notification behavior should stop. Third-party file servers that don't support directory change notifications may also expose this behavior.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

To prevent this issue, disable SMB directory change notifications by using the **NoRemoteChangeNotify** registry value. Do this on any systems that will be accessing the FileTable share through Windows Explorer.

- To apply the setting to the user who is currently logged on, add the **NoRemoteChangeNotify** registry entry to the following registry key:

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`

- To apply the setting to all users who log on to the computer, add the **NoRemoteChangeNotify** registry entry to the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`

When you set the value of the **NoRemoteChangeNotify** registry entry to **1**, you turn off remote Change Notify requests for file and folder changes that occur in folders of a mapped network share. To turn on remote Change Notify requests, set the **NoRemoteChangeNotify** registry entry to 0 (zero).

Make sure that you turn off Change Notify requests for only the user who is currently logged on, as follows:

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
2. Locate and click the following registry key:

    `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *NoRemoteChangeNotify*, and then press ENTER.
5. On the **Edit** menu, click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.
7. Exit Registry Editor.

### Turn off Change Notify requests for all users

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then click **OK**.
2. Locate and click the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type *NoRemoteChangeNotify*, and then press ENTER.
5. On the **Edit** menu, click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.
7. Exit Registry Editor.
