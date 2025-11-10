---
title: CMG Maintenance Task fails to update Public IP Resource after installing the Update Rollup for Microsoft Configuration Manager version 2503 (KB32851084)
description: CMG Maintenance Task fails to update Public IP Resource after installing the Update Rollup for Microsoft Configuration Manager version 2503 (KB32851084).
ms.date: 10/11/2025
ms.reviewer: kaushika, payur
author: Cloud-Writer
ms.author: dmarin
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG)
---
# CMG Maintenance Task fails to update Public IP Resource after installing the Update Rollup for Microsoft Configuration Manager version 2503 (KB32851084)

*Applies to*: Configuration Manager (current branch)

## Symptoms

After installing the [Update Rollup for Microsoft Configuration Manager version 2503 (KB32851084)](/intune/configmgr/hotfix/2503/32851084), CloudMgr.log on the Service Connection Point may display the error message resembling the following:

```output
Resource Manager - Creating Public IP Address <Name of CMG> with deployment CreatePublicIPAddressXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX~~
ERROR: Exception occured for service <Name of CMG> : System.AggregateException: One or more errors occurred.
---> Azure.RequestFailedException: At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.~~Status: 200 (OK)~~ErrorCode: DeploymentFailed~~~~Service request succeeded. Response content and headers are not included to avoid logging sensitive data.~~~~
at Azure.Core.OperationInternal`1.GetResponseFromState(OperationState`1 state)~~
at Azure.Core.OperationInternal`1.<UpdateStatusAsync>d__20.MoveNext()~~--- End of stack trace from previous location where exception was thrown ---~~
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()~~
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)~~
at Azure.Core.OperationInternalBase.<UpdateStatusAsync>d__13.MoveNext()~~--- End of stack trace from previous location where exception was thrown ---~~
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()~~
at Azure.Core.OperationPoller.<WaitForCompletionAsync>d__11.MoveNext()~~--- End of stack trace from previous location where exception was thrown ---~~
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()~~
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)~~
at Azure.Core.OperationInternalBase.<WaitForCompletionResponseAsync>d__19.MoveNext()~~--- End of stack trace from previous location where exception was thrown ---~~
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()~~
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)~~
at Azure.Core.OperationInternal`1.<WaitForCompletionAsync>d__19.MoveNext()~~--- End of stack trace from previous location where exception was thrown ---~~
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()~~
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)~~
at System.Threading.Tasks.ValueTask`1.get_Result()~~
at Azure.Core.OperationInternal`1.<WaitForCompletionAsync>d__15.MoveNext()~~--- End of stack trace from previous location where exception was thrown ---~~
at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()~~
at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)~~
at Azure.ResourceManager.Resources.ArmDeploymentCollection.<CreateOrUpdateAsync>d__4.MoveNext()~~
--- End of inner exception stack trace ---~~
at System.Threading.Tasks.Task`1.GetResultCore(Boolean waitCompletionNotification)~~
at Microsoft.ConfigurationManager.AzureManagement.ResourceManager.StartAndMonitorDeployment(String resourceGroupName, String deploymentName, ArmDeploymentContent deploymentContent, Int32 secondsToWait, Int32 timeoutInMinutes)~~
at Microsoft.ConfigurationManager.AzureManagement.Resource

TaskManager: Task [Deployment Maintenance for service <Name of CMG>] status is Faulted~~

ERROR: TaskManager: Task [Deployment Maintenance for service <Name of CMG>] has failed. Exception Azure.RequestFailedException, At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details.~~Status: 200 (OK)~~ErrorCode: DeploymentFailed~~~~Service request succeeded. Response content and headers are not included to avoid logging sensitive data.~~.~~

TaskManager: Scheduling task [Deployment Maintenance for service <Name of CMG>] for retry.~~
```

In the Azure portal, the Activity log of the Resource Group that contains the resources of the CMG displays the error message resembling the following:

```output
Operation Name:  Create or Update Public Ip Address

Summary - Message; Resource /subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/<Name of CMG Resource Group>/providers/Microsoft.Network/publicIPAddresses/<Name of Public IP Address> has an existing availability zone constraint 1, 2, 3 and the request has availability zone constraint NoZone, which do not match. Zones cannot be added/updated/removed once the resource is created. The resource cannot be updated from regional to zonal or vice-versa.
```

The Cloud Management Gateway (CMG) state in the Configuration Manager console may then appear in "Error" status with the detailed information "Failed to perform maintenance" in "Status Description" and flipping back to "Ready" shortly afterwards.

The error messages are likely to repeat every 20 mins aligning with the Deployment Maintenance Task retries.

## Cause

Once the Update Rollup is installed, it triggers a setup maintenance task for the CMG. This maintenance task launches deployments for CMG Resources in Azure. In the deployment associated to the Public IP Address, the maintenance task attempts to update its "Availability Zone" configuration property to **"No zone"**. If the existing Public IP resource already has "Availability Zone" property configured (for example, to "Zone 1", "Zone 2" or "Zone 3"), the deployment fails.

The issue then affects the Azure regions where [Availability Zones](/azure/reliability/availability-zones-overview?toc=%2Fazure%2Fvirtual-network%2Ftoc.json&tabs=azure-cli) are supported. The current list is available at [Azure regions list](/azure/reliability/regions-list#azure-regions-list-1).

Current Configuration Manager releases don't specify Availability Zone when creating a new Public IP Address Resource for CMG. Hence, this issue doesn't affect new CMG deployments.

## Resolution

At this point, there is no confirmed impact from this behavior. Hence, the recommended action is to ignore these errors.

Microsoft plans resolving this problem in the future release of Microsoft Configuration Manager.

## More information

For more information about CMG monitoring, see [Monitor the CMG](/intune/configmgr/core/clients/manage/cmg/monitor-clients-cloud-management-gateways) article.
