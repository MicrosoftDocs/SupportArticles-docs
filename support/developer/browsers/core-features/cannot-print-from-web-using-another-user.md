---
title: Can't print from the web if running Internet Explorer 11 as another user
description: Describes an issue that occurs when you try to print from Internet Explorer 11 through a different user account. A workaround is provided.
ms.date: 03/26/2020
---
# Can't print from the web if you run Internet Explorer 11 as another user

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a workaround to solve the issue that you cannot print from Internet Explorer 11 by using another user account.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 3136268

## Symptoms

Consider the following scenario:

- You sign in to a 64-bit version of Windows through user account A.
- You run Internet Explorer 11 through user account B (by using the **Run as a different user** option).
- You browse to any webpage by using this Internet Explorer instance.
- You try to print the webpage contents.

In this scenario, the document doesn't print. No error is displayed.

## Cause

This issue occurs because Internet Explorer 11 uses newer APIs to retrieve more detailed printer information. These new APIs require that the caller application run as the session user for 32-bit applications.

## Workaround

To work around this issue, determine whether you really have to run Internet Explorer 11 as another user. If not, remove this dependency.

## More information

If you make sure that the iexplore.exe process that's responsible for the printing procedure is a 64-bit process, printing should work correctly. You can do this by configuring Internet Explorer 11 to use a single process (`TabProcGrowth=0`), but this will reduce security and increase the chance of application compatibility issues.

Alternatively, you could enable Enhanced Protected Mode (EPM) and force all processes to be 64-bit, but this applies to only websites that belong to security zones where Protected Mode is enabled (typically only the Internet zone). And this may also cause application compatibility issues.

Because of the problems that they may trigger, neither of the workarounds in this section are recommended. Therefore, removing the dependency is the best option.
