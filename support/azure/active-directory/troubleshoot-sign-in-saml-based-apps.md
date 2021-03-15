---
title: Problems signing in to SAML-based single sign-on configured apps
description: Guidance for the specific errors when signing into an application you have configured for SAML-based federated single sign-on with Azure Active Directory.
ms.date: 03/15/2021
ms.prod-support-area-path: 
ms.reviewer: bernawy
---

# Problems signing in to SAML-based single sign-on configured apps
To troubleshoot the sign-in issues below, we recommend the following to better diagnosis and automate the resolution steps:

- Install the [My Apps Secure Browser Extension](https://docs.microsoft.com/azure/active-directory/manage-apps/my-apps-deployment-plan) to help Azure Active Directory (Azure AD) to provide better diagnosis and resolutions when using the testing experience in the Azure portal.
- Reproduce the error using the testing experience in the app configuration page in the Azure portal. Learn more on [Debug SAML-based single sign-on applications](https://docs.microsoft.com/azure/active-directory/manage-apps/debug-saml-sso-issues)

If you use the [testing experience](https://docs.microsoft.com/azure/active-directory/manage-apps/debug-saml-sso-issues) in the Azure portal with the My Apps Secure Browser Extension, you don't need to manually follow the steps below to open the SAML-based single sign-on configuration page.

To open the SAML-based single sign-on configuration page:
1.  Open the [**Azure portal**](https://portal.azure.com/) and sign in as a **Global Administrator** or **Coadmin**.
1.  Open the **Azure Active Directory Extension** by selecting **All services** at the top of the main left-hand navigation menu.
1.  Type **“Azure Active Directory"** in the filter search box and select the **Azure Active Directory** item.
1.  Select **Enterprise Applications** from the Azure Active Directory left-hand navigation menu.
1.  Select **All Applications** to view a list of all your applications.

    If you do not see the application you want show up here, use the **Filter** control at the top of the **All Applications List** and set the **Show** option to **All Applications**.

1.  Select the application you want to configure for single sign-on.
1. Once the application loads, select **Single sign-on** from the application’s left-hand navigation menu.
1. Select SAML-based SSO.
