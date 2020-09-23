---
title: Error 403 when you use ASP to upload large file 
description: This article provides resolutions for the error 403 that occurs when you use an Active Server Pages request to upload a large file to a computer where Internet Information Services (IIS) 8.0 or later version is installed.
ms.date: 08/06/2020
ms.prod-support-area-path: Health, Diagnostic, and Performance Features
---
# Error 403 when you upload a large file by using ASP request in Internet Information Services  

This article helps you resolve the problem that occurs when you use an Active Server Pages request to upload a large file to a computer where Internet Information Services (IIS) 8.0 or later version is installed.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 327659

## Symptoms

> [!IMPORTANT]
> This article contains information about editing the metabase. Before you edit the metabase, verify that you have a backup copy that you can restore if a problem occurs. For information about how to do this, see the **Configuration Backup/Restore Help** topic in Microsoft Management Console (MMC).

When you use an Active Server Pages (ASP) request to upload a large file to a computer where Internet Information Services (IIS) 8.0 or later version is installed, the upload may fail. You may also receive an error 403 response or an error message that is similar to one of the following:

Error message 1

> Request object error 'ASP 0104 : 80004005' Operation not Allowed

Error message 2

> 007~ASP 0104~Operation not Allowed

When you post lots of form data to an ASP page, you may receive an error message that is similar to the following:

> Error '80020009' Exception occurred

Additionally, the file upload may fail when you use the `Response.binaryWrite` method.

You experience one or more of these symptoms even though the same file upload worked in earlier versions of IIS.

## Cause

This issue occurs if a `Content-Length` header is present and if the `Content-Length` header specifies an amount of data that is larger than the value of the `AspMaxRequestEntityAllowed` property in the IIS metabase. The default value for the `AspMaxRequestEntityAllowed` property is **204,800** bytes.

> [!NOTE]
> This metabase property was first included in the October 2002 cumulative update for IIS. This metabase property is included in a default installation of IIS 8.0 or later versions.

## Resolution

> [!WARNING]
> If you edit the metabase incorrectly, you can cause serious problems that may require you to reinstall any product that uses the metabase. Microsoft cannot guarantee that problems that result if you incorrectly edit the metabase can be solved. Edit the metabase at your own risk.

> [!NOTE]
> Always back up the metabase before you edit it.  

To resolve this issue, modify the value in the `AspMaxRequestEntityAllowed` property to set the maximum number of bytes that are permitted in the entity body of an ASP request. To do this, follow these steps:

1. At a command prompt, type `cd drive :\inetpub\adminscripts`, and then press **ENTER**.

    > [!NOTE]
    > In this command to change folders, **drive** is a placeholder for the hard disk where IIS is installed.

2. At a command prompt, type the command `cscript adsutil.vbs set w3svc/ASPMaxRequestEntityAllowed size`, and then press **ENTER**.

    > [!NOTE]
    > In this command, **size** is a placeholder for the largest file size upload that you want to allow. The maximum value is **1,073,741,824** bytes. Set this value to the lowest possible value that allows for the functionality that you want.

3. At a command prompt, type the command `iisreset`, and then press **ENTER**.

## More information

The `AspMaxRequestEntityAllowed` property specifies the maximum number of bytes that are permitted in the entity body of an ASP request. If a `Content-Length` header is present and if the `Content-Length` header specifies an amount of data that is larger than the value of the `AspMaxRequestEntityAllowed` property, IIS returns a 403 error response. The `AspMaxRequestEntityAllowed` property applies only to `PUT` requests and to `POST` requests. The `AspMaxRequestEntityAllowed` property does not apply to `GET` requests. Because this metabase property applies only to ASP, other Internet Server API (ISAPI) extensions are not affected.

The `AspMaxRequestEntityAllowed` property is related in function to the `MaxRequestEntityAllowed` property. However, the `AspMaxRequestEntityAllowed` property is specific to ASP requests. You can set the `MaxRequestEntityAllowed` property to **1** megabyte (MB) at the World Wide Web Publishing Service (WWW Service) level. Then, you can set the `AspMaxRequestEntityAllowed` property to a smaller value if you know that your specific ASP applications handle a smaller amount of data.
