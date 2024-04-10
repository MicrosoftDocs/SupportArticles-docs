---
title: Session variables in Internet Explorer are missing
description: This article describes the reasons and solutions for variables that cannot be saved after the security patch is installed in Internet Explorer 5.5 or 6.0.
ms.date: 06/03/2020
ms.reviewer: 
---
# Session variables do not persist between requests after you install Internet Explorer security Patch

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides methods to solve the problem of missing session variables in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 5.5, Internet Explorer 6.0  
_Original KB number:_ &nbsp; 316112

## Symptoms

After you install security patch for Microsoft Internet Explorer 5.5 or 6.0, you may encounter the following problems:

- Session variables are lost.
- Session state is not maintained between requests.
- Cookies are not set on the client system.

> [!NOTE]
> These problems can also occur after you install a more recent patch.

## Cause

Security patch prevents servers with improper name syntax from setting cookies names. Domains that use cookies must use only alphanumeric characters ("-" or ".") in the domain name and the server name. Internet Explorer blocks cookies from a server if the server name contains other characters, such as an underscore character ("_").

Because ASP session state and session variables rely on cookies to function, ASP cannot maintain session state between requests if cookies cannot be set on the client.

This issue can also be caused by an incorrect name syntax in a host header.

## Resolution

To work around this problem, use one of the following methods:

- Rename the domain name and the server name, and use only alphanumeric characters.
- Browse to the server by using the Internet Protocol (IP) address rather than the domain/server name.

> [!NOTE]
> You may need to change the Microsoft Internet Information Server (IIS) configuration after you rename a server. For more information, see the **References** section.

## Status

This behavior is by design.

## References

For more information about the RFC 883 specifications, see [DOMAIN NAMES - IMPLEMENTATION and SPECIFICATION](https://www.ietf.org/rfc/rfc883.txt?number=883).
