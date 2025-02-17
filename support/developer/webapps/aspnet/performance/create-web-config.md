---
title: Create Web.config for ASP.NET applications
description: This article describes how to create the Web.config file for an ASP.NET application.
ms.date: 03/27/2020
ms.custom: sap:Performance
ms.topic: how-to
---
# Create the Web.config file for an ASP.NET application

This article describes how to create the *Web.config* file that's used to control the behavior of individual ASP.NET applications.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 815179

## Summary

The Microsoft .NET Framework, and ASP.NET in particular, uses XML-formatted .config files to configure applications. This practice is a departure from conventional registry and metabase configuration mechanisms. There's currently no Microsoft Management Console (MMC) snap-in or other Microsoft-provided administration tool that you can use to create and to modify .config files.

## Hierarchy of .config files

The .NET Framework relies on .config files to define configuration options. The .config files are text-based XML files. Multiple .config files can, and typically do, exist on a single system.

System-wide configuration settings for the .NET Framework are defined in the *Machine.config* file. The *Machine.config* file is located in the `%SystemRoot%\Microsoft.NET\Framework\%VersionNumber%\CONFIG\` folder. The default settings that are contained in the *Machine.config* file can be modified to affect the behavior of Microsoft .NET applications on the whole system.

You can change the ASP.NET configuration settings for a single application if you create a *Web.config* file in the root folder of the application. When you do this, the settings in the *Web.config* file override the settings in the *Machine.config* file.

## Create a Web.config file

You can create a *Web.config* file by using a text editor such as Notepad. You must create a text file that is named *Web.config* in the root directory of your ASP.NET application. The *Web.config* file must be a well-formed XML document and must have a format similar to the `%SystemRoot%\Microsoft.NET\Framework\%VersionNumber%\CONFIG\Machine.config` file.

The *Web.config* file must contain only entries for configuration items that override the settings in the *Machine.config* file. At a minimum, the *Web.config* file must have the `<configuration>` element and the `<system.web>` element. These elements will contain individual configuration elements.

The following example shows a minimal *Web.config* file:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
    <system.web>
    </system.web>
</configuration>
```

The first line of the *Web.config* file describes the document as XML-formatted and specifies the character encoding type. This first line must be the same for all .config files.

The lines that follow mark the beginning and the end of the `<configuration>` element and the `<system.web>` element of the *Web.config* file. By themselves, these lines do nothing. However, the lines provide a structure that permits you to add future configuration settings. You add the majority of the ASP.NET configuration settings between the `<system.web>` and `</system.web>` lines. These lines mark the beginning and the end of the ASP.NET configuration settings.

## References

- [ASP.NET Configuration](/previous-versions/dotnet/netframework-1.1/aa719558(v=vs.71))

- [Format of ASP.NET Configuration Files](/previous-versions/dotnet/netframework-1.1/ackhksh7(v=vs.71))

- [How To Edit the Configuration of an ASP.NET Application](https://support.microsoft.com/help/815178)
