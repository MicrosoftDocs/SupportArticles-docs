---
title: Incorrect TLS is displayed
description: Describes an issue in which SSL (TLS 1.0) is displayed as the Security Layer protocol instead of the actual TLS 1.2 protocol. A resolution is provided.
ms.date: 12/09/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
---
# Incorrect TLS is displayed when you use RDP with SSL encryption

This article provides a solution to an issue where SSL (TLS 1.0) is displayed as the Security Layer protocol instead of the actual TLS 1.2 protocol.

_Applies to:_ &nbsp; Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 3097192

## Symptoms

Consider the following scenario:

- You have a computer that's running Windows Server operating system.
- You have the Remote Desktop Connection Broker (RDCB) role configured on this computer.
- You try to secure the RDP connections to the target computers by using SSL encryption (Transport Layer Security (TLS)).

In this scenario, you may notice that the **Security Layer** list displays **SSL (TLS 1.0)**, even though it's actually using TLS 1.2:

:::image type="content" source="./media/incorrect-tls-use-rdp-with-ssl-encryption/ssl-tsl-1-in-configuration-security-setting.png" alt-text="The Security Layer shows SSL (TLS 1.0) in Configure security settings page.":::

You may also notice similar behavior when you try to configure the **Security Layer** settings by applying the following Group Policy setting:  

Require use of specific security layer for remote (RDP) connections  

:::image type="content" source="./media/incorrect-tls-use-rdp-with-ssl-encryption/configure-security-layer.png" alt-text="The Security Layer settings in the Require use of specific security layer for remote (RDP) connections dialog box.":::

You can find this setting in the following location:  

Computer Configuration\Policies\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Security

## Resolution

This issue is caused by a bug in the Windows Server GUIs. You can safely ignore the TLS version that's displayed in the GUI because this does not reflect the version of TLS that's being used for client connections.

## More information

The following required hotfix introduces support for TLS 1.2 on a Windows Server 2008 R2 Session Host server. This fix complies with recent PCI DSS security standards.

[3080079](https://support.microsoft.com/help/3080079) Update to add RDS support for TLS 1.1 and TLS 1.2 in Windows 7 or Windows Server 2008 R2

If the client machine is running Windows 7, it must have the RDC 8.0 update installed in order to use TLS 1.2. Without the RDC 8.0 update, the Windows 7 client can only use TLS 1.0.
