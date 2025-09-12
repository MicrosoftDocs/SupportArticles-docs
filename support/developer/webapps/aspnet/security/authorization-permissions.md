---
title: Control authorization permissions in ASP.NET
description: This article introduces how to apply the \<location> tag to the Web.config file to configure access to a specific file and folder.
ms.date: 04/03/2020
ms.custom: sap:Security
ms.reviewer: NATHANE
ms.topic: how-to
---
# Control authorization permissions in an ASP.NET application  

This update introduces how to apply the `<location>` tag to the *Web.config* file to configure access to a specific file and folder.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 316871

## Summary

Use this step-by-step guide to apply the `<location>` tag to the *Web.config* file to configure access to a specific file and folder.

When using forms-based authentication in ASP.NET applications, only authenticated users are granted access to pages in the application. Unauthenticated users are automatically redirected to the page specified by the `loginUrl` attribute of the *Web.config* file where they can submit their credentials. In some cases, you may want to permit users to access certain pages in an application without requiring authentication.

## Configure access to a specific file and folder

1. Set up forms-based authentication. For more information, see [How to implement Forms-Based Authentication in Your ASP.NET Application by Using C# .NET](https://support.microsoft.com/help/301240).

2. Request any page in your application to be redirected to *Logon.aspx* automatically.
3. In the *Web.config* file, type or paste the following code.

    This code grants all users access to the *Default1.aspx* page and the *Subdir1* folder.

    ```xml
    <configuration>
        <system.web>
            <authentication mode="Forms" >
                <forms loginUrl="login.aspx" name=".ASPNETAUTH" protection="None" path="/" timeout="20" >
                </forms>
            </authentication>
            <!-- This section denies access to all files in this application except for those that you have not explicitly specified by using another setting. -->
            <authorization>
                <deny users="?" />
            </authorization>
        </system.web>
        <!-- This section gives the unauthenticated user access to the Default1.aspx page only. It is located in the same folder as this configuration file. -->
        <location path="default1.aspx">
            <system.web>
                <authorization>
                    <allow users ="*" />
                </authorization>
            </system.web>
        </location>
        <!-- This section gives the unauthenticated user access to all of the files that are stored in the Subdir1 folder. -->
        <location path="subdir1">
            <system.web>
                <authorization>
                    <allow users ="*" />
                </authorization>
            </system.web>
        </location>
    </configuration>
    ```

    Users can open the *Default1.aspx* file or any other file saved in the `subdir1` folder in your application. They won't be redirected automatically to the *Logon.aspx* file for authentication.
4. Repeat Step 3 to identify any other pages or folders for which you want to permit access by unauthenticated users.

## References

- [INFO: ASP.NET Security Overview](https://support.microsoft.com/help/306590)

- [Configuration \<location> Settings](/previous-versions/dotnet/netframework-1.1/6hbkh9s7(v=vs.71))
