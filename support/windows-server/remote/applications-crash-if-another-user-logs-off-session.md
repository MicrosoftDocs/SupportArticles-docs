---
title: Applications crash if another user logs off
description: Discusses an issue in which applications crash or become unresponsive if another user logs off a Remote Desktop session in Windows Server 2012/R2 or Windows Server 2008/R2.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
ms.subservice: rds
---
# Applications crash or become unresponsive if another user logs off a Remote Desktop session in Windows Server 2012/R2 or Windows Server 2008/R2

This article helps fix an issue where applications crash or become unresponsive if another user logs off a Remote Desktop session.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2536487

## Symptoms

When you run an application from a mapped drive, the application becomes unresponsive or crashes for a user (or multiple users) when another user logs off. This issue occurs in Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 Service Pack 1 (SP1), and Windows Server 2008.
For example, this issue may occur in the following scenario:

- One server is a file server and another is a Remote Session Host server (terminal server).
- A folder on the file server is mapped for use by remote users connecting to the RDS server.
- An application on the mapped share is launched by multiple users.
- One user logs off. This causes the other users of the application to experience an application crash or unresponsiveness. Depending on the OS version, this issue occurs when either the first or last user of the application logs off, as follows:

  - In Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008, this issue occurs when the first user who logged on logs off.
  - In Windows Server 2008 R2 SP1, this issue occurs when the last user who logged on logs off.

> [!NOTE]
> In Windows Server 2008 R2 SP1, this behavior changes to the same as that of Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 after you install [hotfix 2559767](https://support.microsoft.com/help/2559767).  

## Cause

This issue occurs because of the way that the redirector handles the File Control Block (FCB) for the binary in question.

In Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008, the FCB is owned by the first user who opened the file, and this FCB is used by subsequent users. When the first user logs off, the FCB is orphaned. This causes the application to crash or become unresponsive on subsequent uses.  
In Windows Server 2008 R2, the FCB is owned by the last user who opened the file, and previous users experience the issue when the last user logs off.  

Technically the FCB is not owned by any specific user. It's just a shared structure that represents a file. The FCB is created when the first handle to the file is opened, and it's destroyed when the last handle to the file is closed. Therefore, it is not tied to a user.  

The orphaned entity is the file object that belongs to the user who logs off. If that file object backs the file system cache or a mapped section, you experience these I/O errors.  

## Resolution

To resolve this issue, upgrade to [Windows Server 2016](https://www.microsoft.com/cloud-platform/windows-server). The issue is fixed in this version of Windows Server.

## Workaround

To work around this issue, use one of the following methods:

- Do not run shared applications from a mapped folder. Instead, install the shared application locally on the terminal server.
- Use WebDAV shares instead of mapped folders if remote binary sharing is required.
- Compile the application by using the **Swap run from network** linker setting:
  - This setting is described here: [https://msdn.microsoft.com/library/chzz5ts6(v=vs.71).aspx](https://msdn.microsoft.com/library/chzz5ts6(v=vs.71).aspx)
- If the application is a managed app, use the [Shadow Copy feature](/windows/win32/vss/shadow-copies-and-shadow-copy-sets).

> [!NOTE]
> We don't recommend that you run binaries remotely. In situations such as this, we recommend that you use the first workaround.
