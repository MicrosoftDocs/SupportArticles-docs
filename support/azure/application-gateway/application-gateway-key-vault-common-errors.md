---
title: Common key vault errors in Application Gateway
titleSuffix: Azure Application Gateway
description: Learn how to troubleshoot common key vault errors in Azure Application Gateway to restore secure HTTPS operations. Follow the steps to fix issues now.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-application-gateway
ms.topic: troubleshooting
ms.date: 03/27/2026
ms.custom: sap:Configuration and Setup,sfi-image-nochange
# Customer intent: As an application administrator, I want to troubleshoot and resolve key vault errors in Application Gateway, so that I can ensure seamless certificate management and maintain secure HTTPS connections.
---

# Common key vault errors in Azure Application Gateway

## Summary

Application Gateway enables you to securely store TLS certificates in Azure Key Vault. When you use a key vault resource, it's important that the gateway always has access to the linked key vault. If your Application Gateway can't fetch the certificate, it disables the associated HTTPS listeners. For more information, see [Understanding disabled listeners](/azure/application-gateway/disabled-listeners).

This article helps you understand the details of the error codes and the steps to resolve key vault misconfigurations.

> [!TIP]
> Use a secret identifier that doesn't specify a version. By using this identifier, Azure Application Gateway automatically rotates the certificate if a newer version is available in Azure Key Vault. An example of a secret URI without a version is: `https://myvault.vault.azure.net/secrets/mysecret/`.

## Azure Advisor error codes

The following sections describe the various errors you might encounter. To check if your gateway has any of these problems, visit [**Azure Advisor**](/azure/application-gateway/key-vault-certs#investigating-and-resolving-key-vault-errors) for your account. Use this troubleshooting article to fix the problem. Configure Azure Advisor alerts to stay informed when a key vault problem is detected for your gateway.

> [!NOTE]
> Azure Application Gateway generates logs for key vault diagnostics every four hours. If the diagnostic continues to show the error after you fix the configuration, you might need to wait for the logs to refresh.

[comment]: # (Error Code 1)
### Error code: UserAssignedIdentityDoesNotHaveGetPermissionOnKeyVault 

**Description:** The associated user-assigned managed identity doesn't have the required permission. 

**Resolution:** Configure the access policies of your key vault to grant the user-assigned managed identity permission on secrets. You can do this in any of the following ways:

  **Vault access policy**
  1. Go to the linked key vault in the Azure portal.
  1. Open **Access policies**.
  1. For **Permission model**, select **Vault access policy**.
  1. Under **Secret Management Operations**, select the **Get** permission.
  1. Select **Save**.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/no-get-permission-for-managed-identity.png" alt-text=" Screenshot that shows how to resolve the Get permission error." lightbox="media/application-gateway-key-vault-common-errors/no-get-permission-for-managed-identity.png":::

For more information, see [Assign a Key Vault access policy by using the Azure portal](/azure/key-vault/general/assign-access-policy-portal).

  **Azure role-based access control**
  1. Go to the linked key vault in the Azure portal.
  1. Open **Access policies**.
  1. For **Permission model**, select **Azure role-based access control**.
  1. Go to **Access Control (IAM)** to configure permissions.
  1. **Add role assignment** for your managed identity by choosing the following values:<br>
    a. **Role**: Key Vault Secrets User<br>
    b. **Assign access to**: Managed identity<br>
    c. **Members**: select the user-assigned managed identity that you associated with your application gateway.<br>
  1. Select **Review + assign**.

For more information, see [Azure role-based access control in Key Vault](/azure/key-vault/general/rbac-guide).

> [!NOTE]
> Portal support for adding a new key vault-based certificate isn't currently available when you use **Azure role-based access control**. You can accomplish it by using an ARM template, CLI, or PowerShell. To learn more, see [Key Vault Azure role-based access control permission model](/azure/application-gateway/key-vault-certs#key-vault-azure-role-based-access-control-permission-model).

[comment]: # (Error Code 2)
### Error code: SecretDisabled 

**Description:** The associated certificate has been disabled in Key Vault. 

**Resolution:** Re-enable the certificate version that is currently in use for Application Gateway.
1. Go to the linked key vault in the Azure portal.
1. Open the **Certificates** pane.
1. Select the required certificate name, and then select the disabled version.
1. On the management page, use the toggle to enable that certificate version.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/secret-disabled.png" alt-text="Screenshot that shows how to re-enable a secret." lightbox="media/application-gateway-key-vault-common-errors/secret-disabled.png":::

[comment]: # (Error Code 3)
### Error code: SecretDeletedFromKeyVault 

**Description:** The associated certificate has been deleted from Key Vault. 

**Resolution:** To recover a deleted certificate: 
1. Go to the linked key vault in the Azure portal.
1. Open the **Certificates** pane.
1. Use the **Managed deleted certificates** tab to recover a deleted certificate.

On the other hand, if a certificate object is permanently deleted, you'll need to create a new certificate and update Application Gateway with the new certificate details. When you're configuring through the Azure CLI or Azure PowerShell, use a secret identifier URI without a version. This choice allows instances to retrieve a renewed version of the certificate, if it exists.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/secret-deleted.png" alt-text="Screenshot that shows how to recover a deleted certificate in Key Vault." lightbox="media/application-gateway-key-vault-common-errors/secret-deleted.png":::

[comment]: # (Error Code 4)
### Error code: UserAssignedManagedIdentityNotFound 

**Description:** The associated user-assigned managed identity has been deleted. 

**Resolution:** Create a new managed identity and use it with the key vault.
1. Re-create a managed identity with the same name that you used previously, and under the same resource group. (**TIP**: Refer to resource Activity Logs for naming details). 
1. Go to the key vault resource that you want, and set its access policies to grant this new managed identity the required permission. You can follow the same steps as mentioned in [Error code: UserAssignedIdentityDoesNotHaveGetPermissionOnKeyVault](/azure/application-gateway/application-gateway-key-vault-common-errors#error-code-userassignedidentitydoesnothavegetpermissiononkeyvault). 

[comment]: # (Error Code 5)
### Error code: KeyVaultHasRestrictedAccess

**Description:** There's a restricted network setting for Key Vault. 

**Resolution:** You encounter this error when you enable the Key Vault firewall for restricted access. You can still configure Application Gateway in a restricted network of Key Vault, by following these steps:
1. In Key Vault, open the **Networking** pane.
1. Select the **Firewalls and virtual networks** tab, and select **Private endpoint and selected networks**.
1. Then, by using Virtual Networks, add your Application Gateway's virtual network and subnet. During the process, also configure the 'Microsoft.KeyVault' service endpoint by selecting its checkbox.
1. Finally, select **Yes** to allow Trusted Services to bypass Key Vault's firewall.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/key-vault-restricted-access.png" alt-text="Screenshot that shows how to work around the restricted network error." lightbox="media/application-gateway-key-vault-common-errors/key-vault-restricted-access.png":::

[comment]: # (Error Code 6)
### Error code: KeyVaultSoftDeleted 

**Description:** The associated key vault is in soft-delete state. 

**Resolution:** In the Azure portal, search for *key vault*. Under **Services**, select **Key vaults**.

:::image type="content" source="./media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-1.png" alt-text="Screenshot that shows how to search for the Key Vault service." lightbox="media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-1.png":::

Select **Managed deleted vaults**. From here, you can find the deleted Key Vault resource and recover it.
:::image type="content" source="./media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-2.png" alt-text="Screenshot that shows how to recover a deleted key vault." lightbox="media/application-gateway-key-vault-common-errors/key-vault-soft-deleted-2.png":::

[comment]: # (Error Code 7)
### Error code: CustomerKeyVaultSubscriptionDisabled 

**Description:** The subscription for Key Vault is disabled. 

**Resolution:** Various reasons can cause Azure to disable your subscription. To take the necessary action to resolve this problem, see [Reactivate a disabled Azure subscription](/azure/cost-management-billing/manage/subscription-disabled).

## Application Gateway error codes
### Error code: ApplicationGatewayCertificateDataOrKeyVaultSecretIdMustBeSpecified / ApplicationGatewaySslCertificateDataMustBeSpecified  

**Description:** You encounter this error when you try to update a listener certificate. When this error occurs, the change to update the certificate is discarded, and the listener continues to handle traffic with the previously defined configuration.

**Resolution:** To resolve this issue, try uploading the certificate again. For example, use the following PowerShell commands to update certificates uploaded to Application Gateway or referenced via Azure Key Vault.

Update certificate uploaded directly to Application Gateway:
```
$appgw = Get-AzApplicationGateway -ResourceGroupName "<ResourceGroup>" -Name "<AppGatewayName>"

$password = ConvertTo-SecureString -String "<password>" -Force -AsPlainText

Set-AzApplicationGatewaySSLCertificate -Name "<oldcertname>" -ApplicationGateway $appgw -CertificateFile "<newcertPath>" -Password $password

Set-AzApplicationGateway -ApplicationGateway $appgw 
```

Update certificate referenced from Azure Key Vault: 
```
$appgw = Get-AzApplicationGateway -ResourceGroupName "<ResourceGroup>" -Name "<AppGatewayName>"

$secret = Get-AzKeyVaultSecret -VaultName "<KeyVaultName>" -Name "<CertificateName>" 
$secretId = $secret.Id.Replace($secret.Version, "") 
$cert = Set-AzApplicationGatewaySslCertificate -ApplicationGateway $AppGW -Name "<CertificateName>" -KeyVaultSecretId $secretId 

Set-AzApplicationGateway -ApplicationGateway $appgw 
```

## Next steps

These troubleshooting articles might be helpful as you continue to use Application Gateway:

- [Understanding and fixing disabled listeners](/azure/application-gateway/disabled-listeners)
- [Azure Application Gateway Resource Health overview](/azure/application-gateway/resource-health-overview)
