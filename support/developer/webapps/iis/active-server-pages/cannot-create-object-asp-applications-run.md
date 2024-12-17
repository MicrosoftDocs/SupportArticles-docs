---
title: Can't create object when ASP applications run
description: This article provides resolutions for the Cannot create object error that occurs when ASP applications run.
ms.date: 12/17/2024
ms.custom: sap:Active Server Pages\Debugging
---
# Can't create object when browsing ASP pages

This article helps you resolve the error (Cannot create object) that occurs when an Active Server Pages (ASP) application runs.

_Original product version:_ &nbsp; Active Server Pages  
_Original KB number:_ &nbsp; 201740

## Symptoms

When an ASP application runs, you might receive the following errors:

Application Event Log error:

> Failed on creation from object context: CoCreateInstance (ProgId: ADODB.Connection.1.5) (CLSID: {ID}) (Microsoft Transaction Server Internals Information: File: d:\viper\src\runtime\context\ccontext.cpp, Line: 1292)

Browser error:

> Microsoft VBScript runtime error '800a01ad' ActiveX component can't create object /test.asp, line 1

The line in the ASP file reads as follows:

```vbscript
<% set db = Server.CreateObject("ADODB.Connection") %>
```

## Cause

This problem is related to the permissions granted to your dynamic link libraries (DLLs). The *IUSR_computer* and *IWAM_computer* accounts (where *computer* is the name of the machine) don't have the permissions necessary to execute the DLLs being instantiated on the `Server.CreateObject` line in the ASP code.

## Resolution

The *IUSR_computer* and *IWAM_computer* accounts must be granted read permissions to the `\<drive letter>: \Program Files\Common Files\System\ADO` directory.
