---
title: VBScript type mismatch error
description: This article provides resolutions for the type mismatch error that occurs when field type is adNumeric.
ms.date: 09/24/2020
ms.custom: sap:Active Server Pages
ms.service: iis
ms.subservice: active-server-pages
---
# VBScript Type type mismatch when field type is adNumeric

This article helps you resolve the Type Mismatch error that occurs when field type is `adNumeric`.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 195180

## Symptoms

When you perform a numeric comparison or calculation on an `adNumeric` (131) field type using VBScript, the following errors may be returned:

> Microsoft VBScript runtime error '800a000d'  
Type mismatch  
Microsoft VBScript runtime error '800a01ca' Variable uses an Automation type not supported in VBScript

## Cause

The errors occur because VBScript cannot properly convert `adNumeric` values to a valid numeric type.

## Resolution

You can use either of the following two possible workarounds:

- Convert the `adNumeric` field using `CDbl()` or `CInt()` as in the following example:

    ```vbscript
     <%@ LANGUAGE="VBScript"%>
     <%
     Set oConn = Server.CreateObject("ADODB.Connection")
     oConn.Open "MyDSN", "MyUserID", "MyPassWord"
     set oRS = oConn.Execute("Select list_price FROM DEMO.PRICE")
     Response.Write("List Price * 100 = " & CDbl(oRS("list_price")) * 100)
     %>
    ```

- Use JScript, because JScript does not exhibit this behavior.

## Steps to Reproduce the Behavior

The following code exhibits the above-mentioned error:

```vbscript
<%
 Set oConn = Server.CreateObject("ADODB.COnnection")
 oConn.Open "MyDSN", "MyUserID", "MyPassWord"
 set oRS = oConn.Execute("Select list_price FROM DEMO.PRICE")'This is the bad line of code, "list_price" is being returned as
 'type adNumeric.
 Response.Write("List Price * 100 = " & oRS("list_price") * 100)
 %>
```
