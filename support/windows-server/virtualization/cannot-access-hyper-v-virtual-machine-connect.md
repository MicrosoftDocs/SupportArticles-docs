---
title: Can't Access Hyper-V Virtual Machines Via VM Connect
description: Describes a
ms.date: 08/13/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-lianna
ms.custom:
- sap:virtualization and hyper-v\configuration of virtual machine settings
- pcy:WinComm Storage High Avail
---
# Unable to access Hyper-V virtual machines via VM Connect: "Local security authority cannot be contacted"

This article addresses an issue where users are unable to connect to Hyper-V virtual machines (VMs) through VM Connect due to a persistent authentication error. The root cause and resolution steps are provided to help restore functionality.

## Prerequisites

Before proceeding, ensure the following:

* Administrative access to the affected server.
* A working server with the correct TLS cryptography registry keys to export.
* Knowledge of registry editing and system reboot procedures.

## Symptoms

Users encountering this issue may experience the following:

* Persistent authentication error message: "Local security authority cannot be contacted."
* Inability to connect to any virtual machines, regardless of the operating system (Windows or Linux), via VM Connect.
* The issue began approximately 20 days before the case was logged.

## Cause

The problem is caused by missing TLS cryptography registry keys required for the SSL/TLS handshake. These keys are crucial for secure communication during the authentication process. Their absence leads to a failure in the SchannelInit process, which prevents authentication attempts from succeeding.

## Solution: Restore missing TLS cryptography registry keys

To resolve the issue, follow these steps:

1. **Export TLS cryptography registry keys from a working server:**

   * On a functioning server, open the Windows Registry Editor (regedit).
   * Navigate to the following registry path:

     HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\SCHANNEL\\Protocols

   * Right-click the Protocols key and select **Export**.
   * Save the exported .reg file to a secure location.

2. **Import the registry keys to the affected server:**

   * Transfer the exported .reg file to the affected server.
   * Open the Windows Registry Editor on the affected server.
   * Double-click the .reg file to import the keys. Follow the prompts to confirm the import.

3. **Reboot the server:**

   * Restart the affected server to apply the changes.

4. **Test the connection:**

   * Attempt to connect to the Hyper-V virtual machines using VM Connect to ensure the issue is resolved.

     By completing these steps, the missing TLS cryptography registry keys are restored, enabling the necessary SSL/TLS handshake and resolving the authentication error.

     ## Determine the cause of the problem

     If the issue persists after performing the solution steps, further investigation may be required to confirm if additional configuration settings or system updates are impacting the VM connection process.

     ## Cause 2: Other potential issues

     If the TLS cryptography keys are present and correctly configured, other potential causes, such as network configuration issues or outdated system components, should be examined.

### Solution 2: Verify network and system configurations

1. Check the server's network connectivity to ensure there are no interruptions.
2. Ensure all system updates and patches are applied to both the host and guest operating systems.
3. Review event logs for additional error messages that may provide insights into the issue.

     If further assistance is required, consider contacting Microsoft Support for advanced troubleshooting.
