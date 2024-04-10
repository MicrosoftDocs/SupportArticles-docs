---
title: Repeatedly prompted for credentials to use proxy server
description: Discusses a problem with Internet Explorer where Internet Explorer repeatedly prompts you for credentials to use a proxy server to view a Web site.
ms.date: 10/13/2020
ms.reviewer: ramakoni
---
# You are repeatedly prompted for credentials to use a proxy server in Internet Explorer Service Pack 1

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a resolution to solve the issue that you're repeatedly prompted for credentials even if you have entered the credentials to use a proxy server to view a Web site in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 822458

## Symptoms

After you type your credentials to use a proxy server to view a Web site, you may be prompted to type your credentials again.

## Cause

This problem may occur if you use Windows NT LAN Manager (NTLM) authentication with more than one proxy server. Microsoft Internet Explorer does not support NTLM authentication with more than one proxy server where NTLM authentication is required on each proxy server. The NTLM authentication on the first proxy server in the chain succeeds, but when the proxy server sends a **407 Proxy authentication required** response, the user is prompted for credentials. This problem occurs with any proxy server product regardless of the manufacturer.

## Resolution

You need to enable Negotiate-Authentication along with Kerberos and Delegation.
