---
title: Cannot visit FTP sites via Web proxies in Internet Explorer
description: This article describes the issue that occurs when you use Internet Explorer to access File Transfer Protocol (FTP) sites through Web proxies in internal clients. And also provides the resolution that helps you to solve this problem.
ms.date: 03/05/2020
---
# Internal clients cannot use Internet Explorer to access FTP sites through Web proxies

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the steps to solve the error message that occurs when you use internal clients to visit a File Transfer Protocol (FTP) site in Internet Explorer.

_Original version:_ &nbsp; Internet Explorer, Microsoft Internet Security and Acceleration Server 2004 Enterprise Edition  
_Original KB number:_ &nbsp; 814473

## Symptoms

When you use Microsoft Internet Explorer to try to access an FTP site, you may receive the following error message:

> Windows cannot access this folder. Make sure you typed the file name correctly, and that you have permission to access to the folder.
>
> _Details:_ &nbsp; The operation timed out.

## Cause

This issue may occur if the following conditions exist:

- You try to access the FTP site from behind a Web proxy firewall.
- Folder view for FTP sites is enabled in the Internet Explorer.

When you turn on folder view for FTP sites, the Internet Explorer client bypasses the Web Proxy, and tries to send FTP connection requests directly to the Internet. This operation is unsuccessful.

## Resolution

To solve this issue, turn off folder view for FTP sites in Internet Explorer:

1. Start Internet Explorer.

2. On the **Tools** menu, click **Internet Options**.

3. Click the **Advanced** tab, click to clear the **Enable folder view for FTP sites** check box, click **Apply**, and then click **OK**.
