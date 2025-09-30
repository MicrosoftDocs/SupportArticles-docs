---
title: Tables Aren't Populated in a DNS Solution that's Deployed to a Workspace
description: Troubleshooting guide for tables that don't get populated after you deploy a DNS solution to a workspace.
ms.date: 09/30/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: v-gsitser, v-ryanberg, neghuman, vikamala
ms.service: azure-monitor
ms.custom: Configure and manage Log Analytics tables
---

# Tables aren't populated in a DNS solution that's deployed to a workspace

After you deploy a DNS solution to a workspace, you might experience an issue in which the deployment finishes successfully, but the tables don't get populated. This can occur if the table creation isn't defined in the ARM template or if there's insufficient data ingestion.

## Common issues and solutions

- **Issue**: The DNS solution deployment finishes, but tables aren't populated.
- **Root cause**: Table creation might not be defined in the ARM template, or there may be no data ingestion.

## Resolution

To resolve the issue, follow these steps:

1. Verify the ARM template configuration:
   1. Check the DNS ARM template to make sure that it includes the definition for the table that you expect to be created.
   1. Navigate to the [Azure portal](https://portal.azure.com), and access the relevant resource group.
   1. Open the ARM template, and search for the table definition.

2. Check data ingestion:
   1. Verify that the Windows DNS Events via AMA Data Connector is installed and connected.
   1. Go to the **Azure Monitor** section in the Azure portal.
   1. Verify the data connector status, and make sure logs that are flowing into the workspace.

3. Manual table creation:
   1. If the table isn't created automatically, consider defining it manually within the ARM template.
   1. Use the Azure Resource Manager to update the template to have the required table definitions.

## References

- [Azure Monitor documentation](/azure/azure-monitor/)
- [ARM template documentation](/azure/azure-resource-manager/templates/)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]