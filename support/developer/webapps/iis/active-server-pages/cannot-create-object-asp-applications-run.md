---
title: Can't create Object when ASP applications run
description: This article provides resolutions for the Cannot create object error that occurs when APS applications run.
ms.date: 02/27/2020
ms.custom: sap:Active Server Pages
ms.subservice: active-server-pages
---
# Can't create Object when browsing ASP pages

This article helps you resolve the error (Cannot create object) that occurs when an Active Server Pages (ASP) applications run.

_Original product version:_ &nbsp; Active Server Pages  
_Original KB number:_ &nbsp; 201740

> [!NOTE]
> We strongly recommend that all users upgrade to Microsoft Internet Information Services (IIS) version 7.0 running on Microsoft Windows Server 2008. IIS 7.0 significantly increases Web infrastructure security.
>
> For more information about IIS 7.0, visit the following Microsoft Web site:
>
> [https://www.iis.net/default.aspx?tabid=1](https://www.iis.net/default.aspx?tabid=1)

## Symptoms

When an Active Server Pages (ASP) application runs, you may receive the following error(s).

Application Event Log Error:

> Failed on creation from object context: CoCreateInstance (ProgId: ADODB.Connection.1.5) (CLSID: {00000514-0000-0010-8000-00AA006D2EA4}) (Microsoft Transaction Server Internals Information: File: d:\viper\src\runtime\context\ccontext.cpp, Line: 1292)

Browser error:

> Microsoft VBScript runtime error '800a01ad' ActiveX component can't create object /test.asp, line 1

The line in the Active Server Pages file reads as follows:

```vbscript
<% set db = Server.CreateObject("ADODB.Connection") %>
```

## Cause

This problem is related to the permissions granted to your DLLs. The *IUSR_computer* and *IWAM_computer* account (where
*computer* is the name of the machine) don't have the permissions necessary to execute the DLLs being instantiated on the "Server.CreateObject" line in the ASP code.

## Resolution

The *IUSR_computer* and *IWAM_computer* account must be granted read permissions to the `\<drive letter>: \Program Files\Common Files\System\ADO` directory.
