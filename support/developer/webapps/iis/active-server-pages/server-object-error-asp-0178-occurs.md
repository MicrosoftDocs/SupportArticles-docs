---
title: Error ASP 0178 when you instantiate COM object
description: This article provides resolutions for the ASP 0178 error that occurs when you instantiate COM object.
ms.date: 09/24/2020
ms.custom: sap:Active Server Pages
---
# Server object error 'ASP 0178' when you instantiate COM object

This article helps you resolve the 'ASP 0178' error that occurs when you instantiate COM object.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 198432

## Symptoms

When instantiating a COM component in an Out-Of-Process Server (EXE) from Active Server Pages (ASP), the following error may occur:

> Server object error 'ASP 0178 : 80070005'  
Server.CreateObject Access Error  
testOOP.asp, line 12  
The call to Server.CreateObject failed while checking permissions.  
Access is denied to this object.  

## Cause

Appropriate permissions to access and launch the Out-Of-Process (OOP) COM object has not been set.

## Resolution

You need to give the IUSR_\<machine_name> account permissions to launch and access your OOP COM object using `dcomcnfg` by doing the following:

1. Launch DCOMCNFG by clicking the Start button, selecting **Run**, and typing *Dcomcnfg* in the Run dialog box.

2. In the **Default Security** tab, click the **Edit Default** in the **Default Access Permissions** frame. The Registry Value Permissions dialog box appears.

3. Add the IUSR_\<machine_name> account and the INTERACTIVE account to the Registry Value Permissions dialog box, and click **OK**.
4. In the **Default Security** tab, click the **Edit Default** in the Default Launch Permissions frame. The Registry Value Permissions dialog box appears.

5. Add the IUSR_\<machine_name> account to the Registry Value Permissions dialog box, and click **OK**.
