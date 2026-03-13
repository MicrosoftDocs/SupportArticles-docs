---
title: Troubleshoot Azure Logic Apps Setup and Connectivity
description: This troubleshooting checklist consolidates the required steps for resolving Azure Logic Apps setup and connectivity issues.
ms.service: azure-logic-apps
ms.reviewer: xuehongg, shrahman, v-ryanberg, v-gsitser
ms.topic: troubleshooting
ms.custom: Networking
ms.date: 11/5/2025
author: JarrettRenshaw
ms.author: jarrettr
---

# Troubleshoot Azure Logic Apps setup and connectivity

This troubleshooting checklist consolidates the required steps for resolving Azure Logic Apps setup and connectivity issues.

## Troubleshooting checklist

### Configure the logic app for VNet integration

Make sure that the logic app is configured correctly for virtual network (VNet) integration:

1. On the Azure portal, navigate to **Logic App > Settings > Networking > Outbound traffic configuration**.
1. Select **Add virtual network integration**.
1. Choose a virtual network that includes a subnet without any delegations. For more information, see [Prerequisites](/azure/logic-apps/secure-single-tenant-workflow-virtual-network-private-endpoint#prerequisites).
1. Add this app setting: **WEBSITE_VNET_ROUTE_ALL = 1**.

### Verify storage account access

Verify that the storage account has the necessary network rules and permissions to allow access from the logic app:

1. Navigate to **Storage Account > Networking > Public network access > Enable from selected networks**.
1. In **Virtual Networks**, add the logic app subnet.

### Verify that private addresses are returned for endpoints

If private endpoints are enabled, check DNS settings to make sure that private addresses are returned for endpoints.

> [!IMPORTANT]
> Make sure that you follow these steps if you use your own DNS server instead of Azure DNS.

1. Create private DNS zones (for example: *privatelink.blob.core.windows.net*).
1. Link the DNS zones to the VNet.
1. Add these app settings:
    - **WEBSITE_DNS_SERVER**
    - **WEBSITE_DNS_ALT_SERVER**
2. Verify these settings by using Kudu together with the `nameresolver` command.

### Enable Allow storage account key access 

Enable **Allow storage account key access** in the storage account configuration:

1. Navigate to **Storage Account** > **Configuration**.
1. Set **Allow storage account key access** to **Enabled**.

### Ensure private endpoint connectivity

Use the built-in connector for Azure Blob Storage to ensure private endpoint connectivity:

1. Navigate to **Workflows**, and select the workflow that you want.
1. On the workflow menu, select **Designer**.
1. Select **Built-in > Azure Blob Storage**.
1. Provide the storage account connection string.

### Switch to built-in connectors

Switch to using built-in connectors for scenarios that require private endpoint access:

1. Select **Built-in connectors** for private endpoint scenarios.

### Route outbound traffic through the VNet

Make sure that the logic app's outbound traffic is correctly routed through the VNet:

1. Select **Route All**.
1. Associate an Azure Network Address Translation (NAT) Gateway for predictable outbound IPs.
1. Verify the network security groups (NSG) and user-defined routes (UDR) rules.

### Search for any missing app settings

Check the logic app runtime configuration to determine whether any app settings are missing.

### Deploy single-tenant logic apps that have private storage accounts

If you still experience deployment failures, make sure that your configurations align with the requirements of your specific deployment scenario. For example, you might have to add the following app settings:

- **WEBSITE_CONTENTOVERVNET = 1**
- **WEBSITE_VNET_ROUTE_ALL = 1**

Additionally, check DNS and host settings.

## References

- [Secure traffic between Standard workflows and virtual networks - Azure Logic Apps](/azure/logic-apps/secure-single-tenant-workflow-virtual-network-private-endpoint)
- [Deploy Standard logic apps to private storage accounts - Azure Logic Apps](/azure/logic-apps/deploy-single-tenant-logic-apps-private-storage-account)
- [Install on-premises data gateway for logic app workflows - Azure Logic Apps](/azure/logic-apps/install-on-premises-data-gateway-workflows)
- [Connect to on-premises data sources - Azure Logic Apps](/azure/logic-apps/connect-on-premises-data-sources?tabs=consumption)

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
