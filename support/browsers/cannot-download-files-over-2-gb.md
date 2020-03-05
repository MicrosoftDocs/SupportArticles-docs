---
title: Cannot download over 2 GB files in Internet Explorer 
description: This article provides the workaround to solve the issue that you cannot download a file that's larger than 2 GB in Internet Explorer 6 or larger than 4 GB in Internet Explorer 7.
ms.date: 03/02/2020
ms.prod-support-area-path: Internet Explorer
---
# You cannot download files that are 2 GB or larger

This article introduces a workaround to solve the problem that you cannot download a file that is larger than 2 gigabytes (GB) in Internet Explorer 6 or is larger than 4 GB in Internet Explorer 7.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 298618

## Symptoms

When you try to download a file from the Internet by using Hypertext Transfer Protocol (HTTP) in Microsoft Internet Explorer, you may find that the download does not complete. As a result, you cannot download the file.

> [!NOTE]
> This download limit has been removed in Internet Explorer 8. Therefore, you should not experience this behavior in Internet Explorer 8.

## Workaround

To work around this problem, you can configure a Web site that is dedicated to downloading large files. To do this, disable the **HTTP Keep-Alives Enabled** option for a Web site that Internet Information Services (IIS) hosts. To disable this option, follow these steps:

1. Open Internet Information Services Manager.

2. Right-click the Web site that requires the change, and then click **Properties**.

3. Clear the **HTTP Keep-Alives Enabled** check box that is located on the **Web Site** tab, and then click **OK**.

> [!NOTE]
>
> - The **HTTP Keep-Alives Enabled** option enables a client that connects to the Web server to reuse the current TCP/IP session when it downloads all content from the Web server. When you disable this option, an Internet Explorer client can then download files of up to 4 GB. However, it also forces the client to establish a new TCP/IP session with the Web server for every content object that is downloaded from the Web page. Additionally, it creates extra TCP/IP overhead for both the server and the client which will adversely affect page load times.
>
> - Windows Internet Explorer 7 can reliably download files up to 4 GB in size without the previously described change to the server. There is no workaround to enable Internet Explorer 7 to download files larger than 4 GB in size. Windows Internet Explorer 8 can reliably download files over 4 GB in size without the previously described change to the server.
