---
title: Enable and disable the Azure Serial Console
description: How to enable and disable the Azure Serial Console service
services: virtual-machines
documentationcenter: ''
author: genlin
manager: dcscontentpm
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-troubleshooting-tools
ms.topic: article
ms.tgt_pltfrm: vm
ms.workload: infrastructure-services
ms.date: 08/20/2019
ms.author: genli
---

# Enable and disable the Azure Serial Console

Just like any other resource, the Azure Serial Console can be enabled and disabled. Serial Console is enabled by default for all subscriptions in global Azure. Currently, disabling Serial Console will disable the service for your entire subscription. Disabling or re-enabling Serial Console for a subscription requires contributor-level access or above on the subscription.

You can also disable Serial Console for an individual VM or virtual machine scale set instance by disabling boot diagnostics. You will need contributor-level access or above on both the VM/virtual machine scale set and your boot diagnostics storage account.

## VM-level disable

The serial console can be disabled for a specific VM or virtual machine scale set by disabling the boot diagnostics setting. Turn off boot diagnostics from the Azure portal to disable the serial console for the VM or the virtual machine scale set. If you are using Serial Console on a virtual machine scale set, ensure you upgrade your virtual machine scale set instances to the latest model.

## Subscription-level enable/disable

> [!NOTE]
> Ensure you are in the right cloud (Azure Public Cloud, Azure US Government Cloud, and so on) before running this command. You can check with `az cloud list` and set your cloud with `az cloud set -n <Name of cloud>`.

### Azure CLI

Serial Console can be disabled and re-enabled for an entire subscription by using the following commands in the Azure CLI (you may use the "Try it" button to launch an instance of the Azure Cloud Shell in which you can run the commands):

To disable Serial Console for a subscription, use the following commands:

```azurecli-interactive
$subscriptionId=$(az account show --output=json | jq -r .id)

az resource invoke-action --action disableConsole --ids "/subscriptions/$subscriptionId/providers/Microsoft.SerialConsole/consoleServices/default" --api-version="2018-05-01"
```

To enable Serial Console for a subscription, use the following commands:

```azurecli-interactive
$subscriptionId=$(az account show --output=json | jq -r .id)

az resource invoke-action --action enableConsole --ids "/subscriptions/$subscriptionId/providers/Microsoft.SerialConsole/consoleServices/default" --api-version="2018-05-01"
```

To get the current enabled/disabled status of Serial Console for a subscription, use the following commands:

```azurecli-interactive
$subscriptionId=$(az account show --output=json | jq -r .id)

az resource show --ids "/subscriptions/$subscriptionId/providers/Microsoft.SerialConsole/consoleServices/default" --output=json --api-version="2018-05-01" | jq .properties
```

### PowerShell

Serial Console can also be enabled and disabled using PowerShell.

To disable Serial Console for a subscription, use the following commands:

```azurepowershell-interactive
$subscription=(Get-AzContext).Subscription.Id

Invoke-AzResourceAction -Action disableConsole -ResourceId /subscriptions/$subscription/providers/Microsoft.SerialConsole/consoleServices/default -ApiVersion 2018-05-01
```

To enable Serial Console for a subscription, use the following commands:

```azurepowershell-interactive
$subscription=(Get-AzContext).Subscription.Id

Invoke-AzResourceAction -Action enableConsole -ResourceId /subscriptions/$subscription/providers/Microsoft.SerialConsole/consoleServices/default -ApiVersion 2018-05-01
```

## Enabling least privilege access to Serial console using RBAC

To enable least privilege access to Serial Console, you need to create an Azure role with the required permissions that has rights to the virtual machine's (the virtual machine you need to access Serial Console on) resource group or the subscription the VM is in. You can assign this Azure role to users that need to access Serial Console.

The role you create will need the following Azure Actions permissions:

```Actions
"Microsoft.Compute/virtualMachines/start/action",
"Microsoft.Compute/virtualMachines/read",
"Microsoft.Compute/virtualMachines/write",
"Microsoft.Resources/subscriptions/resourceGroups/read",
"Microsoft.Storage/storageAccounts/listKeys/action",
"Microsoft.Storage/storageAccounts/read",
"Microsoft.SerialConsole/serialPorts/connect/action"
```

The table below explains what each Azure action does:

| Azure Action | Description  |
|---|---|
| "Microsoft.Compute/virtualMachines/start/action" | Starts the virtual machine |
| "Microsoft.Compute/virtualMachines/read" | Get the properties of a virtual machine |
| "Microsoft.Compute/virtualMachines/write" | Creates a new virtual machine or updates an existing virtual machine |
| "Microsoft.Resources/subscriptions/resourceGroups/read | Gets or lists resource groups |
| "Microsoft.Storage/storageAccounts/listKeys/action" | Returns the access keys for the specified storage account
| "Microsoft.Storage/storageAccounts/read" | Returns the list of storage accounts or gets the properties for the specified storage account |
| "Microsoft.SerialConsole/serialPorts/connect/action" | Connect to a serial port |

The JSON below can be used to define a custom role with least privilege access to VMs in a subscription and VMs in a resource group in a subscription.

If you'd like to only assign access to VMs in a resource group, then delete the first value ` "/subscriptions/<subscriptionID>/"` in the `assignableScopes` property below.

If you'd like to assign access to VMs in a subscription, then delete the second value ` "/subscriptions/<subscriptionID>/resourceGroups/<resourceGroup>"` in the `assignableScopes` property below.

```json
"properties": {
    "roleName": "Azure Serial Console Access Role",
    "description": "Serial Console access with least privilege.",
    "assignableScopes": [
        "/subscriptions/<subscriptionID>/"
        "/subscriptions/<subscriptionID>/resourceGroups/<resourceGroup>"
    ],
    "permissions": [
        {
            "actions": [
                "Microsoft.Compute/virtualMachines/start/action",
                "Microsoft.Compute/virtualMachines/read",
                "Microsoft.Compute/virtualMachines/write",
                "Microsoft.Resources/subscriptions/resourceGroups/read",
                "Microsoft.Storage/storageAccounts/listKeys/action",
                "Microsoft.Storage/storageAccounts/read",
                "Microsoft.SerialConsole/serialPorts/connect/action"
            ],
            "notActions": [],
            "dataActions": [],
            "notDataActions": []
        }
    ]
}
```

For instructions on how to use the Azure portal to create a custom role for least privilege access to Serial console, read the following documentation [Create or update Azure custom roles using the Azure portal
](/azure/role-based-access-control/custom-roles-portal).

For [Step 1: Determine the permissions you need](/azure/role-based-access-control/custom-roles-portal#step-1-determine-the-permissions-you-need), the permissions you need for the role are the Azure actions shown above.

For [Step 5: Assignable scopes](/azure/role-based-access-control/custom-roles-portal#step-5-assignable-scopes), set the scope to be the VM's resource group if you only want the user with the role to have access to a particular VM's Serial Console. You can also set the scope to be the subscription if you want the user to have Serial Console access to any VM in the subscription.

For instructions on how to use the Azure portal to assign roles, read the following documentation [Assign Azure roles using the Azure portal
](/azure/role-based-access-control/role-assignments-portal?tabs=current).


## Next steps

* Learn more about the [Azure Serial Console for Linux VMs](../virtual-machines/linux/serial-console-linux.md)
* Learn more about the [Azure Serial Console for Windows VMs](./serial-console-windows.md)
* Learn about [power management options within the Azure Serial Console](./serial-console-power-options.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
