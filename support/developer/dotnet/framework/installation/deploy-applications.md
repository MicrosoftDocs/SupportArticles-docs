---
title: Deploy Applications Built on .NET Framework
description: This article discusses important considerations for deploying applications that are built on .NET Framework.
ms.date: 07/07/2025
ms.custom: sap:Installation and Deployment
ms.topic: how-to

#customer intent: As a developer, I want to deploy my .NET Framework application so that it's accessible to my users.
---
# Deploy applications that are built on .NET Framework

This article discusses important considerations for deploying applications that are built on .NET Framework. For information about how to secure applications that are built on .NET Framework, see [Secure applications that are built on the .NET Framework](/troubleshoot/developer/dotnet/framework/general/secure-applications).

_Applies to:_ .NET Framework

_Original KB number:_ 818016

## Web.Config file for an ASP.NET application

The `Web.config` file is an XML file that contains application-specific settings that override system defaults. Although most ASP applications that are built on .NET Framework are deployed by having a `Web.config` file, the `Web.config` file is optional. You may have to create a `Web.config` file to override default settings on an application-by-application basis.

For more information about how to create a `Web.config` file for an application that doesn't already have one, see [Edit the configuration of an ASP.NET application](/troubleshoot/developer/webapps/aspnet/development/edit-web-config).

## Configure an ASP.NET application

All systems on which .NET Framework is deployed have system-wide ASP.NET configuration settings that are defined in the `<system.web>` element of the `Machine.config` file. You can modify these settings on an application-by-application basis. In fact, such a modification is frequently necessary.

For more information about how to override .NET framework default configuration settings for a specific application, see [Edit the configuration of an ASP.NET application](/troubleshoot/developer/webapps/aspnet/development/edit-web-config).

## Minimum client installation requirements

Before you can deploy applications that are built on .NET Framework to a client system, that system must have specific software components and updates installed. Most client systems meet the requirements. However, you might have to manually verify that a specific system is ready to receive the .NET Framework redistributable.

## Minimum server installation requirements

Before you can deploy applications that are built on .NET Framework to a server, the server must have specific software components and updates installed. Most server systems meet the requirements. However, you might have to manually verify that a specific system is ready to receive the .NET Framework redistributable.

## Enable and disable ASP.NET functionality in IIS

When .NET Framework is installed on a server that's running Internet Information Services (IIS), ASP.NET is automatically enabled for virtual servers. However, you might not want this configuration. As new ASP Web applications that are built on .NET Framework are deployed to a server that's running IIS 5.0, you can control which virtual servers and directories support ASP.NET and which virtual servers don't.

For more information about how to enable and disable ASP.NET functionality for virtual servers and directories in IIS 5.0, see [Plan an ASP.NET Website on IIS](/iis/application-frameworks/scenario-build-an-aspnet-website-on-iis/plan-an-asp-net-website-on-iis).

## Custom error messages

Many sites change IIS default error message to display a user-friendly page or to notify an administrator. By default, if errors occur in an ASP.NET application that's built on .NET Framework and deployed to a server that has IIS 5.0 custom error messages, the errors don't trigger the custom messages. However, you can configure the application to return the custom messages.

For more information about how to configure custom error messages for ASP applications that are built on .NET Framework, see [Create custom error reporting pages in ASP.NET by using Visual Basic .NET](/troubleshoot/developer/webapps/aspnet/development/custom-error-reporting-page).

## Application-specific and directory-specific configuration settings

The most common way to override system defaults for a whole ASP.NET application is to create or edit a `Web.config` file for that application. However, configuration changes often must apply only to specific files or folders in an application. You have two methods to limit the scope of configuration changes:

- Add the `<location>` configuration element to the `Machine.config` file or the `Web.config` file

- Add more `Web.config` files to subfolders

For more information about how to apply changes that affect specific applications and directories, see [Make application and directory-specific configuration settings in an ASP.NET application](/troubleshoot/developer/webapps/aspnet/development/application-directory-configuration).

## Configure session state management

ASP.NET has new features for session state management. Session state settings in ASP.NET are configured through the `Web.config` file of an ASP.NET application. Several sessions state management options are available in ASP.NET. These options include mode (inproc, State Server, SQL Server), cookieless state management, out-of-process mode state server, and port settings.

For more information about ASP.NET session state management, see [ASP.NET Session State](/previous-versions/dotnet/articles/ms972429(v=msdn.10)).

## Build and deploy a .NET security policy deployment package

.NET Framework introduces *security policy* to control the resources that an application can use to gain access to a system. Security policy defines an application's authorization based on the application's location or source. As an administrator, you can control security policy on a computer-by-computer basis. However, you can use deployment packages as a more scalable method for deploying and managing security policies in Active Directory environments.

## Migrate an ASP web application to ASP.NET while retaining existing file names

ASP.NET offers many benefits over the earlier ASP 3.0 scripting environment. Specifically, ASP applications that are built on .NET Framework offer improved performance, scalability, and reliability. Therefore, many new ASP applications that are built on .NET Framework are actually upgrades to existing ASP 3.0 applications.

One of the challenges to upgrade an application from ASP 3.0 to ASP.NET is that the two environments use different file name extensions. By default, ASP 3.0 uses ".asp" and ASP.NET uses ".aspx." Although the different file name extensions permit the two applications to be located in a single folder, they require that you change bookmarks and hyperlinks before the ASP 3.0 application can be taken offline.

## Configure an ASP.NET application to use existing authentication and authorization

ASP.NET includes more flexible and sophisticated authentication and authorization systems than ASP 3.0. By default, you can use only Windows authentication to authenticate ASP 3.0 applications. Also, you can control authorization only by using NTFS file permissions.

ASP.NET supports Windows authentication and can impersonate the user in much the same manner as ASP 3.0 does. By default, however, this setting isn't enabled.

## Deploy an ASP.NET web application by using XCopy deployment

You can deploy your ASP.NET web application by using the MS-DOS `xcopy` command-line tool. However, it's a good idea to deploy your project instead of using `xcopy`. Similar to the Copy Project command, `xcopy` doesn't register or verify the location of assemblies. Also, for web projects, `xcopy` doesn't automatically configure IIS directory settings.

For more information, see [Deploy an ASP.NET web application by using Xcopy deployment](/troubleshoot/developer/visualstudio/language-compilers/deploy-aspnet-app-xcopy-command).

## Set up multiple server ASP.NET web applications and web services

For most uses of ASP.NET, a single server can handle all requests quickly. However, many environments require that you deploy multiple servers for the following uses:

- Handle consistently high traffic volumes
- Support processor-intensive applications
- Respond to sudden bursts in traffic
- Meet redundancy requirements

## Related content

- [Deploy .NET Framework and applications](/dotnet/framework/deployment/)
- [Deploying the .NET Framework](/dotnet/framework/deployment/deploying-the-net-framework)
