---
title: Secure applications built on .NET Framework
description: Describes important considerations for securing applications that are built on the .NET Framework.
ms.date: 05/06/2020
ms.topic: how-to
---
# Secure applications that are built on the .NET Framework

This article describes important considerations for securing applications that are built on Microsoft .NET Framework.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 818014

## Summary

This article is one of a series of articles that provide detailed information for applications that are built on the .NET Framework.

The articles in this series include the following ones:

- [HOW TO: Deploy Applications That Are Built on the .NET Framework](https://support.microsoft.com/help/818016)

- [HOW TO: Secure Applications That Are Built on the .NET Framework](https://support.microsoft.com/help/818014)

## Adjust .NET Framework security on a zone-by-zone basis

The .NET Framework assigns trust levels to managed assemblies. These assignments are based, in part, on the zone where the assembly runs. The standard zones are My Computer, Local Intranet, Internet, Trusted Sites, and Untrusted Sites. You may have to increase or reduce the trust level that is associated with one of these zones. The .NET Framework includes tools for adjusting these settings.

## Adjust the level of trust in a .NET Framework assembly

The .NET Framework includes many ways to determine the level of trust that you should grant to an assembly. However, you can make exceptions to the rules to enable a specific assembly to receive a higher level of trust than it would typically receive based on the evidence provided to the common language runtime. The .NET Framework provides a wizard tool specifically for this purpose.

## Restore policy levels that have been customized

As an Administrator, you have complete control over the access that you grant to assemblies that run at the various trust levels. If you customize trust levels, you may experience problems when you run an application that typically runs under a standard trust level. However, you can quickly restore policy levels to their default settings.

## Evaluate the permissions that are granted to an assembly

When you have enterprise, machine, and user security configuration policies, and customizable trust levels, it can be difficult to assess the permissions that have been granted to a managed assembly. The .NET Framework Configuration tool includes a simple method to evaluate these permissions.

## Audit the security of .NET-connected applications

During upgrades, testing, and troubleshooting, the configuration of production systems may change in unintentional ways. For example, an administrator might grant administrative credentials to a user while determining whether an error is related to access rights. If that administrator forgets to revoke those elevated credentials after completing the troubleshooting process, the integrity of the system is compromised.

Because system security can be degraded over time by this type of action, it's a good idea to do regular audits. To do it, document key aspects of a pristine system to create a baseline measure. Compare these settings against the baseline over time to determine if any problems have developed that might significantly reduce the level of vulnerability.

## Configure a .NET-connected application and SQL Server to use an alternate port number for network communications

Many automated tools identify available services and vulnerabilities by querying well-known port numbers. These tools include both legitimate security assessment tools and tools that malicious users might use.

One way to reduce the exposure to these types of tools is to change the port number that the applications use. You can apply this method to .NET-connected applications that rely on a back-end SQL Server database. This method works if both the server and the client are correctly configured.

## Lock down an ASP.NET web application or web service

There are many ways to increase the security of ASP.NET web applications and web services. For example, you can use packet filtering, firewalls, restrictive file permissions, the URL Scan Internet Server Application Programming Interface (ISAPI) filter, and carefully controlled SQL Server privileges. It's a good idea to review these different methods to provide security-in-depth for ASP.NET applications.

## Configure NTFS file permissions to increase security of ASP.NET applications

New Technology File System (NTFS) file permissions continue to be an important layer of security for web applications. ASP.NET applications include many more file types than previous web application environments. The files that anonymous user accounts must have access to isn't obvious.

## Configure SQL Server security for applications that are built on the .NET Framework

By default, SQL Server doesn't grant users the ability to query or update databases. This rule also applies to ASP.NET applications and the ASPNET user account. To enable ASP.NET applications to gain access to data that is stored in a SQL Server database, the database administrator must grant rights to the ASPNET account.

For additional information about how to configure SQL Server to allow queries and updates from ASP.NET applications, visit [Configure permissions on database objects](/sql/t-sql/lesson-2-configuring-permissions-on-database-objects?view=sql-server-ver15&preserve-view=true).

## Configure URLScan to increase protection of ASP.NET web applications

When you install URLScan on an Internet Information Services 5.0 (IIS 5.0) server, it's configured to allow ASP 3.0 applications to run. However, when you install the .NET Framework, the URLScan configuration isn't updated to include the new ASP.NET file types. If you want the added security of the URLScan ISAPI filter for your ASP.NET applications, adjust the URLScan configuration.

## Require authentication for ASP.NET web applications

Many ASP.NET applications don't allow anonymous access. An ASP.NET application that requires authentication can use one of the following three methods: Forms authentication, .NET Passport authentication, and Windows authentication. Each authentication method requires a different configuration technique.

## Restrict specific users from gaining access to specified web resources

ASP.NET includes Forms authentication. It's a unique way to authenticate users without creating Windows accounts. ASP.NET also includes the ability to grant or deny these users' access to different web resources.

For more information about how to control access to web resources on a per-user basis, visit [How To Restrict Specific Users from Gaining Access to Specified web Resources](https://support.microsoft.com/help/815151).

## Limit the web services protocols that a server permits

By default, ASP.NET supports three ways for web services clients to issue requests to web services: SOAP, HTTP GET, and HTTP PUT. However, most applications require only one of these three methods. It's a good idea to reduce the attack surface by disabling any unused protocols.

## Don't permit browser access to .NET-connected web services

ASP.NET web services provide a browser-friendly interface to make it easier for developers to create web services clients. This friendly interface permits anyone who can reach the web service to view the complete details of the methods that are available and any required parameters. This access is useful for public web services that include only publicly available methods. However, it may reduce the security of private web services.

For additional information about how to control access to web resources on a per-user basis, visit [How To Restrict Specific Users from Gaining Access to Specified web Resources](https://support.microsoft.com/help/815151).

## Use ASP.NET to protect file types

The structure of ASP.NET applications causes many private files to be stored with files that end-users request. ASP.NET protects these files by intercepting requests for the files and returning an error. You can extend this type of protection to any file type by using configuration settings. If your application includes unusual file types that should remain private, you can use ASP.NET file protection to protect those files.

## References

For more information about how to secure applications that are built on the .NET Framework, visit [What's new in Windows 10 deployment](/windows/deployment/deploy-whats-new).
