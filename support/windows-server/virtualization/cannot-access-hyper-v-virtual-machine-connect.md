---
title: Can't Access Hyper-V Virtual Machines Via VMConnect
description: Addresses an issue where you can't connect to Hyper-V virtual machines (VMs) through Virtual Machine Connection (VMConnect) after you repeatedly receive an authentication error.
ms.date: 08/13/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-lianna
ms.custom:
- sap:virtualization and hyper-v\configuration of virtual machine settings
- pcy:WinComm Storage High Avail
---
# Can't access Hyper-V virtual machines via VMConnect

This article addresses an issue where you can't connect to Hyper-V virtual machines (VMs) through Virtual Machine Connection (VMConnect) after you repeatedly receive an authentication error.

> [!NOTE]
> Before proceeding with the following procedures in this article, ensure you have administrative access to the affected server. In addition, you have a working server with the correct Transport Layer Security (TLS) cryptography registry keys to export.

You repeatedly receive an authentication error message:

> Local security authority cannot be contacted.

After about 20 days, you can't connect to any virtual machines, regardless of the operating system (Windows or Linux), via VMConnect.

## Missing TLS cryptography registry keys

The issue is caused by missing TLS cryptography registry keys required for the TLS/Secure Sockets Layer (SSL) handshake. These keys are crucial for secure communication during the authentication process. Their absence leads to a failure in the secure channel initialization process, which prevents authentication attempts from succeeding.

## Restore missing TLS cryptography registry keys

[!INCLUDE [Registry alert](../../includes/registry-important-alert.md)]

To resolve the issue, follow these steps:

1. Export TLS cryptography registry keys from a working server:

   1. Open Windows Registry Editor (**regedit.exe**) on a working server, and go to the following registry path:

      `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`

   2. Right-click the `Protocols` key and select **Export**.
   3. Save the exported `.reg` file to a secure location.

2. Import the registry keys to the affected server:

   1. Transfer the exported `.reg` file to the affected server.
   2. Open the Registry Editor on the affected server, and double-click the `.reg` file to import the keys. Follow the prompts to confirm the import.

3. Restart the affected server to apply the changes.
4. Connect to the Hyper-V virtual machines using VMConnect to ensure the issue is resolved.

After you complete these steps, the missing TLS cryptography registry keys are restored, enabling the necessary TLS/SSL handshake and resolving the authentication error.

## Other potential causes

If the issue persists, further investigation might be required to confirm whether additional configuration settings or system updates are impacting the VM connection process. For example, network configuration issues or outdated system components should be examined.

You can verify the network and system configurations by using the following steps:

1. Check the server's network connectivity to ensure there are no interruptions.
2. Ensure all system updates and patches are applied to both the host and guest operating systems.
3. Review event logs for additional error messages that might provide insights into the issue.

If further assistance is required, consider contacting Microsoft Support for advanced troubleshooting.
