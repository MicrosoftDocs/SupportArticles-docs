---
title: Find servers that hold FSMO roles
description: Describe how to find the servers that hold the Flexible Single Master Operation (FSMO) roles in a forest.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, MHUNTER, dhook
ms.custom: sap:active-directory-fsmo, csstroubleshoot
---
# How To Find Servers That Hold Flexible Single Master Operations Roles

This article describes how to find the servers that hold the Flexible Single Master Operation (FSMO) roles in a forest.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 234790

## Summary

Active Directory defines five FSMO roles:

- Schema master
- Domain naming master
- RID master
- PDC master
- Infrastructure master

The schema master and the domain naming master are per-forest roles. Therefore, there is only one schema master and one domain naming master per forest.

The RID master, the PDC master, and the infrastructure master are per-domain roles. Each domain has its own RID master, PDC master, and infrastructure master. Therefore, if a forest has three domains, there are three RID masters, three PDC masters, and three infrastructures masters.

## Determine the RID, PDC, and Infrastructure FSMO Holders of a Selected Domain

1. Click Start, click Run, type dsa.msc, and then click OK.
2. Right-click the selected Domain Object in the top-left pane, and then click Operations Masters.
3. Click the PDC tab to view the server holding the PDC master role.
4. Click the Infrastructure tab to view the server holding the Infrastructure master role.
5. Click the RID Pool tab to view the server holding the RID master role.

## Determine the Schema FSMO Holder in a Forest

1. Click Start, click Run, type mmc, and then click OK.
2. On the Console menu, click **Add/Remove Snap-in**, click Add, double-click Active Directory Schema, click Close, and then click OK.
3. Right-click Active Directory Schema in the top-left pane, and then click Operations Masters to view the server holding the schema master role.

> [!NOTE]
> For the Active Directory Schema snap-in to be available, you may have to register the Schmmgmt.dll file. To do this, click Start , click Run , type regsvr32 schmmgmt.dll in the Open box, and then click OK . A message is displayed that states the registration was successful.

## Determine the Domain Naming FSMO Holder in a Forest

1. Click Start, click Run, type mmc, and then click OK.
2. On the Console menu, click **Add/Remove Snap-in**, click Add, double-click **Active Directory Domains and Trusts**, click Close, and then click OK.
3. In the left pane, click **Active Directory Domains and Trusts**.
4. Right-click **Active Directory Domains and Trust**, and then click Operations Master to view the server holding the domain naming master role in the Forest.

## Use the Windows 2000 Server Resource Kit

The Windows 2000 Resource Kit contains a .cmd file called Dumpfsmos.cmd that you can use to quickly list FSMO role owners for your current domain and forest. The .cmd file uses Ntdsutil.exe to enumerate the role owners. The Dumpfsmos.cmd file contains:

```console
@echo off
REM
REM Script to dump FSMO role owners on the server designated by %1
REM

if ""=="%1" goto usage

Ntdsutil roles Connections "Connect to server %1" Quit "select Operation Target" "List roles for connected server" Quit Quit Quit 

goto done

:usage

@echo Please provide the name of a domain controller (i.e. dumpfsmos MYDC)
@echo.

:done
```

## Use the NTDSUTIL Tool

NTDSUTIL is a tool included with Windows 2000 Server, Windows 2000 Advanced Server, and Windows 2000 Datacenter Server. This tool is can be used to verify change certain aspects of the Active Directory. The following is the steps needed to view the Flexible Single Master Operation (FSMO) roles on a given Domain Controller.

Ntdsutil.exe is the only tool that shows you all the FSMO role owners. You can view the PDC emulator, RID master, and infrastructure master role owners in Active Directory Users and Computers. You can view the schema master role owner in the Active Directory Schema snap-in. You can view the domain naming master role owner in Active Directory Domains and Trusts.

1. Click Start, click Run, type cmd in the Open box, and then press ENTER.
2. Type ntdsutil, and then press ENTER.
3. Type domain management, and then press ENTER.
4. Type connections, and then press ENTER.
5. Type connect to server
 **ServerName**, where
 **ServerName** is the Name of the Domain Controller you would like to view, and then press ENTER.
6. Type quit, and then press ENTER.
7. Type select operation target, and then press ENTER.
8. Type list roles for connected server, and then press ENTER. A list is displayed similar to what is listed below. Results may very depending on the roles the particular Domain Controller may hold. If you receive an error message, check the spelling of the commands as the syntax of the commands must be exact. If you need the syntax of a command, type? at each prompt:

    ```console
    Server "dc1" knows about 5 roles
    Schema - CN=NTDS
    Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=corp,DC=com
    Domain - CN=NTDS
    Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=corp,DC=com
    PDC - CN=NTDS
    Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=corp,DC=com
    RID - CN=NTDS
    Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=corp,DC=com
    Infrastructure - CN=NTDS
    Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=corp,DC=com
    ```

## Use DCDIAG

On a Windows 2000 Domain Controller, run the following command:

```console
DCdiag /test:Knowsofroleholders /v
```

You must use the /v switch. This lists the owners of all FSMO roles in the enterprise.

## References

For additional information, click the article numbers below to view the articles:

- [197132](https://support.microsoft.com/help/197132) Windows 2000 Active Directory FSMO Roles

- [223346](https://support.microsoft.com/help/223346) FSMO Placement and Optimization on Windows 2000 Domains
