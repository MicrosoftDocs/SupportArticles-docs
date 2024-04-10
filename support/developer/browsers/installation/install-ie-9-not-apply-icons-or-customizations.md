---
title: Icons or customizations are missing of Internet Explorer 9
description: This article describes the problem that icons and user-defined aren't displayed when the Internet Explorer 9 is installed but the system isn't restarted, here a solution is provided for this.
ms.date: 06/09/2020
ms.reviewer: 
---
# Installing Internet Explorer 9 doesn't apply icons or per-user customizations

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving cases that you don't see icons or per-user customizations of Internet Explorer 9.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2642824

## Symptoms

After installing Internet Explorer 9 with no reboot option, you do not see icons or per-user customizations.

## Cause

This problem occurs because a user with Administrator privileges is required to delete the `NoIE4StubProcessing`registry keys. These are put in place to ensure there is a reboot before user customizations take place.

## Resolution

Do one of the following steps:

1. To install using Windows Update or Windows Server Update Services (WSUS).
2. To reboot the machine as part of the installation process.
3. To delete the following registry keys:

```console
C:\Windows\System32\reg.exe DELETE HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components /v NoIE4StubProcessing /f

C:\Windows\System32\reg.exe DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v NoIE4StubProcessing /f
```

> [!NOTE]
> If you have a current Internet Explorer Administration Kit(IEAK) package installed you should run the following command prior to the Internet Explorer 9 install: `Rundll32.exe iedkcs32.dll,BrandCleanInstallStubs`

## More information

- [Using Software Distribution Tools to Install Internet Explorer 9](/previous-versions/windows/internet-explorer/ie-it-pro/internet-explorer-9/gg699427(v=technet.10))
