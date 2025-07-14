---
title: Secure Applications Built on .NET Framework
description: Discusses important considerations for securing applications that are built on .NET Framework.
ms.date: 07/07/2025
ms.topic: how-to
ms.custom: sap:Common Language Runtime (CLR)

#customer intent: As a developer, I want to secure my .NET Framework application so that it's protected against security vulnerabilities.
---
# Secure applications that are built on .NET Framework

This article discusses important considerations for securing applications that are built on Microsoft .NET Framework.

This article is one of a series of articles that provide detailed information for applications that are built on .NET Framework.

For important consideration when deploying applications that are built on the .NET Framework, see the related [Deploy applications that are built on the .NET Framework](/troubleshoot/developer/dotnet/framework/installation/deploy-applications).

_Applies to:_ .NET Framework

_Original KB number:_ 818014

## Adjust .NET Framework security on a zone-by-zone basis

.NET Framework assigns trust levels to managed assemblies. These assignments are based, in part, on the zone where the assembly runs. The standard zones are My Computer, Local Intranet, Internet, Trusted Sites, and Untrusted Sites. You might have to increase or reduce the trust level that is associated with any of these zones. .NET Framework includes tools for adjusting these settings.

## Adjust the level of trust in a .NET Framework assembly

.NET Framework includes many ways to determine the level of trust that you should grant to an assembly. However, you can make exceptions to the rules to enable a specific assembly to receive a higher level of trust than it would typically receive based on the evidence that's provided to the common language runtime. .NET Framework provides a wizard tool specifically for this purpose.

## Restore policy levels that were customized

As an administrator, you have complete control over the access that you grant to assemblies that run at the various trust levels. If you customize trust levels, you might experience problems when you run an application that typically runs under a standard trust level. However, you can quickly restore policy levels to their default settings.

## Evaluate the permissions that are granted to an assembly

If you have security configuration policies at the enterprise, machine, and user levels, and customizable trust levels, you might find it difficult to assess the permissions that were granted to a managed assembly. The .NET Framework Configuration tool includes a simple method to evaluate these permissions.

## Audit the security of .NET-connected applications

During upgrades, testing, and troubleshooting, the configuration of production systems might change in unintentional ways. For example, an administrator might grant administrative credentials to a user while determining whether an error is related to access rights. If that administrator forgets to revoke those elevated credentials after completing the troubleshooting process, the integrity of the system is compromised.

Because this kind of action can degrade system security over time, we recommend that you do regular audits. To run the audits, create a baseline measure by documenting the key aspects of a pristine system. Compare these settings against the baseline over time to determine whether any problems developed that might significantly reduce the level of security.

## Configure a .NET-connected application and SQL Server to use an alternative port number for network communications

Many automated tools identify available services and vulnerabilities by querying well-known port numbers. These tools include both legitimate security assessment tools and tools that malicious users might use.

One way to reduce exposure to these kinds of tools is to change the port number that the applications use. You can apply this method to .NET-connected applications that rely on a back-end SQL Server database. This method works if both the server and the client are correctly configured.

## Lock down an ASP.NET web application or web service

There are many ways to increase the security of ASP.NET web applications and web services. For example, you can use packet filtering, firewalls, restrictive file permissions, the URL Scan Internet Server Application Programming Interface (ISAPI) filter, or carefully controlled SQL Server privileges. You should review these different methods for providing security-in-depth for ASP.NET applications.

## Configure NTFS file permissions to increase security of ASP.NET applications

New Technology File System (NTFS) file permissions continue to be an important layer of security for web applications. ASP.NET applications include many more file types than did previous web application environments. The list of files that anonymous user accounts must have access to isn't obvious.

## Configure SQL Server security for applications that are built on .NET Framework

By default, SQL Server doesn't grant users the ability to query or update databases. This rule also applies to ASP.NET applications and the ASPNET user account. To enable ASP.NET applications to gain access to data that's stored in a SQL Server database, the database administrator must grant rights to the ASPNET account.

For more information about how to configure SQL Server to allow queries and updates from ASP.NET applications, see [Configure permissions on database objects](/sql/t-sql/lesson-2-configuring-permissions-on-database-objects?view=sql-server-ver15&preserve-view=true).

## Configure URLScan to increase protection of ASP.NET web applications

When you install URLScan on an Internet Information Services 5.0 (IIS 5.0) server, the tool is configured to allow ASP 3.0 applications to run. However, when you install .NET Framework, the URLScan configuration isn't updated to include the new ASP.NET file types. If you want the added security of the URLScan ISAPI filter for your ASP.NET applications, adjust the URLScan configuration.

## Require authentication for ASP.NET web applications

Many ASP.NET applications don't allow anonymous access. An ASP.NET application that requires authentication can use one of the following three methods: Forms authentication, .NET Passport authentication, and Windows authentication. Each authentication method requires a different configuration technique.

## Restrict specific users from gaining access to specified web resources

ASP.NET includes Forms authentication. This unique method authenticates users without creating Windows accounts. ASP.NET also includes the ability to grant or deny access to different web resources for these users.

For more information about how to control access to web resources on a per-user basis, visit [Restrict specific users from gaining access to specified web resources](/troubleshoot/developer/webapps/aspnet/configuration/restrict-users-access-web-resource).

## Limit the web services protocols that a server permits

By default, ASP.NET supports three methods for web services clients to issue requests to web services: SOAP, HTTP GET, and HTTP PUT. However, most applications require only one of these methods. We recommend that you reduce the attack surface by disabling any unused protocols.

## Don't permit browser access to .NET-connected web services

ASP.NET web services provide a browser-friendly interface to make it easier for developers to create web services clients. This friendly interface permits anyone who can reach the web service to view the complete details of the methods that are available and any required parameters. This access is useful for public web services that include only publicly available methods. However, it might reduce the security of private web services.

For more information about how to control access to web resources on a per-user basis, see [Restrict specific users from gaining access to specified web resources](/troubleshoot/developer/webapps/aspnet/configuration/restrict-users-access-web-resource).

## Use ASP.NET to protect file types

The structure of ASP.NET applications causes many private files to be stored together with files that end-users request. ASP.NET protects these files by intercepting requests for the files and returning an error. You can extend this type of protection to any file type by using configuration settings. If your application includes unusual file types that should remain private, you can use ASP.NET file protection to protect those files.
