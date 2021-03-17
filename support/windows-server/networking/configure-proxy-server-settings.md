---
title: Configure proxy server settings
description: Describes how to configure proxy server settings in Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: TCP/IP communications
ms.technology: networking
---
# Configure proxy server settings in Windows

This article describes how to configure proxy server settings in Windows.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2777643

> [!NOTE]
> Home users: This article is intended for use by support agents and IT professionals. If you're looking for more information about how to configure a proxy on a home computer, please see the following article:  
>
> [How to reset your Internet Explorer proxy settings](https://support.microsoft.com/help/2289942)  

## Summary

Several methods are available to configure Windows to use a proxy server to connect to the Internet. The method that will work the best for you depends on the kinds of apps that you're using.

### How to configure proxy server settings through Web Proxy Auto-Discovery Protocol (WPAD)

We recommend that you use WPAD to configure Windows to use an Internet proxy server. The configuration is performed through DNS or DHCP. It requires no settings on client computers. It means that users can bring computers and devices from home or other locations, and automatically discover the Internet proxy server configuration.

### How to configure proxy server settings in Internet Explorer or by using Group Policy

If you prefer to statically configure client computers with their Internet proxy server settings, you can manually configure the settings in Internet Explorer or configure domain-joined computers by using Group Policy. Applications that do not obtain their proxy settings from Internet Explorer may have to have settings within each app to configure proxy settings.

### Proxy Auto Configuration (PAC) files/Automatic Configuration Script

Proxy Auto Configuration (PAC) file settings can also be manually configured in Internet Explorer or by using Group Policy. When you use Microsoft Store apps, the kind of app determines whether proxy settings that are obtained from PAC files are used. Additionally, the app may have to have settings to configure proxy settings.

### Proxy/Firewall client software

Proxy/Firewall client software is specific to the brand of proxy server that you are using. Microsoft Forefront Threat Management Gateway (TMG) 2010 is an example of a proxy server that can use client software to control proxy settings. Proxy/Firewall client software that is installed as an LSP driver will not work in Windows with any Modern/Microsoft Store apps but will work with standard apps. Proxy/Firewall client software that's installed as a WFP driver will work with Windows in all apps. You should contact the proxy server manufacturer if you have other questions about how to use the manufacturer's client software together with Windows.

> [!NOTE]
> The TMG/ISA firewall client tool is LSP based and will not work with Modern/Microsoft Store apps.

### Command-line setting

You can also configure proxy server settings by using the `netsh winhttp set proxy` command. This option is recommended only for testing, because it isn't easy to deploy. The command must be executed at a command prompt by using Administrative credentials. We don't recommend this option for mobile computers. The reason is most users can't change this setting when they connect to a different network.

## More information

For more information about how to use WPAD, see the following articles:  
[Configuring Web proxy clients to automatically detect a Forefront TMG server](https://technet.microsoft.com/library/cc995139)  
[Automatic Detection](https://technet.microsoft.com/library/gg699445.aspx)  

For more information about how to configure proxy server settings by using Group Policy, see the following articles:  
[Internet Explorer Maintenance Extension Tools and Settings](https://technet.microsoft.com/library/cc736412.aspx)
