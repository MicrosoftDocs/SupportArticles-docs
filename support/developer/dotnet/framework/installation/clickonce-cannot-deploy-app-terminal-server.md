---
title: ClickOnce can't be used in Terminal Server
description: ClickOnce can't be used to deploy applications in Windows Terminal Server.
ms.date: 05/13/2020
ms.custom: sap:Installation
---
# ClickOnce can't be used in Windows Terminal Server

This article explains why ClickOnce can't be used to deploy applications on Windows Terminal Servers.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 2020945

## Symptoms

ClickOnce can't be used to deploy applications on any Windows Terminal Servers including 2008 and 2008 R2.

## Cause

This is because of a limitation within the Windows Terminal Server remoting functionality.  

This is a limitation regardless of how the ClickOnce deployment is initiated include clicking on the deployment URL from within a standard Terminal Server session or using the **Start a program** on the **Programs** tab in the Remote Desktop Connection (MSTSC).

## Resolution

ClickOnce apps aren't supported as RemoteApps.

## More information

While it might be possible to get a ClickOnce application to deploy on some of the older operating systems this functionality hasn't been tested and could be adversely affected by future operating system service packs.

References:

- [Application Settings Architecture](/previous-versions/visualstudio/visual-studio-2010/8eyb2ct1(v=vs.100))
- [Choosing a Deployment Strategy](/previous-versions/visualstudio/visual-studio-2010/e2444w33(v=vs.100))
