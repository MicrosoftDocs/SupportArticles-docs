---
title: Upgrade Advisor tool failed to run
description: Provides a solution to an error that occurs when you run the Windows 7 Upgrade Advisor tool on a system.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# Windows 7 Upgrade Advisor tool failed to run with error message "Windows 7 Upgrade Advisor was unable to reach the Microsoft server for compatibility information. Check your internet connection and try again later."

This article provides a solution to an error that occurs when you run the Windows 7 Upgrade Advisor tool on a system.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2448270

## Symptoms

When you run the Windows 7 Upgrade Advisor tool on a system that must use a proxy to access the internet, you receive the error:

> Windows 7 Upgrade Advisor was unable to reach the Microsoft server for compatibility information. Check your internet connection and try again later.

## Cause

Windows 7 Upgrade Advisor tries to reach the Microsoft server to get the compatibility information. The error is shown since Windows 7 Upgrade Advisor doesn't support proxy authentication.

In the error log (%temp%\WuaDiagnostics.log), you receive the error like following one:

> [7/23/2010 12:04:41 PM] Exception: The request failed with HTTP status 407: Proxy Authentication Required

## Resolution  

On the proxy, create an anonymous access rule specific to the destinations FQDN (fully qualified domain name)'s used by the Windows 7 Upgrade Advisor, for example, you may create the following rules:

> Action: Allow  
Protocols: HTTP, HTTPS  
From/Listener: Internal  
To: Domain Name Set  
aeos.microsoft.com  
aestats.microsoft.com  
crl.microsoft.com  
download.microsoft.com  
go.microsoft.com  
>
> Condition: All Users

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
