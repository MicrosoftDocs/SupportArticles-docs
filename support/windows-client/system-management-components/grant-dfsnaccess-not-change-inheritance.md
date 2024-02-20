---
title: Grant-DfsnAccess cmdlet doesn't change inheritance on DFS links
description: Describes a problem in which the Windows PowerShell cmdlet Grant-DfsnAccess doesn't change inheritance on DFS links. Provides a workaround.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, huberts
ms.custom: sap:powershell, csstroubleshoot
---
# Windows PowerShell cmdlet Grant-DfsnAccess doesn't change inheritance on DFS links

This article provides workarounds for an issue where Windows PowerShell cmdlet `Grant-DfsnAccess` doesn't change inheritance on Distributed File System (DFS) links.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2 Standard, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2938148

## Symptoms

You use the Windows PowerShell cmdlet `Grant-DfsnAccess` to set permissions on DFS links in a DFS namespace in order to have the links filtered by Access Based Enumeration, as in the following example:

```powershell
Grant-DfsnAccess -Path "\\Contoso.com\Software\Projects" -AccountName "Contoso\UserName"
```

Although the command is completed successfully and the result of the cmdlet shows the correct permissions, you notice that the Access Based Enumeration filtering doesn't reflect the newly set permissions. Additionally, when you check the permissions of the link in the DFS Management Console, you notice that the **Use inherited permission from the local file System** option is still selected.

## Cause

Although the `Grant-DfsnAccess` cmdlet successfully configures the view permissions for individual groups or users, the cmdlet doesn't change the inheritance mode from use inherited to set explicit. Therefore, the permissions that are set on the link don't take effect.

Microsoft is aware of this problem with the Windows PowerShell cmdlet `Grant-DfsnAccess`.

## Workaround

To work around this problem, use one of the following methods.

- Manually disable inheritance in the DFS Management Console by selecting the **Set explicit view permissions** option.

- Use the `dfsutil property sd grant` command instead, as in the following example:

  ```console
  dfsutil property sd grant \\Contoso.com\Software\Projects Contoso\UserName:RX protect
  ```

## More information

In order to administer DFS namespaces, several Windows PowerShell cmdlets were created as replacement for the command-line utilities such as dfsutil.exe. One of the administrative tasks that is automated is the granting of permissions to DFS links for ABE filtering. By default, DFS namespaces inherit the permission from the DFS root down to the links. This is represented in the Microsoft Management Console (MMC) user interface as use inherited permissions from the local file system. However, for certain links to be displayed while other links aren't, the administrator has to select the **Set explicit view permissions on the DFS folder** option and then set the **Configure View permissions** for the individual users or groups.
