---
title: Something Went Wrong Error Codes in Power Apps
description: Provides solutions to error messages that occur when using the wrap feature in Power Apps.
ms.reviewer: sitaramp, koagarwa
ms.author: arijitba
author: arijitba
ms.date: 08/04/2025
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sap:App Management\Wrap an app
---
# "Something went wrong" error that occurs when using the wrap feature

This article provides solutions to error messages that occur when using the [wrap](/power-apps/maker/common/wrap/overview) feature in Microsoft Power Apps. These errors often occur when steps in the wrap wizard, such as permissions or registration, are missed, even if the build succeeds but login fails.

## Error message: "Something went wrong. [5objp]"

This issue might occur due to a signature hash key mismatch or a redirect URI mismatch during the app authentication process.

#### Cause 1: Signature hash key mismatch

The APK is signed with a different key than the one registered in the Microsoft Entra ID application. This issue might occur if:

- A different keystore is used during the build process.
- The registered hash key is incorrectly generated or copied (for example, it includes extra spaces or invalid characters).

To resolve this issue, verify that the signature hash key is correct:

1. [Generate the correct hash key](/power-apps/maker/common/wrap/code-sign-android#generate-key-and-signature-hash) from the keystore used to sign the app.

2. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

3. In the app's navigation pane, select **Authentication**.

4. Under the **Platform configurations** section, locate the **Android** platform.

5. Check if your app's signature hash key is listed and matches the hash key generated from your keystore.

6. If the hash key is missing or incorrect, add or update it as needed, and then save your changes.

#### Cause 2: Redirect URI mismatch

The redirect URI being used by the app doesn't match what's registered in the portal:

- Redirect URIs are case-sensitive. Mismatches might occur if the Bundle ID or URI is entered with incorrect casing.
- Special characters in the URI (such as `%2F` and `%3D`) must be properly encoded and match exactly what's registered in Microsoft Entra ID.

To resolve this issue, verify that the redirect URI is correct:

1. Install [Android Studio](https://developer.android.com/studio) and set up an emulator.

2. Launch the emulator and drag the APK file onto it to install the app.

3. Open the app in the emulator, attempt to sign in, and note the error message.

4. On the error screen, locate the redirect URI being used.

5. If the hash key in the URI contains encoded characters (for example, `%2F`), decode them (`%2F` becomes `/`) to get the signature hash key.

6. Copy the decoded signature hash key.

7. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

8. Under **Authentication**, review the configured [redirect URIs](/entra/identity-platform/how-to-add-redirect-uri#add-a-redirect-uri).

9. If the redirect URI is missing, add it with the correct Bundle ID and signature hash key, and then save your changes.

10. Compare the existing redirect URI character by character (including case and encoding) with the one registered in Microsoft Entra ID.

11. If manually entering the Bundle ID in the portal, double-check for case consistency.

### Recommended practices

To avoid this error in the future:

- Always copy the Bundle ID and hash key directly from the project or build output.
- Use logging or emulator logs to inspect the exact redirect URI at runtime.
- Avoid manually typing or modifying hash keys or redirect URIs.
- Use [Android Studio](https://developer.android.com/studio) to verify your app configuration.

## Error message: "Something went wrong [2002]" and error code 9n155

The error might occur when the app registration isn't configured to support [multitenant accounts](/security/zero-trust/develop/identity-supported-account-types#accounts-in-any-organizational-directory-only---multitenant).

#### Cause

This error typically occurs when the app registration is created using the wrap wizard, which, by default, sets the app to single-tenant mode. If the user doesn't manually update this setting or accidentally selects single tenant during manual app registration, the wrap app is unable to authenticate, resulting in error code 9n155.

#### Resolution

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), go to **App registrations** and select your app.

2. In the **Essentials** section, locate **Supported account types**. It should be set to **Multiple organizations**. If not, set it to **Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant)**.

3. Save your changes.

## Other issues

If your issue isn't covered here, or if the preceding steps don't resolve your problem, [search for more support resources](https://powerapps.microsoft.com/support) or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support) with detailed steps to reproduce the problem.

## Related information

- [Azure key vault errors in wrap for Power Apps](azure-key-vault-errors.md)
- [Troubleshoot common issues when using the wrap feature](wrap-issues.md)
