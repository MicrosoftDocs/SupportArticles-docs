---
title: Can't access OpsMgr AppAdvisor
description: Discusses that you cannot access the System Center Operations Manager Application Advisor website when you use Kerberos authentication.
ms.date: 04/15/2024
---
# Can't access the System Center Operations Manager AppAdvisor website when using Kerberos authentication

This article helps you work around an issue in which you can't access the System Center Operations Manager Application Advisor (AppAdvisor) website when you use Kerberos authentication.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2872367

## Symptoms

Consider the following scenario:

- You are using Microsoft System Center Operations Manager.
- The AppAdvisor console is installed on a different computer than the server that's running the SQL Server Reporting Services (SSRS) or the server that's hosting the `OperationsManagerDW` database.
- You are using Kerberos authentication to access AppAdvisor.

In this scenario, you cannot access AppAdvisor as expected.

## Cause

This behavior may occur because of an increase in the number of authentication hops that are required.

## Workaround

To work around this behavior, configure AppAdvisor to use forms-based authentication. This configuration generates a dialog box in which the user can enter credentials.

## More information

If you are a member of the Operations Manager Application Monitoring Operator role, the user account must be authenticated when you access AppAdvisor. This is so that the user account can be checked against the System Center data access service in order to grant access to AppAdvisor.

AppAdvisor acts as a proxy between SSRS and the front-end server that lets you select certain reports and their parameters. The SSRS has their own authentication model. This model is changed by System Center Operations Manager during reporting installation. This change introduces an additional hop in the authentication process.

The identity flow for AppAdvisor is as follows.

- From browser to website: The website performs an initial check of the user's identity to determine whether the user is granted access. This check is performed against the System Center data access service.
- From website to SSRS: The user's identity must be forwarded to SSRS because Operations Manager uses SSRS to enforce a separate identify and authorization check against the System Center Data Access service.
- From SSRS to the `OperationsManagerDW` database: This step uses the SSRS AppPool credentials.

Because of the additional authentication hop that occurs, Windows authentication may not work in this scenario. This behavior is partly affected by the web console and whether the SSRS websites are hosted on the same server. You can use forms-based authentication in a distributed environment to help restore access to AppAdvisor.

## References

For more information about the identity flow for AppAdvisor, see [Identity flow for AppAdvisor and AppDiagnostics](https://social.technet.microsoft.com/forums/systemcenter/b54c409c-7416-495a-81a0-40172bdfb2c4/identity-flow-for-appadvisor-and-appdiagnostics)
