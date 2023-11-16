---
title: Azure Virtual Machine Scale Set instances aren't repaired
description: Provides solutions for an issue where Azure Virtual Machine Scale Set instances aren't repaired even when the automatic repairs policy is enabled.
ms.date: 12/05/2022
ms.reviewer: hilarywang, azurevmlnxcic, azurevmcptcic, v-weizhu
ms.service: virtual-machine-scale-sets
ms.subservice: troubleshoot-compute-health
---
# Azure Virtual Machine Scale Set instances aren't repaired even when the automatic repairs policy is enabled

Azure VMSS instances remain in an "Unhealthy" state and aren't repaired even when the automatic repairs policy is enabled. This article provides possible causes and corresponding solutions for this issue:

- [Automatic repairs policy isn't correctly enabled in the scale set](#automatic-repairs-not-enabled).
- [Health monitoring isn't correctly configured in the scale set](#health-monitoring-not-configured).
- [The instance is marked unhealthy due to a provisioning failure](#instance-marked-unhealthy).
- [Automatic repairs have been suspended in the scale set due to too many failed repairs](#automatic-repairs-suspended).
- [The instance is in its grace period](#instance-in-grace-period).

## <a id="automatic-repairs-not-enabled"></a>Automatic repairs policy isn't correctly enabled in the scale set

Confirm that your VMSS is opted into automatic repairs by [viewing its service state](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#viewing-and-updating-the-service-state-of-automatic-instance-repairs-policy).

Under the `orchestrationServices` property, if the `serviceState` for automatic repairs is `Running`, the VMSS is opted into automatic repairs.

If the `serviceState` is `NotRunning` or the automatic repairs policy doesn't show up under the `orchestrationServices` property, you must enable the automatic repairs policy in the scale set. For more information, see [Enabling automatic repairs policy when updating an existing scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#enabling-automatic-repairs-policy-when-updating-an-existing-scale-set).

If the `serviceState` is `Suspended`, go to [Automatic repairs have been suspended in the scale set due to too many failed repairs](#automatic-repairs-suspended).

## <a id="health-monitoring-not-configured"></a>Health monitoring isn't correctly configured in the scale set

If all the instances in the scale set show up as "Unhealthy", it could be a sign that your health monitoring probe isn't configured correctly during setup. Make sure that your application emits the expected HTTP/HTTPS/TCP responses to the configured endpoints.

In order to achieve a "Healthy" status, the application health extension probes or load balancer health probes require, at minimum, a 2xx HTTP(S) response or a successful TCP handshake from your application at the configured endpoint. If the expected response isn't received, an "Unhealthy" status will be reported. Make sure that the correct health signals are emitted by your application to the provided endpoint.

For more information about the expected TCP/HTTP(S) responses for load balancer health probes, see [Load Balancer Custom Probes](/azure/load-balancer/load-balancer-custom-probe-overview#tcp-probe).

For more information about the expected TCP/HTTP(S) responses for application health extension probes, see the "Configure endpoint to provide health status" section in [Requirements for using automatic instance repairs](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#requirements-for-using-automatic-instance-repairs).

## <a id="instance-marked-unhealthy"></a>The instance is marked unhealthy due to a provisioning failure

Use [Get Instance View](/rest/api/compute/virtual-machine-scale-sets/get-instance-view?tabs=HTTP) with the API version 2019-12-01 or higher for the VMSS to view the provisioning state of the instances under `statusesSummary` from the `virtualMachine` property.

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

If you have a `ProvisioningState/failed` code under `statusesSummary`, delete the failed instance and add a new instance to your scale set. [Instance repairs currently doesn't support scenarios where a virtual machine is marked "Unhealthy" due to a provisioning failure](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#requirements-for-using-automatic-instance-repairs).

To remove the failed instance from your scale set, see [Remove VMs from a scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-powershell#remove-vms-from-a-scale-set).

To add a new instance to your scale set, see [Change the capacity of a scale set](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-manage-powershell#change-the-capacity-of-a-scale-set).

## <a id="automatic-repairs-suspended"></a>Automatic repairs have been suspended in the scale set due to too many failed repairs

If your application continues to emit an "Unhealthy" signal after repeated repair attempts, the platform will eventually suspend instance repairs as a safety measure by changing the `serviceState` for automatic repairs to `Suspended`.

Confirm the `serviceState` of your automatic repairs policy. To do this, see [Viewing and updating the service state of automatic instance repairs policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#viewing-and-updating-the-service-state-of-automatic-instance-repairs-policy).

If the `serviceState` is `Suspended`, resume automatic repairs by updating the `serviceState` back to `Running` by using the `setOrchestrationServiceState` API and cmdlet examples in [Viewing and updating the service state of automatic instance repairs policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#viewing-and-updating-the-service-state-of-automatic-instance-repairs-policy).

## <a id="instance-in-grace-period"></a>The instance is in its grace period

If none of the causes above are applicable to the issue, the instance could be in its grace period.

The grace period is the amount of time automatic repairs will wait after any state change on the instance before performing repairs, which helps avoid any premature or accidental repairs. The repair action should happen once the grace period is completed for the instance. For more information on the grace period setting for automatic repairs, see [Grace Period](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-instance-repairs#grace-period).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
