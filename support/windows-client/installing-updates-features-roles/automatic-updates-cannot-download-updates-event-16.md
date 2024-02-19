---
title: Automatic Updates can't download updates and event ID 16 is logged
description: Describes an issue where Automatic Updates can't download updates and event ID 16 is recorded in the system log.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, drewel
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Automatic Updates can't download updates and event ID 16 is logged

This article describes an issue where Automatic Updates can't download updates and event ID 16 is recorded in the system log.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 824208

## Symptoms

When Automatic Updates tries to download updates, the download doesn't succeed, and Event ID 16 is recorded in the system log.

## Cause

This behavior may occur if both of the following conditions are true:

- In your computer's Local Area Network (LAN) settings, the **Automatically detect settings** check box is selected.
- You can't ping the Web Proxy Auto-Discovery (WPAD) server by its Domain Name System (DNS) name. This behavior may occur if your computer's connection-specific DNS suffix doesn't match the DNS domain where the WPAD server's DNS entry is registered.

For your computer to automatically detect LAN settings, the WPAD server's DNS entry must be correctly configured, and a DNS query from your computer must successfully resolve the name `WPAD.mydomain.com`, where `mydomain.com` is the connection-specific DNS domain. If a DNS query from Automatic Updates can't resolve the name of the WPAD server, Automatic Updates can't use the WPAD server.

## Resolution

To resolve this behavior, make sure that the WPAD server's DNS entry is correctly configured, and make sure that your computer's connection-specific DNS suffix matches the DNS domain where the WPAD server's DNS entry is registered.

## Status

This behavior is by design.

## More information

If you use Dynamic Host Configuration Protocol (DHCP), you can configure the **015 DNS Domain Name** option on the DHCP server to set the connection-specific DNS suffix of the client computers. After you configure this option, you must release and then renew the DHCP lease on the client computers.

To configure your DHCP server to set the connection-specific DNS suffix for its client computers, follow these steps:

1. If you use a Windows 2000 Server-based computer as your DHCP server, click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **DHCP**.

    If you use a Windows XP-based computer as your DHCP server, click **Start,** click **Control Panel**, click **Performance and Maintenance**, click **Administrative Tools**, and then double-click **DHCP**.

    If you use a Windows Server 2003-based computer as your DHCP server, click **Start**, point to **Administrative Tools**, and then click **DHCP**.
2. Double-click the name of your server, right-click **Server Options**, and then click **Configure Options**.
3. In the **Available Options** list, click **015 DNS Domain Name**.
4. Under **Data entry**, in the **String value** box, type the connection-specific domain name that you want the client computers to use as their connection-specific DNS suffix.

    > [!NOTE]
    > The connection-specific domain name must match the domain where the WPAD server's DNS entry is registered--for example, **mydomain.com**.
5. Click **OK**.

To release and to renew the DHCP lease on the client computers, and to confirm that the computer can resolve the WPAD server name, follow these steps:

1. From the command prompt, type `ipconfig /release`, and then press ENTER.
2. Type `ipconfig /renew`, and then press ENTER.
3. Type `ping WPAD.mydomain.com`, where `mydomain.com` is the connection-specific DNS domain, and then press ENTER.

    > [!NOTE]
    > If the computer successfully resolves the name of the WPAD server, you see a series of messages that include the words "Reply from."

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
