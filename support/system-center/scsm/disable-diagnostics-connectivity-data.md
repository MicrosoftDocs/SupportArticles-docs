---
title: Disable sharing usage and connectivity data
description: Describes how to disable diagnostic and connectivity data for Service Management Automation, Service Provider Foundation and Service Manager Self-Serve portal.
ms.date: 08/04/2020
ms.reviewer: rahulgup
---
# Disable diagnostic and connectivity data for SMA, SPF, and Service Manager Self-Serve portal

Service Management Automation (SMA), Service Provider Foundation (SPF), and Service Manager Self-Serve Portal send diagnostic and connectivity data to Microsoft based on the users selection.

_Original product version:_ &nbsp; System Center 2016 Service Manager  
_Original KB number:_ &nbsp; 3096505

## Summary

Microsoft automatically collects diagnostics and connectivity data over the Internet (data). Microsoft uses this data to provide and improve the quality, security, and integrity of Microsoft products and services. For example, we analyze performance and reliability such as what features that you use, how quickly the features respond, device performance, user interface interactions, and any problems that you experience with the product. Data also includes information about the configuration of your software such as the software version that you are currently running and your IP address.

By default this feature is enabled however administrators can turn off this feature at any time.

## Disable sharing usage and connectivity data in SMA

1. Import the SMA PowerShell module in your deployment.

2. Run the following PowerShell cmdlet to disable the sharing of usage and connectivity data in SMA:

    ```powershell
    Set-SmaAdminConfiguration -WebServiceEndpoint <String> [-AuthenticationType <String>] -Telemetry $false
    ```

## Disable sharing usage and connectivity data in SPF

Set the value of the `DiagnosticAndUsageDataEnabled` registry subkey under `HKEY_LOCAL_MACHINE\Software\Microsoft\Service Provider Foundation` on the SPF server to **0**.

## Disable sharing diagnostics and usage data in Service Manager Self-Serve Portal

Set the `EnableTelemetry` key in web.config to **False**. For more information, see [Customize the Self-Service portal](/system-center/scsm/deploy-self-service-portal#customize-the-self-service-portal).
