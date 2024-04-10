---
title: Web Deployment error with non-admin user
description: This article provides a resolution to error message when performing a Web Deploy operation that requires administrative permissions.
ms.date: 03/23/2020
ms.custom: sap:Deployment and migration
ms.subservice: deployment-migration
---
# Error when you use the Web Deployment tool as a non-administrative user

This article helps you resolve the error that occurs when you use the Web Deployment Tool (Web Deploy) as a non-administrative user.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2023852

## Symptoms

When performing a Web Deploy operation that requires administrative permissions, you receive this error message:

> An error occurred when committing changes to the IIS Configuration System  
> The identity performing the operation was  
> <domain\username>  
> Error: Filename:\\\\?  
> C:\Windows\system32\inetsrv\config\applicationHost.config  
> Error: Cannot write configuration file due to insufficient permission

## Cause

Internet Information Services (IIS) requires administrative privileges to make configuration changes to the *ApplicationHost.config file*. The user executing the operation doesn't have sufficient rights to access the *ApplicationHost.config* file and perform changes. This error could occur in a hosted scenario where the person executing the command isn't the administrator of the target hosting machine.  

## Resolution when Web Deploy operation runs by Msdeploy.exe

If Web Deploy operation runs from a command line using Msdeploy.exe, verify if the account performing the operation has the following permissions:

- Read permission to `%windir%\system32\inetsrv\config`
- Modify permission to `%windir%\system32\inetsrv\config\applicationHost.config`.

> [!WARNING]
> Granting these permissions to a non-administrator user will allow the user to access any IIS setting. This may not be secure for some environments. Microsoft recommends using the [Web Deployment handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler) and delegation for non-admin scenarios.

## Resolution when Web Deploy operation performed via WMSVC

If Web Deploy operation performed using delegation via the Web Management Service (WMSVC), verify if the account configured in the delegation rule has the following permissions:

- Read permission to `%windir%\system32\inetsrv\config`.
- Modify permission to `%windir%\system32\inetsrv\config\applicationHost.config`.

> [!NOTE]
> The account's identity depends on how the `Delegation Rule` is configured:
> - `CurrentUser`: The user account used to make the remote connection in IIS. 
> - `ProcessIdentity`: The configured identity of the WMSVC service on the target server.
> - `SpecificUser`: User defined in the **Specify Credentials** dialog of the delegation rule.

## More information

- [Web Deployment Tool](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd568996(v=ws.10))

- [Configure the Web Deployment Handler](/iis/publish/using-web-deploy/configure-the-web-deployment-handler)

- [Taking an Application Offline before Publishing](/iis/publish/deploying-application-packages/taking-an-application-offline-before-publishing)
