---
title: Reset the Salesforce Server-to-Server Connector in Sales Agent
description: Fix a Salesforce server-to-server connector that won't enable or disable in Sales agent. Learn how to reset the Salesforce artifacts and Dataverse credentials.
ms.date: 08/25/2026
ms.reviewer: shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
ai-usage: ai-assisted
---

# Reset Salesforce server-to-server connector in Sales agent

## Summary

This article explains how to reset the Salesforce server-to-server connector for Sales agent when you can't enable or disable the connection for a Salesforce org. Resetting the connector means that you remove the artifacts that the connector deployed to the Salesforce org and then delete the corresponding credentials row in the `msdyn_vivaorgextensioncreds` table in the `msdyn_viva` Dataverse environment. Clearing both sides returns the org to a clean, unconnected state so that you can try the connection again.

Treat this reset as a last resort. First, select **Reconnect** on the error message that Sales agent shows, which deletes the existing connection and creates a new one. Next, try the error-specific guidance in [Errors when you enable Salesforce with server-to-server flow](errors-enabling-salesforce-server-to-server-flow.md), [Errors when you disable Salesforce with server-to-server flow](errors-disabling-salesforce-server-to-server-flow.md), and [Errors when accessing Salesforce with server-to-server flow](errors-when-accessing-salesforce-with-server-to-server-flow.md). Use this article only when neither approach resolves the problem.

## Affected clients and configurations

| Requirement type | Description |
|---------|---------|
|**Client app**     | Microsoft Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Administrators   |

## Symptoms

You can't enable or disable access on the [Sales agent admin settings page](/microsoft-sales-copilot/connect-agent-datasource#set-up-server-to-server-connection-to-salesforce). You might see the enable or disable request repeatedly fail or return an error. This behavior typically occurs after you previously attempted to enable or disable the connector for the same Salesforce org, and standard troubleshooting didn't resolve the problem.

## Cause

When you enable the Salesforce server-to-server connection, the system deploys several artifacts to your Salesforce org:

- Connected app or external client app
- Integration user
- Permission set
- Custom profile

At the same time, a corresponding credentials record is stored in the `msdyn_vivaorgextensioncreds` [Dataverse table](/power-apps/maker/data-platform/entity-overview) in your `msdyn_viva` environment. If the Dataverse record and the Salesforce artifacts don't match, the connector can't complete an enable or disable request.

The mismatch between the Dataverse credentials and the Salesforce artifacts can occur due to:

- The Salesforce org being used across multiple Microsoft 365 tenants
- Migration of the Salesforce org
- Accidental deletion or modification of artifacts in Salesforce
- Transient errors during connector enable or disable operations

When this mismatch occurs, resetting the connector by removing all artifacts and credentials allows you to reestablish a clean connection.

## Prerequisites

Before you reset the connector, verify that you have the following:

- **Salesforce org admin access**: Required to delete connected apps, permission sets, and users.
- **Dataverse admin access** (or Power Platform admin access): Required to access and modify the `msdyn_vivaorgextensioncreds` table.

> [!IMPORTANT]
> This process permanently deletes data from both Salesforce and Dataverse. Deletions can't be recovered. Ensure you're deleting the correct artifacts for the Salesforce org that needs to be reset.

## Solution

Reset the connector by removing all artifacts and credentials, then reestablish a clean connection. The reset process involves three main steps:

1. [Remove Salesforce artifacts](#step-1-remove-salesforce-artifacts): Delete the connected app, permission set, and integration user from the Salesforce org.
1. [Delete the Dataverse credentials row](#step-2-delete-the-credentials-row-in-dataverse): Remove the connection record from the `msdyn_vivaorgextensioncreds` table.
1. [Reconnect the Salesforce org](#step-3-re-enable-the-salesforce-server-to-server-connection: Establish a fresh server-to-server connection.

## Step 1: Remove Salesforce artifacts

Sign in to your Salesforce org as an admin and delete the artifacts that the Sales agent server-to-server connector deployed. Use the search box in the left navigation panel of Salesforce setup to locate each item.

> [!NOTE]
> Component names depend on when the server-to-server connection was last enabled. Recently enabled orgs use the **M365 Copilot Sales** prefix, while older orgs use the **Copilot for Sales** prefix. Look for whichever variant exists in the org.

### Delete the connected app or external client app

Depending on when the connection was enabled, the Salesforce org contains either a connected app or an external client app.

To delete a connected app:

1. In the left sidebar, search for **App Manager**.
1. Locate the connected app with **M365 Copilot Sales** (or **Copilot for Sales** for older orgs) in the name.
1. Select it and delete it.

To delete an external client app:

1. In the left sidebar, search for **External Client Apps**.
1. Select **External Client App Manager**.
1. Find and select **M365 Copilot Sales External Client App**.
1. In the top right, select the dropdown menu and choose **Delete**.
1. Confirm the deletion.

### Remove the permission set

Before deleting the permission set, remove it from the integration user (Salesforce doesn't allow deletion if it's still assigned).

1. In the left sidebar, search for **Permission Sets**.
1. Open the permission set named **M365 Copilot Sales connected app permission set** (or **Copilot for Sales connected app permission set** for older orgs).
1. Select **Manage Assignments**.
1. Select the integration user and choose **Remove Assignments**.

   Alternatively, open the integration user record and remove the permission set from the **Permission Set Assignments** related list.

1. Return to the permission set and delete it.

For background on what this permission set grants, see [Permissions of the integration user](/microsoft-sales-copilot/connect-agent-datasource#permissions-of-the-integration-user).

### Deactivate the integration user

Deactivate the integration user that the connector created in the Salesforce org. 

1. In the left sidebar, search for **Users**.
1. Find the user named **M365 Copilot Sales Integration User** (or **Copilot for Sales Integration User** for older orgs).
1. Clear the **Active** checkbox.
1. Change the **Profile** assignment to a standard Salesforce profile that isn't related to Copilot for Sales.
1. Save the changes.

You must reassign the profile because the next step deletes the custom profile, and Salesforce doesn't delete a profile that's still assigned to a user.

### Delete the custom profile

Delete the custom profile that the connector created in the Salesforce org.

1. In the left sidebar, search for **Profiles**.
1. Find and select **CopilotForSalesIntegrationProfile**.
1. Select **Delete** and confirm.

## Step 2: Delete the credentials row in Dataverse

After you remove the Salesforce artifacts, delete the connection credentials from the `msdyn_vivaorgextensioncreds` table in your `msdyn_viva` Dataverse environment. This step removes the stored connection data that corresponds to the Salesforce org.

1. Go to the [Power Apps portal](https://make.powerapps.com).
1. In the top-right corner, select the **msdyn_viva** environment.
1. In the left panel, select **Tables** > **All**.
1. Search for and select **msdyn_vivaorgextensioncreds**.
1. Select **Edit** to view the table data.
1. In the column header area, select **+\<Number\> more** to display additional columns.
1. Ensure the following columns are visible: **Extension Name** and **Org id**. You can uncheck other columns if needed.
1. Find and select the row containing the Salesforce org URL that needs to be reset.
1. Delete this row.

## Step 3: Re-enable the Salesforce server-to-server connection

After you remove both the Salesforce artifacts and the Dataverse credentials, the connector is fully reset. You can now connect by following the standard setup process:

1. Go to the [Sales agent admin settings page](/microsoft-sales-copilot/connect-agent-datasource#set-up-server-to-server-connection-to-salesforce).
1. Follow the prompts to enable the server-to-server connection for the Salesforce org.
1. The system deploys new artifacts and credentials, creating a clean connection state.

## Related content

- [Connect your agents to a data source](/microsoft-sales-copilot/connect-agent-datasource)
- [Set up Sales agent](/microsoft-sales-copilot/set-up-sales-agent)
- [Errors when you enable Salesforce with server-to-server flow](errors-enabling-salesforce-server-to-server-flow.md)
- [Errors when you disable Salesforce with server-to-server flow](errors-disabling-salesforce-server-to-server-flow.md)
