---
title: Account is not authorized to login
description: Discusses an issue where an error occurs when you try to join a Windows 2000-based computer to a Microsoft Windows NT 4.0-based domain.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-join-issues, csstroubleshoot
---
# Error message: The account is not authorized to login from this station

This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 281648

## Symptoms

When you attempt to join a Windows 2000-based computer to a Microsoft Windows NT 4.0-based domain, you may receive the following error message:

> The following error occurred attempting to join the domain "domainname": The account is not authorized to login from this station.

## Cause

This behavior can occur because the Local Group Policy, specifically those in the Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options folder have a restrictive setting.

Some of the policies that may cause this behavior are:

- Digitally sign client communications (always)
- Digitally sign server communications (always)
- Digitally sign server communications (when possible)
- LAN Manager Authentication Level set to Send LM and NTLM - use NTLMv2 session security if negotiated
- Secure channel: Digitally encrypt or sign secure channel data (always)
- Secure channel: Require strong (Windows 2000 or later) session key

## Resolution

To work around this behavior, set the values back to what they would be if a clean install had occurred.

Examine the preceding policies and set them back to their default settings.

The default settings of these policies are:

- Digitally sign client communications (always) - disabled
- Digitally sign server communications (always)- disabled
- Digitally sign server communications (when possible) - disabled
- LAN Manager Authentication Level set to Send LM and NTLM - use NTLMv2 session security if negotiated - (default) send LM & NTLM responses
- Secure channel: Digitally encrypt or sign secure channel data (always) - disabled
- Secure channel: Require strong (Windows 2000 or later) session key - disabled

Restart your computer and you should be able to join the domain.

## Status

This behavior is by design.
