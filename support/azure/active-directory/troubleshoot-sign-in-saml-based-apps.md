---
title: Problems signing in to SAML-based Single Sign-On configured apps
description: Guidance for the specific errors when signing into an application you have configured for SAML-based federated Single Sign-On with Microsoft Entra ID.
ms.date: 07/18/2023
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---

# Problems signing in to SAML-based Single Sign-On configured apps

To troubleshoot the sign-in issues below, we recommend the following to better diagnosis and automate the resolution steps:

- Install the [My Apps Secure Browser Extension](/azure/active-directory/manage-apps/my-apps-deployment-plan) to help Microsoft Entra ID to provide better diagnosis and resolutions when using the testing experience in the Azure portal.
- Reproduce the error using the testing experience in the app configuration page in the Azure portal. Learn more on [Debug SAML-based Single Sign-On applications](/azure/active-directory/manage-apps/debug-saml-sso-issues)

If you use the [testing experience](/azure/active-directory/manage-apps/debug-saml-sso-issues) in the Azure portal with the My Apps Secure Browser Extension, you don't need to manually follow the steps below to open the SAML-based Single Sign-On configuration page.

To open the SAML-based Single Sign-On configuration page:

1. Open the [**Azure portal**](https://portal.azure.com/) and sign in as a **Global Administrator** or **Coadmin**.
1. Open the **Microsoft Entra Extension** by selecting **All services** at the top of the main left-hand navigation menu.
1. Type **“Microsoft Entra ID"** in the filter search box and select the **Microsoft Entra ID** item.
1. Select **Enterprise Applications** from the Microsoft Entra left-hand navigation menu.
1. Select **All Applications** to view a list of all your applications.

    If you do not see the application you want show up here, use the **Filter** control at the top of the **All Applications List** and set the **Show** option to **All Applications**.

1. Select the application you want to configure for Single Sign-On.
1. Once the application loads, select **Single Sign-On** from the application’s left-hand navigation menu.
1. Select SAML-based SSO.

## General troubleshooting

### Problem when customizing the SAML claims sent to an application

To learn how to customize the SAML attribute claims sent to your application, see [Claims mapping in Microsoft Entra ID](/azure/active-directory/develop/active-directory-claims-mapping).

### Errors related to misconfigured apps

Verify both the configurations in the portal match what you have in your app. Specifically, compare Client/Application ID, Reply URLs, Client Secrets/Keys, and App ID URI.

Compare the resource you’re requesting access to in code with the configured permissions in the **Required Resources** tab to make sure you only request resources you’ve configured.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
