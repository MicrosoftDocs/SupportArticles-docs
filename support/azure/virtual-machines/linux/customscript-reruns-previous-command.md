---
title: CustomScript reruns the previous command in Azure Linux
description: Discusses an issue in which the last command in the Azure Linux CustomScript extension reruns the previous command. Provides a workaround.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.custom: linux-related-content
ms.collection: linux
---
# The CustomScript extension reruns a command in Azure Linux

This article provides a workaround to an issue in which the last command in the Azure Linux CustomScript extension reruns the previous command.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4054277

## Symptoms

After update 2.0.5 is applied to Linux Microsoft.Azure.Extensions.CustomScript 2.0.x as an auto update, the previous command that was run by the extension is rerun.  

Virtual machines that have Microsoft.Azure.Extensions.CustomScript 2.0.x installed are susceptible to receive the 2.0.5 update. However, because virtual machines  do not receive minor updates immediately, this update requires a virtual machine model change.

To determine the script version, open the Azure portal, select the virtual machine, select **Extensions** > **Custom Script Extension**, and then select the extension to view its version properties.
You can also query for the full version information by running the following command at a command prompt:

```azurecli
az vm get-instance-view -g resourceGroupName -n vmName --query "instanceView.extensions[?type == 'Microsoft.Azure.Extensions.CustomScript']"
```

```
[
  {
    "name": "CustomScript",
    "statuses": [
      {
        "code": "ProvisioningState/succeeded",
        "displayStatus": "Provisioning succeeded",
        "level": "Info",
        "message": "Enable succeeded: \n[stdout]\nFri Nov 10 23:41:04 UTC 2017\n\n[stderr]\n",
        "time": null
      }
    ],
    "substatuses": null,
    "type": "Microsoft.Azure.Extensions.CustomScript",
    "typeHandlerVersion": "2.0.5"
  }
]
```

## Cause

This problem occurs because of an issue in the Microsoft.Azure.Extensions.CustomScript 2.0.5 extension. This is not the expected behavior of the upgrade.

## Workaround

If you use a version of CustomScript that is earlier than 2.0.5, you can avoid this unexpected behavior by uninstalling Linux Microsoft.Azure.Extensions.CustomScript.

## Status

A fix to resolve to the issue with CSE has been resolved in CustomScript 2.0.6 as an extension auto update.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
