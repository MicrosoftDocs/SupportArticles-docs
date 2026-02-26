---
title: CMG Maintenance Task Fails to Update After Installing KB32851084
description: Troubleshoot the CMG Maintenance Task failure caused by Availability Zone conflicts in Public IP Resource updates for Configuration Manager version 2503.
ms.service: configuration-manager
ms.topic: troubleshooting
ms.manager: dcscontentpm
audience: itpro
ms.date: 11/11/2025
ms.reviewer: kaushika, payur
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG)
---
# CMG maintenance task fails to update public IP resource after installing KB32851084

*Applies to*: Configuration Manager (current branch)

## Symptoms

After you install the [Update Rollup for Microsoft Configuration Manager version 2503 (KB32851084)](/intune/configmgr/hotfix/2503/32851084), CloudMgr.log on the Service Connection Point might display the following error message:

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

In the Azure portal, the Activity log of the Resource Group that contains the resources of the CMG displays the following error message:

```output
Operation Name: Create or Update Public Ip Address

Summary - Message; Resource /subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/<Name of CMG Resource Group>/providers/Microsoft.Network/publicIPAddresses/<Name of Public IP Address> has an existing availability zone constraint 1, 2, 3 and the request has availability zone constraint NoZone, which do not match. Zones cannot be added/updated/removed once the resource is created. The resource cannot be updated from regional to zonal or vice-versa.
```

The Cloud Management Gateway (CMG) state in the Configuration Manager console might then appear in "Error" status with the detailed information "Failed to perform maintenance" in "Status Description" and flipping back to "Ready" shortly afterwards.

The error messages likely repeat every 20 minutes, aligning with the Deployment Maintenance Task retries.

## Cause

When you install the Update Rollup, it triggers a setup maintenance task for the CMG. This maintenance task launches deployments for CMG Resources in Azure. In the deployment associated to the Public IP Address, the maintenance task attempts to update its "Availability Zone" configuration property to **"No zone"**. If the existing Public IP resource already has "Availability Zone" property configured (for example, to "Zone 1", "Zone 2", or "Zone 3"), the deployment fails.

The issue then affects the Azure regions where [Availability Zones](/azure/reliability/availability-zones-overview?toc=%2Fazure%2Fvirtual-network%2Ftoc.json&tabs=azure-cli) are supported. The current list is available at [Azure regions list](/azure/reliability/regions-list#azure-regions-list-1).

Current Configuration Manager releases don't specify Availability Zone when creating a new Public IP Address Resource for CMG. Hence, this issue doesn't affect new CMG deployments.

## Resolution

Microsoft has released a hotfix to address this issue: [Cloud management gateway deployment maintenance update for Configuration Manager 2409, 2503](/intune/configmgr/hotfix/2503/35958849). [Configuration Manager 2509](/intune/configmgr/hotfix/2509/35877153) includes this hotfix.

## More information

For more information about CMG monitoring, see [Monitor the CMG](/intune/configmgr/core/clients/manage/cmg/monitor-clients-cloud-management-gateway)
