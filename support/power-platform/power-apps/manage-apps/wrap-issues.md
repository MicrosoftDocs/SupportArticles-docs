---
title: Troubleshoot the wrap feature in Power Apps
description: Provides solutions to common issues when using the wrap feature in Power Apps.
ms.reviewer: sitaramp, koagarwa
ms.author: arijitba
author: arijitba
ms.date: 06/17/2025
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app
---
# Troubleshoot wrap feature issues in Power Apps

This guide provides solutions to common issues encountered when using the [wrap](/power-apps/maker/common/wrap/overview) feature in Microsoft Power Apps.

## Issue 1: Wrap build fails

If your wrap build fails, try the following actions:

### Verify image formats

All images in your wrap project must be in PNG format. Using other formats causes the build to fail. Use an image converter to convert images to `.png`.

> [!IMPORTANT]  
> Renaming a file extension to `.png` doesn't convert the image to PNG format.

### Check Azure key vault setup

- Ensure you create an Azure service principal and assign the correct role.
- For more information, see [Create Azure key vault for wrap in Power Apps](/power-apps/maker/common/wrap/create-key-vault-for-code-signing).

Your key vault must contain:

- **For iOS**: Two tags, one certificate, and one secret.
- **For Android**: One tag and one certificate.

---

## Issue 2: Wrap button is disabled

You can only wrap apps if you have edit permissions. Confirm you have the correct permissions for the app and try again.

---

## Issue 3: Unable to save your wrap project or trigger a build

Update to the latest version of the wrap solution and try again.

---

## Issue 4: Unable to install wrapped mobile app

Ensure your app is properly signed by configuring a key vault during the build process, or signing the app manually.

For more information, see:

- [Set up Key vault for automated signing](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

In addition, verify your device meets the [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

---

## Issue 5: Can't sign in or see data in wrapped app

If you can't sign in or see data in your wrapped app, try the following actions:

### Verify API permissions and access

- Ensure all required API permissions are configured and admin permissions are granted.

  :::image type="content" source="media/wrap-issues/api-permissions-2.png" alt-text="Screenshot that shows the API permissions for the app." lightbox="media/wrap-issues/api-permissions-2.png":::

- Ensure the `Add-AdminAllowedThirdPartyApps` script runs successfully.  
  For more information, see [Allow registered apps in your environment](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Check account type and redirect URIs

- Verify the Microsoft Entra app type is set to **Multitenant** and the supported account type is **Accounts in any organizational directory (Any Microsoft Entra ID tenant)**.

- Configure proper redirect URIs for iOS and Android:
  - For Android, confirm the hash is correct.  
  - For more information, see [Configure platform settings and redirect URIs](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

---

## Issue 6: Azure key vault errors in wrap for Power Apps

You might encounter these error codes in the wrap wizard:

| Error Code | Error Message |
|------------|-------------|
| [1000118](#error-code-1000118) | Default subscription not found or missing access permissions. |
| [1000119](#error-code-1000119) | Key vault doesn't exist or is missing access privileges. |
| [1000120](#error-code-1000120) | No organization ID tags found on key vault. |
| [1000121](#error-code-1000121) | Android keystore isn't valid. Missing tag and/or certificate. |
| [1000122](#error-code-1000122) | iOS certificate isn't valid. |
| [1000123](#error-code-1000123) | iOS profile isn't valid. |
| [1000128](#error-code-1000128) | Missing access key used while accessing Azure Blob storage location. |
| [1000130](#error-code-1000130) | Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard isn't set. |
| [1000131](#error-code-1000131) | Missing tags for the specified Azure Key Vault resourceID. |

### Error code 1000118

Erroe message: Default subscription not found, or missing access permissions.

#### Resolution steps

1. Ensure your Azure key vault is in the tenant's **Default subscription**.

2. As a Microsoft Entra ID (formerly Azure AD) admin, add the service principal for the AppID "4e1f8dc5-5a42-45ce-a096-700fa485ba20" by running the following commands in PowerShell:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

3. In the [Azure portal](https://portal.azure.com), under **Access Control (IAM)**, assign the **Reader** role to your service principal:

   1. Go to **Access control (IAM)**, and then select **Add role assignment**.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   1. Choose **Reader** under **Job function roles** and go to the **Members** tab.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   1. Search for your app name.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for your app." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   1. Assign the **Reader** role.

      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to your app." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

### Error code 1000119

Error message: Key vault doesn't exist, or Key vault is missing access privileges.

#### Resolution steps

1. Confirm your Azure key vault is in the tenant's **Default subscription**.

2. While creating the key vault, select **Vault access policy**.

   :::image type="content" source="media/wrap-issues/vault-acces-policy.png" alt-text="Select the Vault Access policy option under the Access configuration tab.":::

3. As a Microsoft Entra ID (formerly Azure AD) admin, add the service principal for the AppID "4e1f8dc5-5a42-45ce-a096-700fa485ba20" by running the following commands in PowerShell:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

4. In the [Azure portal](https://portal.azure.com), assign the **Reader** role as shown in the previous error code section.

5. Add access policies to the key vault:

   :::image type="content" source="media/wrap-issues/create-vault-access-policy.png" alt-text="Screenshot that shows how to add access policies for your Azure key vault.":::

   :::image type="content" source="media/wrap-issues/review-and-create-vault-policy.png" alt-text="Screenshot that shows how to review and create the vault access policy.":::

### Error code 1000120

Error message: No organization ID tags found on key vault.

#### Resolution steps

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments), select your environment.

   :::image type="content" source="media/wrap-issues/environment-tab.png" alt-text="Screenshot that shows the Environment tab in Power Platform admin center." lightbox="media/wrap-issues/environment-tab.png":::

2. Copy the **Organization ID**.

   :::image type="content" source="media/wrap-issues/organization-id.png" alt-text="Screenshot that shows the organization ID that you can find in your environment in Power Platform admin center.":::

3. In your key vault, go to **Tags** and create a tag named **organization-id** with your organization ID as the value.

   :::image type="content" source="media/wrap-issues/add-tag.png" alt-text="Screenshot that shows how to add an organization ID to a tag in Azure portal." lightbox="media/wrap-issues/add-tag.png":::

### Error code 1000121

Error message: Android keystore isn't valid. Missing Tag and/or Certificate.

#### Resolution steps

1. Import your **Android Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an Android certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name.png" alt-text="Screenshot that shows how to create an Android certificate." lightbox="media/wrap-issues/certificate-name.png":::

2. Add a **Tag** for your certificate:

   - **Tag name**: Use the same Bundle ID as your wrap project (for example, `com.testApp.wrap`).
   - **Tag value**: Use the certificate name you assigned when uploading (for example, `AndroidCertificate`).

   :::image type="content" source="media/wrap-issues/create-certificate-tag.png" alt-text="Screenshot that shows how to create a certificate tag." lightbox="media/wrap-issues/create-certificate-tag.png":::

### Error code 1000122

Error message: iOS certificate isn't valid.

#### Resolution steps

1. Import your **iOS Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an iOS certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name-ios.png" alt-text="Screenshot that shows how to create an iOS certificate." lightbox="media/wrap-issues/certificate-name-ios.png":::

2. Add a **Tag** for your certificate:

   - **Tag name**: Use the Bundle ID from your wrap project.
   - **Tag value**: Use the certificate name you assigned when uploading (for example, `iOSCertificate`).

   :::image type="content" source="media/wrap-issues/certificate-tag-ios.png" alt-text="Screenshot that shows how to create a certificate tag for iOS." lightbox="media/wrap-issues/certificate-tag-ios.png":::

### Error code 1000123

Error message: iOS profile isn't valid.

#### Resolution steps

1. Import your **Provisioning Profile** as a **Secret**.

2. Add a **Tag** for your provisioning profile:

   - **Tag name**: Use the Bundle ID from your wrap project.
   - **Tag value**: Use the name you gave the secret when uploading (for example, `iOSProvisioningProfile`).

   :::image type="content" source="media/wrap-issues/provisioning-profile-secret-tag.png" alt-text="Screenshot that shows how to create a tag for iOS Provisioning Profile Secret." lightbox="media/wrap-issues/provisioning-profile-secret-tag.png":::

### Error code 1000128

Error message: Missing access key used while accessing Azure Blob storage location.

#### Resolution steps

Add your access key from the Azure Blob storage account to the Azure key vault.

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Error code 1000130

Error message: Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard isn't set.

#### Resolution steps

- Missing environment variable - Verify whether the environment variable with the given name exists - "PA_Wrap_KV_ResourceID". If not create one 

- Add the resource ID for the Azure key vaults you intend to use with your wrap application.

- Ensure that all required tags are present for the resource ID linked to the Bundle ID specified in the wrap wizard.

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Error code 1000131

Error message: No tags or missing access permission for the specified Azure Key Vault.

#### Resolution steps

- Verify that the environment variable "PA_Wrap_KV_ResourceID" exists. If it does not, create it.

- Set this variable to the resource ID of the Azure Key Vault you intend to use with your Wrap application.

- Confirm that the specified resource ID includes all required tags associated with the Bundle ID defined in the Wrap Wizard.

- Verify your access permission for your key vault
  - As a Microsoft Entra ID (formerly Azure AD) admin, add the service principal for the AppID "4e1f8dc5-5a42-45ce-a096-700fa485ba20" by running the following commands in PowerShell:

     ```powershell
     Connect-AzureAD -TenantId <your tenant ID>
     New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
     ```
  - In the [Azure portal](https://portal.azure.com), under **Access Control (IAM)**, assign the **Reader** role to your service principal:
   1. Go to **Access control (IAM)**, and then select **Add role assignment**.
      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::
   1. Choose **Reader** under **Job function roles** and go to the **Members** tab.
      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::
   1. Search for your app name.
      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for your app." lightbox="media/wrap-issues/select-members-to-add-role.png":::
   1. Assign the **Reader** role.
      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to your app." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

---

## Issue 7: Fail to sign in to wrapped app

1. Ensure the user has access to the app. For more information, see [Share a canvas app with your organization](/power-apps/maker/canvas-apps/share-app).

2. If the user has app access but still can't sign in, check the [conditional Access policies in Microsoft Entra admin center](/entra/identity/monitoring-health/how-to-view-applied-conditional-access-policies).

3. Use the correlation ID from the failed sign-in screen for further troubleshooting.

---

## Issue 8: Error message: "Something went wrong. [5objp]"

This issue might occur due to a Signature Hash Key mismatch or a Redirect URI mismatch during the app authentication process.

#### Common root causes

##### Cause 1: Signature Hash Key mismatch

The APK is signed with a different key than the one registered in the Microsoft Entra ID application. This might occur if:

- A different keystore is used during the build process.

- The registered hash key is incorrectly generated or copied (for example, it includes extra spaces or invalid characters.)

##### Cause 2: Redirect URI mismatch

The redirect URI being used by the app doesn't match what's registered in the portal:

- Redirect URIs are case-sensitive. Mismatches might occur if the Bundle ID or URI is entered with incorrect casing.

- Special characters in the URI (such as `%2F`, `%3D`) must be properly encoded and match exactly what is registered in Microsoft Entra ID.

#### How to fix the issue

##### Verify the Signature Hash Key

1. [Generate the correct hash key](/power-apps/maker/common/wrap/code-sign-android#generate-keys) from the keystore used to sign the app.

2. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

3. In the app's navigation pane, select **Authentication**.

4. Under the **Platform configurations** section, locate the **Android** platform.

5. Check that your app's Signature Hash Key is listed and matches the hash key generated from your keystore.

6. If the hash key is missing or incorrect, add or update it as needed, and then save your changes.

##### Check the Redirect URI

1. Install [Android Studio](https://developer.android.com/studio) and set up an emulator.

2. Launch the emulator and drag the APK file onto it to install the app.

3. Open the app in the emulator, attempt to sign in, and note the error message.

4. On the error screen, locate the redirect URI being used.

5. If the hash key in the URI contains encoded characters (for example, `%2F`), decode them (`%2F` becomes `/`) to get the Signature Hash Key.

6. Copy the decoded Signature Hash Key.

7. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

8. Under **Authentication**, review the configured [redirect URIs](/entra/identity-platform/how-to-add-redirect-uri#add-a-redirect-uri).

9. If the redirect URI is missing, add it with the correct Bundle ID and Signature Hash Key, and then save your changes.

10. Compare the existing redirect URI character-by-character (including case and encoding) with the one registered in Microsoft Entra ID.

11. If manually entering the Bundle ID in the portal, double-check for case consistency.

#### Recommended practices

To avoid this error in the future:

- Always copy the Bundle ID and hash key directly from the project or build output.
- Use logging or emulator logs to inspect the exact redirect URI at runtime.
- Avoid manually typing or modifying hash keys or redirect URIs.
- Use [Android Studio](https://developer.android.com/studio) to verify your app configuration.

---

## Issue 9: Error message "Something went wrong [2002]" and error code 9n155

The error might occur when the app registration isn't configured to support [multitenant accounts](/security/zero-trust/develop/identity-supported-account-types#accounts-in-any-organizational-directory-only---multitenant).

#### Common root causes

This error typically occurs when the app registration is created using the wrap wizard, which by default sets the app to single-tenant mode. If the user doesn't manually update this setting or accidentally selects single tenant during manual app registration, wrap app is unable to authenticate, resulting in error code 9n155.

#### Resolution

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

2. In the **Essentials** section, locate **Supported account types**. It should be set to **Multiple organizations**. If not, set it to **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant)**.

3. Save your changes.

---

## Other issues

If your issue isn't covered here, or if the preceding steps don't resolve your problem, see [Next steps](#next-steps) to report your issue. Be prepared to provide detailed steps to reproduce the problem.

### Collecting diagnostic information

For troubleshooting sign-in issues, you can collect session details:

- For wrap wizard: On the sign-in screen, tap the gear icon in the upper-right corner and select **Session Details**.
- For mobile devices: After opening the app, press and hold the screen, and then select **Session Details**.

## Next steps

If your issue still persists, [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support).
