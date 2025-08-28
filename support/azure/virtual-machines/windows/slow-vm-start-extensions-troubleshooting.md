---
title: Slow Azure Virtual Machine Start operations caused by extensions being in a failed state
description: Troubleshooting guide for slow Azure Virtual Machine Start operations caused by the extensions being in a failed state.
ms.date: 08/28/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:Cannot start or stop my VM
---
# Slow Azure Virtual Machine Start operations caused by extensions being in a failed state

## Overview

You may experience slow Azure Virtual Machine (VM) **Start** or **Redeploy**
operations when one or more of the VM extensions are in a **Failed** state.
This article will cover possible causes and resolutions.

## Symptom

In this scenario, the VM's guest OS can be active and working and the
VM can connect successfully, but the operation is still appearing to run
in the Azure portal.

## Cause

VM extensions are software components that run inside the VM to enable
configuration management, security, monitoring, and other features. VM
extensions have a 90-minute provisioning timeout, which means they must
complete their installation or update within that time limit. If an
extension fails to provision within the timeout, it will be marked as
failed and will not be retried until the next VM operation that triggers
the extension, such as a **Start** or a **Redeploy**.

When a VM has one or more extensions in a failed state, it can cause
delays in other VM operations, such as **Start** or **Redeploy** because the Azure
platform will try to provision the failed extensions again before
completing the operation. This can result in the VMs showing a **Starting**
status for an extended period.

## Resolution

To mitigate this issue, you may follow these steps:

1. Review the extension status and logs for the VM to determine the
    root cause of the failure.

    - To check the status of the extensions installed on the VM, go to the
      VM Blade and select the **extensions + applications** option under
      **Settings** in the left-hand pane. If the status is not **Provisioning Succeeded**, the extension may need to be removed or further investigation may be required.

      :::image type="content" source="media/slow-vm-start-extensions-troubleshooting/extensions-applications-status.png" alt-text="Screenshot of the portal with the extenstions and applications statuses. Status is highlighted.":::

    - Logs for the extensions can be found within the Guest OS of the VM.
      See the [Further Troubleshooting section](#further-troubleshooting) for more information.

1. Check the status of the VM "Guest Agent", as it is responsible for
    handling the provisioning of extensions. If the "Guest Agent" is not
    in a ready state, it may need to be reviewed. For further guidance,
    refer to the documents mentioned in the [Further Troubleshooting section](#further-troubleshooting).

      :::image type="content" source="media/slow-vm-start-extensions-troubleshooting/agent-status-version.png" alt-text="Screenshot of the portal with the VM overview. Agent status and Agent version are highlighted.":::

1. Resolve the extension failure by either fixing the configuration or
    uninstalling the extension. You can use the Azure portal, PowerShell, CLI, or REST API to update or remove the extension. You may need to contact the extension publisher for support if the issue is related to the extension functionality or compatibility.

1. Stop then Start the VM to verify that the extension provisioning
    succeeds and the VM Start operation completes faster. You can use
    the Azure portal, PowerShell, CLI, or REST API to "Stop/Start" the
    VM.

## Further Troubleshooting

For more guidance on how to troubleshoot Azure VM guest agent and
extension issues, see:

- [Troubleshooting Windows VM extension failures](/azure/virtual-machines/extensions/troubleshoot)
- [Troubleshoot Azure Windows VM Agent issues](/azure/virtual-machines/windows-azure-guest-agent)
- [Troubleshoot the Azure Linux Agent](/azure/virtual-machines/linux-azure-guest-agent)
