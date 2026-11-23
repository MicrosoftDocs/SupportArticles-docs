---
title: Troubleshoot key vault errors
titleSuffix: Azure Application Gateway
description: Learn how to troubleshoot common key vault errors in Azure Application Gateway to restore secure HTTPS operations. Follow the steps to fix issues now.
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 08/28/2026
ms.custom: sap:Configuration and Setup,sfi-image-nochange
# Customer intent: As an application administrator, I want to troubleshoot and resolve key vault errors in Application Gateway, so that I can ensure seamless certificate management and maintain secure HTTPS connections.
---

# Troubleshoot common key vault errors in Azure Application Gateway

## Summary

This article explains how to troubleshoot common key vault errors in Azure Application Gateway and resolve misconfigurations that can disrupt certificate management and secure HTTPS connections.

Application Gateway enables you to securely store TLS certificates in Azure Key Vault. When you use a key vault resource, it's important that the gateway always has access to the linked key vault. If your Application Gateway can't fetch the certificate, it disables the associated HTTPS listeners. For more information, see [Understanding disabled listeners](/azure/application-gateway/disabled-listeners).

> [!TIP]
> Use a secret identifier that doesn't specify a version. By using this identifier, Azure Application Gateway automatically rotates the certificate if a newer version is available in Azure Key Vault. An example of a secret Uniform Resource Identifier (URI) without a version is: `https://myvault.vault.azure.net/secrets/mysecret/`.

## Azure Advisor error codes

The following sections describe the various errors you might encounter. To check if your gateway has any of these problems, visit [Azure Advisor](/azure/application-gateway/key-vault-certs#investigating-and-resolving-key-vault-errors) for your account. Use this troubleshooting article to resolve the problem. Configure Azure Advisor alerts to stay informed when a key vault problem is detected for your gateway.

> [!NOTE]
> Application Gateway generates logs for key vault diagnostics every four hours. If the diagnostic continues to show the error after you fix the configuration, you might need to wait for the logs to refresh.

### Error code - "UserAssignedIdentityDoesNotHaveGetPermissionOnKeyVault"

#### Description

The associated user-assigned managed identity doesn't have the required permission. 

#### Solution

Configure the access policies of your key vault to grant the user-assigned managed identity permission on secrets. You can do this in either of the following two ways:

  **Vault access policy**

  1. In the [Azure portal](https://portal.azure.com), go to the linked key vault.
  1. Select **Access policies**.
  1. For **Permission model**, select **Vault access policy**.
  1. In **Secret Management Operations**, select the **Get** permission.
  1. Select **Save**.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/no-get-permission-for-managed-identity.png" alt-text="Screenshot of Key Vault access policy settings used to grant a managed identity Get permission." lightbox="./media/application-gateway-key-vault-common-errors/no-get-permission-for-managed-identity.png":::

For more information, see [Assign a Key Vault access policy by using the Azure portal](/azure/key-vault/general/assign-access-policy-portal).

  **Azure role-based access control (RBAC)**

  1. In the Azure portal, go to the linked key vault.
  1. Select **Access policies**.
  1. For **Permission model**, select **Azure role-based access control**.
  1. Go to **Access Control (IAM)** to configure permissions.
  1. **Add role assignment** for your managed identity by choosing the following values:
    a. **Role**: Key Vault Secrets User
    b. **Assign access to**: Managed identity
    c. **Members**: select the user-assigned managed identity that you associated with your application gateway.
  1. Select **Review + assign**.

For more information, see [Azure role-based access control in Key Vault](/azure/key-vault/general/rbac-guide).

> [!NOTE]
> Portal support for adding a new key vault-based certificate isn't currently available when you use **Azure role-based access control**. You can accomplish it by using an Azure Resource Management (ARM) template, Azure CLI, or Azure PowerShell. To learn more, see [Key Vault Azure role-based access control permission model](/azure/application-gateway/key-vault-certs#key-vault-azure-role-based-access-control-permission-model).

### Error code - "SecretDisabled"

#### Description

The associated certificate is disabled in Azure Key Vault. 

#### Solution

Enable the certificate version that Application Gateway uses.
To do this, follow these steps:

1. In the Azure portal, go to the linked key vault.
1. Select **Certificates**.
1. Select the certificate name you want, and then select the disabled version.
1. On the management page, use the toggle to enable that certificate version.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/secret-disabled.png" alt-text="Screenshot of the Key Vault certificate version toggle used to re-enable a disabled secret." lightbox="./media/application-gateway-key-vault-common-errors/secret-disabled.png":::

### Error code - "SecretDeletedFromKeyVault" 

#### Description

The associated certificate is deleted from Key Vault. 

#### Solution

To recover a deleted certificate, follow these steps: 

1. In the Azure portal, go to the linked key vault.
1. Open the **Certificates** pane.
1. Use the **Managed deleted certificates** tab to recover a deleted certificate.

If you permanently delete a certificate object, create a new certificate and update Application Gateway with the new certificate details. When you configure through Azure CLI or Azure PowerShell, use a secret identifier URI without a version. This choice allows instances to retrieve a renewed version of the certificate, if it exists.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/secret-deleted.png" alt-text="Screenshot of the Managed deleted certificates tab used to recover a deleted Key Vault certificate." lightbox="./media/application-gateway-key-vault-common-errors/secret-deleted.png":::

### Error code - "UserAssignedManagedIdentityNotFound" 

#### Description

The associated user-assigned managed identity is deleted. 

#### Solution

Create a new managed identity and use it with the key vault.
To do so, follow these steps:

1. Re-create a managed identity with the same name that you used previously, and under the same resource group. Refer to resource Activity Logs for naming details. 
1. Go to the key vault resource that you want, and set its access policies to grant this new managed identity the required permission. For more information, see [Error code: UserAssignedIdentityDoesNotHaveGetPermissionOnKeyVault](/azure/application-gateway/application-gateway-key-vault-common-errors#error-code-userassignedidentitydoesnothavegetpermissiononkeyvault). 

### Error code - "KeyVaultHasRestrictedAccess"

#### Description

Key Vault has a restricted network setting. 

#### Solution

You encounter this error when you enable the Key Vault firewall for restricted access. Configure Application Gateway in a restricted network of Key Vault.
To do so, follow these steps:

1. In Key Vault, select **Networking**.
1. Select the **Firewalls and virtual networks** tab, and then select **Private endpoint and selected networks**.
1. Use Azure Virtual Network to add your Application Gateway's virtual network and subnet. 
1. Select the **Microsoft.KeyVault** checkbox.
1. Select **Yes**. This action allows trusted services to bypass the Key Vault firewall.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/key-vault-restricted-access.png" alt-text="Screenshot of Key Vault networking settings used to configure restricted network access." lightbox="./media/application-gateway-key-vault-common-errors/key-vault-restricted-access.png":::

### Error code - "KeyVaultSoftDeleted"

#### Description

The associated key vault is in soft-delete state. 

#### Solution

Find the deleted key vault resource. 
To do so, follow these steps:

1. In the Azure portal, search for **key vault**. 
1. In **Services**, select **Key vaults**.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-1.png" alt-text="Screenshot of searching for the Key Vault service in the Azure portal." lightbox="media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-1.png":::

1. Select **Managed deleted vaults**. 
1. Find the deleted key vault resource and recover it.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-2.png" alt-text="Screenshot of Managed deleted vaults with the option to recover a deleted key vault." lightbox="./media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-2.png":::

### Error code - "CustomerKeyVaultSubscriptionDisabled" 

#### Description

The subscription for Key Vault is disabled. 

#### Solution

Various reasons can cause Azure to disable your subscription. To take the necessary action to resolve this problem, see [Reactivate a disabled Azure subscription](/azure/cost-management-billing/manage/subscription-disabled).

## Application Gateway error codes

### Error code - "ApplicationGatewayCertificateDataOrKeyVaultSecretIdMustBeSpecified / ApplicationGatewaySslCertificateDataMustBeSpecified"

#### Description 

You encounter this error when you try to update a listener certificate. When this error occurs, the change to update the certificate is discarded, and the listener continues to handle traffic with the previously defined configuration.

#### Solution

To resolve this issue, try uploading the certificate again. For example, use the following PowerShell commands to update certificates uploaded to Application Gateway or referenced via Azure Key Vault.

Update certificate uploaded directly to Application Gateway.

```
$appgw = Get-AzApplicationGateway -ResourceGroupName "<ResourceGroup>" -Name "<AppGatewayName>"

$password = ConvertTo-SecureString -String "<password>" -Force -AsPlainText

Set-AzApplicationGatewaySSLCertificate -Name "<oldcertname>" -ApplicationGateway $appgw -CertificateFile "<newcertPath>" -Password $password

Set-AzApplicationGateway -ApplicationGateway $appgw 
```

Update certificate referenced from Azure Key Vault. 

```
$appgw = Get-AzApplicationGateway -ResourceGroupName "<ResourceGroup>" -Name "<AppGatewayName>"

$secret = Get-AzKeyVaultSecret -VaultName "<KeyVaultName>" -Name "<CertificateName>" 
$secretId = $secret.Id.Replace($secret.Version, "") 
$cert = Set-AzApplicationGatewaySslCertificate -ApplicationGateway $AppGW -Name "<CertificateName>" -KeyVaultSecretId $secretId 

Set-AzApplicationGateway -ApplicationGateway $appgw 
```

## References

- [Understanding and fixing disabled listeners](/azure/application-gateway/disabled-listeners)
- [Azure Application Gateway Resource Health overview](/azure/application-gateway/resource-health-overview)
