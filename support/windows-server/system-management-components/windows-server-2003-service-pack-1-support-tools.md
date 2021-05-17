---
title: Windows Server 2003 Service Pack 1 Support Tools
description: Describes updates to the Windows Server 2003 Support Tools that are included in Windows Server 2003 SP1.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Help and Support
ms.technology: windows-server-system-management-components
---
# Windows Server 2003 Service Pack 1 Support Tools

This article describes updates to the Microsoft Windows Server 2003 Support Tools that are included in Microsoft Windows Server 2003 Service Pack 1 (SP1).

_Applies to:_ &nbsp; Windows Server 2003 Service Pack 1
_Original KB number:_ &nbsp;892777

## Introduction

If you are a support person or a network administrator, you can use the Windows Support Tools to manage networks and to troubleshoot network problems that you may experience.

## More information

Windows Server 2003 SP1 includes updates for the following Support Tools:  

- Acldiag.exe
- Adsiedit.msc
- Bitsadmin.exe
- Dcdiag.exe
- Dfsutil.exe
- Dnslint.exe
- Dsacls.exe
- Iadstools.dll
- Ktpass.exe
- Ldp.exe
- Netdiag.exe
- Netdom.exe
- Ntfrsutl.exe
- Portqry.exe
- Repadmin.exe
- Replmon.exe
- Setspn.exe

The Windows Support Tools are not automatically installed when you install Windows Server 2003 SP1. To install the Windows Support Tools on a computer that is running Windows Server 2003, run the Suptools.msi program that is in the Support\Tools folder on the Windows Server 2003 SP1 CD.

The Windows Server 2003 Support Tools Help file (Suptools.chm) is located in the Sup_srv.cab file. This Help file includes a description of each tool and its associated syntax. This Help file also includes sample output and notes. See this Help file for specific usage information for these tools.

For additional help, type the following command at the command prompt, and then press ENTER: **tool name** /help.

> [!NOTE]
> In this command, the placeholder **tool name** represents the name of the tool for which you want to obtain help.

> [!NOTE]
> If you have an earlier version of the Windows Support Tools installed on your computer, you must remove this version before you install the Windows Server 2003 SP1 Support Tools.
