---
title: Azure batch pool creation failure
description: An Azure batch pool creation failure occurs. You can review the symptoms, understand the causes, and apply solutions to this problem.
ms.date: 11/22/2022
ms.reviewer: biny, v-weizhu
ms.service: batch
---
# Azure batch pool creation failure

This article describes how to resolve an Azure batch pool creation failure.

## Scenario 1: Batch account public network access-related issue

When you create an Azure Batch account, one of the following three options can be selected for the **Public network access**:

- **All networks**
- **Selected networks**
- **Disabled**

:::image type="content" source="media/azure-batch-pool-creation-failure/public-network-access-options.png" alt-text="Screenshot that shows three options of public network access.":::

Depending on the selected option, you may come across issues at the Batch pool creation.

### Symptom 1 for Scenario 1

When you select the **Image Type** during the Batch pool creation, you may encounter the following error message:

> Failed to retrieve supported OS image information
>
> code : AuthorizationFailure
> message : This request is not authorized to perform this operation.
> RequestId:22b29112-fd1b-4376-bbd9-8036aa722e43 Time:2022-10-24T04:17:03.5602162Z

### Cause 1: Public network access is disabled, but Batch account doesn't have private endpoint

You create a Batch account with the **Public network access** set to **Disabled**. This setting makes access from the public network be removed. If the Batch account doesn't have a private endpoint, the connection to the Batch account will be restricted.

### Solution 1: Create private endpoint for Batch account

1. Create a [private endpoint for the Batch account](/azure/batch/private-connectivity). By enabling a private endpoint, you're bringing the Batch account into the virtual network of the private endpoint. Access from the virtual network will be available.

    :::image type="content" source="media/azure-batch-pool-creation-failure/private-endpoint.png" alt-text="Screenshot of the private endpoint.":::

2. Create a virtual machine (VM) in the same virtual network as the Batch account private endpoint where you won't see the error during the pool creation.

### Cause 2: Public access is only allowed from selected networks, but IP addresses aren't specified

You create a Batch account with the **Public network access** set to **Selected networks**. This setting makes the Batch account accessible only from the specified IP addresses. However, the specified IP addresses aren't added.

### Solution 2: Add specified IP addresses

To resolve the issue, add the IP addresses from which you would like to access the Batch account.

See the following screenshot as an example:

:::image type="content" source="media/azure-batch-pool-creation-failure/add-ip-ranges-to-allow-access.png" alt-text="Screenshot that shows the added IP address under the Address range.":::

### Symptom 2 for Scenario 1

Consider the following scenario:

- You create a new Batch account with **Public network access** set to **Disabled**.
- The Batch account has a private endpoint.
- You access the Batch account from within the virtual network of the Batch account private endpoint.

In this scenario, you may get the following error message:

> Failed to retrieve supported OS image information
>
> An error was encountered when sending your request, please make sure your network/DNS/firewall/proxy is configured correctly to not block rest api calls to Batch service. Error details: {"readyState":0,"status":0,"statusText":"error"}

### Cause: No DNS record

The creation of the private endpoint will assign a private IP address from the selected virtual network. To connect privately with your private endpoint, you need a DNS record.

### Solution: Configure private DNS zone for private endpoint

In this section, assume that the Batch account endpoint is "testbatchdoc.eastus2.batch.azure.com".

:::image type="content" source="media/azure-batch-pool-creation-failure/batch-account-endpoint.png" alt-text="Screenshot of Batch account endpoint.":::

1. Check if the Batch account endpoint FQDN resolves to the private IP address.

    1. Select the private endpoint.

        :::image type="content" source="media/azure-batch-pool-creation-failure/select-private-endpoint.png" alt-text="Screenshot of selecting the private endpoint.":::

    2. Navigate to the DNS configuration of the private endpoint and find the private IP address of the FQDN "testbatchdoc.eastus2.batch.azure.com".

        :::image type="content" source="media/azure-batch-pool-creation-failure/fqdn-private-ip-address.png" alt-text="Screenshot shows the IP address of FQDN." lightbox="media/azure-batch-pool-creation-failure/fqdn-private-ip-address.png":::

    3. From a VM within the same virtual network as the Batch account, run the following PowerShell command to resolve the FQDN:

        ```powershell
        nslookup testbatchdoc.eastus2.batch.azure.com
        ```

        Here's a command output example:

        :::image type="content" source="media/azure-batch-pool-creation-failure/nslookup-command-output.png" alt-text="Screenshot of the first nslookup command output.":::

        The command output indicates that the FQDN doesn't resolve to the private IP address 10.2.0.15. It means that no private DNS zone is configured for the private endpoint.

2. Configure a private DNS zone in the private endpoint DNS configuration.

    :::image type="content" source="media/azure-batch-pool-creation-failure/add-private-zone.png" alt-text="Screenshot of the added private DNS zone.":::

3. Once the private DNS zone "eastus2.privatelink.batch.azure.com" is configured, select it or search it, and check if the record set "testbatchdoc" is added for the FQDN.

    :::image type="content" source="media/azure-batch-pool-creation-failure/record-set.png" alt-text="Screenshot of the record set." lightbox="media/azure-batch-pool-creation-failure/record-set.png":::

4. Run the `nslookup <FQDN>` command.

    Here's a command output example.

    :::image type="content" source="media/azure-batch-pool-creation-failure/second-nslookup-command-output.png" alt-text="Screenshot of the second nslookup command output.":::

    The command output indicates that the FQDN is resolved to the private IP address. Now, the Batch connectivity for the pool creation should be allowed.

## Scenario 2: Batch pool virtual network-related issue

### Symptom for Scenario 2

When you create a Batch pool with a virtual network, the operation fails immediately. The following error message appears in the activity log or in the notification, which indicates a subnet setting issue:

> InvalidPropertyValue: The value provided for one of the properties in the request body is invalid.  
> RequestId:6886b8ad-3c3d-4de5-adc8-f0d10795939c Time:0000-00-00T00:00:00.Z  
> PropertyName: subnetId  
> PropertyValue: /subscriptions//\<subscription-id>/resourceGroups/\<resource-group-name>/providers/Microsoft.Network/virtualNetworks/\<virtualnetwork-name>/subnets/\<subnet-name>  
> Reason: The specified subnet '\<subnet-name>' has PrivateLinkServiceNetworkPolicies or PrivateEndpointNetworkPolicies enabled, please disable them to provision NoPublicAddresses Pool  
> PropertyPath: properties.networkConfiguration.subnetId

### Cause: Private endpoint network policy is enabled

The subnet you're using has the **Private endpoint network policy** set to **Enabled**. This network policy prevents the pool creation operations from being completed.

### Solution: Disable Private endpoint network policy

To resolve this issue, before you create the Batch pool, disable the **Private endpoint network policy** by using the Azure portal, PowerShell, Azure CLI, or Azure Resource Manager Template in the subnet.

For more information, see [Disable network policies for Azure Private Link service source IP address](/azure/private-link/disable-private-link-service-network-policy).

## Scenario 3: Azure Policy-related issue

### Symptom for Scenario 3

When you create a new Batch pool without data disk encryption (**Disk Encryption Configuration** is set to **None**), the operation fails immediately.

:::image type="content" source="media/azure-batch-pool-creation-failure/disk-encryption-configuration-set-to-none.png" alt-text="Screenshot of the Disk Encryption Configuration setting.":::

The following error message appears in the notification or the activity log:

:::image type="content" source="media/azure-batch-pool-creation-failure/resource-disallowed-by-policy.png" alt-text="Screenshot of the error message in the activity log.":::

### Cause: Azure policy blocks Batch pool creation

There's a built-in policy called "Azure Batch pools should have disk encryption enabled." It has a policy assignment that denies the creation of a new Batch pool that doesn't have disk encryption.

The pool creation may be blocked by other Azure policies, and the error message would be similar to the one in the activity log or the notification.

### Solution: Modify policy or enable disk encryption for the Batch pool

To resolve this issue, modify your policy or enable disk encryption for the Batch pool.

Here are the steps to modify a policy:

1. Go to the Azure Policy portal.
2. Find the assignment "Azure Batch pools should have disk encryption enabled."
3. Modify the assignment effect or delete it.

    To modify the assignment effect, follow these steps:

    1. Select **Edit**.
    2. Under **Parameters**, change the effect from **Deny** to **Audit**.

## Scenario 4: Feature not supported issue

### Symptom for Scenario 4

When you create a Batch pool without public IP addresses, the following message prompts out. It informs you that the Batch pool creation failed due to the "NoPublicIPAddress" feature being disabled.

:::image type="content" source="media/azure-batch-pool-creation-failure/feature-nopublicipaddress-disabled-error.png" alt-text="Screenshot of the error message in the notification.":::

You also can see the same error in the activity log:

:::image type="content" source="media/azure-batch-pool-creation-failure/error-activity-log.png" alt-text="Screenshot of the 'Feature is disabled' error message in the activity log." lightbox="media/azure-batch-pool-creation-failure/error-activity-log.png":::

### Cause: Batch account's region doesn't support pools without public IP addresses

Support for pools without public IP addresses in Azure Batch is currently in public preview for the following regions: France Central, East Asia, West Central US, South Central US, West US 2, East US, North Europe, East US 2, Central US, West Europe, North Central US, West US, Australia East, Japan East, and Japan West.

If your Batch account isn't located in those regions, when you create the Batch pool without public IP addresses, you'll encounter the "FeatureDisabled" error.

For more information, see [Create an Azure Batch pool without public IP addresses (preview)](/azure/batch/batch-pool-no-public-ip-address).

### Solution 1: Create Batch account in a region that supports pools without public IP addresses

To use a Batch pool without public IP addresses, create a Batch account located in the following regions: France Central, East Asia, West Central US, South Central US, West US 2, East US, North Europe, East US 2, Central US, West Europe, North Central US, West US, Australia East, Japan East, and Japan West.

### Solution 2: Enable simplified compute node communication

If your Batch account is located in the following regions, to use the pool without public IP addresses, raise a support ticket to enable the [simplified compute node communication](/azure/batch/simplified-compute-node-communication#supported-regions):

- Public: Central US EUAP, East US 2 EUAP, West Central US, North Central US, South Central US, East US, East US 2, West US 2, West US, Central US, West US 3, East Asia, South East Asia, Australia East, Australia Southeast, Brazil Southeast, Brazil South, Canada Central, Canada East, North Europe, West Europe, Central India, South India, Japan East, Japan West, Korea Central, Korea South, Sweden Central, Sweden South, Switzerland North, Switzerland West, UK West, UK South, UAE North, France Central, Germany West Central, Norway East, and South Africa North.
- Government: USGov Arizona, USGov Virginia, and USGov Texas.
- China: China North 3.

Once you enable the simplified compute node communication, [create a simplified compute node communication pool without public IP addresses](/azure/batch/simplified-node-communication-pool-no-public-ip). It will have the same functionalities as the pool without public IP addresses, but the simplified compute node communication can support more regions.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
