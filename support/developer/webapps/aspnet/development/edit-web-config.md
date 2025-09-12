---
title: Edit configuration of an ASP.NET application
description: This article describes how to edit the Web.config file of an ASP.NET application.
ms.date: 03/27/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Edit the configuration of an ASP.NET application

This article describes how to edit the *Web.config* file of an ASP.NET application.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 815178

## Summary

The *Web.config* file defines the behavior of ASP.NET applications. The Microsoft .NET Framework, including ASP.NET, uses XML-formatted .config text files to configure applications. This is a departure from conventional registry and metabase configuration mechanisms. Currently there's no Microsoft Management Console (MMC) snap-in or other Microsoft-provided administration tool for creating and for modifying .config files.

## Add configuration settings to Web.config

Most ASP.NET applications come with a prebuilt *Web.config* file that can be edited with any text editor such as Notepad. Generally, *Web.config* files contain comments that make editing the file self-explanatory. However, you may have to add configuration items to a *Web.config* file that doesn't already have the configuration item defined. To add a standard configuration item to a *Web.config* file, follow these steps:

1. Open the *Machine.config* file in a text editor such as Notepad.

    The *Machine.config* file is located in the `%SystemRoot%\Microsoft.NET\Framework\%VersionNumber%\CONFIG\` directory.

2. In the *Machine.config* file, locate the configuration setting you want to override in your *Web.config* file. When the element is more than one line, the element starts with an `<element_name>` line, and ends with `</element_name>`. The element may also be self-closing and may look similar to `<element_name attribute1='option' attribute2='option' />`. White space is ignored. Therefore, the element may span multiple lines. The element may be preceded by a comment. The comment is contained inside
`<!-- and -->` markings. The `<trace>` configuration element example that follows is an example of a self-closing element. The `<trace>` configuration element example has multiple attributes, spans multiple lines, and has a comment at the beginning.

    ```xml
    <!--
    trace Attributes:
        enabled="[true|false]" - Enable application tracing
        localOnly="[true|false]" - View trace results from localhost only
        pageOutput="[true|false]" - Display trace output on individual pages
        requestLimit="[number]" - Number of trace results available in trace.axd
        traceMode="[SortByTime|SortByCategory]" - Sorts trace result displays based on Time or Category
     -->
    <trace
        enabled="false"
        localOnly="true"
        pageOutput="false"
        requestLimit="10"
        traceMode="SortByTime"
    />
    ```

3. Copy the whole configuration element and any beginning comment to the clipboard.
4. Determine how the element is nested in the *Machine.config* file.

    The *Machine.config* file is hierarchical, and configuration elements are nested in other elements. When you copy a configuration element from the *Machine.config* file to the *Web.config* file, you must nest that configuration element in the same element that it was copied from. To determine the element of the *Machine.config* file that the configuration element is contained in, scroll up in the *Machine.config* file until you find an element that is opened, not closed. The containing element is simple to identify because higher-level elements have less indentation.

    Most ASP.NET configuration items are contained in the `<system.web>` element. The end of the element ( `</system.web>` ) must be placed after your configuration element.

    > [!NOTE]
    > The element that your configuration element is contained in. You must paste that element in the same element in the *Web.config* file. A configuration element may be nested in multiple elements. You must create all higher-level elements in the *Web.config* file.
5. Close the *Machine.config* file and then use your text editor to open the *Web.config* file in the root directory of your ASP.NET application.
6. Paste the configuration element between the beginning and the end of the element that you identified in step 4.

    For example, if the configuration item is contained in the `<system.web>` element, the configuration item must be pasted immediately after the opening line of the `<system.web>` element and before the `</system.web>` closing line.
7. Modify the configuration element in the *Web.config* file to override the *Machine.config* setting for that application.

    This setting applies to the folder that contains the *Web.config* file and all sub folders.

## References

- [How To Create the Web.config File for an ASP.NET Application](https://support.microsoft.com/help/815179)

- [How To Deploy Applications That Are Built on the .NET Framework](https://support.microsoft.com/help/818016)

- [ASP.NET Configuration](/previous-versions/dotnet/netframework-1.1/aa719558(v=vs.71))

- [Format of ASP.NET Configuration Files](/previous-versions/dotnet/netframework-1.1/ackhksh7(v=vs.71))
