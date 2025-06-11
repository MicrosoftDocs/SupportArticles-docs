---

title: Troubleshooting the Wrap Feature in Power Apps  
description: Solutions for common issues when using the wrap feature in Power Apps.  
ms.reviewer: sitaramp, koagarwa  
ms.author: arijitba  
author: arijitba  
ms.date: 03/28/2025  
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app  
---

# Troubleshooting Wrap Feature Issues in Power Apps

This guide covers how to resolve frequent problems encountered with the wrap feature in Microsoft Power Apps.

## Issue 1: Wrap Build Fails

If the wrap build fails, try the following troubleshooting steps:

### Step 1: Ensure Images are PNG

Confirm that all images used in your wrap project are in PNG format. If you use any other format, the build won’t succeed. Convert images to *.png* with an image converter.

> [!IMPORTANT]  
> Changing a file extension to *.png* does not actually convert the image to PNG format.

### Step 2: Check Key Vault Setup

Verify that you have created an Azure service principal and assigned the correct role. Details are available in steps 1 and 2 of [Create native mobile apps for iOS and Android using wrap](/power-apps/maker/common/wrap/wrap-how-to).

Ensure your key vault contains the correct items:
- For iOS: two tags, one certificate, one secret
- For Android: one tag, one certificate

Learn more: [Create Azure key vault for wrap in Power Apps](/power-apps/maker/common/wrap/create-key-vault-for-code-signing).

## Issue 2: Wrap Button is Disabled

You can only wrap apps if you have edit permissions. Confirm you have the correct permissions for the app and try again.


## Issue 4: Unable to Install Wrapped Mobile App

Ensure your application is properly signed. This can be done by configuring a key vault during build, or by signing the app manually. See:
- [Set up Key vault for automated signing](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

Also verify your device meets these [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

## Issue 5: Cannot Sign In or See Data in Wrapped App

If you have trouble signing in or accessing data, check the following:
- Microsoft Entra app is set up properly.
- All required API permissions are configured. For more info and a screenshot, see below and [Configure API Permissions](/power-apps/maker/common/wrap/how-to):

  :::image type="content" source="media/wrap-issues/api-permissions-2.png" alt-text="Screenshot that shows the API permissions for the app." lightbox="media/wrap-issues/api-permissions-2.png":::

- The `Add-AdminAllowedThirdPartyApps` script ran successfully. Details: [Allow registered apps in your environment](/power-apps/maker/common/wrap/how-to).
- The Microsoft Entra app type is **Multitenant**. Under **Authentication**, the supported account type should be **Accounts in any organizational directory (Any Microsoft Entra ID tenant)**.
- Proper redirect URIs are set for iOS and Android. For Android, confirm the hash is correct. See [Configure platform settings and redirect URIs](/power-apps/maker/common/wrap/how-to).

## Issue 6: Azure Key Vault Errors in Wrap for Power Apps

You may encounter these error codes in the wrap wizard:

- [Error code 1000118: Default subscription not found or missing access permissions.](#error-code-1000118)
- [Error code 1000119: Key vault does not exist or is missing access privileges.](#error-code-1000119)
- [Error code 1000120: No organization ID tags found on key vault.](#error-code-1000120)
- [Error code 1000121: Android keystore is not valid. Missing tag and/or certificate.](#error-code-1000121)
- [Error code 1000122: iOS certificate is not valid.](#error-code-1000122)
- [Error code 1000123: iOS profile is not valid.](#error-code-1000123)
- [Error code 1000128: Missing access key used while accessing Azure Blob storage location.](#error-code-1000128)
- [Error code 1000130: Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard is not set.](#error-code-1000130)
- [Error code 1000131: Missing tags for the specified Azure Key Vault resourceID.](#error-code-1000131)

### Error code 1000118

| Error code | Description |
|------------|--------------------------|
|1000118     | Default subscription not found, or missing access permissions |

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Ensure your Azure key vault is in the tenant’s **Default subscription**.
2. As admin, run:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   ```
   ```powershell
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

3. In the [Azure portal](https://portal.azure.com), under **Access Control (IAM)**, add a **Reader** role assignment to the Service Principal.

   1. Go to **Access control (IAM)**, then select **Add role assignment**.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   2. Choose **Reader** under **Job function roles** and go to the **Members** tab.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   3. Search for **Wrap KeyVault Access App**.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for Wrap KeyVault Access App." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   4. Assign the **Reader** role.

      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to Wrap KeyVault Access App." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

### Error code 1000119

| Error code | Description |
|------------|--------------------------|
|1000119     | Keyvault does not exist, or Keyvault is missing access privileges |

1. Confirm your Azure key vault is in the tenant’s **Default subscription**.
2. While creating the key vault, select **Vault access policy**.

   :::image type="content" source="media/wrap-issues/vault-acces-policy.png" alt-text="Select the Vault Access policy option under the Access configuration tab.":::

3. As admin, run:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   ```
   ```powershell
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

4. In the [Azure portal](https://portal.azure.com), assign the **Reader** role as shown above.

   :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for Wrap KeyVault Access App." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to Wrap KeyVault Access App." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

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
|1000121     | Android keystore is not valid. Missing Tag and/or Certificate |

1. Import your **Android Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an Android certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name.png" alt-text="Screenshot that shows how to create an Android certificate." lightbox="media/wrap-issues/certificate-name.png":::

2. Add a **Tag** for your certificate:
   - **Tag name**: Use the same bundle id as your wrap project (for example, **com.testApp.wrap**).
   - **Tag value**: Use the certificate name you assigned while uploading (for example, **AndroidCertificate**).

    :::image type="content" source="media/wrap-issues/create-certificate-tag.png" alt-text="Screenshot that shows how to create a certificate tag." lightbox="media/wrap-issues/create-certificate-tag.png":::

### Error code 1000122

| Error code | Description |
|------------|--------------------------|
|1000122     | iOS certificate is not valid |

1. Import your **iOS Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an iOS certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name-ios.png" alt-text="Screenshot that shows how to create an iOS certificate." lightbox="media/wrap-issues/certificate-name-ios.png":::

2. Add a **Tag** for your certificate:
   - **Tag name**: Use the bundle id from your wrap project.
   - **Tag value**: Use the certificate name as uploaded (for example, **iOSCertificate**).

   :::image type="content" source="media/wrap-issues/certificate-tag-ios.png" alt-text="Screenshot that shows how to create a certificate tag for iOS." lightbox="media/wrap-issues/certificate-tag-ios.png":::

### Error code 1000123

| Error code | Description |
|------------|--------------------------|
|1000123     | iOS profile is not valid |

1. Import your **Provisioning Profile** as a **Secret**.
2. Add a **Tag** for your provisioning profile:
   - **Tag name**: Use the bundle id from your wrap project.
   - **Tag value**: Use the name you gave the secret when uploading (for example, **iOSProvisioningProfile**).

   :::image type="content" source="media/wrap-issues/provisioning-profile-secret-tag.png" alt-text="Screenshot that shows how to create a tag for iOS Provisioning Profile Secret." lightbox="media/wrap-issues/provisioning-profile-secret-tag.png":::

### Error code 1000128

| Error code | Description |
|------------|--------------------------|
|1000128     | Missing access key used while accessing azure blob storage location |

Add your access key from the Azure blob storage account to the Azure key vault. Learn more: [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Error code 1000130

| Error code      | Description          |
| ------------- |:-------------|
|1000130  |  Missing default value: The required environment variable for setting up Azure Key Vault in the wrap wizard is not set. |

To resolve this error, add the resourceID for the Azure Key Vaults you intend to use with your wrap application. Ensure that all required tags are present for the resourceID linked to the bundleID specified in the wrap wizard. For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

### Error code 1000131

| Error code      | Description          |
| ------------- |:-------------|
|1000131  |   Missing tags for the specified Azure Key Vault resourceID.|

After setting up Azure Key Vaults, add all required tags. Confirm that the resourceID associated with the bundleID in the wrap wizard includes every necessary tags. For more information [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

## Issue 7: Sign-in to Wrapped App Fails

1. Ensure the user has access to the app. See: [Share a canvas app with your organization](/power-apps/maker/canvas-apps/share-app).
2. If access exists, check [Conditional Access policies in Microsoft Entra admin center](/entra/identity/monitoring-health/how-to-view-applied-conditional-access-policies).
3. For more troubleshooting, copy the correlation ID shown on the failed sign-in screen and follow the instructions in [How to troubleshoot Microsoft Entra sign-in errors](/entra/identity/users/troubleshoot-sign-in).

## Issue 8 – Error Code: 5objp

**Reason:**  
The hash key or redirect URL used in the APK does not match the one registered in Azure AD, causing a mismatch error during authentication.

**How to Debug and Fix Redirect URI Issues (Android/Emulator):**
1. Install Android Studio and set up an emulator.
2. Launch the emulator and drag the APK file onto it to install the app.
3. Open the app in the emulator, attempt to log in, and observe the error message.
4. The error screen will display the redirect URI being used.
5. If the hash key in the URI contains encoded characters (e.g., `%2F`), decode them (e.g., `%2F` becomes `/`) to get the Signature Hash Key.
6. Copy the decoded Signature Hash Key.
7. In the Azure Portal, go to **App Registrations** and select the relevant app.
8. Under **Authentication**, review the configured Redirect URIs.
9. If the displayed redirect URI is missing, add it with the correct Bundle ID and Signature Hash Key, then save.

## Issue 9 – Error Code: 9n155

**Reason:**  
The app registration is not configured to support multi-tenant accounts.

**How to Fix:**
1. Go to the Azure Portal → **App Registrations** → select your app.
2. In **Overview**, find **Supported account types**. It should be set to "Multiple organizations".
3. If not, click to edit and select **Accounts in any organizational directory (Any Azure AD directory)**.
4. Save your changes.

## Other Issues

For issues not covered here, or if the above steps do not resolve your problem, see [Next steps](#next-steps) to report your issue. Be prepared to provide a repro.

- On the sign-in screen, tap the gear icon in the bottom right and select **Session Details**.
- After opening the app, press and hold the screen, then select **Session Details**.

## Next Steps

If your issue isn’t addressed here, you can [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support).
