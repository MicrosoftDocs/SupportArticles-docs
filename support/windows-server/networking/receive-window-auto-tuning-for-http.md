---
title: Receive Window Auto-Tuning feature for HTTP traffic
description: Describes how Auto-Tuning improves data transfer, how to enable Auto-Tuning for HTTP traffic on Windows Vista-based computers, and issues that may occur after you enable Auto-Tuning for HTTP traffic.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# Receive Window Auto-Tuning feature for HTTP traffic on Windows Vista-based computers

This article describes how the Receive Window Auto-Tuning feature improves data transfer, how to enable/diable this feature for HTTP traffic on Windows Vista-based computers, and issues that may occur after you enable this feature for HTTP traffic.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 947239

## Introduction

Windows Vista includes the [Receive Window Auto-Tuning](/previous-versions/technet-magazine/cc162519(v=msdn.10)) feature that improves performance for programs that receive TCP data over a network. However, this feature is disabled by default for programs that use the [Windows HTTP Services (WinHTTP)](/windows/win32/winhttp/about-winhttp) interface. Some examples of programs that use WinHTTP include Automatic Updates, Windows Update, Remote Desktop Connection, Windows Explorer (network file copy), and Sharepoint (WebDAV).

If you enable Receive Window Auto-Tuning for WinHTTP traffic, data transfers over the network may be more efficient. However, in some cases you might experience slower data transfers or loss of connectivity if your network uses an older router and firewall that does not support this feature. For example, when you use Windows Internet Explorer to access applications that are hosted in Microsoft Office SharePoint Server, the HTTP traffic may slow down. This occurs because certain routers do not support the Receive Window Auto-Tuning feature.

> [!NOTE]
> Since the release of Windows 7, Receive Window Auto-Tuning is now available for programs that use the [Windows Internet (WinINet)](/windows/win32/wininet/portal) application programming interface (API) for HTTP requests instead of WinHTTP. Some examples of programs that use WinINet for HTTP traffic include Internet Explorer, Outlook, and Outlook Express.

## How Receive Window Auto-Tuning feature improves data transfer

The Receive Window Auto-Tuning feature lets the operating system continually monitor routing conditions such as bandwidth, network delay, and application delay. Therefore, the operating system can configure connections by scaling the TCP receive window to maximize the network performance. To determine the optimal receive window size, the Receive Window Auto-Tuning feature measures the products that delay bandwidth and the application retrieve rates. Then, the Receive Window Auto-Tuning feature adapts the receive window size of the ongoing transmission to take advantage of any unused bandwidth.

## Enable Receive Window Auto-Tuning feature for WinHTTP traffic

> [!NOTE]
> Prerequisites: You must be running Windows Vista Service Pack 2 or Windows Vista Service Pack 1, or have hotfix 939006 installed to enable auto-tuning for WinHTTP.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
To enable the Receive Window Auto-Tuning feature for HTTP traffic, you must edit the registry. To do this, follow these steps:

1. Click **Start**, type *regedit* in the **Start Search** box, and then press ENTER.
2. Locate and then right-click the registry subkey `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp`.
3. Point to **New**, and then click **DWORD Value**.
4. Type *TcpAutotuning*, and then press ENTER.
5. Right-click **TcpAutotuning**, and then click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.
7. Exit Registry Editor.
8. Restart the computer.

The Receive Window Auto-Tuning feature is enabled for HTTP traffic if the **TcpAutotuning** registry entry is set to **1**. The Receive Window Auto-Tuning feature is not enabled for HTTP traffic if the **TcpAutotuning** registry entry does not exist or if it is set to a value that is not **1**.

To enable the Windows Internet (WinINet) in Windows 7, follow these steps:

1. Click **Start**, type *regedit* in the **Search programs and files** box, and then press ENTER.
2. Locate and then right-click the registry subkey `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings`.
3. Point to **New**, and then click **DWORD Value**.
4. Type *TcpAutotuning*, and then press ENTER.
5. Right-click **TcpAutotuning**, and then click **Modify**.
6. In the **Value data** box, type *1*, and then click **OK**.
7. Repeat step 2 through step 6 to add a **TcpAutotuning** entry with DWORD value of **1** under the following registry subkey: 

    `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings`

8. Exit Registry Editor.
9. Restart the computer.

WinINet is enabled if the **TcpAutotuning** registry entries are set to **1**. WinINet is not enabled if the **TcpAutotuning** registry entries do not exist or if they are set to a value that is not **1**.

Check whether the problem is fixed. If the problem is fixed, you are finished with this article. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).

## Issues that may occur after you enable the Receive Window Auto-Tuning feature for HTTP traffic

When the Receive Window Auto-Tuning feature is enabled for HTTP traffic, older routers, older firewalls, and older operating systems that are incompatible with the Receive Window Auto-Tuning feature may sometimes cause slow data transfer or a loss of connectivity. When this occurs, users may experience slow performance. Or, the applications may crash. These older devices do not comply with the RFC 1323 standard. Some device manufacturers provide software that works around the hardware limitations. Contact the device manufacturer to determine whether this kind of software is available.

If the incompatible devices are outside your organization, and you cannot change the devices, this issue will remain. Therefore, you may have to disable the Receive Window Auto-Tuning feature for HTTP traffic.

## Disable the Receive Window Auto-Tuning feature

To disable the Receive Window Auto-Tuning feature for HTTP traffic, follow these steps:

1. Log on to the computer as a user who has administrative credentials.
2. Click **Start**, type `runas /user: local_computer_name \administrator cmd` in the **Start Search** box, and then press ENTER.
3. When you are prompted for the administrator account password, type the correct password, and then press ENTER.
4. At the command prompt, type the following command, and then press ENTER:

    ```console
    netsh interface tcp set global autotuninglevel=disabled
    ```

5. Exit the Command Prompt window.
6. Restart the computer.

Check whether the problem is fixed. If the problem is fixed, you are finished with this article. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).
