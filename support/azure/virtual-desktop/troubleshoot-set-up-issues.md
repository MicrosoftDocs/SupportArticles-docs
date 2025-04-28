---
title: Azure Virtual Desktop environment host pool creation
description: Helps troubleshoot and resolve tenant and host pool issues during setup of an Azure Virtual Desktop environment.
ms.topic: troubleshooting
ms.custom: references_regions, devx-track-arm-template, docs_inherited, pcy:wincomm-user-experience
ms.date: 01/21/2025
ms.reviewer: daknappe
---

# Troubleshoot host pool creation

This article covers issues during the initial setup of the Azure Virtual Desktop tenant and the related session host pool infrastructure.

## Provide feedback

Visit the [Azure Virtual Desktop Tech Community](https://techcommunity.microsoft.com/t5/azure-virtual-desktop/bd-p/AzureVirtualDesktopForum) to discuss the Azure Virtual Desktop service with the product team and active community members.

## Acquire the Windows Enterprise multi-session image

To use the Windows Enterprise multi-session image, go to Azure Marketplace, and select the version that you want to deploy:

- Windows 10 [Microsoft Azure Marketplace](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/microsoftwindowsdesktop.windows-10?tab=PlansAndPrice)
- Windows 11 [Microsoft Azure Marketplace](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/microsoftwindowsdesktop.windows-11?tab=PlansAndPrice)

## Issues with using the Azure portal to create host pools

### Error: "Create a free account" appears when accessing the service

:::image type="content" source="media/troubleshoot-set-up-issues/create-new-account.png" alt-text="Screenshot of the Azure portal displaying the 'Create a free account' message.":::

#### Cause

There aren't active subscriptions in the account you signed in to Azure with, or the account doesn't have permissions to view the subscriptions.

#### Resolution

Sign in to the subscription where you deploy the session host virtual machines (VMs) with an account that has at least contributor-level access.

### Error: "Exceeding quota limit"

If your operation goes over the quota limit, you can do one of the following things:

- Create a new host pool with the same parameters but fewer VMs and VM cores.
- Open the link you see in the `statusMessage` field in a browser to submit a request to increase the quota for your Azure subscription for the specified VM SKU.

### Error: Can't see user assignments in application groups

#### Cause

This error usually occurs after you move the subscription from one Microsoft Entra tenant to another. If your old assignments are still tied to the previous Microsoft Entra tenant, the Azure portal loses track of them.

#### Resolution

You need to reassign users to application groups.

### I don't see the Azure region I want to use when selecting the location for my service objects

#### Cause

Azure doesn't currently support that region for the Azure Virtual Desktop service. For more information about which geographies we support, check out [Data locations](/azure/virtual-desktop/data-locations). If Azure Virtual Desktop supports the location but it still doesn't appear when you're trying to select a location, your resource provider hasn't updated yet.

#### Resolution

To get the latest list of regions, re-register the resource provider:

1. Go to **Subscriptions** and select the relevant subscription.
2. Select **Resource Provider**.
3. Select **Microsoft.DesktopVirtualization**, and then select **Re-register** from the action menu.

When you re-register the resource provider, you won't see any specific UI feedback or update statuses. The re-registration process also won't interfere with your existing environments.

## Azure Resource Manager template errors

Follow these instructions to troubleshoot unsuccessful deployments of Azure Resource Manager templates and PowerShell Desired State Configuration (DSC).

1. Review errors in the deployment using [View deployment operations with Azure Resource Manager](/azure/virtual-desktop/../azure-resource-manager/templates/deployment-history).
2. If there are no errors in the deployment, review errors in the activity log using [View activity logs to audit actions on resources](/azure/azure-monitor/essentials/activity-log).
3. Once the error is identified, use the error message and the resources in [Troubleshoot common Azure deployment errors with Azure Resource Manager](/azure/virtual-desktop/../azure-resource-manager/templates/common-deployment-errors) to address the issue.
4. Delete any resources created during the previous deployment and retry deploying the template.

### Error: Your deployment failed….\<hostname>/joindomain

:::image type="content" source="media/troubleshoot-set-up-issues/failure-joindomain.png" alt-text="Screenshot showing the Your deployment failed message.":::

Example of raw error:

```output
 {"code":"DeploymentFailed","message":"At least one resource deployment operation failed. Please list deployment operations for details.
 Please see https://aka.ms/arm-debug for usage details.","details":[{"code":"Conflict","message":"{\r\n \"status\": \"Failed\",\r\n \"error\":
 {\r\n \"code\": \"ResourceDeploymentFailure\",\r\n \"message\": \"The resource operation completed with terminal provisioning state 'Failed'.
 \",\r\n \"details\": [\r\n {\r\n \"code\": \"VMExtensionProvisioningError\",\r\n \"message\": \"VM has reported a failure when processing
 extension 'joindomain'. Error message: \\\"Exception(s) occurred while joining Domain 'diamondsg.onmicrosoft.com'\\\".\"\r\n }\r\n ]\r\n }\r\n}"}]}
```

#### Cause 1

Credentials provided for joining VMs to the domain are incorrect.

#### Resolution 1

See the "Incorrect credentials" error for VMs that aren't joined to the domain in [Session host VM configuration](/azure/virtual-desktop/troubleshoot-vm-configuration).

#### Cause 2

Domain name doesn't resolve.

#### Resolution 2

See [Error: Domain name doesn't resolve](troubleshoot-vm-configuration.md#error-domain-name-doesnt-resolve) in [Session host VM configuration](/azure/virtual-desktop/troubleshoot-vm-configuration).

#### Cause 3

Your virtual network (virtual network) DNS configuration is set to **Default**.

#### Resolution 3

To fix this issue, take the following steps:

1. Open the Azure portal and go to the **Virtual networks** tab.
2. Find your virtual network, and then select **DNS servers**.
3. The DNS servers menu should appear on the right side of your screen. On that menu, select **Custom**.
4. Make sure the DNS servers listed under **Custom** match your domain controller or Active Directory domain. If you don't see your DNS server, you can add it by entering its value into the **Add DNS server** field.

### Error: Your deployment failed...\Unauthorized

```output
{"code":"DeploymentFailed","message":"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-debug for usage details.","details":[{"code":"Unauthorized","message":"{\r\n \"Code\": \"Unauthorized\",\r\n \"Message\": \"The scale operation is not allowed for this subscription in this region. Try selecting different region or scale option.\",\r\n \"Target\": null,\r\n \"Details\": [\r\n {\r\n \"Message\": \"The scale operation is not allowed for this subscription in this region. Try selecting different region or scale option.\"\r\n },\r\n {\r\n \"Code\": \"Unauthorized\"\r\n },\r\n {\r\n \"ErrorEntity\": {\r\n \"ExtendedCode\": \"52020\",\r\n \"MessageTemplate\": \"The scale operation is not allowed for this subscription in this region. Try selecting different region or scale option.\",\r\n \"Parameters\": [\r\n \"default\"\r\n ],\r\n \"Code\": \"Unauthorized\",\r\n \"Message\": \"The scale operation is not allowed for this subscription in this region. Try selecting different region or scale option.\"\r\n }\r\n }\r\n ],\r\n \"Innererror\": null\r\n}"}]}
```

#### Cause

The subscription you're using is a type that can't access required features in the region where the customer is trying to deploy. For example, MSDN, Free, or Education subscriptions can show this error.

#### Resolution

Change your subscription type or region to one that can access the required features.

### Error: VMExtensionProvisioningError

:::image type="content" source="media/troubleshoot-set-up-issues/failure-vmextensionprovisioning.png" alt-text="Screenshot of Your deployment failed with terminal provisioning state failed.":::

#### Cause 1

Transient error with the Azure Virtual Desktop environment.

#### Cause 2

Transient error with connection.

#### Resolution

Confirm Azure Virtual Desktop environment is healthy by signing in using PowerShell. Finish the VM registration manually in [Create a host pool with PowerShell](/azure/virtual-desktop/create-host-pools-powershell).

### Error: The Admin Username specified isn't allowed

:::image type="content" source="media/troubleshoot-set-up-issues/failure-username.png" alt-text="Screenshot of your deployment failed in which an admin specified isn't allowed.":::

Example of raw error:

```output
 { …{ "provisioningOperation":
 "Create", "provisioningState": "Failed", "timestamp": "2019-01-29T20:53:18.904917Z", "duration": "PT3.0574505S", "trackingId":
 "1f460af8-34dd-4c03-9359-9ab249a1a005", "statusCode": "BadRequest", "statusMessage": { "error": { "code": "InvalidParameter", "message":
 "The Admin Username specified is not allowed.", "target": "adminUsername" } … }
```

#### Cause

The password provided contains forbidden substrings (admin, administrator, and root).

#### Resolution

Update username or use different users.

### Error: VM has reported a failure when processing extension

:::image type="content" source="media/troubleshoot-set-up-issues/failure-processing.png" alt-text="Screenshot of the resource operation completed with terminal provisioning state in Your deployment failed.":::

Example of raw error:

```output
{ … "code": "ResourceDeploymentFailure", "message":
 "The resource operation completed with terminal provisioning state 'Failed'.", "details": [ { "code":
 "VMExtensionProvisioningError", "message": "VM has reported a failure when processing extension 'dscextension'.
 Error message: \"DSC Configuration 'SessionHost' completed with error(s). Following are the first few:
 PowerShell DSC resource MSFT_ScriptResource failed to execute Set-TargetResource functionality with error message:
 One or more errors occurred. The SendConfigurationApply function did not succeed.\"." } ] … }
```

#### Cause

PowerShell DSC extension wasn't able to get admin access on the VM.

#### Resolution

Confirm the username and the password have administrative access on the virtual machine and run the Azure Resource Manager template again.

### Error: DeploymentFailed - PowerShell DSC Configuration 'FirstSessionHost' completed with errors

:::image type="content" source="media/troubleshoot-set-up-issues/failure-dsc.png" alt-text="Screenshot of deployment fail with PowerShell DSC Configuration 'FirstSessionHost' completed with errors.":::

Example of raw error:

```output
{
    "code": "DeploymentFailed",
   "message": "At least one resource deployment operation failed. Please list
 deployment operations for details. 4 Please see https://aka.ms/arm-debug for usage details.",
 "details": [
         { "code": "Conflict",
         "message": "{\r\n \"status\": \"Failed\",\r\n \"error\": {\r\n \"code\":
         \"ResourceDeploymentFailure\",\r\n \"message\": \"The resource
         operation completed with terminal provisioning state 'Failed'.\",\r\n
         \"details\": [\r\n {\r\n \"code\":
        \"VMExtensionProvisioningError\",\r\n \"message\": \"VM has
              reported a failure when processing extension 'dscextension'.
              Error message: \\\"DSC Configuration 'FirstSessionHost'
              completed with error(s). Following are the first few:
              PowerShell DSC resource MSFT ScriptResource failed to
              execute Set-TargetResource functionality with error message:
              One or more errors occurred. The SendConfigurationApply
              function did not succeed.\\\".\"\r\n }\r\n ]\r\n }\r\n}"  }

```

#### Cause

PowerShell DSC extension wasn't able to get admin access on the VM.

#### Resolution

Confirm the username and the password provided have administrative access on the virtual machine and run the Azure Resource Manager template again.

### Error: DeploymentFailed - InvalidResourceReference

Example of raw error:

```output
{"code":"DeploymentFailed","message":"At least one resource deployment operation
failed. Please list deployment operations for details. Please see https://aka.ms/arm-
debug for usage details.","details":[{"code":"Conflict","message":"{\r\n \"status\":
\"Failed\",\r\n \"error\": {\r\n \"code\": \"ResourceDeploymentFailure\",\r\n
\"message\": \"The resource operation completed with terminal provisioning state
'Failed'.\",\r\n \"details\": [\r\n {\r\n \"code\": \"DeploymentFailed\",\r\n
\"message\": \"At least one resource deployment operation failed. Please list
deployment operations for details. Please see https://aka.ms/arm-debug for usage
details.\",\r\n \"details\": [\r\n {\r\n \"code\": \"BadRequest\",\r\n \"message\":
\"{\\r\\n \\\"error\\\": {\\r\\n \\\"code\\\": \\\"InvalidResourceReference\\\",\\r\\n
\\\"message\\\": \\\"Resource /subscriptions/EXAMPLE/resourceGroups/ernani-wvd-
demo/providers/Microsoft.Network/virtualNetworks/wvd-vnet/subnets/default
referenced by resource /subscriptions/EXAMPLE/resourceGroups/ernani-wvd-
demo/providers/Microsoft.Network/networkInterfaces/erd. Please make sure that
the referenced resource exists, and that both resources are in the same
region.\\\",\\r\\n\\\"details\\\": []\\r\\n }\\r\\n}\"\r\n }\r\n ]\r\n }\r\n ]\r\n }\r\n}"}]}
```

#### Cause

Part of the resource group name is used for certain resources being created by the template. Due to the name matching existing resources, the template might select an existing resource from a different group.

#### Resolution

When running the Azure Resource Manager template to deploy session host VMs, make the first two characters unique for your subscription resource group name.

### Error: DeploymentFailed - InvalidResourceReference

Example of raw error:

```output
{"code":"DeploymentFailed","message":"At least one resource deployment operation
failed. Please list deployment operations for details. Please see https://aka.ms/arm-
debug for usage details.","details":[{"code":"Conflict","message":"{\r\n \"status\":
\"Failed\",\r\n \"error\": {\r\n \"code\": \"ResourceDeploymentFailure\",\r\n
\"message\": \"The resource operation completed with terminal provisioning state
'Failed'.\",\r\n \"details\": [\r\n {\r\n \"code\": \"DeploymentFailed\",\r\n
\"message\": \"At least one resource deployment operation failed. Please list
deployment operations for details. Please see https://aka.ms/arm-debug for usage
details.\",\r\n \"details\": [\r\n {\r\n \"code\": \"BadRequest\",\r\n \"message\":
\"{\\r\\n \\\"error\\\": {\\r\\n \\\"code\\\": \\\"InvalidResourceReference\\\",\\r\\n
\\\"message\\\": \\\"Resource /subscriptions/EXAMPLE/resourceGroups/ernani-wvd-
demo/providers/Microsoft.Network/virtualNetworks/wvd-vnet/subnets/default
referenced by resource /subscriptions/EXAMPLE/resourceGroups/DEMO/providers/Microsoft.Network/networkInterfaces
/EXAMPLE was not found. Please make sure that the referenced resource exists, and that both
resources are in the same region.\\\",\\r\\n \\\"details\\\": []\\r\\n }\\r\\n}\"\r\n
}\r\n ]\r\n }\r\n ]\r\n }\r\n\
```

#### Cause

This error occurs because the Network Interface Card (NIC) created with the Azure Resource Manager template has the same name as another NIC already in the virtual network.

#### Resolution

Use a different host prefix.

### Error: DeploymentFailed - Error downloading

Example of raw error:

```output
\\\"The DSC Extension failed to execute: Error downloading
https://catalogartifact.azureedge.net/publicartifacts/rds.wvd-provision-host-pool-
2dec7a4d-006c-4cc0-965a-02bbe438d6ff-prod
/Artifacts/DSC/Configuration.zip after 29 attempts: The remote name could not be
resolved: 'catalogartifact.azureedge.net'.\\nMore information about the failure can
be found in the logs located under
'C:\\\\WindowsAzure\\\\Logs\\\\Plugins\\\\Microsoft.Powershell.DSC\\\\2.77.0.0' on
the VM.\\\"
```

#### Cause

This error occurs due to a static route, firewall rule, or Network Security Group (NSG) blocking the download of the zip file tied to the Azure Resource Manager template.

#### Resolution

Remove blocking static route, firewall rule, or NSG. Optionally, open the Azure Resource Manager template json file in a text editor, take the link to zip file, and download the resource to an allowed location.

### Error: Can't delete a session host from the host pool after deleting the VM

#### Cause

You need to delete the session host before you delete the VM.

#### Resolution

Put the session host in drain mode, sign out all users from the session host, and then delete the host.

## Next steps

- For an overview on troubleshooting Azure Virtual Desktop and the escalation tracks, see [Troubleshooting overview, feedback, and support](/azure/virtual-desktop/troubleshoot-set-up-overview).
- To troubleshoot issues while configuring a virtual machine (VM) in Azure Virtual Desktop, see [Session host virtual machine configuration](/azure/virtual-desktop/troubleshoot-vm-configuration).
- To troubleshoot issues related to the Azure Virtual Desktop agent or session connectivity, see [Troubleshoot common Azure Virtual Desktop Agent issues](/azure/virtual-desktop/troubleshoot-agent).
- To troubleshoot issues with Azure Virtual Desktop client connections, see [Azure Virtual Desktop service connections](/azure/virtual-desktop/troubleshoot-service-connection).
- To troubleshoot issues with Remote Desktop clients, see [Troubleshoot the Remote Desktop client](/azure/virtual-desktop/troubleshoot-client-windows)
- To troubleshoot issues when using PowerShell with Azure Virtual Desktop, see [Azure Virtual Desktop PowerShell](/azure/virtual-desktop/troubleshoot-powershell).
- For more information about the service, see [Azure Virtual Desktop environment](/azure/virtual-desktop/environment-setup).
- To go through a troubleshoot tutorial, see [Tutorial: Troubleshoot Resource Manager template deployments](/azure/virtual-desktop/../azure-resource-manager/templates/template-tutorial-troubleshoot).
- For more information about auditing actions, see [Audit operations with Resource Manager](/azure/azure-monitor/essentials/activity-log).
- For more information about actions to determine the errors during deployment, see [View deployment operations](/azure/virtual-desktop/../azure-resource-manager/templates/deployment-history).
