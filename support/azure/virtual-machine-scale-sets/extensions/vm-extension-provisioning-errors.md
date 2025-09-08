---
title: VM extension provisioning errors in Virtual Machine Scale Sets
description: Steps to resolve VM extension provisioning errors in a Virtual Machine Scale Set.
ms.date: 07/16/2021
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: azure-virtual-machine-scale-sets
ms.custom: sap:Extensions not operating correctly
---

# VM extension provisioning errors in Virtual Machine Scale Sets

This article provides guidance on resolving **VMExtensionProvisioningError**, **VMExtensionHandlerNonTransientError**, or **VMExtensionProvisioningTimeout** errors that appear when you attempt to deploy, update, reimage, start, or scale a Virtual Machine Scale Set.

> [!NOTE]
> In the context of Virtual Machine Scale Sets, the "VM" in these errors messages refers to an instance within a specific Virtual Machine Scale Set.

## Symptoms

You see **VMExtensionProvisioningError**, **VMExtensionHandlerNonTransientError**, or **VMExtensionProvisioningTimeout** errors, as in the following examples:

> `'statusMessage': '{\\'status\\':\\'Failed\\',\\'error\\':{\\'code\\':\\'ResourceOperationFailure\\',\\'message\\':\\'The resource operation completed with terminal provisioning state 'Failed'.\\',\\'details\\':[{\\'code\\':\\'VMExtensionProvisioningError\\',\\'message\\':\\'Multiple VM extensions failed to be provisioned on the VM. Please see the VM extension instance view for other failures.`

> `{'status': 'Failed','error': {'code':'VMExtensionHandlerNonTransientError','message': 'The handler for VM extension type 'Microsoft.EnterpriseCloud.Monitoring.OmsAgentForLinux' has reported terminal failure for VM extension 'OmsAgentForLinux' with error message: '[ExtensionOperationError] Non-zero exit code: 10`

> `'statusMessage': '{\\'status\\':\\'Failed\\',\\'error\\':{\\'code\\':\\'ResourceOperationFailure\\',\\'message\\':\\'The resource operation completed with terminal provisioning state 'Failed'.\\',\\'details\\':[{\\'code\\':\\'VMExtensionProvisioningTimeout\\',\\'message\\':\\'Provisioning of VM extension configure-settings has timed out. Extension provisioning has taken too long to complete.`

## Cause

A VM extension is hanging or has failed during the provisioning state.

## Get more information about extension failure

To begin resolving this error, you should first determine which extension(s) and instance(s) are affected. To do so, run the following Azure command-line interface (Azure CLI) command:

```azurecli-interactive
az vmss list-instances --resource-group MyResourceGroup --name MyVmss --query "[].{instanceId:instanceId, extension:resources[].id, extProvisioningState:resources[].provisioningState}"
```

The output of this command will display the provisioning states of the extensions on each instance. The following example output shows how this extension information is grouped by instance ID.

:::image type="content" source="media/vm-extension-provisioning-errors/provisioning-states-instances.png" alt-text="Screenshot of output with instance IDs highlighted." border="false":::

Within each section dedicated to a particular instance, the "extProvisioningState" list at the top displays the provisioning states of the extensions installed on that instance.  This list is followed by the "extension" list, which displays the names of the extensions in same corresponding order.

For example, in the following example output, the first provisioning state in this instance, "Failed," corresponds to the first extension, "customScript." By matching the provisioning states to the extensions listed, you can also determine that in this example, the second and third extensions listed were successfully provisioned on the same instance.

:::image type="content" source="media/vm-extension-provisioning-errors/provisioning-states-extensions-matched.png" alt-text="Screenshot of output showing the provisioning state and matched extension names." border="false":::

## Attempt to scale out the Virtual Machine Scale Set

If the extension has not failed on every instance, add new instances to the Virtual Machine Scale Set and see if the extension provisioning succeeds. If it succeeds, delete the instances on which the extension provisioning has failed.

## Read logs on impacted instances

To gain further insight into the cause of the error, sign in to the affected instances. Depending on the OS of the Virtual Machine Scale Set and the impacted extension, navigate to the appropriate logs and review the impacted time frame:

- **Windows Virtual Machine Scale Sets**: *C:\WindowsAzure\logs\plugins\ExtensionName\Extension.log*
- **Linux Virtual Machine Scale Sets**: */var/log/plugins/ExtensionName/Extension.log*

## Verify that the failed extension is following best practices

If the extension is customizable, such as Custom Script Extension (CSE) or Desired State Configuration (DSC), verify that you are following all necessary pre-requisites and recommended best practices.

- [Custom Script Extension Best Practices](/azure/virtual-machines/extensions/custom-script-windows#tips-and-tricks)
- [Desired State Configuration Prerequisites](/azure/virtual-machines/extensions/dsc-overview)

## Reinstall the extension

1. On the **Extensions** blade of the Virtual Machine Scale Set, select the extension with the provisioning errors.
1. Click **Uninstall**.

   :::image type="content" source="media/vm-extension-provisioning-errors/uninstall-extension.png" alt-text="Screenshot of extensions blade with the uninstall button highlighted":::

1. On the **Extensions** blade, click **Add**.
1. Select and re-install the same extension.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
