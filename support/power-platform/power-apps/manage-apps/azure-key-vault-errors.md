---
title: Azure Key Vault Errors in Wrap For Power Apps
description: Provides solutions for the Azure key vault errors that occur when using the wrap feature in Power Apps.
ms.reviewer: sitaramp, koagarwa
ms.author: arijitba
author: arijitba
ms.date: 08/04/2025
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app
---
# Azure key vault errors in wrap for Power Apps

This article provides step-by-step solutions for Azure Key Vault errors you might encounter when using the [wrap wizard](/power-apps/maker/common/wrap/wrap-how-to) to build your mobile app.

| Error code | Error message |
|------------|-------------|
| [1000118](#error-code-1000118) | Default subscription not found or missing access permissions. |
| [1000119](#error-code-1000119) | Key vault doesn't exist or is missing access privileges.|
| [1000120](#error-code-1000120) | No organization ID tags found on key vault. Ensure that the tag {Bundle ID}.{organization-id} is present and uses the correct case sensitivity.|
| [1000121](#error-code-1000121) | Android keystore isn't valid. Ensure that the tag {Bundle ID}.{keystore} is present and uses the correct case sensitivity.|
| [1000122](#error-code-1000122) | iOS certificate isn't valid. Missing Tag and/or Secret. Ensure that the tag {Bundle ID}.{cert} is present and uses the correct case sensitivity.|
| [1000123](#error-code-1000123) | iOS profile isn't valid. Ensure that the tag {Bundle ID}.{profile} is present and uses the correct case sensitivity.|
| [1000128](#error-code-1000128) | Missing access key required to access the Azure Blob Storage location. Ensure that the tag {Bundle ID}.{accessKey} is present and uses the correct case sensitivity.|
| [1000130](#error-code-1000130) | Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard isn't set.|
| [1000131](#error-code-1000131) | No tags or missing access permission for the specified Azure Key Vault. |
| [1000132](#error-code-1000132) | Missing environment variable 'PA_Wrap_KV_ResourceID' for the targeted environment. |

## Error code 1000118

Error message: Default subscription not found, or missing access permissions.

#### Resolution steps

1. Ensure your Azure key vault is in the tenant's **Default subscription**.

2. As a Microsoft Entra ID (formerly Azure AD) admin, add the service principal for the AppID "4e1f8dc5-5a42-45ce-a096-700fa485ba20" by running the following commands in PowerShell:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

3. In the [Azure portal](https://portal.azure.com), under **Access Control (IAM)**, assign the **Reader** role to your service principal:

   1. Go to **Access control (IAM)**, and then select **Add role assignment**.

      :::image type="content" source="media/azure-key-vault-errors/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/azure-key-vault-errors/add-role-assignment.png":::

   1. Choose **Reader** under **Job function roles** and go to the **Members** tab.

      :::image type="content" source="media/azure-key-vault-errors/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/azure-key-vault-errors/add-members.png":::

   1. Search for your app name.

      :::image type="content" source="media/azure-key-vault-errors/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for your app." lightbox="media/azure-key-vault-errors/select-members-to-add-role.png":::

   1. Assign the **Reader** role.

      :::image type="content" source="media/azure-key-vault-errors/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to your app." lightbox="media/azure-key-vault-errors/assign-reader-role-to-wrap-keyvault-access-app.png":::

## Error code 1000119

Error message: Key vault doesn't exist or is missing access privileges.

### Resolution steps

1. Confirm your Azure key vault is in the tenant's **Default subscription**.

2. While creating the key vault, select **Vault access policy**.

   :::image type="content" source="media/azure-key-vault-errors/vault-acces-policy.png" alt-text="Select the Vault Access policy option under the Access configuration tab.":::

3. As a Microsoft Entra ID (formerly Azure AD) admin, add the service principal for the AppID "4e1f8dc5-5a42-45ce-a096-700fa485ba20" by running the following commands in PowerShell:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

4. In the [Azure portal](https://portal.azure.com), assign the **Reader** role as shown in the previous error code section.

5. Add access policies to the key vault:

   :::image type="content" source="media/azure-key-vault-errors/create-vault-access-policy.png" alt-text="Screenshot that shows how to add access policies for your Azure key vault.":::

   :::image type="content" source="media/azure-key-vault-errors/review-and-create-vault-policy.png" alt-text="Screenshot that shows how to review and create the vault access policy.":::

## Error code 1000120

Error message: No organization ID tags found on key vault. Ensure that the tag {Bundle ID}.{organization-id} is present and uses the correct case sensitivity.

### Resolution steps

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments), select your environment.

   :::image type="content" source="media/azure-key-vault-errors/environment-tab.png" alt-text="Screenshot that shows the Environment tab in Power Platform admin center." lightbox="media/azure-key-vault-errors/environment-tab.png":::

2. Copy the **Organization ID**.

   :::image type="content" source="media/azure-key-vault-errors/organization-id.png" alt-text="Screenshot that shows the organization ID you can find in your environment in Power Platform admin center.":::

3. In your key vault, go to **Tags** and create a tag named **organization-id** with your organization ID as the value.

   :::image type="content" source="media/azure-key-vault-errors/add-tag.png" alt-text="Screenshot that shows how to add an organization ID to a tag in Azure portal." lightbox="media/azure-key-vault-errors/add-tag.png":::

## Error code 1000121

Error message: Android keystore isn't valid. Ensure that the tag {Bundle ID}.{keystore} is present and uses the correct case sensitivity.

### Resolution steps

1. Import your **Android Certificate**.

   :::image type="content" source="media/azure-key-vault-errors/import-certificate.png" alt-text="Screenshot that shows how to import an Android certificate." lightbox="media/azure-key-vault-errors/import-certificate.png":::

   :::image type="content" source="media/azure-key-vault-errors/certificate-name.png" alt-text="Screenshot that shows how to create an Android certificate." lightbox="media/azure-key-vault-errors/certificate-name.png":::

2. Add a **Tag** for your certificate:

   - **Tag name**: Use the same Bundle ID as your wrap project (for example, `com.testApp.wrap`).
   - **Tag value**: Use the certificate name you assigned when uploading (for example, `AndroidCertificate`).

   :::image type="content" source="media/azure-key-vault-errors/create-certificate-tag.png" alt-text="Screenshot that shows how to create a certificate tag." lightbox="media/azure-key-vault-errors/create-certificate-tag.png":::

## Error code 1000122

Error message: iOS certificate isn't valid. Missing Tag and/or Secret. Ensure that the tag {Bundle ID}.{cert} is present and uses the correct case sensitivity.

### Resolution steps

1. Import your **iOS Certificate**.

   :::image type="content" source="media/azure-key-vault-errors/import-certificate.png" alt-text="Screenshot that shows how to import an iOS certificate." lightbox="media/azure-key-vault-errors/import-certificate.png":::

   :::image type="content" source="media/azure-key-vault-errors/certificate-name-ios.png" alt-text="Screenshot that shows how to create an iOS certificate." lightbox="media/azure-key-vault-errors/certificate-name-ios.png":::

2. Add a **Tag** for your certificate:

   - **Tag name**: Use the Bundle ID from your wrap project.
   - **Tag value**: Use the certificate name you assigned when uploading (for example, `iOSCertificate`).

   :::image type="content" source="media/azure-key-vault-errors/certificate-tag-ios.png" alt-text="Screenshot that shows how to create a certificate tag for iOS." lightbox="media/azure-key-vault-errors/certificate-tag-ios.png":::

## Error code 1000123

Error message: iOS profile isn't valid. Ensure that the tag {Bundle ID}.{profile} is present and uses the correct case sensitivity.

### Resolution steps

1. Import your **Provisioning Profile** as a **Secret**.

2. Add a **Tag** for your provisioning profile:

   - **Tag name**: Use the Bundle ID from your wrap project.
   - **Tag value**: Use the name you gave the secret when uploading (for example, `iOSProvisioningProfile`).

   :::image type="content" source="media/azure-key-vault-errors/provisioning-profile-secret-tag.png" alt-text="Screenshot that shows how to create a tag for iOS Provisioning Profile Secret." lightbox="media/azure-key-vault-errors/provisioning-profile-secret-tag.png":::

## Error code 1000128

Error message: Missing access key required to access the Azure Blob Storage location. Ensure that the tag {Bundle ID}.{accessKey} is present and uses the correct case sensitivity.

### Resolution steps

Add your access key from the Azure Blob storage account to the Azure key vault.

For more information, see [Step 3: Choose target platform](/power-apps/maker/common/wrap/wrap-how-to#3-choose-target-platform).

## Error code 1000130

Error message: Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard isn't set.

### Resolution steps

1. Assign the resource ID of the Azure key vault you intend to use with your wrap application to the variable.

2. Confirm that the specified resource ID includes all required tags associated with the Bundle ID defined in the wrap wizard.

For more information, see [Step 3: Choose target platform](/power-apps/maker/common/wrap/wrap-how-to#3-choose-target-platform).

## Error code 1000131

Error message: No tags or missing access permission for the specified Azure Key Vault.

### Resolution steps

1. Assign the resource ID of the Azure key vault you intend to use with your wrap application to the variable.

2. Confirm that the specified resource ID includes all required tags associated with the Bundle ID defined in the wrap wizard.

3. Ensure you have permission to access your key vault:

   1. As a Microsoft Entra ID (formerly Azure AD) admin, add the service principal for the AppID "4e1f8dc5-5a42-45ce-a096-700fa485ba20" by running the following commands in PowerShell:

      ```powershell
      Connect-AzureAD -TenantId <your tenant ID>
      New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
      ```

   1. In the [Azure portal](https://portal.azure.com), under **Access Control (IAM)**, assign the **Reader** role to your service principal:

      1. Go to **Access control (IAM)**, and then select **Add role assignment**.

         :::image type="content" source="media/azure-key-vault-errors/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/azure-key-vault-errors/add-role-assignment.png":::

      1. Choose **Reader** under **Job function roles** and go to the **Members** tab.

         :::image type="content" source="media/azure-key-vault-errors/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/azure-key-vault-errors/add-members.png":::

      1. Search for your app name.

         :::image type="content" source="media/azure-key-vault-errors/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for your app." lightbox="media/azure-key-vault-errors/select-members-to-add-role.png":::

      1. Assign the **Reader** role.

         :::image type="content" source="media/azure-key-vault-errors/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to your app." lightbox="media/azure-key-vault-errors/assign-reader-role-to-wrap-keyvault-access-app.png":::

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

## Error code 1000132

Error message: Missing environment variable 'PA_Wrap_KV_ResourceID' for the targeted environment.

### Resolution steps

1. Check whether the environment variable `PA_Wrap_KV_ResourceID` exists in the target environment. If it doesn't, create it.

2. Ensure the name follows the correct naming convention without typos or formatting errors.

For more information, see [Step 3: Choose target platform](/power-apps/maker/common/wrap/wrap-how-to#3-choose-target-platform).

## Other issues

If your issue isn't covered here, or if the preceding steps don't resolve your problem, [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support) and provide detailed steps to reproduce the problem.

## Related information

- ["Something went wrong" error that occurs when using the wrap feature](something-went-wrong-error-codes.md)
- [Troubleshoot common issues when using the wrap feature](wrap-issues.md)
