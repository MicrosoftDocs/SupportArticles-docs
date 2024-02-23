---
title: Certificate Services doesn't start
description: Provides a solution to an issue where Certificate Services (certsvc) doesn't start after upgrade to Microsoft Windows Server 2016.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# Certificate Services (certsvc) doesn't start after upgrade to Windows Server 2016

This article provides a solution to an issue where Certificate Services (certsvc) doesn't start after upgrade to Microsoft Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 3205641

## Symptoms

After you perform an in-place upgrade of Windows Server 2012 or Windows Server 2012 R2 to Windows Server 2016, Active Directory Certificate Services (certsvc) may not start. If you try to manually start the service from Services Management Console (services.msc), the attempt may fail with the following error message:

Windows could not start the Active Directory Certificate Services service on Local Computer.
Error 1058: The service cannot be started, either because it is disabled or because it has not enabled devices associated with it.

Additionally, when you try to start Active Directory Certificate Services from the Certificate Services snap-in, it may fail, and then you receive the following error message:

> Title: Microsoft Active Directory Certificate Services  
The service cannot be started, either because it is disabled or because it has not enabled devices associated with it.  
0x422 (WIN32: 1058 ERROR_SERVICE_DISABLED)

> [!Note]
>
> - No event is recorded in the System or Application logs when the service fails to start.
> - This issue may occur on different configurations. For example: Domain joined, Non-Domain joined, Enterprise Certificate Authority, and Standalone Certificate Authority

## Workaround

To recover from this issue, restart the computer. Active Directory Certificate Services is automatically started after the computer reboots.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
