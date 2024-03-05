---
title: Local Security Authority can't contact
description: Provides a solution to an error that occurs when you try to establish a remote desktop connection using RD client (mstsc.exe) to a Remote Desktop server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, deepku
ms.custom: sap:authentication, csstroubleshoot
---
# RDP connection to Remote Desktop server running Windows Server 2008 R2 may fail with message The Local Security Authority cannot be contacted

This article provides a solution to an error that occurs when you try to establish a remote desktop connection using RD client (mstsc.exe) to a Remote Desktop server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2493594

## Symptoms

When attempting to establish a remote desktop connection using RD client (mstsc.exe) to a Remote Desktop server that is running Windows Server 2008 R2, you may meet any of these messages:

> The connection cannot be completed because the remote computer that was reached is not the one you specified. This could be caused by an outdated entry in the DNS cache. Try using the IP address of the computer instead of the name.

Or

> An authentication error has occurred.  
The Local Security Authority cannot be contacted

## Cause

Generally this error message points to network congestions prohibiting a secure connection to the RD server. However, this error message may also appear if RD Server is configured for secure connections using TLS and TLS isn't supported at the client (source machine) attempting the Remote Desktop Protocol (RDP) connection.

## Resolution

Remote Desktop in Windows Server 2008 R2 offers three types of secure connections:

Negotiate: This security method uses Transport Layer Security (TLS) 1.0 to authenticate the server if TLS is supported. If TLS isn't supported, the server isn't authenticated.

RDP Security Layer: This security method uses Remote Desktop Protocol encryption to help secure communications between the client computer and the server. If you select this setting, the server isn't authenticated.

SSL (Secure Sockets Layer): This security method requires TLS 1.0 to authenticate the server. If TLS isn't supported, you can't establish a connection to the server. This method is only available if you select a valid certificate.

To resolve the issue, change the remote desktop security on the RD server to RDP Security Layer to allow a secure connection using Remote Desktop Protocol encryption. Below are the steps:

1. Navigate to **Start** > **Administrative Tools** > **Remote Desktop Services** > **Remote Desktop Session Host Configuration**.
2. With RD Session Host Configuration selected view under **Connections**.  
3. Right-click RDP Listener with connection type Microsoft RDP 6.1 and choose **Properties**.
4. In general tab of properties dialog box under **Security**, select **RDP Security Layer** as the Security Layer.
5. Select **OK**.

> [!NOTE]
> This setting doesn't need a restart of the Server or Remote Desktop Service.

## More information

You may also see Event ID 56 with source TermDD in the system event logs on the RD server for every unsuccessful RDP attempt.
