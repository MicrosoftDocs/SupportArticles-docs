---
title: Can't change identity of application pool
description: Fixes a problem where you can't change the identity of an application pool using Internet Information Services Manager from a remote computer.
ms.date: 03/23/2020
ms.custom: sap:WWW authentication and authorization
ms.technology: www-authentication-authorization
---
# Error when you change the identity of an application pool by using IIS Manager from a remote computer: Keyset does not exist

This article resolves the **Keyset does not exist** error. The error occurs when you change the identity of an application pool by using Microsoft Internet Information Services (IIS) Manager from a remote computer.

_Original product version:_ &nbsp; Windows Server 2008, Windows Server 2008 R2  
_Original KB number:_ &nbsp; 977754

## Symptoms

Consider the following scenario:

- On a server that is running Windows Server 2008 or Windows Server 2008 R2, you enable remote management for IIS.
- The server has more than one application pool configured in IIS.
- One of the application pools is configured to use custom user identity.
- You use IIS Manager to connect to the server as an administrator from a remote computer.

In this scenario, when you to try to change the identity of any application pool, you receive the following error message:

> There was an error while performing this operation.  
> Details:  
> Keyset does not exist (Exception from HRESULT: 0x80090016)

## Cause

The *LOCAL SERVICE* account is the service account of the IIS Web Management Service (also known as WMSvc). This problem occurs because the *LOCAL SERVICE* account doesn't have Read access on the `iisWasKey` key that is located in the `%ALLUSERSPROFILE%\Microsoft\Crypto\RSA\MachineKeys` folder.

Here's the file name of the `iisWasKey` key:  
*76944fb33636aeddb9590521c2e8815a_GUID*

## Resolution

To resolve this problem, follow these steps:

1. Locate the `%ALLUSERSPROFILE%\Microsoft\Crypto\RSA\MachineKeys` folder.
2. Right-click the *76944fb33636aeddb9590521c2e8815a_GUID* file, and then select **Properties**.
3. Select the **Security** tab, and then select **Edit**. If you're asked whether you want to continue the operation, select **Continue**. Then, the list of group names and user names that have access to this key file appears in the **Permissions** dialog box.
4. Select **Add**. Then, the **Select Users, Computers, Service Accounts, or Groups** dialog box appears.
5. Type *LOCAL SERVICE*, and then select **Check Names**.
6. Select **OK**.
7. In the **Group or user names** list, select *LOCAL SERVICE*. Make sure that the **Read** check box is checked in the **Permissions for LOCAL SERVICE** list.
8. Select **OK**.

## More information

This problem is fixed in Windows Server 2008 Service Pack 2.
