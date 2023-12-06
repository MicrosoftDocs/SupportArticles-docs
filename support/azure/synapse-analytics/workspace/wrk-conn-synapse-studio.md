---
title: Resolve Azure Synapse Studio connectivity issues
description: Provides solutions to common connectivity issues encountered in Azure Synapse Studio.
ms.date: 02/21/2023
ms.reviewer: scepperl, v-sidong, aminpashna
---

# Resolve Azure Synapse Studio connectivity issues

_Applies to:_ &nbsp; Azure Synapse Analytics

Connectivity issues in Azure Synapse Studio are typically caused by configuration issues such as incorrect network settings or improper security role assignments.  Use the following guidance to troubleshoot connectivity issues with Synapse Studio.

## Common issues and solutions

| Symptom | Cause | Resolution |
|---------|-------|------------|
|Error code 9054 occurs when you can't connect to linked services.|Deployments of a workspace in GIT without the Managed Virtual Network|Add the Managed Virtual Network configuration to the template used for workspace deployment.|
|Error 400 while loading synapse workspace.|Misconfiguration|- [Connect to workspace resources in Azure Synapse Analytics Studio from a restricted network](/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network)<br>- [Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)|
|Error message: ADLS Gen2 operation failed for: Storage operation '' get failed with Operation returned an invalid status code 'Forbidden.'|When the workspace is created, a default Linked Service to storage account is created as well. It uses workspace Managed Service Identity as an authentication method, and this Linked Service can't be edited. You're getting this error because the workspace identity is lacking the Storage Blob Data Contributor role on the associated storage account.|[Access control in Synapse Workspace](/azure/synapse-analytics/security/how-to-set-up-access-control#step-4-grant-the-workspace-msi-access-to-the-default-storage-container)|
|Error message: An instance-specific error occurred while establishing a connection to SQL Server. Connection was denied since Deny public network access is set to Yes.|Using a workspace with data exfiltration protection (DEP) enabled|- [Understanding Azure Synapse Private Endpoints](https://techcommunity.microsoft.com/t5/azure-architecture-blog/understanding-azure-synapse-private-endpoints/ba-p/2281463)<br> - [Connect to a Synapse workspace using private links](/azure/synapse-analytics/security/how-to-connect-to-workspace-with-private-links)<br> - [Data exfiltration protection for Azure Synapse Analytics workspaces](/azure/synapse-analytics/security/workspace-data-exfiltration-protection)<br>- [Managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints)|
|Error message: COPY statement input file schema discovery failed Cannot bulk load.| Misconfiguration | [Use external tables with Synapse SQL](/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=hadoop)|
|Table Lock while pulling up the data from SAP ECC.|By design (This issue is due to transaction isolation that reduces inconsistency in the data.)|NA|
|Error message: Per-machine installation is stopped because there is existing per-user gateway installation. | This error indicates that a Self-Hosted Integration Runtime has already been installed on the target Virtual Machine. Only one SHIR per VM is permitted. | To install another SHIR for Azure Synapse, you need to set up separate Virtual Machines to host each Integration Runtime instance.  At this time, only Azure Data Factory supports the Self-hosted IR sharing feature.  For more information, see [Create a self-hosted integration runtime.](/azure/data-factory/create-self-hosted-integration-runtime?tabs=synapse-analytics) |
|Error message: Error code 2108, Error calling the endpoint ''. Response status code: ''. More details: Exception message: '' Request didn't reach the server from the client. | This issue could happen because of an underlying issue such as: <br> - Network connectivity<br> - DNS failure <br> - Server certificate validation <br> - Timeout misconfigured with a Managed Virtual Network and with Data Exfiltration Protection enabled | **Note**: The type of VNET (Shared VNET or Managed VNET) applied to the workspace can only be applied at creation time.<br><br> Take a look at the Private Endpoint Overview and related documentation:<br>- [What is a private endpoint?](/azure/private-link/private-endpoint-overview)<br>- [Understanding Azure Synapse Private Endpoints](https://techcommunity.microsoft.com/t5/azure-architecture-blog/understanding-azure-synapse-private-endpoints/ba-p/2281463)<br><br>A Private Link Service may also be a possible solution:<br> - [What is Azure Private Link?](/azure/private-link/private-link-overview)<br> - [What is Azure Private Link service?](/azure/private-link/private-link-service-overview)<br><br> Many configurations require DNS configuration within your network so that requests will be correctly routed to the Private Endpoints inside the VNET:<br>[Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)|
|ADLS Gen1 data access via Service Principal isn't working.|The Linked Service in the GIT repo can't be published to Synapse live mode.|NA|

## Troubleshooting tips

- Learn how to [troubleshoot Azure Synapse Studio](/azure/synapse-analytics/troubleshoot/troubleshoot-synapse-studio#troubleshooting-steps).

- [Diagnose connectivity issues using this PowerShell script](/azure/synapse-analytics/troubleshoot/troubleshoot-synapse-studio-powershell).

- Confirm Synapse Studio can access all the required endpoints:

  - Ensure the firewall on your network and local computer allows outgoing communication on TCP ports 80, 443, and 1443 for Synapse Studio.
  - Allow outgoing communication on UDP port 53 for the DNS server for name resolution.
  - To connect using tools such as SSMS and Power BI, you must allow outgoing communication on TCP port 1433.
  - If you're using the default Redirect connection policy setting, you may need to allow outgoing communication on more ports.

- Test access with different browsers, and disable any pop-up blockers and plugins.

- Investigate issues related to security and permissions:

  - [Workspaces, data, and pipelines](/azure/synapse-analytics/sql/access-control)
  - [Managed identities](/azure/synapse-analytics/security/synapse-workspace-managed-identity)
  - [Database access](/azure/azure-sql/database/logins-create-manage?toc=%2Fazure%2Fsynapse-analytics%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fbreadcrumb%2Ftoc.json)

## Failed to load one or more resources due to a forbidden issue with error code 403

Error code 403 may be an intermittent issue while opening your Synapse workspace in Synapse Studio.

Make sure you have the following required permissions to access your workspace:

- From the Azure portal, navigate to your Synapse workspace > **Access control (IAM)** > **View my access**, and ensure that you have the Owner or Contributor permission.
- From the Azure portal, navigate to your Synapse workspace > **Networking**, and ensure that the correct client IP address is present in the firewall rules.

To solve the issue, use one of the following options:

**Option 1:** Try to manually sign in to your [workspace](https://web.azuresynapse.net). For more information, see [Create a Synapse workspace: Open Synapse Studio](/azure/synapse-analytics/get-started-create-workspace#open-synapse-studio).

**Option 2:** Try to use one of the following methods:

- Clear the **Cookies and Cached data** of your browser.
- Use Private mode.
- Try using a different browser.

## Setting up Synapse on a private network

You may not be able to connect to Azure Synapse if you disable the public network in the firewall.

Enable Public IP and add specific IPs that need to access Azure Synapse. Azure Firewall won't allow any other Public IP Address besides the one already added.

If you want to disable public IP, you can implement one of the following options:

- If only a few users are planning to connect to Azure Synapse from their own machine, use a [Point-To-Site](/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal) VPN connection to connect to Azure Synapse.
- If many users want to connect to Azure services from their own workstation, use [ExpressRoute](/azure/expressroute/expressroute-introduction).

## Resources

- [Launch Synapse Studio](/azure/synapse-analytics/quickstart-synapse-studio#launch-synapse-studio)
- [Connect to Synapse from your own network](/azure/synapse-analytics/security/synapse-workspace-ip-firewall#connect-to-synapse-from-your-own-network)
- [Synapse Workspace Pools and On Demand Inaccessible](https://techcommunity.microsoft.com/t5/azure-synapse-analytics/synapse-workspace-pools-and-on-demand-inaccessible/ba-p/1403485)
- [Understanding Azure Synapse Private Endpoints](https://techcommunity.microsoft.com/t5/azure-architecture-blog/understanding-azure-synapse-private-endpoints/ba-p/2281463)
- [Azure RBAC permissions for Azure Private Link](/azure/private-link/rbac-permissions?msclkid=d6948d48c6dc11ec857440eb53627605)
- [Assign the correct Synapse RBAC role](/azure/synapse-analytics/security/synapse-workspace-synapse-rbac-roles).
- [Create and manage IP firewall rules](/azure/azure-sql/database/firewall-configure#create-and-manage-ip-firewall-rules)
- Create a [self-hosted integration runtime (SHIR)](/azure/purview/manage-integration-runtimes) while [data exfiltration protection (DEP)](/azure/synapse-analytics/security/workspace-data-exfiltration-protection) is enabled in your workspace to prevent access issues.
- [Connect to workspace resources from a restricted network](/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network)
