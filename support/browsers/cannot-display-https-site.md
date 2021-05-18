---
title: HTTPS site cannot be display in Internet Explorer
description: This article describes the situation where https sites can't be displayed in Internet Explorer when SSL 2.0 and TLS 1.2 are loaded.
ms.date: 06/09/2020
ms.reviewer: 
---
# Internet Explorer cannot display an HTTPS site when SSL 2.0 and TLS 1.2 are selected

[!INCLUDE [](../includes/browsers-important.md)]

This article provides a solution for Internet Explorer unable to display HTTPS websites.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2851628

## Symptoms

Assume that you select SSL 2.0 and TLS 1.2 in the Internet Explorer 11 security settings. When you try to access an HTTPS website in Internet Explorer, you receive the following error message:

> Internet Explorer cannot display the webpage

## Cause

The issue occurs because SSL 2.0 and TLS 1.2 are not compatible with each other in Internet Explorer 9 and later versions.

## Resolution

To use client-side certificates to establish an HTTPS connection over TLS 1.2, you must disable SSL 2.0. For more information about how to do this, see [Change security and privacy settings for Internet Explorer 11](https://support.microsoft.com/help/17479/windows-internet-explorer-11-change-security-privacy-settings).

> [!NOTE]
> SSL 2.0 is disabled by default.
