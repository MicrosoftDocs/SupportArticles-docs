---
title: Azure Virtual Machine Scale Sets instances aren't repaired
description: Provides solutions for an issue where Azure Virtual Machine Scale Sets instances aren't repaired even when the automatic repairs policy is enabled.
ms.date: 12/05/2022
author: AmandaAZ
ms.author: v-weizhu
ms.reviewer: hilarywang, azurevmlnxcic, azurevmcptcic
ms.service: virtual-machine-scale-sets
---
# Azure Virtual Machine Scale Sets instances aren't repaired even when automatic repairs policy is enabled

This article provides solutions for an issue where Azure Virtual Machine Scale Sets (VMSS) instances aren't repaired even when the automatic repairs policy is enabled.

## Symptoms

Azure VMSS instances remain in an "Unhealthy" state and aren't repaired even when the automatic repairs policy is enabled.

## Cause 1：Automatic repairs policy isn't correctly enabled in the scale set

You can confirm that your VMSS is opted into automatic instance repairs by [viewing its service state](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#viewing-and-updating-the-service-state-of-automatic-instance-repairs-policy). Under the `orchestrationServices` property, if the `serviceState` for automatic repairs is "Running", your VMSS is opted into automatic instance repairs.

## Resolution 1: Enable automatic repairs in the scale set

If the `serviceState` is "NotRunning" or the automatic repairs policy doesn't show up under the `orchestrationServices` property, you must enable the automatic repairs policy in your scale set. For more information, see [Enabling automatic repairs policy when updating an existing scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#enabling-automatic-repairs-policy-when-updating-an-existing-scale-set).

If the `serviceState` is "Suspended", see [Resolution 4].

## Cause 2: Health monitoring isn't correctly configured in the scale set

If all the instances in your scale set are showing up as "Unhealthy", it could be a sign that your health monitoring probe isn't configured correctly during setup. Make sure that your application is emitting the expected HTTP/HTTPS/TCP responses to the configured endpoints.

## Resolution 2: Ensure expected HTTP/HTTPS/TCP responses are sent to configured endpoints

In order to achieve a "Healthy" status, the application health extension or load balancer health probes require at minimum a 2xx HTTP(S) response or a successful TCP handshake from your application at the configured endpoint. If the expected response isn't received, an "Unhealthy" status will be reported. Make sure that the correct health signals are emitted by your application to the provided endpoint.

For more information about the expected TCP/HTTP(S) responses for load balancer health probes, see [Load Balancer Custom Probes](/azure/load-balancer/load-balancer-custom-probe-overview#tcp-probe).

For more information about the expected TCP/HTTP(S) responses for application health extension probes, see the "Configure endpoint to provide health status" section in [Requirements for using automatic instance repairs](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#requirements-for-using-automatic-instance-repairs).

## Cause 3: Instance is marked unhealthy due to provisioning failure

Use [Get Instance View](/rest/api/compute/virtual-machine-scale-sets/get-instance-view?tabs=HTTP) with API version 2019-12-01 or higher for the VMSS to view the provisioning state of your instances under `statusesSummary` from the `virtualMachine` property.

### REST API

```http
GET '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/instanceView?api-version=2019-12-01'
```

```json
"virtualMachine": {
        "statusesSummary": [
            {
                "code": "ProvisioningState/succeeded",
                "count": 2
            }
        ]
}
```

## Resolution 3: Delete failed instance and add a new instance to the scale set

If you have a "ProvisioningState/failed" code under `statusesSummary`, delete the failed instance and add a new instance to your scale set. [Instance repairs currently doesn't support scenarios where a virtual machine is marked "Unhealthy" due to a provisioning failure](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#requirements-for-using-automatic-instance-repairs).

To remove the failed instance from your scale set, see [Remove VMs from a scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-powershell#remove-vms-from-a-scale-set).

To add a new instance to your scale set, see [Change the capacity of a scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-powershell#change-the-capacity-of-a-scale-set).

## Cause 4: Automatic repairs have been suspended in the scale set due to too many failed repairs

If your application continues to emit an "Unhealthy" signal after repeated repair attempts, the platform will eventually suspend instance repairs as a safety measure by changing the `serviceState` for automatic repairs to "Suspended". You can confirm the `serviceState` of your automatic repairs policy at [Viewing and updating the service state of automatic instance repairs policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#viewing-and-updating-the-service-state-of-automatic-instance-repairs-policy).

## Resolution 4: Resume automatic repairs by updating serviceState back to "Running"

If your serviceState is "Suspended", you can resume automatic repairs by updating the serviceState back to "Running" using the `setOrchestrationServiceState` API and cmdlet examples at [Viewing and updating the service state of automatic instance repairs policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#viewing-and-updating-the-service-state-of-automatic-instance-repairs-policy).

## Cause 5: Instance is in its grace period

If none of the causes above are applicable to your issue, your instance could be in grace period.

## Resolution 5：Set grace period

The grace period is the number of time automatic repairs will wait after any state change on the instance before performing repairs, which helps avoid any premature or accidental repairs. The repair action should happen once the grace period is completed for the instance. For more information on the grace period setting for automatic repairs, see [Grace Period](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#grace-period).

## Next steps

If you don't see your problem or can't resolve your issue, try one of the following channels for more support.

- Get answers from Azure experts through [Azure Forums](https://azure.microsoft.com/support/forums/).
- Connect with [@AzureSupport](https://twitter.com/azuresupport), the official Microsoft Azure account for improving customer experience.
- File an Azure support incident. Go to the [Azure support site](https://azure.microsoft.com/support/options/) and select Get Support.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
