---
title: MFA fails because five registered devices use authenticator apps
description: Learn how to resolve a scenario in which you can't set up multifactor authentication (MFA) because you already registered five devices to use authenticator apps.
ms.date: 06/23/2023
ms.editor: v-jsitser
ms.reviewer: gudlapreethi, bemey, filuz, robgarcia, azureidcic, v-leedennis
ms.service: active-directory
ms.subservice: enterprise-users
---
# Can't set up MFA because five devices are already registered to use an authenticator app

This article discusses how to resolve a scenario in which you can't set up multifactor authentication (MFA) because you already registered five devices to use authenticator apps.

## Symptoms

When you try to set up MFA, you receive the following error message:

> You cannot have more than 5 hardware tokens or authenticator apps. Please delete one or more of your authenticator apps and then add a new authenticator app. If you need to delete your hardware token, please contact your administrator. Disabling a hardware token will not allow you to add new authenticator app.
>
> You have too many devices registered.

## Cause

You previously set up five different phones or other devices to be registered for MFA by using an authenticator app. As a result, the maximum allowed number of device tokens (5) are already persisted in the `StrongAuthenticationPhoneAppDetail` property of your directory user object.

## Solution 1: Delete the sign-in methods directly in a web browser

To delete the device tokens, you can delete the sign-in methods from your security settings directly within a web browser. However, if you aren't an administrator, or you aren't the only administrator for your Microsoft Entra ID, you must first have someone else (the administrator or another administrator user) set the requirement for re-registering MFA in the procedure in the following section.

### Part 1: Have your administrator or another administrator user set the MFA re-registration requirement

> [!NOTE]  
> This procedure isn't required if you're the only administrator for your Microsoft Entra ID.

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.

1. In the Microsoft Entra navigation pane, locate the **Manage** heading, and then select **Users**.

1. In the list of Microsoft Entra users, select the **Display name** of the user.

1. In the navigation pane for the Microsoft Entra user, locate the **Manage** heading, and then select **Authentication methods**.

1. In the Microsoft Entra user menu, select **Require re-register multifactor authentication**.

### Part 2: Delete some or all of your sign-in methods

You can delete the device tokens by deleting the corresponding sign-in methods. Follow these steps:

1. To view your sign-in methods, go to <https://aka.ms/mysecurityinfo>.

   For example, the sign-in method list might include a phone method that's associated with a phone number, and an authenticator app method that's associated with a particular device. For more information, see [What authentication and verification methods are available in Microsoft Entra ID?](/azure/active-directory/authentication/concept-authentication-methods)

1. Delete any or all five of the sign-in methods that are listed.

   > [!WARNING]  
   > If you try to delete a [passwordless sign-in method](/azure/active-directory/authentication/concept-authentication-passwordless), you receive the following error message in a dialog box that contains the **Sign in** and **Cancel** buttons:
   >
   > > **Delete authenticator app**
   > >
   > > To delete this authenticator app, you need to sign in with two-factor authentication.
   >
   > To be able to delete the passwordless sign-in method, set up another two-factor authentication method (such as a phone call or an SMS text message) beforehand. Then, when you retry deleting the passwordless sign-in method, use that two-factor authentication method to sign in.

## Solution 2: Delete the authenticator apps by using Microsoft Graph

Global Administrators can delete a user's authenticator app by using the Microsoft Graph API. In some instances, the Microsoft Graph API is the only available solution (for example, if you're using the security defaults). To use this solution, you or your Global Administrator should sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) as a Global Administrator, and then follow these steps:

1. In the [query area of Graph Explorer](/graph/graph-explorer/graph-explorer-features#query-area), take the following actions:

   1. In the **HTTP methods** list, select **GET**.

   1. In the query box, enter `https://graph.microsoft.com/beta/users/<user-principal-name>/authentication/microsoftAuthenticatorMethods`. Replace the placeholder of the [user principal name](/azure/active-directory/hybrid/connect/howto-troubleshoot-upn-changes) (UPN) with the UPN of the user whose authentication app has to be deleted.

   1. Select the **Run query** button.

      > [!WARNING]  
      > If you experience a permission error when run the query, follow these steps to get the necessary permission:
      >
      > 1. Select the **Modify permissions** tab.
      >
      > 1. Select the **Open the permissions panel** link.
      >
      > 1. In the permissions panel, expand the **UserAuthenticationMethod** node, and then select the **UserAuthenticationMethod.ReadWrite.All** permission.
      >
      > 1. Select the **Consent** button.
      >
      > After you complete these steps, try again to run the query.

      In the response pane, the **Response header** tab displays JSON code that shows the authenticator method information. In the following example code snippet, the user is associated with a total of one authenticator method:

   ```json
   {
     "@odata.context": "https://graph.microsoft.com/beta/$metadata#users('user%40contoso.com')/authentication/microsoftAuthenticatorMethods",
     "value": [
       {
         "id": "01234567-89ab-cdef-0123-456789abcdef",
         "displayName": "SM-G973F",
         "deviceTag": "SoftwareTokenActivated",
         "phoneAppVersion": "6.2102.0762",
         "createdDateTime": null
       }
     ]
   }
   ```

1. In the response pane's **Response header** tab, copy and save the `id` property (a GUID) of each authenticator method that you want to delete.

1. In the query area, set **HTTP methods** to **DELETE**, and set **Query box** to `https://graph.microsoft.com/beta/users/<user-principal-name>/authentication/microsoftAuthenticatorMethods/<authenticator-id-guid>`. Enter the UPN and authenticator GUID to replace the placeholder values.

1. Select the **Run query** button. If this deletion query successfully deletes the authenticator app, the status message "No Content - 204 - \<query-execution-time>" appears.

1. Repeat steps 2–4 for each of the authenticator apps that you want to delete.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
