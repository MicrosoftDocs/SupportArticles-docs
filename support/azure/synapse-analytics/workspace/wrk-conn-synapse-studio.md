---
title: Resolve Azure Synapse Studio connectivity issues
description: Provides solutions to common connectivity issues encountered on Azure Synapse Studio
ms.date: 01/31/2023
author: scott-epperly
ms.author: aminpashna
ms.reviewer: scepperl
---

# Resolve Azure Synapse Studio connectivity issues

_Applies to:_ &nbsp; Azure Synapse Analytics

Connectivity issues in Azure Synapse Studio are typically caused by configuration issues such as incorrect network settings or improper security role assignments.  Use the following guidance to troubleshoot connectivity issues with Synapse Studio. 

## Common issues and solutions

| Symptom | Cause | Resolution |
|---------|-------|------------|
|Error code 9054 Cannot connect to linked services|Deployments of a workspace in GIT without the Managed Vnet|Add the Managed Virtual Network configuration on the template used for workspace deployment|
|Error 400 while loading synapse workspace|misconfiguration|<ul><li>[Connect to workspace resources in Azure Synapse Analytics Studio from a restricted network](/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network)</li><li>[Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)</li></ul>|
|ADLS Gen2 operation failed for: Storage operation '' get failed with Operation returned an invalid status code 'Forbidden'|When the Workspace is created, a default Linked Service to storage account is created as well. It uses workspace Managed Service Identity as authentication method and this Linked Service can't be edited. You're getting this error because the workspace identity is lacking the Storage Blob Data Contributor role on the associated storage account|[Access control in Synapse Workspace](/azure/synapse-analytics/security/how-to-set-up-access-control#step-4-grant-the-workspace-msi-access-to-the-default-storage-container)|
|An instance-specific error occurred while establishing a connection to SQL Server. Connection was denied since Deny Public Network Access is set to Yes|Using data exfiltration protection (DEP) enabled workspace|<ul><li>[Understanding Azure Synapse Private Endpoints](https://techcommunity.microsoft.com/t5/azure-architecture-blog/understanding-azure-synapse-private-endpoints/ba-p/2281463)</li><li>[Connect to a Synapse workspace using private links](/azure/synapse-analytics/security/how-to-connect-to-workspace-with-private-links)</li><li>[Data exfiltration protection for Azure Synapse Analytics workspaces](/azure/synapse-analytics/security/workspace-data-exfiltration-protection)</li><li>[Managed private endpoints](/azure/synapse-analytics/security/synapse-workspace-managed-private-endpoints)</li></ul>|
|Error Message ***COPY statement input file schema discovery failed Cannot bulk load***| Misconfiguration | [Use external tables with Synapse SQL](/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=hadoop)|
|Table Lock while pulling up the data from SAP ECC|By Design|This issue is due to transaction isolation to reduce inconsistency in the data|
|Error message: **Per-machine installation is stopped because there is existing per user gateway installation** | This error indicates that a Self-Hosted Integration Runtime has already been installed on the target Virtual Machine. Only one SHIR per VM is permitted. | To install another SHIR for Azure Synapse, you'll need to set up separate Virtual Machines to host each Integration Runtime instance.  At this time, only Azure Data Factory supports the Self-hosted IR sharing feature.  For more information, see [Create a self-hosted integration runtime](/azure/data-factory/create-self-hosted-integration-runtime?tabs=synapse-analytics) |
|Error code 2108, Error calling the endpoint ''. Response status code: ''. More details: Exception message: '' Request didn't reach the server from the client. | This issue could happen because of an underlying issue such as <ul><li>network connectivity</li><li>DNS failure</li><li>server certificate validation</li><li>timeout misconfigured with a Managed Virtual Network and with Data Exfiltration Protection enabled</li></ul> | **Note**: The type of VNET (Shared VNET or Managed VNET) applied to the workspace can only be applied at creation time.<br><br> Take a look at the Private Endpoint Overview and related documentation:<ul><li>[What is a private endpoint?](/azure/private-link/private-endpoint-overview)</li><li>[Understanding Azure Synapse Private Endpoints](https://techcommunity.microsoft.com/t5/azure-architecture-blog/understanding-azure-synapse-private-endpoints/ba-p/2281463)</li></ul>A Private Link Service may also be a possible solution:<ul><li>[What is Azure Private Link?](/azure/private-link/private-link-overview)</li><li>[What is Azure Private Link service?](/azure/private-link/private-link-service-overview)</li></ul>Many configurations will require DNS configuration within your network so that requests will be correctly routed to the Private Endpoints inside the VNET:<ul><li>[Azure Private Endpoint DNS configuration](/azure/private-link/private-endpoint-dns)</li><ul>|
|ADLS Gen1 data access via Service Principal isn't working|Linked Service in the GIT repo can't be published to Synapse live mode|The Linked Service in the GIT repo can't be published to Synapse live mode|

## Troubleshooting tips
- Learn how to [troubleshoot Azure Synapse Studio](/azure/synapse-analytics/troubleshoot/troubleshoot-synapse-studio#troubleshooting-steps).

- [Diagnose connectivity issues using this PowerShell script](/azure/synapse-analytics/troubleshoot/troubleshoot-synapse-studio-powershell).

- Confirm Synapse Studio can access all the required endpoints:
  - Ensure the firewall on your network and local computer allows outgoing communication on TCP ports 80, 443, and 1443 for Synapse Studio.
  - Allow outgoing communication is on UDP port 53 for Synapse Studio.
  - To connect using tools such as SSMS and Power BI, you must allow outgoing communication on TCP port 1433.
  - If you're using the default Redirect connection policy setting, you may need to allow outgoing communication on more ports.

- Test access with different browsers, and disable any pop-up blockers and plugins.

- Investigate issues related to security and permissions:
  - [Workspaces, data, and pipelines](/azure/synapse-analytics/sql/access-control)
  - [Managed identities](/azure/synapse-analytics/security/synapse-workspace-managed-identity)
  - [Database access](/azure/azure-sql/database/logins-create-manage?toc=%2Fazure%2Fsynapse-analytics%2Ftoc.json&bc=%2Fazure%2Fsynapse-analytics%2Fbreadcrumb%2Ftoc.json)


## Failed to load one or more resources due to forbidden issue, error code 403

Error code 403 may be an intermittent issue while opening your Synapse workspace in Synapse Studio.

Make sure you have the following required permissions to access your workspace:
 - From the Azure portal, under Synapse Workspace, Access control (IAM), View my access, the user needs to have Owner/Contributor permission.
 - From the Azure portal, under Synapse Workspace, Networking, the user needs to ensure the correct client IP address is present in the firewall rules.

**Option 1:** Try to manually sign into your [workspace](https://web.azuresynapse.net). For more information, see [Create a Synapse workspace: Open Synapse Studio](/azure/synapse-analytics/get-started-create-workspace#open-synapse-studio).

**Option 2:**
 - Clear the **Cookies and Cached data** of your browser.
 - Use Private Mode.
 - Try using different browser.


## Setting up Synapse on a private network

You may not be able to connect to Azure Synapse if you disable the public network in firewall.
- Enable Public IP and add specific IPs that need to access Azure Synapse. Azure Firewall won't allow any other Public IP Address besides the one already added.

If you want to disable public IP, you can implement one of the following options.
    - If only a few users are planning to connect to Azure Synapse from their own machine, use a [Point-To-Site](/azure/vpn-gateway/vpn-gateway-howto-point-to-site-resource-manager-portal) VPN connection to connect to Azure Synapse.
    - If many users want to connect to Azure services from their own workstation, use [ExpressRoute](/azure/expressroute/expressroute-introduction).


## Resources

- [Launch Synapse Studio](/azure/synapse-analytics/quickstart-synapse-studio#launch-synapse-studio)
- [Connect to Synapse from your own network](/azure/synapse-analytics/security/synapse-workspace-ip-firewall#connect-to-synapse-from-your-own-network)
- [Synapse Workspace Pools and On Demand Inaccessible](https://techcommunity.microsoft.com/t5/azure-synapse-analytics/synapse-workspace-pools-and-on-demand-inaccessible/ba-p/1403485)
- [Understanding Azure Synapse Private Endpoints](https://techcommunity.microsoft.com/t5/azure-architecture-blog/understanding-azure-synapse-private-endpoints/ba-p/2281463)
- [Azure RBAC permissions for Azure Private Link](/azure/private-link/rbac-permissions?msclkid=d6948d48c6dc11ec857440eb53627605)
- [Assign the correct Synapse RBAC role](/azure/synapse-analytics/security/synapse-workspace-synapse-rbac-roles).
 - [Create and manage IP firewall rules](/azure/azure-sql/database/firewall-configure?view=azuresql#create-and-manage-ip-firewall-rules)
- Create a [self-hosted integration runtime (SHIR)](/azure/purview/manage-integration-runtimes) while [data exfiltration protection (DEP)](/azure/synapse-analytics/security/workspace-data-exfiltration-protection) is enabled in your workspace to prevent access issues.
- [Connect to workspace resources from a restricted network](/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network)

