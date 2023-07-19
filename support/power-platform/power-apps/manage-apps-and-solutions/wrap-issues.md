---
title: Troubleshoot wrap issues
description: Provides resolutions for issues related to the wrap feature in Power Apps.
ms.reviewer: makolomi
ms.date: 07/19/2023
---
# Troubleshoot issues with the wrap feature in Power Apps

This article helps you resolve the most common issues with the wrap feature in Microsoft Power Apps.

## Issue 1 - Wrap build is failing

If your wrap build fails, you can take the following steps to solve the issue.

#### Step 1: Verify that your images are in a PNG format

Ensure that the images you're using in wrap are in a PNG format. Using images in any format other than PNG in wrap will cause the build to fail. Use an image converter to save your images as *.png* files or ensure that your original image files are in a PNG format instead.

> [!IMPORTANT]
> Manually changing your image file extension from *.jpeg* or any other format to *.png* won't automatically reformat the image to a PNG format.

#### Step 2: Verify that your App Center is correctly configured

Your App Center link must be created as an app within an organization and not a standalone app. The following screenshot shows how to create a new organization in wrap wizard.

:::image type="content" source="media/wrap-issues/new-app-center-location.png" alt-text="Screenshot that shows how to create a new app center location in wrap wizard.":::

For more information about how to automatically create a new location in wrap wizard, see [step 5: Manage output](/power-apps/maker/common/wrap/wrap-how-to#step-5-manage-output) in Create native mobile apps for iOS and Android using the wizard.

#### Step 3: Verify that your key vault configuration is correct

Make sure that an Azure service principal is created and the service principal role is added correctly. For more information, see steps 1 and 2 in [Create native mobile apps for iOS and Android using the wizard](/power-apps/maker/common/wrap/wrap-how-to#create-native-mobile-apps-for-ios-and-android-using-the-wizard).

Ensure that your key vault contains all necessary certificates, secrets, and tags for iOS, Android, or both:

- iOS: two tags, one certificate, and one secret
- Android: one tag and one certificate

For more information, see [Create Azure key vault for wrap in Power Apps](/power-apps/maker/common/wrap/create-key-vault-for-code-signing).

#### Step 4: Try again if you have all the proper configurations

If your wrap build still fails after you've verified that your wrap project has all the proper configurations, reach out to <pamobsup@microsoft.com>. For details, see the [Other issues in wrap](#other-issues-in-wrap-for-power-apps) section of this article.

## Issue 2 - Wrap button is disabled for my app

You can only wrap apps with edit permissions. Make sure that you have edit permissions for the app you want to wrap, and try again.

## Issue 3 - Can't save my project or trigger a wrap build

To resolve this issue, you can:

- Update to the latest wrap solution version and try again.
- Ensure that no UI validation errors block the **Save** or **Build** submission.

## Issue 4 - Can't install a wrapped mobile app on a device

Make sure that you've signed the outputted application. You can sign it by configuring a key vault and providing it at build trigger time or manually signing. For more information on code signing, see:

- [Set up Key vault for automated signing](/power-apps/maker/common/wrap/wrap-how-to#step-2-target-platform)
- [Code sign for iOS](/power-apps/maker/common/wrap/code-sign-ios)
- [Code sign for Android](/power-apps/maker/common/wrap/code-sign-android)

Verify that your mobile device meets these [minimum requirements](/power-apps/maker/common/wrap/overview#software-and-device-requirements).

## Issue 5 - Can't sign in to a wrapped mobile app or can't see data

If you can't sign in to your wrapped mobile app, verify that:

- Your Microsoft Azure Active Directory (AAD) app is properly configured.
- All API permissions for the app have been added correctly. For more information about how to see and configure API permissions for the app, see the below screenshot and [Configure API Permissions](/power-apps/maker/common/wrap/wrap-how-to#step-4-register-app).

  :::image type="content" source="media/wrap-issues/api-permissions.png" alt-text="Screenshot that shows the API permissions for the app." lightbox="media/wrap-issues/api-permissions.png":::

- The `Add-AdminAllowedThirdPartyApps` script was run successfully. For more information, see [Allow registered apps in your environment](/power-apps/maker/common/wrap/how-to).
- Your AAD app type is **Multitenant**. Under your AAD app's **Authentication** tab, supported account types should be **Accounts in any organizational directory (Any Azure AD directory – Multitenant)**.
- The proper redirect URIs have been created for iOS and Android. For Android, check that the hash is provided correctly. For more information about configuring a redirect URI, see [Configure platform settings](/azure/active-directory/develop/quickstart-register-app#configure-platform-settings).

## Issue 6 - Errors in Azure key vault in wrap for Power Apps

The following Azure key vault errors might appear in wrap for Power Apps and can be rectified.

#### Error code 1000118

| Error code      | Description          |
| ------------- |-------------|
|1000118    | Default subscription not found, or missing access permissions|

- Make sure your Azure key vault is in the **Default subscription** for your tenant.
- Run these commands in PowerShell as an admin:

  ```ps
  Connect-AzureAD -TenantId <your tenant ID>
  ```

  ```ps
  New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
  ```

- In the [Azure portal](https://portal.azure.com), go to your default subscription, on the **Access Control (IAM)** page, add a **Reader** role assignment to the **Service Principal** representing your app, for example, **Wrap KeyVault Access App**. Make sure that it's in the **Subscription's IAM** and **Keyvault's IAM**. Here are the steps:

   1. Go to the **Access control (IAM)** tab, and select the **Add role assignment** option under the **Add** menu button.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab.":::

   2. Select the **Job function roles** tab and make sure that the **Reader** role is selected. Then select the **Members** tab on the top menu.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   3. Search for **Wrap KeyVault Access App** on the **Members** tab.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for Wrap KeyVault Access App." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   4. Select **Wrap KeyVault Access App** and then select the **Review + assign** button on the bottom of the tab to assign the **Reader** role to it.
  
      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to Wrap KeyVault Access App.":::
  
#### Error code 1000119

| Error code      | Description          |
| ------------- |-------------|
|1000119    | Keyvault does not exist, or Keyvault is missing access privileges|

- Verify that your Azure key vault is in the **Default subscription** for your tenant.
- Make sure that the **Vault access policy** option is selected when you create your key vault.

   :::image type="content" source="media/wrap-issues/vault-acces-policy.png" alt-text="Select the Vault Access policy option under the Access configuration tab.":::

- Run these commands in PowerShell as an admin:

  ```ps
  Connect-AzureAD -TenantId <your tenant ID>
  ```

  ```ps
  New-AzureADServicePrincipal -AppId 4e1f8dc5-5a42-45ce-a096-700fa485ba20 -DisplayName "Wrap KeyVault Access App"
  ```

- In the [Azure portal](https://portal.azure.com), go to your default subscription, on the **Access Control (IAM)** page, add a **Reader** role assignment to the **Service Principal** representing your app, for example, **Wrap KeyVault Access App**. Make sure that it's in the **Subscription's IAM** and **Keyvault's IAM**. Here are the steps:

   1. Go to the **Access control (IAM)** tab, and select the **Add role assignment** option under the **Add** menu button.

      :::image type="content" source="media/wrap-issues/add-role-assignment.png" alt-text="Screenshot that shows the Add role assignment option in the Access control (IAM) tab." lightbox="media/wrap-issues/add-role-assignment.png":::

   2. Select the **Job function roles** tab and make sure that the **Reader** role is selected. Then select the **Members** tab on the top menu.

      :::image type="content" source="media/wrap-issues/add-members.png" alt-text="Screenshot that shows the Members tab on the top menu." lightbox="media/wrap-issues/add-members.png":::

   3. Search for **Wrap KeyVault Access App** on the **Members** tab.

      :::image type="content" source="media/wrap-issues/select-members-to-add-role.png" alt-text="Screenshot that shows how to search for Wrap KeyVault Access App." lightbox="media/wrap-issues/select-members-to-add-role.png":::

   4. Select **Wrap KeyVault Access App** and then select the **Review + assign** button on the bottom of the tab to assign the **Reader** role to it.
  
      :::image type="content" source="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png" alt-text="Screenshot that shows how to assign a Reader role to Wrap KeyVault Access App." lightbox="media/wrap-issues/assign-reader-role-to-wrap-keyvault-access-app.png":::

- Add access policies to your Azure key vault.

   :::image type="content" source="media/wrap-issues/create-vault-access-policy.png" alt-text="Screenshot that shows how to add access policies for your Azure key vault.":::

   :::image type="content" source="media/wrap-issues/review-and-create-vault-policy.png" alt-text="Screenshot that shows how to review and create vault access policy.":::

#### Error code 1000120

| Error code      | Description          |
| ------------- |-------------|
|1000120   | No organization ID tags found on key vault|

- Go to [Power Platform admin center](https://admin.powerplatform.microsoft.com/environments) and select **Environment** where your wrap project is.

   :::image type="content" source="media/wrap-issues/environment-tab.png" alt-text="Screenshot that shows the Environment tab in Power Platform admin center." lightbox="media/wrap-issues/environment-tab.png":::

- Copy the **Organization ID**.

   :::image type="content" source="media/wrap-issues/organization-id.png" alt-text="Screenshot that shows the organization ID that you can find in your environment in Power Platform admin center.":::

- In your key vault at [Azure portal](https://portal.azure.com), go to **Tags**, create a new tag named **organization-id**, and add your organization ID to this tag.

   :::image type="content" source="media/wrap-issues/add-tag.png" alt-text="Screenshot that shows how to add an organization ID to a tag in Azure portal.":::

#### Error code 1000121

| Error code      | Description          |
| ------------- |-------------|
|1000121    | Android keystore is not valid. Missing Tag and/or Certificate|

- Import your **Android Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an Android certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name.png" alt-text="Screenshot that shows how to create an Android certificate." lightbox="media/wrap-issues/certificate-name.png":::

- Add a new **Tag** for your **Certificate**.

   1. The **Tag name** should be based on the **bundle id** that you used in your **wrap project**. For example, if the **bundle id** for your wrapped app is **com.testApp.wrap**, then the new **Tag name** should be **com.testApp.wrap.keystore**.

   2. The **Tag value** should correspod to the name you chose for your **Certificate** when uploading a certificate file in the previous step. For example, if your **Cerfificate** is named **AndroidWrapCertificate**, then the value for the **Tag value** should also be **AndroidWrapCertificate**.

   :::image type="content" source="media/wrap-issues/create-certificate-tag.png" alt-text="Screenshot that shows how to create a certificate tag." lightbox="media/wrap-issues/create-certificate-tag.png:::
  
#### Error code 1000122

| Error code      | Description          |
| ------------- |:-------------|
|1000122    |  iOS certificate is not valid|

- Import your **iOS Certificate**.

   :::image type="content" source="media/wrap-issues/import-certificate.png" alt-text="Screenshot that shows how to import an iOS certificate." lightbox="media/wrap-issues/import-certificate.png":::

   :::image type="content" source="media/wrap-issues/certificate-name-ios.png" alt-text="Screenshot that shows how to create an iOS certificate." lightbox="media/wrap-issues/certificate-name-ios.png":::

- Add a new **Tag** for your **Certificate**.

 1. The **Tag name** should be based on the **bundle id** that you used in your **wrap project**. For example, if the **bundle id** for your wrapped app is **com.testApp.wrap**, then the new **Tag name** should be **com.testApp.wrap.cert**.

 2. The **Tag value** should correspod to the name you chose for your **Certificate** when uploading a certificate file in the previous step. For example, if your **Cerfificate** is named **iOSCertificate1**, then the value for the **Tag value** should also be **iOSCertificate1**.

  :::image type="content" source="media/wrap-issues/certificate-tag-ios.png" alt-text="Screenshot that shows how to create a certificate tag for iOS." lightbox="media/wrap-issues/certificate-tag-ios.png":::

#### Error code 1000123

| Error code      | Description          |
| ------------- |:-------------|
|1000123    |   iOS profile is not valid|

- Import your **Provisioning Profile** as a **Secret**.
- Add a new **Tag** for your **Provisioning Profile**.

   1. The **Tag name** should be based on the **bundle id** that you used in your **wrap project**. For example, if the **bundle id** for your wrapped app is **com.testApp.wrap**, then the new **Tag name** should be **com.testApp.wrap.profile**.

   2. The **Tag value** should correspond to the name you chose for your **Secret** when uploading a povisioning profile in the previous step. For example, if your **Secret** is named **iOSProvisioningProfileSecret**, then the value for the **Tag value** should also be **iOSProvisioningProfileSecret**.

  :::image type="content" source="media/wrap-issues/provisioning-profile-secret-tag.png" alt-text="Screenshot that shows how to create a tag for iOS Provisioning Profile Secret." lightbox="media/wrap-issues/provisioning-profile-secret-tag.png":::

## Other issues in wrap for Power Apps

For all other issues, or if your issue persists after following these steps, reach out to <pamobsup@microsoft.com>. You need to provide a repro video, screenshots, or both together with a session ID that can be acquired in the following ways:

- On the sign-in screen, go to the lower right to select the gear icon, and then select **Session Details**.
- After you open and app, shake your device, and then select **Session Details**.
