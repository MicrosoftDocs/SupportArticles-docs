---
title: GetAddrInfo fails with WSAHOST_NOT_FOUND (11001) error when there was a previous call for the AF_INET6 family in Windows
description: Address an issue in which you receive a WSAHOST_NOT_FOUND error when the GetAddrInfo is called after another call for the AF_INET6 family.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo, kevidyke, ajayps
ms.custom: sap:dns, csstroubleshoot
---
# GetAddrInfo fails with error 11001 when there was a previous call for the AF_INET6 family in Windows

This article addresses an issue in which you receive a WSAHOST_NOT_FOUND error when the `GetAddrInfo` is called after another call for the AF_INET6 family.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4057932

## Symptoms

Consider the following scenario:

- You use a flat name without any suffixes to run a query for a host name.
- You have a suffix search list, and this host name is resolvable through one of these suffixes other than the last suffix in the list.
- You run `GetAddrInfo` for the AF_INET6 family first, and then you run that command for the AF_INET family.

In this scenario, the function can't resolve the provided host name, and you receive the " WSAHOST_NOT_FOUND (11001)" error message.

For example, you have the following environment:

- Suffix Search List: `contoso.com`, `foo.contoso.com`, `bar.contoso.com`  
- Host name trying to be resolved: test  
- Host DNS A record present in: `foo.contoso.com`

When you try to run the following sample code, the calls fail with the 11001 error.

```cpp
hints.ai_socktype = SOCK_STREAM;
                hints.ai_protocol = IPPROTO_TCP;
                hints.ai_flags = 0;
                hints.ai_family = AF_INET6;
getaddrinfo("test", NULL, &hints, &res)
hints.ai_family = AF_INET;
getaddrinfo("test", NULL, &hints, &res)
```

## Workaround

This issue can be avoided by using the following methods. The issue will not occur if you:

- Use AF_UNSPEC for the family and let our code determine the A/AAAA results for you.
- Put the suffix with the matching host A record as the last entry in the suffix search list.
- Disable negative caching on the DNS client.
- Pass the fully qualified host name to be resolved.

The first option is the recommended method, as there's usually no need to do the calls on a per family basis, and Windows is much better optimized to return the best possible set of results for both families.
