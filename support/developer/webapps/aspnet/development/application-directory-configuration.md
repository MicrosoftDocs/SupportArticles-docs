---
title: Application configuration in ASP.NET
description: This article describes how to use ASP.NET to make application-specific and directory-specific configuration settings.
ms.date: 04/03/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Make application and directory-specific configuration settings in an ASP.NET application

This article describes how to make application-specific and directory-specific configuration settings in ASP.NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 815174

## Summary

The *Web.config* file is in the root directory of an ASP.NET application. The *Web.config* file specifies configuration information that is specific to the application. You can also set configuration settings on a per-directory basis. There are two ways to do so:

- Distribute multiple *Web.config* files to directories in the application. Add a *Web.config* file in the ASP.NET application directory with settings that override settings in a higher-level *Web.config* file or in the system machine configuration (*Machine.config*) file.

- Add per-directory or per-file settings directly to the application *Web.config* file. This method uses a single *Web.config* file to turn on per-directory configuration settings. You can also use this method in the *Machine.config* file to force configuration settings on ASP.NET web applications and then to stop *Web.config* files from overriding *Machine.config* settings.

## Use the location element in the Machine.config file

To specify settings that apply to a web application or directory, you can add the `<location>` element to the `<configuration>` element of a system *Machine.config* file. It's useful when you centralize configuration settings in a single file. It's also useful in Web-hosting environments to mandate specific configuration settings on individual web applications.

The `<location>` element contains two attributes, `path` and `allowOverride`. The `path` attribute defines the site or virtual directory that the configuration settings cover. To specify that the settings in the `<location>` element apply to the default Web site, set the `path` attribute to `Default Web Site`. To specify that the settings apply to the application that is named *MyApp* in the default web site, set the `path` attribute to `Default Web Site/MyApp`.

When the `allowOverride` attribute is false, the *Web.config* files in the web application directories can't override the settings that you specified in the `<location>` element. It's a useful setting in environments where you must restrict application developers in how they configure a web application. The following example shows a part of a *Machine.config* file. The file requires authentication to access the *MyApp* application on the default Web site and can't be overridden by settings in a *Web.config* file.

```xml
<configuration>
    <location path="Default Web Site/MyApp" allowOverride="false">
        <system.web>
            <authorization>
                <allow users="?" />
            </authorization>
        </system.web>
    </location>
</configuration>
```

## Use the location element in the Web.config file

To specify settings that apply to a specific application or directory, add the `<location>` element to the `<configuration>` element of an application *Web.config* file. The `<location>` element typically contains a `<system.web>` element and other configuration elements exactly as you use them in the *Web.config* file. The `path` attribute of the `<location>` element specifies the virtual directory or the file name where the location configuration items apply. The following example shows part of an application *Web.config* file that specifies custom error messages for the forum virtual directory.

```xml
<configuration>
    <location path="forum" >
        <system.web>
            <customErrors mode="RemoteOnly" defaultRedirect="forum-error.aspx">
                <error statusCode="404" redirect="forum-file-not-found.aspx" />
            </customErrors>
        </system.web>
    </location>
</configuration>
```

## References

- [How To Deploy Applications That Are Built on the .NET Framework](https://support.microsoft.com/help/818016)  

- [ASP.NET Configuration](/previous-versions/dotnet/netframework-1.1/aa719558(v=vs.71))

- [Format of ASP.NET Configuration Files](/previous-versions/dotnet/netframework-1.1/ackhksh7(v=vs.71))
