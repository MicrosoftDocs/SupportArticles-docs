---
title: FTP authorization rules aren't inherited
description: This article provides resolutions for the problem that with User name physical directory (enable global virtual directories), FTP authorization rules aren't inherited in IIS.
ms.date: 04/15/2020
ms.custom: sap:FTP authentication and authorization
ms.technology: ftp-authentication-authorization
ms.reviewer: nanram
---
# FTP authorization rules aren't inherited with user isolation setting in FTP sites in IIS

This article helps you resolve the problem where FTP authorization rules aren't inherited with user isolation setting if FTP user isolation is configured at the site-level.

_Original product version:_ &nbsp; Internet Information Services 7.5  
_Original KB number:_ &nbsp; 4294477

## Symptoms

In Microsoft Internet Information Services (IIS), if FTP user isolation is configured at the site-level to **User name physical directory (enable global virtual directories)**, FTP authorization rules do not adhere to the physical path of the application and will not be inherited as per the folder structure.

Assume that an IIS FTP site has user isolation set to **User name physical directory (enable global virtual directories)**, and in the FTP authorization feature, read permissions are granted to all users. A folder named *Upload* is created under `\FTP\Localuser\<user_name>\`, and read and write access is granted to all users through the FTP authorization feature in IIS for this *Upload* folder. Despite having write permissions to the *Upload* folder, when a user whose user name matches the *<user_name>* folder in the path tries to upload a file in the *Upload* folder, the user receives an **Access denied** error message.

The output from trying to upload an FTP file through the command-line FTP utility that is included in Windows resembles the following:

```console
ftp> cd upload  
250 CWD command successful.  
ftp> put c:\file_name.txt  
200 EPRT command successful.  
550-Access is denied.  
Win32 error: Access is denied.  
Error details: Authorization rules denied the access.  
550 End
```

## Cause

This behavior is by design. The FTP user isolation **User name physical directory (enable global virtual directories)** setting ensures backward-compatibility with legacy IIS 6 functionality.

## Resolution

To get the desired behavior, use another folder outside the user isolated folders, and then set the required FTP authorization rules on that folder. For FTP sites that use **User name physical directory (enable global virtual directories)** isolation, use the `FTP/Upload` path instead of `FTP/LocalUser/<user_name>/Upload` for setting the FTP authorization rules. The directory parser will ignore the part of the path for `FTP/LocalUser/<user_name>/Upload` because this is used for the isolation lookup. Therefore, the behavior will only work as expected when authorization rules are defined on paths outside the user isolated folders, such as the `FTP/Upload` example path. In this manner, authorization applies to the *Upload* folder for all users.

The following is a sample authorization rule in the *ApplicationHost.config* file:

```xml
<location path="FTP/Upload">
    <system.ftpServer>
        <security>
            <authorization>
                <remove users="*" roles="" permissions="Read" />
                <add accessType="Allow" users="*" permissions="Read, Write" />
            </authorization>
        </security>
    </system.ftpServer>
</location>
```

When you try to upload a document to the FTP site that has this configuration, the output from the FTP command prompt utility in Windows resembles the following:

```console
ftp> cd upload  
250 CWD command successful.  
ftp> put c:\file_name.txt  
200 EPRT command successful.  
125 Data connection already open; Transfer starting.  
226 Transfer complete.  
ftp: 14 bytes sent in 0.00Seconds 14000.00Kbytes/sec.
```

The User Isolation **User name physical directory (enable global virtual directories)** setting is inherited from IIS 6 and does not follow the correct folder structure. Another isolation mode, **User name directory (disable global virtual directories)**, is present in IIS 7 and later versions, and this configuration does follow authorization rules.
