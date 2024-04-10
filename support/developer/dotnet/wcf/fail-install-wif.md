---
title: Fail to install Windows Identity Foundation
description: This article provides resolutions for an issue that prevents you from installing Windows Identity Foundation in Windows Core.
ms.date: 08/24/2020
ms.reviewer: rviana, brandwe
---
# You can't install Windows Identity Foundation in Windows Core

This article helps you resolve an issue that prevents you from installing Windows Identity Foundation (WIF) in Windows Core.

_Original product version:_ &nbsp; .NET Framework 4.5, Windows Server, Windows Identity Foundation  
_Original KB number:_ &nbsp; 3044149

## Symptoms

You try to install WIF through the GUI or by running the following PowerShell command in Windows Core (2008-2012/R2):

```powershell
install-windowsfeature windows-identity-foundation
```

However, you receive the following error message:

> Installation of one or more roles, role services, or features failed. One or several parent features are disabled so current feature cannot be enabled. Error: 0xc004000d

## Cause

This behavior is by design. WIF requires some features (such as the .NET Framework 4.5 or .NET Framework 3.5) that are not installed in Windows Core.

## Resolution

To install Windows Foundation in Windows Core, you must apply the Minimal Server Interface. The Minimal Server Interface binaries are not present in Windows Core installation. To obtain these binaries, you must use the Features on-Demand component or an alternative installation source.

You can also install (and uninstall) features remotely from Windows Server Manager on a remote installation of Windows 8 or Windows 2012. For information about how to do this, see the [More Information](#more-information) section.

## More information

- [Windows Server Installation Options](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831786(v=ws.11))

- [Configuring the Minimal Server Interface](/archive/blogs/server_core/configuring-the-minimal-server-interface)

## Applies to

- Windows Server 2012 Foundation
- Windows Server 2012 R2 Foundation
- Windows Server 2008 R2 Foundation
- Windows Server 2008 Foundation
