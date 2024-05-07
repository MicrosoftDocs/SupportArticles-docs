---
title: Restrict users from accessing to web resources
description: This article describes some methods about restricting specific users from gaining access to specified web resources.
ms.date: 03/26/2020
ms.custom: sap:Configuration
ms.topic: how-to
---
# Restrict specific users from gaining access to specified web resources

This article describes methods about how to restrict specific users from gaining access to specified web resources.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 815151

## Summary

Web applications that are based on ASP.NET provide many ways for users to be authenticated and authorized to gain access to resources. The way that you restrict access to resources varies, depending on the authentication method that you use. For example, for an application where you use Microsoft Windows authentication and you enable impersonation, you can use New Technology File System (NTFS) file permissions for access control. However, for an application where you use forms authentication, you must modify the Web.config file to restrict access. This article describes how to control authorization for both of these ASP.NET authentication methods.

## Control authorization by using file permissions

For ASP.NET web applications where you use Windows authentication and you enable impersonation, you can use standard NTFS file permissions to require authentication and to restrict access to the files and folders:

- To require authentication, remove the ASPNET user account's access permissions for the file or folder.
- To restrict access to specific Windows user accounts or group accounts, grant or deny Read NTFS file permissions to files or folders.

## Control authorization by modifying the Web.config file

To restrict access to ASP.NET applications that use forms authentication, edit the `<authorization>` element in the application's *Web.config* file. To do this, follow these steps:

1. Start a text editor, such as Notepad, and then open the *Web.config* file that is located in the application's root folder.

    > [!NOTE]
    > If the *Web.config* file doesn't exist, create a *Web.config* file for the ASP.NET application.

2. If you want to control authorization for the whole application, add the `<authorization>` configuration element to the `<system.web>` element in the *Web.config* file.
3. In the `<authorization>` element, add the `<allow>` configuration element and the `<deny>` configuration element. Use the `users` attribute to specify a comma-delimited list of user names. You can use a question mark (?) as a wildcard character that matches any user name. For example, the following code denies access to all users except `user1` and `user2`:

    ```xml
    <authorization>
        <allow users="user1, user2"/>
        <deny users="?"/>
    </authorization>
    ```

4. Save the *Web.config* file.

## References

- [How To Edit the Configuration of an ASP.NET Application](https://support.microsoft.com/help/815178)

- [How To Create the Web.config File for an ASP.NET Application](https://support.microsoft.com/help/815179)

- [How To Make Application and Directory-Specific Configuration Settings in an ASP.NET Application](https://support.microsoft.com/help/815174)  

- [How To Secure Applications That Are Built on the .NET Framework](https://support.microsoft.com/help/818014)
