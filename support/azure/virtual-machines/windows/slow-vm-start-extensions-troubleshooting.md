---
title: Slow Azure Virtual Machine Start Operations Caused by Extensions in failed state
description: Troubleshooting guide for slow Azure Virtual Machine Start operations that are caused by the extensions being in a failed state.
ms.date: 09/02/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:Cannot start or stop my VM
---
# Slow Azure VM Start operations when extensions are "Failed"

[!INCLUDE [Feedback](../../../includes/vmassist-include.md)]

## Overview

You might experience slow Microsoft Azure Virtual Machine (VM) **Start** or **Redeploy** operations when one or more of the VM extensions are in a **Failed** state. This article discusses possible causes of this issue and resolutions.

## Symptoms

Although the Azure VM guest OS is active and working, and the VM can connect successfully, the operation still appears to run in the Azure portal.

## Cause

VM extensions are software components that run inside the VM to enable configuration management, security, monitoring, and other features. VM extensions have a 90-minute provisioning timeout. They must complete their installation or update within that time limit. If an extension doesn't provision within the timeout period, it's marked as failed. The extension isn't retried until the next VM operation that triggers it, such as **Start** or **Redeploy**.

If a VM has one or more extensions in a **Failed** state, delays can occur in other VM operations, such as **Start** or **Redeploy**. This issue occurs because the Azure platform tries to provision the failed extensions again before it completes the operation. Therefore, the VMs show a **Starting** status for an extended period.

## More information

To mitigate this issue, follow these steps:

1. To determine the root cause of the failure, review the extension status and logs for the VM.

   To check the status of the extensions that are installed on the VM, go to the VM blade, and then select the **extensions + applications** option under
      **Settings** in the left pane. If the status isn't **Provisioning Succeeded**, the extension might have to be removed or investigated further.

      :::image type="content" source="media/slow-vm-start-extensions-troubleshooting/extensions-applications-status.png" alt-text="Screenshot of the portal showing the extensions and applications statuses. Status is highlighted.":::

    - Logs for the extensions can be found within the Guest OS of the VM. For more information, see the [References section](#references).

1. Check the status of the VM "Guest Agent" that's responsible for provisioning the extensions. If the "Guest Agent" isn't in a ready state, a review might be required. For more guidance, refer to the documents that are mentioned in the [References section](#references).

      :::image type="content" source="media/slow-vm-start-extensions-troubleshooting/agent-status-version.png" alt-text="Screenshot of the portal showing the VM overview. Agent status and Agent version are highlighted.":::

1. Resolve the extension failure by either fixing the configuration or uninstalling the extension. You can use the Azure portal, PowerShell, CLI, or REST API to update or remove the extension. If the issue is related to the extension functionality or compatibility, you might have to contact the extension publisher for support.

1. Stop and then restart the VM to verify that the extension provisioning succeeds and the VM Start operation finishes faster. You can use the Azure portal, PowerShell, CLI, or REST API to do these operations.

## References

For more guidance to troubleshoot the Azure VM Guest Agent and extension issues, see:

- [Troubleshooting Azure Windows VM extension failures](/azure/virtual-machines/extensions/troubleshoot)
- [Troubleshoot Azure Windows VM Agent issues](windows-azure-guest-agent.md)
- [Troubleshoot the Azure Linux Agent](../linux/linux-azure-guest-agent.md)
