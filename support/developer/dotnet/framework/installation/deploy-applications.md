---
title: Deploy applications built on .NET Framework
description: This article describes important considerations for deploying applications that are built on the .NET Framework.
ms.date: 07/07/2025
ms.custom: sap:Installation and Deployment
ms.topic: how-to

#customer intent: As a developer, I want to deploy my .NET Framework application so that it's accessible to my users.
---
# Deploy applications that are built on the .NET Framework

This article describes important considerations for deploying applications that are built on the .NET Framework.

This article is one of a series of articles that provide detailed information for applications that are built on the .NET Framework.

The articles in this series include the following:

- [Deploy applications that are built on the .NET Framework](/troubleshoot/developer/dotnet/framework/installation/deploy-applications)
- [Secure applications that are built on the .NET Framework](/troubleshoot/developer/dotnet/framework/general/secure-applications)

_Original product version:_ .NET Framework

_Original KB number:_ 818016

## Create the Web.Config file for an ASP.NET application

The `Web.config` file is an XML file that contains application-specific settings that override system defaults. While most ASP applications that are built on the .NET Framework are deployed with a `Web.config` file, the `Web.config` file is optional. You may have to create a `Web.config` file to override default settings on an application-by-application basis.

For more information about how to create a `Web.config` file for an application that doesn't already have one, visit [Edit the configuration of an ASP.NET application](/troubleshoot/developer/webapps/aspnet/development/edit-web-config).

## Edit the configuration of an ASP.NET application

All systems where the .NET Framework has been deployed have system-wide ASP.NET configuration settings that are defined in the `<system.web>` element of the `Machine.config` file. You can modify these settings (frequently, you must modify these settings) on an application-by-application basis.

For more information about how to override .NET framework default configuration settings for a specific application, see [Edit the configuration of an ASP.NET application](/troubleshoot/developer/webapps/aspnet/development/edit-web-config).

## Determine if a client system meets the minimum requirements for installing the .NET Framework

Before you can deploy applications that are built on the .NET Framework to a client system, that system must have specific software components and patches installed. Most client systems meet the requirements. However, you may have to manually verify that a specific system is ready to receive the .NET Framework redistributable.

## Determine if a server system meets the minimum requirements for installing the .NET Framework

Before you can deploy applications that are built on the .NET Framework to a server, the server must have specific software components and patches installed. Most server systems meet the requirements. However, you may have to manually verify that a specific system is ready to receive the .NET Framework redistributable.

## Selectively enable and disable ASP.NET functionality in IIS

When the .NET Framework is installed on a server computer running Internet Information Services (IIS), ASP.NET is automatically enabled for virtual servers. However, you might not want this configuration. As new ASP Web applications that are built on the .NET Framework are deployed to a server computer running IIS 5.0, you can control which virtual servers and directories support ASP.NET and which virtual servers don't.

For additional information about how to enable and disable ASP.NET functionality for virtual servers and directories in IIS 5.0, visit [Plan an ASP.NET Website on IIS](/iis/application-frameworks/scenario-build-an-aspnet-website-on-iis/plan-an-asp-net-website-on-iis).

## Configure custom error messages for an ASP.NET application

Many sites change IIS default error message to display a user-friendly page or to notify an administrator. When a server computer running IIS 5.0 has custom error messages, and an ASP Web application that is built on the .NET Framework is deployed to that server computer, errors in the ASP.NET application don't use IIS 5.0 custom error messages unless the application is configured to do so.

For additional information about how to configure custom error messages for ASP applications built on the .NET Framework, visit [Create custom error reporting pages in ASP.NET by using Visual Basic .NET](/troubleshoot/developer/webapps/aspnet/development/custom-error-reporting-page).

## Make application-specific and directory-specific configuration settings in an ASP.NET application

The most common way to override system defaults for a whole ASP.NET application is to create or edit a `Web.config` file for that application. However, configuration changes frequently must apply only to specific files or folders in an application. There are two ways to limit the scope of configuration changes:

- Add the `<location>` configuration element to the `Machine.config` file or the `Web.config` file.

- Add additional `Web.config` files to subfolders. For additional information about how to apply changes that affect specific applications and directories, visit [Make application and directory-specific configuration settings in an ASP.NET application](/troubleshoot/developer/webapps/aspnet/development/application-directory-configuration).

## Configure session state management for ASP.NET applications

ASP.NET has new features for session state management. Session state settings in ASP.NET are configured through the `Web.config` file of an ASP.NET application. Several sessions state management options are available in ASP.NET. These options include mode (inproc, State Server, SQL Server), cookieless state management, out-of process mode state server, and the port settings.

For more information about ASP.NET Session State Management, visit [ASP.NET Session State](/previous-versions/dotnet/articles/ms972429(v=msdn.10)).

## Build and deploy a .NET security policy deployment package

The .NET Framework introduces *security policy*. The security policy is a new way to control the resources that an application can gain access to on a system. It defines an application's authorization based on the application's location or source. As an administrator, you can control security policy on a computer-by-computer basis. However, you can use deployment packages as a more scalable method for deploying and managing security policies in Active Directory environments.

## Migrate an ASP web application to ASP.NET while retaining existing file names

ASP.NET offers many benefits over the earlier ASP 3.0 scripting environment. Specifically, ASP applications that are built on the .NET Framework offer improved performance, scalability, and reliability. As a result, many new ASP applications that are built on the .NET Framework are actually upgrades to existing ASP 3.0 applications.

One of the challenges of upgrading an application from ASP 3.0 to ASP.NET is that the two environments use different file name extensions. By default, ASP 3.0 uses .asp file name extensions. However, ASP.NET uses .aspx file name extensions. Although the different file name extensions permit the two applications to be located in a single folder, they require bookmarks and hyperlinks to be changed before the ASP 3.0 application is taken offline.

## Configure an ASP.NET application to use the same authentication and authorization as an existing ASP web application

ASP.NET includes more flexible and sophisticated authentication and authorization systems than ASP 3.0. By default, you can use only Windows authentication to authenticate ASP 3.0 applications. Also, you can control authorization only by using NTFS file permissions.

ASP.NET supports Windows authentication, and can impersonate the end user in much the same way that ASP 3.0 does. However, by default, this setting isn't enabled.

## Deploy an ASP.NET web application by using XCopy deployment

You can deploy your ASP.NET web application by using the MS-DOS `xcopy` command-line utility. However, it's a good idea to deploy your project instead of using `xcopy`. As with the Copy Project command, `xcopy` doesn't register or verify the location of assemblies. Also, for web projects, `xcopy` doesn't automatically configure IIS directory settings.

For additional information, visit [Deploy an ASP.NET web application by using Xcopy deployment](/troubleshoot/developer/visualstudio/language-compilers/deploy-aspnet-app-xcopy-command).

## Set up multiple server ASP.NET web applications and web services

For most uses of ASP.NET, a single server can handle all requests quickly. However, many environments must deploy multiple servers to handle consistently high volumes of traffic, to support processor-intensive applications, to respond to sudden bursts in traffic, or to meet redundancy requirements.

## Related content

- [Deploy .NET Framework and applications](/dotnet/framework/deployment/)
- [Deploying the .NET Framework](/dotnet/framework/deployment/deploying-the-net-framework)
