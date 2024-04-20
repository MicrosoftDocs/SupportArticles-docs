---
title: Can't install Configuration Manager client without BITS
description: Describes a problem in which the System Center 2012 Configuration Manager client installation fails when BITS is not installed.
ms.date: 12/05/2023
ms.reviewer: kaushika, keiththo, erinwi
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# Configuration Manager client installation fails when BITS is not installed

This article fixes an issue in which Configuration Manager client installation fails when Microsoft Background Intelligent Transfer Service (BITS) isn't installed.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2678905

## Symptoms

When you try to install the Microsoft System Center 2012 Configuration Manager client, the installation fails, and the following error messages are logged in the CCMSetup.log file:

> This operating system does not contain the correct version of BITS. BITS 2.5 or later is required.  
> Sending Fallback Status Point message, STATEID='321'.  
> State message with TopicType 800 and TopicId {0D94311F-CB7B-4E73-94B1-75878081111C} has been sent to the FSPCcmSetup failed with error code 0x80004005

## Cause

This problem occurs because BITS version 2.5 or a later version must be installed before you can install the Configuration Manager client.

## Resolution

To resolve this problem, first deploy the minimum required version of BITS or a later version on client computers. After you install BITS, you must restart the client computer must be restarted. Then, you can install the Configuration Manager client.

## More information

BITS version 2.5 is required to enable throttled data transfers between the client computer and System Center 2012 Configuration Manager site systems. BITS is not automatically downloaded during client installation. Most operating systems include BITS. However, if your operating system doesn't include BITS, you must install BITS before you install the System Center 2012 Configuration Manager client.

For more information about the prerequisites for Configuration Manager, see [Prerequisites for Windows Client Deployment in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg682042(v=technet.10)?redirectedfrom=MSDN).

For a complete version history of BITS that includes all available download locations, see [Background Intelligent Transfer Service: What's New](/windows/win32/bits/what-s-new?redirectedfrom=MSDN).
