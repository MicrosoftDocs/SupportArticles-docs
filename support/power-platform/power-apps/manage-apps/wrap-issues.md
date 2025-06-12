---
title: Troubleshooting the Wrap Feature in Power Apps  
description: Solutions for common issues when using the wrap feature in Power Apps.  
ms.reviewer: sitaramp, koagarwa  
ms.author: arijitba  
author: arijitba  
ms.date: 06/12/2025  
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app  
---
# Troubleshooting wrap feature issues in Power Apps

This guide provides solutions for common issues encountered when using the [wrap](/power-apps/maker/common/wrap/overview) feature in Microsoft Power Apps.

## Issue 1: Wrap build fails

If your wrap build fails, try the following steps:

1. Verify image formats:

   All images in your wrap project must be in PNG format. Using other formats will cause the build to fail. Use an image converter to convert images to `.png`.

   > [!IMPORTANT]  
   > Renaming a file extension to `.png` doesn't convert the image to PNG format.

2. Check Azure key vault setup:

   - Ensure you have created an Azure service principal and assigned the correct role.
   - For more information, see [Create Azure key vault for wrap in Power Apps](/power-apps/maker/common/wrap/create-key-vault-for-code-signing).

   Your key vault must contain:

   - For iOS: Two tags, one certificate, and one secret.
   - For Android: One tag and one certificate.

## Issue 2: Wrap button is disabled

You can only wrap apps if you have edit permissions. Confirm you have the correct permissions for the app and try again.

## Issue 3: Unable to save your wrap project or trigger a build

Update to the latest version of the wrap solution and try again.

## Issue 4: Unable to install wrapped mobile app

Ensure your app is properly signed. You can do this by configuring a key vault during the build process or by signing the app manually. For more information, see:

- [Set up Key vault for automated signing](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

Also, verify your device meets the [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

## Issue 5: Can't sign in or see data in wrapped app

If you can't sign in or see data in your wrapped app, try the following steps:

- Ensure all required API permissions are configured and admin permissions are granted.

  :::image type="content" source="media/wrap-issues/api-permissions-2.png" alt-text="Screenshot that shows the API permissions for the app." lightbox="media/wrap-issues/api-permissions-2.png":::

- Ensure the `Add-AdminAllowedThirdPartyApps` script has been run successfully.  
  For more information, see [Allow registered apps in your environment](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).
- Verify the Microsoft Entra app type is set to **Multitenant** and the supported account type is **Accounts in any organizational directory (Any Microsoft Entra ID tenant)**.
- Configure proper redirect URIs for iOS and Android:
  - For Android, confirm the hash is correct.  
  - For more information, see [Configure platform settings and redirect URIs](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

## Issue 6: Azure key vault errors in wrap for Power Apps

You may encounter these error codes in the wrap wizard:

- [Error code 1000118: Default subscription not found or missing access permissions.](#error-code-1000118)
- [Error code 1000119: Key vault doesn't exist or is missing access privileges.](#error-code-1000119)
- [Error code 1000120: No organization ID tags found on key vault.](#error-code-1000120)
- [Error code 1000121: Android keystore isn't valid. Missing tag and/or certificate.](#error-code-1000121)
- [Error code 1000122: iOS certificate isn't valid.](#error-code-1000122)
- [Error code 1000123: iOS profile isn't valid.](#error-code-1000123)
- [Error code 1000128: Missing access key used while accessing Azure Blob storage location.](#error-code-1000128)
- [Error code 1000130: Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard isn't set.](#error-code-1000130)
- [Error code 1000131: Missing tags for the specified Azure Key Vault resourceID.](#error-code-1000131)

For each error, follow the recommended steps below:

### Error code 1000118

| Error code | Description |
|------------|--------------------------|
|1000118     | Default subscription not found, or missing access permissions |

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Ensure your Azure key vault is in the tenant's **Default subscription**.
2. As an admin, run the following commands in PowerShell:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   ```

   ```powershell
   New-AzureADServicePrincipal -AppId <AppName> -DisplayName <AppDisplayName>
   ```

3. In the [Azure portal](https://portal.azure.com), under **Access Control (IAM)**, assign the **Reader** role to your service principal.

   1. Go to **Access control (IAM)**, then select **Add role assignment**.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   2. Choose **Reader** under **Job function roles** and go to the **Members** tab.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   3. Search for your app name.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for your app." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   4. Assign the **Reader** role.

      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to your app." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

### Error code 1000119

| Error code | Description |
|------------|--------------------------|
|1000119     | Key vault doesn't exist, or Key vault is missing access privileges |

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Confirm your Azure key vault is in the tenant's **Default subscription**.
2. While creating the key vault, select **Vault access policy**.

   :::image type="content" source="media/wrap-issues/vault-acces-policy.png" alt-text="Select the Vault Access policy option under the Access configuration tab.":::

3. As an admin, run the following commands in PowerShell:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   ```

   ```powershell
   New-AzureADServicePrincipal -AppId <AppName> -DisplayName <DisplayName>
   ```

4. In the [Azure portal](https://portal.azure.com), assign the **Reader** role as shown above.

   :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for your app." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to your app." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

5. Add access policies to the key vault:

   :::image type="content" source="media/wrap-issues/create-vault-access-policy.png" alt-text="Screenshot that shows how to add access policies for your Azure key vault.":::

   :::image type="content" source="media/wrap-issues/review-and-create-vault-policy.png" alt-text="Screenshot that shows how to review and create the vault access policy.":::

### Error code 1000120

| Error code | Description |
|------------|--------------------------|
|1000120     | No organization ID tags found on key vault |

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments), select your environment.

   :::image type="content" source="media/wrap-issues/environment-tab.png" alt-text="Screenshot that shows the Environment tab in Power Platform admin center." lightbox="media/wrap-issues/environment-tab.png":::

2. Copy the **Organization ID**.

   :::image type="content" source="media/wrap-issues/organization-id.png" alt-text="Screenshot that shows the organization ID that you can find in your environment in Power Platform admin center.":::

3. In your key vault, go to **Tags** and create a tag named **organization-id** with your organization ID as the value.

   :::image type="content" source="media/wrap-issues/add-tag.png" alt-text="Screenshot that shows how to add an organization ID to a tag in Azure portal." lightbox="media/wrap-issues/add-tag.png":::

### Error code 1000121

| Error code | Description |
|------------|--------------------------|
|1000121     | Android keystore isn't valid. Missing Tag and/or Certificate |

1. Import your **Android Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an Android certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name.png" alt-text="Screenshot that shows how to create an Android certificate." lightbox="media/wrap-issues/certificate-name.png":::

2. Add a **Tag** for your certificate:

   - **Tag name**: Use the same Bundle ID as your wrap project (for example, `com.testApp.wrap`).
   - **Tag value**: Use the certificate name you assigned while uploading (for example, `AndroidCertificate`).

    :::image type="content" source="media/wrap-issues/create-certificate-tag.png" alt-text="Screenshot that shows how to create a certificate tag." lightbox="media/wrap-issues/create-certificate-tag.png":::

### Error code 1000122

| Error code | Description |
|------------|--------------------------|
|1000122     | iOS certificate isn't valid |

1. Import your **iOS Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an iOS certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name-ios.png" alt-text="Screenshot that shows how to create an iOS certificate." lightbox="media/wrap-issues/certificate-name-ios.png":::

2. Add a **Tag** for your certificate:

   - **Tag name**: Use the Bundle ID from your wrap project.
   - **Tag value**: Use the certificate name you assigned while uploading (for example, `iOSCertificate`).

   :::image type="content" source="media/wrap-issues/certificate-tag-ios.png" alt-text="Screenshot that shows how to create a certificate tag for iOS." lightbox="media/wrap-issues/certificate-tag-ios.png":::

### Error code 1000123

| Error code | Description |
|------------|--------------------------|
|1000123     | iOS profile isn't valid |

1. Import your **Provisioning Profile** as a **Secret**.

2. Add a **Tag** for your provisioning profile:

   - **Tag name**: Use the Bundle ID from your wrap project.
   - **Tag value**: Use the name you gave the secret when uploading (for example, `iOSProvisioningProfile`).

   :::image type="content" source="media/wrap-issues/provisioning-profile-secret-tag.png" alt-text="Screenshot that shows how to create a tag for iOS Provisioning Profile Secret." lightbox="media/wrap-issues/provisioning-profile-secret-tag.png":::

### Error code 1000128

| Error code | Description |
|------------|--------------------------|
|1000128     | Missing access key used while accessing Azure Blob storage location |

Add your access key from the Azure Blob storage account to the Azure key vault.

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Error code 1000130

| Error code      | Description          |
| ------------- |:-------------|
|1000130  |  Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard isn't set. |

- Add the resource ID for the Azure Key Vaults you intend to use with your wrap application.
- Ensure that all required tags are present for the resource ID linked to the Bundle ID specified in the wrap wizard.

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Error code 1000131

| Error code      | Description          |
| ------------- |:-------------|
|1000131  |   Missing tags for the specified Azure Key Vault resourceID.|

- After setting up Azure Key Vaults, add all required tags.
- Confirm that the resource ID associated with the Bundle ID specified in the wrap wizard includes every necessary tag.

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

## Issue 7: Fail to sign in to wrapped app

1. Ensure the user has access to the app. For more information, see [Share a canvas app with your organization](/power-apps/maker/canvas-apps/share-app).
2. If the user has app access but still can't sign in, check the [conditional Access policies in Microsoft Entra admin center](/entra/identity/monitoring-health/how-to-view-applied-conditional-access-policies).
3. Use the correlation ID from the failed sign-in screen for further troubleshooting.

## Issue 8: Error code 5objp

### Cause

The Signature Hash Key or redirect URI used in the Android Package Kit (APK) file doesn't match the one registered in Microsoft Entra ID (formerly Azure Active Directory), causing a mismatch error during authentication.

### Resolution

To troubleshoot and resolve redirect URI issues for Android:

1. Install [Android Studio](https://developer.android.com/studio) and set up an emulator.
2. Launch the emulator and drag the APK file onto it to install the app.
3. Open the app in the emulator, attempt to sign in, and note the error message.
4. On the error screen, locate the redirect URI being used.
5. If the hash key in the URI contains encoded characters (for example, `%2F`), decode them (`%2F` becomes `/`) to get the Signature Hash Key.
6. Copy the decoded Signature Hash Key.
7. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.
8. Under **Authentication**, review the configured [redirect URIs](/entra/identity-platform/how-to-add-redirect-uri#add-a-redirect-uri).
9. If the redirect URI is missing, add it with the correct Bundle ID and Signature Hash Key, then save your changes.

## Issue 9: Error code 9n155

### Cause

The app registration isn't configured to support [multitenant accounts](/security/zero-trust/develop/identity-supported-account-types#accounts-in-any-organizational-directory-only---multitenant).

### Resolution

To resolve this issue:

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

2. In the **Essentials** section, locate **Supported account types**. It should be set to **Multiple organizations**. If not, set it to **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant)**.

3. Save your changes.

## Other issues

If your issue isn't covered here, or if the steps above don't resolve your problem, see [Next steps](#next-steps) to report your issue. Be prepared to provide detailed steps to reproduce the problem.

For troubleshooting sign-in issues, you can collect session details:

- On the sign-in screen, tap the gear icon in the bottom right and select **Session Details**.
- After opening the app, press and hold the screen, then select **Session Details**.

## Next steps

If your issue still persists, [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support).
