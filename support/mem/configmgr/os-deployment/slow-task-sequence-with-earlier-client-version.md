---
title: A task sequence is slow with earlier client versions
description: Describes an issue causing slow task sequences if the client in the media, or in the boot image, is earlier than the site version. Provides a resolution.
ms.date: 12/05/2023
ms.reviewer: kaushika, sccmcsscontent, rasiddiq
---
# A task sequence is slow if the client in the media or in the boot image is earlier than the site version

This article provides a solution for the issue that task sequence execution is slow if the Configuration Manager client in the media or in the boot image is earlier than the site version.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4490065

## Symptoms

Consider the following scenario:

- You have a Configuration Manager current branch version 1810 or a later environment.
- You have production clients on a version of Configuration Manager earlier than version 1810.
- When you use PXE boot or task sequence media to install the Windows operating system, you may see significant delays in the overall runtime for the task sequence.
- You have an HTTPS hierarchy.

In this scenario, when you examine the smsts.log file, you receive this error message:

> Setting Media Certificate.  
> CLibSMSMessageWinHttpTransport::Send: WinHttpOpenRequest - URL: DPServerFQDN:443 PROPFIND /CCMTOKENAUTH_SMS_DP_SMSPKG$/PKGID  
> 401 - Unsuccessful with anonymous access. Retrying with context credentials.  
> SendResourceRequest() failed. 80190191

## Cause

This issue occurs because of a new token feature that is automatically activated in Configuration Manager current branch version 1810 and later versions.

If the client has an older version installed, it won't have code to decode the token and will fail on calling `CCMTOKENAUTH_SMS_DP_SMSPKG$`.

Clients eventually will fall back to `NOCERT_SMS_DP_SMSPKG$` after several retries.

For each package, this delay can cause around 1 to 4 minutes additional time, so the total time that's spent on the task sequence execution will be larger.

## Resolution for PXE boot

1. Update the client at the **Setup Windows** and **Configuration Manager** tasks to the version 1810 client. If you use the default Configuration Manager client package, make sure the client is promoted to the latest version.

1. Update the boot image by updating it on the Configuration Manager distribution point and make sure the version is greater than or equal to Configuration Manager, version 1810.

## Resolution for Media boot

1. Update the client at the **Setup Windows** and **Configuration Manager** tasks to the version 1810 client. If you use the default Configuration Manager client package, make sure the client is promoted to the latest version.

1. Update the boot image by updating it on the Configuration Manager distribution point and make sure the version is greater than or equal to Configuration Manager, version 1810.

1. Update the boot media so that it contains the updated boot image.
