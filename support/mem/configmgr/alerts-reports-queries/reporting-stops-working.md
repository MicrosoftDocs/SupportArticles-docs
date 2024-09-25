---
title: Reporting doesn't work 
description: Fixes an issue in which Configuration Manager reporting doesn't work after you move the reporting services point role to a new server or you enable TLS 1.2 on the site servers.
ms.date: 12/05/2023
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Reports and subscriptions
ms.reviewer: kaushika
---
# Reporting stops working after you move a reporting services point or enable TLS 1.2 in Configuration Manager

This article helps you fix an issue in which Configuration Manager reporting doesn't work after you move the reporting services point role to a new server or you enable TLS 1.2 on the site servers.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4503578

## Symptoms

After you move the reporting services point role to a new server, or you enable TLS 1.2 on the site servers, reporting no longer works in Configuration Manager.

The following error messages are logged in the Srsrp.log file on the reporting services point:

> Successfully created srsserver SMS_SRS_REPORTING_POINT  
> Reporting Services URL from Registry [https://\<ServerName>.contoso.com/SCCMReportServer/ReportService2005.asmx] SMS_SRS_REPORTING_POINT  
> The underlying connection was closed: An unexpected error occurred on a receive. SMS_SRS_REPORTING_POINT  
> (!) SRS not detected as running SMS_SRS_REPORTING_POINT  
> Failures reported during periodic health check by the SRS Server [\<ServerName>.contoso.com]. SMS_SRS_REPORTING_POINT

## Cause

This issue occurs because the site servers and site systems don't meet the requirements that are described in [How to enable TLS 1.2](/mem/configmgr/core/plan-design/security/enable-tls-1-2).

## Resolution

To fix this issue and enable TLS 1.2 in Configuration Manager, make sure that the site servers and site systems meet the requirements that are described in [How to enable TLS 1.2](/mem/configmgr/core/plan-design/security/enable-tls-1-2).

To do this, follow these steps:

1. Verify that .NET Framework is updated and has strong cryptography enabled on all relevant computers.

   To do this, first determine your .NET Framework version number, and then follow these guidelines:
   - .NET Framework 4.6.2 supports TLS 1.1 and TLS 1.2. No additional changes are required.
   - .NET Framework 4.6 and earlier versions [must be updated](/dotnet/framework/migration-guide/versions-and-dependencies) to support TLS 1.1 and TLS 1.2.

     If you're using .NET Framework 4.5.1 or 4.5.2 on Windows 8.1, Windows RT 8.1, or Windows Server 2012, the relevant updates and details are also available from [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=2898850).

   - All Configuration Manager client computers and site systems should have the following registry values set.

     **For 32-bit applications that are running on 32-bit systems or 64-bit applications that are running on 64-bit systems:**

     ```
     [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727]
     "SystemDefaultTlsVersions"=dword:00000001
     "SchUseStrongCrypto"=dword:00000001

     [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319]
     "SystemDefaultTlsVersions"=dword:00000001
     "SchUseStrongCrypto"=dword:00000001
     ```

     **For 32-bit applications that are running on 64-bit systems:**

     ```
     [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v2.0.50727]
     "SystemDefaultTlsVersions"=dword:00000001
     "SchUseStrongCrypto"=dword:00000001

     [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319]
     "SystemDefaultTlsVersions"=dword:00000001
     "SchUseStrongCrypto"=dword:00000001
     ```

2. Verify that the SMS_Executive service is restarted after any updates are installed.
