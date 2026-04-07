---
title: Resolve environment variable key vault auth errors in Power Platform
description: Resolve the "User is not authorized to read secrets" error when you save environment variables that reference Azure Key Vault secrets in Power Platform and Dataverse.
ms.date: 04/03/2026
ms.reviewer: saagrawal, v-shaywood
ms.custom: sap:Working with Solutions
---

# "User is not authorized to read secrets" error when saving environment variables

## Summary

This article helps you resolve the "User is not authorized to read secrets" error that occurs when you create, update, or import environment variables that reference [Azure Key Vault](/azure/key-vault/general/overview) secrets in [Microsoft Dataverse](/power-apps/maker/data-platform/) and Power Platform. This error indicates that Power Platform can't access the specified Key Vault secret. Common causes include missing role assignments, incorrect access control settings, and network restrictions.

This article applies to Dataverse and Power Platform solutions. For Azure Key Vault errors that are related to _Wrap for Power Apps_, see [Azure Key Vault errors in Wrap for Power Apps](/troubleshoot/power-platform/power-apps/manage-apps/azure-key-vault-errors).

## Symptoms

When you create, update, or import a solution that contains an environment variable that references an Azure Key Vault secret, you receive the following error message:

> This variable didn't save properly. User is not authorized to read secrets from '/subscriptions/\<SubscriptionId>/resourceGroups/\<ResourceGroup>/providers/Microsoft.KeyVault/vaults/\<VaultName>/secrets/\<SecretName>' resource.

You might also see the following error entry in the diagnostic logs:

> Azure.RequestFailedException: Caller is not authorized to perform action 'Microsoft.KeyVault/vaults/secrets/getSecret/action' on resource '/subscriptions/\<SubscriptionId>/resourceGroups/\<ResourceGroup>/providers/Microsoft.KeyVault/vaults/\<VaultName>/secrets/\<SecretName>' (Status: 403 Forbidden)

The following screenshot shows how this error appears in the Power Apps maker portal when you create or save an environment variable.

:::image type="content" source="media/environment-variable-key-vault-auth-error/ev-keyvault-error-ui.png" alt-text="Screenshot of the Power Apps New environment variable dialog showing the authorization error banner. The Data Type is set to Secret and Secret Store is set to Azure Key Vault.":::

This error might occur in the following scenarios:

- Creating a new environment variable that has the type of **Secret** and that uses **Azure Key Vault** as the secret store.
- Updating the Key Vault secret reference value of an existing environment variable
- Importing a solution that contains environment variables that reference Azure Key Vault secrets

## Grant the Key Vault Secrets User role to the Dataverse service principal

The Dataverse service principal requires the **Key Vault Secrets User** role on your Azure Key Vault. Without this role, Dataverse can't retrieve the secret value on behalf of users.

> [!IMPORTANT]
> If you previously configured your service principal to have only the **Key Vault Reader** role, be aware that this role isn't sufficient. You must also add the **Key Vault Secrets User** role.

To add this role assignment:

1. In the [Azure portal](https://portal.azure.com), go to your key vault.
1. In the left pane, select **Access control (IAM)**.
1. Select **Add** > **Add role assignment**.
1. On the **Role** tab, search for and select **Key Vault Secrets User**.
1. On the **Members** tab, select **Select members**.
1. Search for **Dataverse**, and select the Dataverse application identity. If multiple Dataverse service principals appear, select each one.
1. Complete the wizard by selecting **Review + assign**.

## Grant the user the Key Vault Secrets User role

The user who creates or updates the environment variable also needs the **Key Vault Secrets User** role on the Azure Key Vault.

To grant this role to the user:

1. In the [Azure portal](https://portal.azure.com), go to your Key Vault.
1. Select **Access control (IAM)** from the left navigation.
1. Select **Add** > **Add role assignment**.
1. On the **Role** tab, search for and select **Key Vault Secrets User**.
1. On the **Members** tab, select **Select members**.
1. Search for and select the user who has to create or update the environment variable.
1. Complete the wizard by selecting **Review + assign**.

## Switch Key Vault to Azure RBAC

Power Platform uses [Azure role-based access control (RBAC)](/azure/role-based-access-control/overview) to check permissions. If your Key Vault still uses the legacy **Vault access policy** permission model, permission checks can fail even if the correct policies are set.

To switch the permission model:

1. In the [Azure portal](https://portal.azure.com), go to your key vault.
1. Select **Settings** > **Access configuration**.
1. Under **Permission model**, select **Azure role-based access control**.
1. Select **Save**.

> [!IMPORTANT]
> After you switch to Azure RBAC, make sure that the **Key Vault Secrets User** role is assigned to both the user and the Dataverse service principal.

## Register the Microsoft.PowerPlatform resource provider

You have to register the `Microsoft.PowerPlatform` resource provider for your Azure subscription. If you don't register Power Platform, it can't interact with Azure resources on your behalf.

To register the resource provider:

1. In the [Azure portal](https://portal.azure.com), go to **Subscriptions**, and select your subscription.
1. In the left pane, select **Resource providers**.
1. Search for `Microsoft.PowerPlatform`.
1. If the status is shown as **NotRegistered**, select the field, and then select **Register**.

For more information, see [Resource providers and resource types](/azure/azure-resource-manager/management/resource-providers-and-types).

## Verify that Key Vault is in the same tenant

The Azure Key Vault must be in the same [Microsoft Entra](/entra/fundamentals/whatis) tenant as your Power Platform environment. Cross-tenant Key Vault access isn't supported.

To check the tenant configuration:

1. Verify that your key vault and your Power Platform environment are in the same Microsoft Entra tenant.
1. If they're in different tenants, take one of the following actions:
   - Move the key vault to the same tenant as your Power Platform environment.
   - Create a new key vault in the correct tenant, and migrate the secrets.

## Create the private endpoint in the correct region (Private Link scenarios)

If you use Azure Key Vault together with [Private Link](/azure/private-link/private-link-overview) and [Virtual Network (VNet) support for Power Platform](/power-platform/admin/vnet-support-overview), the private endpoint must be in the same region as the Power Platform environment cluster. For example, if your environment is in _West US_, the private endpoint must also be in _West US_.

> [!IMPORTANT]
> Virtual Network support for Power Platform requires a [Managed Environment](/power-platform/admin/managed-environment-overview). Make sure that your environment is enabled as a Managed Environment before you set up Private Link.

To create a private endpoint in the correct region:

1. Identify the deployment region of your Power Platform environment:
   1. Open [Power Apps](https://make.powerapps.com), and select the **Settings** (gear symbol) in the top-right corner.
   1. Select **Session details**.
   1. Note the **Deployment location** value (for example, **WUS** is West US and **EUS** is East US).
1. In the [Azure portal](https://portal.azure.com), go to your key vault.
1. Select **Settings** > **Networking** > **Private endpoint connections**.
1. Create a new private endpoint in the same region as your Power Platform environment.
1. Select the virtual network and subnet that are delegated to Power Platform.
1. If your Enterprise Policy includes multiple subnet delegations (for example, West US and East US), create private endpoints in each region.
1. Make sure **Private DNS integration** is enabled for the new endpoint.

For more information, see [Set up Virtual Network support for Power Platform](/power-platform/admin/vnet-support-setup-configure).

## Allow Power Platform IP addresses through the Key Vault firewall

If you enable a firewall on your Key Vault, the firewall might block Power Platform requests. This block might occur because Power Platform IP addresses aren't on the **Azure Trusted Services** list, or because the firewall allows access only from specific IP addresses or virtual networks.

To update the firewall rules:

1. In the [Azure portal](https://portal.azure.com), go to your key vault.
1. Select **Settings** > **Networking**.
1. Under **Firewalls and virtual networks**, add the Power Platform IP address ranges that are listed at [Power Platform URLs and IP address ranges](/power-platform/admin/online-requirements#ip-addresses-required).

> [!IMPORTANT]
> The **"Allow trusted Microsoft services to bypass this firewall"** option doesn't include Power Platform. You must explicitly add the IP ranges.

## Related content

- [Use environment variables for Azure Key Vault secrets](/power-apps/maker/data-platform/environmentvariables-azure-key-vault-secrets)
- [Environment variables overview](/power-apps/maker/data-platform/environmentvariables)
- [Provide access to Key Vault with Azure RBAC](/azure/key-vault/general/rbac-guide)
