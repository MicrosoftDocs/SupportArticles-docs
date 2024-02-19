---
title: Configure Wi-Fi Sense and Paid Wi-Fi Services
description: Discusses the methods to configure Wi-Fi Sense and Paid Wi-Fi Services on Windows 10 Version 1607 computers that are deployed in an enterprise.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:wireless-networking-and-802.1x-authentication, csstroubleshoot
---
# How to configure Wi-Fi Sense and Paid Wi-Fi Services on Windows 10 in an enterprise

This article discusses the methods to configure Wi-Fi Sense and Paid Wi-Fi Services in Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3085719

## Summary

Wi-Fi Sense can automatically make Wi-Fi connections on your computer so that you can go online quickly in more locations. Wi-Fi Sense can connect you to open Wi-Fi hotspots that are collected through crowdsourcing, or to Wi-Fi networks that your contacts share with you through Wi-Fi Sense.

Paid Wi-Fi Services enable you to get online by buying Wi-Fi at the hotspot through Microsoft Store. Windows will temporarily connect to open hotspots to see if paid Wi-Fi services are available.

## More information

To disable Wi-Fi Sense and Paid Wi-Fi Services on computers in the enterprise, use the following methods, as appropriate for your device management process:

[Configuring through the Windows Provisioning framework](https://msdn.microsoft.com/library/windows/hardware/mt219718%28v=vs.85%29.aspx)

[Configuring through legacy Unattended Windows setup (if the enterprises use unattended setup for provisioning)](https://msdn.microsoft.com/library/windows/hardware/mt186511%28v=vs.85%29.aspx)

IT administrators can also use Group Policy to disable Wi-Fi Sense and Paid Wi-Fi Services.

### For Windows 10 Version 1511 or later versions of Windows

Configure the Group Policy Object **Allow Windows to automatically connect to suggested open hotspots, to networks shared by contacts, and to hotspots offering paid services** under **Computer Configuration\\Administrative Templates\\Network\\WLAN Service\\WLAN Settings\\**.

### For earlier versions of Windows than Windows 10 Version 1511

Configure the Group Policy to create and set the following DWORD registry value to **0** to disable Wi-Fi Sense:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config\AutoConnectAllowedOEM`

> [!NOTE]
> If you use Group Policy to disable Wi-Fi Sense, this also disables the following related Wi-Fi Sense features:

- Connect automatically to open hotspots
- Connect automatically to networks shared by my contacts
- Allow me to select networks to share my contacts

More information is available on TechNet: [Registry Extension](https://technet.microsoft.com/library/cc771589.aspx).
