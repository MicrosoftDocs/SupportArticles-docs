---
title: Troubleshoot issues in Global Secure Access client for Windows
description: Learn how to troubleshoot issues that can occur when you use the Global Secure Access client for Windows.
ms.date: 01/08/2025
author: Abizerh
ms.author: abizerh
editor: v-jsitser
ms.reviewer: tdetzner, pudwivedi, joflore, shacharrozin, azureidcic, v-leedennis
ms.service: entra-id
ms.custom: sap:Private Access
---
# Troubleshoot issues in the Global Secure Access client for Windows

The [Global Secure Access client](/entra/global-secure-access/how-to-install-windows-client) is deployed on a managed Microsoft Windows device (that is, a Microsoft Entra hybrid join device or a Microsoft Entra joined device). It enables an organization to control network traffic between these devices and various websites, applications, and resources that are available on the internet or intranet (on-premises corporate network). If you use this method to route traffic, you can enforce more checks and controls, such as continuous access evaluation (CAE), device compliance, and multi-factor authentication, to be applied for resource access.

:::image type="content" source="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-architecture.png" alt-text="Diagram of traffic routing from the Global Secure Access client to internet or intranet access over Microsoft Entra." border="false" lightbox="./media/troubleshoot-global-secure-access-client-windows-issues/global-secure-access-architecture.png":::

## Installation

You can use the following methods to install the Global Secure Access client on a managed Windows device:

- Download and install on a Windows device as a local administrator.

- Deploy through Active Directory Domain Services (AD DS) Group Policy for a Microsoft Entra hybrid join device.

- Deploy through Intune or other MDM service for a Microsoft Entra hybrid join or Microsoft Entra joined device.

If you experience a failure when you try to install the Global Secure Access client, check the following items:

- [Prerequisites for the Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client#prerequisites)

- Errors in the Global Secure Access client logs (*C:\\Users\\\<username>\\AppData\\Local\\Temp\\Global_Secure_Access_Client_\<number>.log*)

- Application and system event logs for any other errors, such as a process failure

If you experience issues when you try to upgrade a client, try to first uninstall the earlier client version, and then restart the device before you try again to install.

## For troubleshooting issues in the Global Secure Access client after the installation is successful, you can use the following self-service diagnostic tools:

- [**Troubleshoot the Global Secure Access client: advanced diagnostics**](/entra/global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics)
- [**Troubleshoot the Global Secure Access client: Health check tab**](/entra/global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check)


### Review the event logs

The Global Secure Access client has detailed event log support. To view the logs, follow these steps:

1. Select **Start**, and search for and select **Event Viewer**.
1. In the console tree of the Event Viewer window, expand **Application and Services logs** > **Microsoft** > **Windows** > **Microsoft Global Secure Access Client**.
1. In the **Microsoft Global Secure Access Client** node, select the **Operational** log. Within this log, you can find events that belong to the following categories:

   - Connection handling and errors
   - Authentication handling and errors

1. In the **Microsoft Global Secure Access Client** node, select the **Debug** log. This log contains events that belong to the following categories:

   - Detailed traffic flow handling
   - Traffic that is acquired or isn't acquired

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[limitations]: /entra/global-secure-access/how-to-install-windows-client#known-limitations
[meac]: https://entra.microsoft.com
