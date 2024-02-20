---
title: SSO with pre-logon fails during user logon after a restart
description: Wireless and Wired 802.1x Authentication may fail on the first logon after a restart if the client system is configured to use a Single Sign On (SSO) profile with pre-logon.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, waynmc, tfairman
ms.custom: sap:kerberos-authentication, csstroubleshoot
---
# SSO with pre-logon fails during user logon after a restart

This article provides a solution to an issue that Single Sign On (SSO) profile with pre-logon fails during user logon after a restart.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3063910

## Symptoms

Wireless and Wired 802.1**x** Authentication fails on the first logon attempt after a system restart if the client system is configured to use a SSO profile with pre-logon. In this situation, the user receives the following error message:

> There are currently no logon servers available to service the logon request.

The message window resembles the following screenshot.

:::image type="content" source="media/sso-pre-logon-fails-during-user-logon/logon-error-message.png" alt-text="Screenshot shows the no logon servers available to service the logon request error.":::

## Cause

This problem is caused by a race-condition that occurs during the boot sequence between the Pre-Logon Authentication Provider (PLAP) logon filter and either the Wired Autoconfig service (for wired connections) or the WLAN Autoconfig service (for wireless connections). The logon filter queries for SSO profiles. However, if the respective Autoconfig service is not fully initialized by the time of the query, the client won't be SSO-configured. Therefore, users can't log on by using SSO.

## Workaround

To work around this problem, connect users through a non-802.1**x** -protected network to cache their credentials during the first logon.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More information

This problem doesn't usually occur. However, if you do encounter this problem, we recommend that you open a support case and collect the relevant log information. To do this, follow these steps:

1. Open an elevated command prompt.
2. Run the following command:

    ```console
    netsh trace start persistent=yes overwrite=yes maxsize=4096 tracefile=c:\net_plap.etl provider={2CF38663-F760-46AC-AAFA-2DDE7F9DB417} keywords=0xffffffffffffffff level=0xff provider="Microsoft-Windows-L2NACP" keywords=0xffffffffffffffff level=0xff
    ```  

3. Restart the computer.
4. Reproduce the logon issue.
5. Connect to an unprotected network to successfully log on and stop the trace. To do this, run the following command:

    ```console
    netsh trace stop
    ```  

    This generates the trace file: c:\net_plap.etl.
