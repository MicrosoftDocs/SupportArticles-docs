---
title: Troubleshoot wrap issues in Power Apps
description: Provides resolutions for issues related to the wrap feature in Power Apps.
ms.reviewer: sitaramp, koagarwa
ms.author: arijitba
author: arijitba
ms.date: 03/28/2025
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app
---
# Troubleshoot issues with the wrap feature in Power Apps

This article helps you resolve the most common issues with the wrap feature in Microsoft Power Apps.

## Issue 1 - Wrap build is failing

If your wrap build fails, you can take the following steps to solve the issue.

#### Step 1: Verify that your images are in PNG format

Ensure that the images you use in wrap are in PNG format. Using images in any format other than PNG in wrap will cause the build to fail. Use an image converter to save your images as *.png* files, or ensure that your original image files are in PNG format.

> [!IMPORTANT]
> Manually changing your image file extension from *.jpeg* or any other format to *.png* won't automatically reformat the image to PNG format.

#### Step 2: Verify that your App Center is correctly configured

Your App Center link must be created as an app within an organization and not as a standalone app. The following screenshot shows how to create a new organization in wrap wizard.

:::image type="content" source="media/wrap-issues/new-app-center-location.png" alt-text="Screenshot that shows how to create a new app center location in wrap wizard.":::

For more information about how to automatically create a new location in wrap wizard, see [Step 5: Manage output](/power-apps/maker/common/wrap/wrap-how-to#step-5-manage-output) in the "Create native mobile apps for iOS and Android using the wizard" section.

#### Step 3: Verify that your key vault configuration is correct

Make sure that an Azure service principal is created, and the service principal role is added correctly. For more information, see steps 1 and 2 in [Create native mobile apps for iOS and Android using the wizard](/power-apps/maker/common/wrap/wrap-how-to#create-native-mobile-apps-for-ios-and-android-using-the-wizard).

Ensure that your key vault contains all necessary certificates, secrets, and tags for iOS, Android, or both:

- iOS: two tags, one certificate, and one secret
- Android: one tag and one certificate

For more information, see [Create Azure key vault for wrap in Power Apps](/power-apps/maker/common/wrap/create-key-vault-for-code-signing).

#### Step 4: Try again if you have all the proper configurations

If your wrap build still fails after you've verified that your wrap project has all the proper configurations, see the [Other issues in wrap](#other-issues-in-wrap-for-power-apps) section of this article.

## Issue 2 - Wrap button is disabled for my app

You can only wrap apps with edit permissions. Make sure that you have edit permissions to the app you want to wrap, and try again.

## Issue 3 - Can't save my project or trigger a wrap build

To resolve this issue, you can:

- Update to the latest wrap solution version and try again.
- Ensure that no UI validation errors block the **Save** or **Build** submission.

## Issue 4 - Can't install a wrapped mobile app on a device

Make sure that you've signed the outputted application. You can sign it by configuring a key vault and providing it at build trigger time, or manually signing. For more information on code signing, see:

- [Set up Key vault for automated signing](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

Verify that your mobile device meets these [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

## Issue 5 - Can't sign in to a wrapped mobile app or can't see data

If you can't sign in to your wrapped mobile app, verify that:

- Your Microsoft Entra app is properly configured.
- All API permissions for the app have been added correctly. For more information about how to see and configure API permissions for the app, see the following screenshot and [Configure API Permissions](/power-apps/maker/common/wrap/wrap-how-to#step-4-register-app).

  :::image type="content" source="media/wrap-issues/api-permissions-2.png" alt-text="Screenshot that shows the API permissions for the app." lightbox="media/wrap-issues/api-permissions-2.png":::

- The `Add-AdminAllowedThirdPartyApps` script has run successfully. For more information, see [Allow registered apps in your environment](/power-apps/maker/common/wrap/how-to).
- Your Microsoft Entra app type is **Multitenant**. Under your Microsoft Entra app's **Authentication** tab, the supported account type should be **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant)**.
- The proper redirect URIs have been created for iOS and Android. For Android, confirm that the hash is provided correctly. For more information about configuring a redirect URI, see [Configure platform settings](/azure/active-directory/develop/quickstart-register-app#configure-platform-settings).

## Issue 6 - Azure key vault errors in wrap for Power Apps

The following Azure key vault error codes might appear in wrap for Power Apps and can be rectified. Use the search feature to locate the specific error code displayed in the Power Apps wrap wizard portal and follow the appropriate steps to solve the error code.

- [Error code 1000118: Default subscription not found or missing access permissions.](#error-code-1000118)
- [Error code 1000119: Key vault does not exist or is missing access privileges.](#error-code-1000119)
- [Error code 1000120: No organization ID tags found on key vault.](#error-code-1000120)
- [Error code 1000121: Android keystore is not valid. Missing tag and/or certificate.](#error-code-1000121)
- [Error code 1000122: iOS certificate is not valid.](#error-code-1000122)
- [Error code 1000123: iOS profile is not valid.](#error-code-1000123)
- [Error code 1000128: Missing access key used while accessing Azure Blob storage location.](#error-code-1000128)

#### Error code 1000118

| Error code      | Description          |
| ------------- |-------------|
|1000118    | Default subscription not found, or missing access permissions|

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

1. Make sure that your Azure key vault is in your tenant's **Default subscription**.
2. Run these commands in PowerShell as an admin:

   ```powershell
   Connect-AzureAD -TenantId <your tenant ID>
   ```

   ```powershell
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

3. In the [Azure portal](https://portal.azure.com), go to your default subscription. On the **Access Control (IAM)** page, add a **Reader** role assignment to the **Service Principal** representing your app, for example, **Wrap KeyVault Access App**. Make sure that it's in the **Subscription's IAM** and **Keyvault's IAM**. Here are the steps:

   1. Go to the **Access control (IAM)** tab, and select the **Add role assignment** option under the **Add** menu button.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   2. Select the **Job function roles** tab, and make sure that the **Reader** role is selected. Then select the **Members** tab on the top menu.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   3. Search for **Wrap KeyVault Access App** on the **Members** tab.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for Wrap KeyVault Access App." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   4. Select **Wrap KeyVault Access App** and then select the **Review + assign** button at the bottom of the tab to assign it the **Reader** role.
  
      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to Wrap KeyVault Access App." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::
  
#### Error code 1000119

| Error code      | Description          |
| ------------- |-------------|
|1000119    | Keyvault does not exist, or Keyvault is missing access privileges|

1. Verify that your Azure key vault is in your tenant's **Default subscription**.
2. Make sure that the **Vault access policy** option is selected when you create your key vault.

   :::image type="content" source="media/wrap-issues/vault-acces-policy.png" alt-text="Select the Vault Access policy option under the Access configuration tab.":::

3. Run these commands in PowerShell as an admin:

   ```powershell
    Connect-AzureAD -TenantId <your tenant ID>
   ```

   ```powershell
   New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
   ```

4. In the [Azure portal](https://portal.azure.com), go to your default subscription. On the **Access Control (IAM)** page, add a **Reader** role assignment to the **Service Principal** representing your app, for example, **Wrap KeyVault Access App**. Make sure that it's in the **Subscription's IAM** and **Keyvault's IAM**. Here are the steps:

   1. Go to the **Access control (IAM)** tab, and select the **Add role assignment** option under the **Add** menu button.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   2. Select the **Job function roles** tab, and make sure that the **Reader** role is selected. Then select the **Members** tab on the top menu.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   3. Search for **Wrap KeyVault Access App** on the **Members** tab.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for Wrap KeyVault Access App." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   4. Select **Wrap KeyVault Access App** and then select the **Review + assign** button at the bottom of the tab to assign it the **Reader** role.
  
      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to Wrap KeyVault Access App." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

5. Add access policies to your Azure key vault.

   :::image type="content" source="media/wrap-issues/create-vault-access-policy.png" alt-text="Screenshot that shows how to add access policies for your Azure key vault.":::

   :::image type="content" source="media/wrap-issues/review-and-create-vault-policy.png" alt-text="Screenshot that shows how to review and create the vault access policy.":::

#### Error code 1000120

| Error code      | Description          |
| ------------- |-------------|
|1000120   | No organization ID tags found on key vault|

1. Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments), select **Environments** and then select the environment where your wrap project is.

   :::image type="content" source="media/wrap-issues/environment-tab.png" alt-text="Screenshot that shows the Environment tab in Power Platform admin center." lightbox="media/wrap-issues/environment-tab.png":::

2. Copy the **Organization ID**.

   :::image type="content" source="media/wrap-issues/organization-id.png" alt-text="Screenshot that shows the organization ID that you can find in your environment in Power Platform admin center.":::

3. In your key vault in the [Azure portal](https://portal.azure.com), go to **Tags**, create a new tag named **organization-id**, and add your organization ID to this tag.

   :::image type="content" source="media/wrap-issues/add-tag.png" alt-text="Screenshot that shows how to add an organization ID to a tag in Azure portal." lightbox="media/wrap-issues/add-tag.png":::

#### Error code 1000121

| Error code      | Description          |
| ------------- |-------------|
|1000121    | Android keystore is not valid. Missing Tag and/or Certificate|

1. Import your **Android Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an Android certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name.png" alt-text="Screenshot that shows how to create an Android certificate." lightbox="media/wrap-issues/certificate-name.png":::

2. Add a new **Tag** for your **Certificate**.

   - The **Tag name** should be based on the **bundle id** that you used in your wrap project. For example, if the **bundle id** for your wrapped app is **com.testApp.wrap**, then the new **Tag name** should be **com.testApp.wrap.keystore**.

   - The **Tag value** should correspond to the name you chose for your **Certificate** when uploading the certificate file in the previous step. For example, if your **Certificate** is named **AndroidWrapCertificate**, then the value of the **Tag value** should also be **AndroidWrapCertificate**.

    :::image type="content" source="media/wrap-issues/create-certificate-tag.png" alt-text="Screenshot that shows how to create a certificate tag." lightbox="media/wrap-issues/create-certificate-tag.png":::
  
#### Error code 1000122

| Error code      | Description          |
| ------------- |:-------------|
|1000122    |  iOS certificate is not valid|

1. Import your **iOS Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an iOS certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name-ios.png" alt-text="Screenshot that shows how to create an iOS certificate." lightbox="media/wrap-issues/certificate-name-ios.png":::

2. Add a new **Tag** for your **Certificate**.

   - The **Tag name** should be based on the **bundle id** that you used in your wrap project. For example, if the **bundle id** for your wrapped app is **com.testApp.wrap**, then the new **Tag name** should be **com.testApp.wrap.cert**.

   - The **Tag value** should correspond to the name you chose for your **Certificate** when uploading the certificate file in the previous step. For example, if your **Certificate** is named **iOSCertificate1**, then the value of the **Tag value** should also be **iOSCertificate1**.

   :::image type="content" source="media/wrap-issues/certificate-tag-ios.png" alt-text="Screenshot that shows how to create a certificate tag for iOS." lightbox="media/wrap-issues/certificate-tag-ios.png":::

#### Error code 1000123

| Error code      | Description          |
| ------------- |:-------------|
|1000123    |   iOS profile is not valid|

1. Import your **Provisioning Profile** as a **Secret**.
2. Add a new **Tag** for your **Provisioning Profile**.

   - The **Tag name** should be based on the **bundle id** that you used in your wrap project. For example, if the **bundle id** for your wrapped app is **com.testApp.wrap**, then the new **Tag name** should be **com.testApp.wrap.profile**.

   - The **Tag value** should correspond to the name you chose for your **Secret** when uploading the povisioning profile in the previous step. For example, if your **Secret** is named **iOSProvisioningProfileSecret**, then the value of the **Tag value** should also be **iOSProvisioningProfileSecret**.

   :::image type="content" source="media/wrap-issues/provisioning-profile-secret-tag.png" alt-text="Screenshot that shows how to create a tag for iOS Provisioning Profile Secret." lightbox="media/wrap-issues/provisioning-profile-secret-tag.png":::

#### Error code 1000128

| Error code      | Description          |
| ------------- |:-------------|
|1000128    |   Missing access key used while accessing azure blob storage location|

You need to add your access key to the Azure blob storage account in the Azure key vault. For more information, see [Step 2: Target platform](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform).

## Issue 7 - Wrap app sign-in fails

1. Verify if the user has access to the application. For more information, see [Share a canvas app with your organization](/power-apps/maker/canvas-apps/share-app).

2. If the user has access permissions, [review the app's Conditional Access policies in the Microsoft Entra admin center](/entra/identity/monitoring-health/how-to-view-applied-conditional-access-policies?tabs=microsoft-entra-admin-center#how-to-view-conditional-access-policies). Ensure you have a role that allows you to see both the sign-in logs and the Conditional Access policies.

3. To explore the results and troubleshoot sign-in errors, copy the correlation ID from the mobile screen showing the failed sign-in and follow the guide in [How to troubleshoot Microsoft Entra sign-in errors](/entra/identity/monitoring-health/howto-troubleshoot-sign-in-errors).

## Issue 8 - Error Code: 5objp

Reason for the above error code:The hash key or redirect URL used in the APK does not match the one registered in Azure AD, causing a mismatch error during authentication.

Steps to Debug and Fix Redirect URI Issues in Android App Using Emulator:
1.	Install Android Studio to set up an emulator on your system.
2.	Launch the emulator and drag and drop the APK file onto it to install the app.
3.	Open the app in the emulator, attempt to log in, and observe the error message.
4.	The error screen will display the redirect URI the app is trying to use.
5.	If the hash key in the URI contains encoded characters like %2, %3, etc., replace them with the correct characters (e.g., %2F becomes /) to decode the Signature Hash Key.
6.	Copy the decoded Signature Hash Key.
7.	Go to the Azure Portal → App Registrations → Select the relevant app.
8.	Under Authentication, check the list of configured Redirect URIs.
9.	If the displayed redirect URI is missing, add it by entering the Bundle ID and the Signature Hash Key, then save the changes.

## Other issues in wrap for Power Apps

For all other issues, or if your issue persists after following these steps, see [Next steps](#next-steps) later in this article to report the issue through a support request. You need to provide a repro video, screenshots, or both, and a session ID that can be get in the following ways:

- On the sign-in screen, go to the lower right corner to select the gear icon, and then select **Session Details**.
- After you open the app, tap and hold on the screen, and then select **Session Details**.



## Next steps

If your issue isn't listed in this article, you can [search for more support resources](https://powerapps.microsoft.com/support), or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support). For more information, see [Get Help + Support](/power-platform/admin/get-help-support).
