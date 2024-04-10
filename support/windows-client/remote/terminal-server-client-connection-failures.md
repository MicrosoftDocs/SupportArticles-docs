---
title: Troubleshooting RDP Client connection problems
description: Describes various causes for Terminal Server Client connection failures.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Session connectivity, csstroubleshoot
---
# Troubleshooting RDP Client connection problems

This article describes various symptoms for Remote Desktop Client connection failures.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186645

## Summary

This article summarizes the various causes for Terminal Server Client connection failures.

## More information

Terminal Server Client (Remote Desktop Client) connection failures such as "Unable to RDP, "Remote Desktop Disconnected," or "Unable to Connect to Remote Desktop (Terminal server)" are common problems that we have seen in product support. This article summarizes the various causes for such failures.

The following are some of the commonly seen symptoms:

- You may be limited in the number of users who can connect simultaneously to a Remote Desktop session or Remote Desktop Services session.
- You may have a port assignment conflict.
- You may have an incorrectly configured Authentication and Encryption setting.
- You may have a certificate corruption.

All the steps are documented in these articles, based on the server operating system:

- Server 2003: [Remote Desktop disconnected or can't connect to remote computer or Remote Desktop server (Terminal Server) that is running Windows Server 2003](https://support.microsoft.com/help/2477023)  
- Server 2008: [General Remote Desktop connection troubleshooting](https://support.microsoft.com/help/2477133)  
- Server 2008 R2: [Troubleshoot "Remote desktop disconnected" errors in Windows Server 2008 R2](https://support.microsoft.com/help/2477176)  

Additionally, we have more symptoms documented in the following Microsoft TechNet article:  

[Troubleshooting General Remote Desktop Error messages](https://technet.microsoft.com/library/cc780927%28ws.10%29.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#remote-desktop-client-connection).
