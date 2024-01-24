---
title: Error when you call MTS COM from ASP
description: This article provides resolutions for the problem where server execution fails when you call an MTS COM Component from ASP.
ms.date: 03/24/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: jmeier
ms.technology: site-behavior-performance
---
# Server execution failed when calling MTS COM component from ASP

This article helps you resolve the problem where server execution fails when you call an Microsoft Transaction Server (MTS) Component Object Model (COM) component from Active Server Pages (ASP)

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 241057

## Symptoms

When you call a COM component of an MTS Package from ASP, the following error may occur intermittently:

> Server object error 'ASP 0177 : 80080005'  
> Server.CreateObject Failed  
> /xxxx.asp, line xx  
> Server execution failed

This error message is association with the following similar event log entry:

> EventID: 4134  
> Source: Transaction Server  
> Type: Error  
> Category: Executive  
> Failed on creation from object context: CoGetClassObject (ProgId: xxxx.xxxx) (CLSID: {B57CF3F7-66D3-496A-9D3B-55AE65A952FB}) (Interface: IClassFactory) (IID: {00000001-0000-0000-C000-000000000046}) (Microsoft Transaction Server Internals Information: File: d:\viper\src\runtime\context\ccontext.cpp, Line: 1285)  
> Data (words):  
> 0000: 80080005

Or the following error might occur when the component is created using the `CreateObject` method instead of `Server.CreateObject` from ASP:

> Microsoft VBScript runtime error '800a01ad'  
> ActiveX component can't create object: 'xxxx.xxxx'  
> /ron/InvPerfStress.asp, line 14

## Cause

This happens when the identity of the MTS Server Package has been set to `Interactive User`. The interactive user is the user that is currently signed in to the server (that is, the computer that hosts the MTS Package). When this user signs off, the components in the MTS Server Package can't be created and executed, and an error is returned.

## Steps to reproduce behavior

1. Create a new MTS Server Package and accept the default interactive user identity.
2. Add your COM component to this package.
3. Create your ASP page and save it in a virtual directory.
4. While logged on to the server, request the ASP page from a browser on a different computer.
5. Sign out from the server
6. Request the ASP page again from the browser on a different computer (or refresh the page requested in step 4).
7. The following error appears in your browser if component is created using `Server.CreateObject`:

    > Server object error 'ASP 0177 : 80080005'  
    > Server.CreateObject Failed  
    > /xxxx.asp, line xx  
    > Server execution failed

8. Sign in to the server and open the Internet Service Manager to change the identity of the MTS Server Package to a specific user.
9. Sign out from the server again.
10. Request the ASP page again from the browser on a different computer (or refresh the page requested in step 4).
11. The page works as expected.

## Resolution

Set the package identity to a specific user.

## Status

This behavior is by design.
