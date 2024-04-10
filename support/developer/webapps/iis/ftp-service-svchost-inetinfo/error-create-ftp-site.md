---
title: Error when you create FTP site
description: This article provides help to solve an issue where an error occurs when you create an FTP site in Internet Information Services.
ms.date: 07/17/2020
ms.custom: sap:FTP Service and Svchost or Inetinfo Process Operation
ms.reviewer: kaorif, mlaing
ms.subservice: ftp-service-svchost-inetinfo
---
# Error occurs when you create an FTP site in Internet Information Services

This article provides help to solve an issue where an error occurs when you create an FTP site in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2505017

## Symptoms

In IIS, you use the Internet Services Manager to create a new FTP site. In the site creation wizard, you enter one of the following characters as part of the FTP site name:

`\ / ? ; : @ & = + $, | " < >`

When you click **Finish** to end the FTP site creation wizard, you may receive the following error message:

> There was an error while performing this operation.  
> Details:  
> The site name cannot contain the following characters: \, /, ?, ;, :,  
> @, &, =, +, $, ,, |, ", <, >.

Also, when you use the Internet Services Manager to create a new virtual directory whose name contains a restricted character, you may receive the following error message:

> The virtual directory path cannot contain the following character:  
> \, ?, ;, :, @, &, =, +, $, ,, |, ", <, >, *.

## Cause

This behavior is by design. In IIS, the Internet Services Manager doesn't allow the creation of FTP or Web sites or virtual directories whose name contains one of the restricted characters that are listed above.

## Resolution

Don't include any of the restricted characters listed above when specifying the name of a new FTP or Web site or virtual directory in the Internet Services Manager.

## More information

It is still possible to create a new FTP site or virtual directory whose name contains one of the restricted characters by using appcmd.exe or editing the *applicationHost.config* file directly. However, if an FTP container is created in this manner and the name contains the colon restricted character (:) in the virtual directory, the following error status will be sent to an FTP client that tries to access that directory:

> 550 The parameter is incorrect.

For security reasons, colons are explicitly rejected from FTP commands by the FTP service, even though the appcmd.exe tool does not block them from being included in a container name.
