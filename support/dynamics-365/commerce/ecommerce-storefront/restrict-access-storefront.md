---
title: Restrict access to a storefront during testing or development in Dynamics 365 Commerce
description: Introduces how to restrict access to a Microsoft Dynamics 365 Commerce storefront while performing internal testing or development.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
---
# How to restrict access to a storefront during testing or development

This article introduces how to restrict access to your site to prevent external users from accessing the published storefront pages during internal testing or active development in Microsoft Dynamics 365 Commerce.

## Set up Azure AD B2C by using standard user flows

For information about how to configure Azure Active Directory B2C (Azure AD B2C) for your e-commerce site, see [Set up a B2C tenant in Commerce](/dynamics365/commerce/set-up-b2c-tenant).

## Restrict user access to storefront pages and block the creation of new users

To restrict user access to storefront pages in Commerce site builder, follow these steps:

1. Go to your site.
1. Select **Pages**, and then select the page to which you want to restrict user access.
1. Select the module or fragment slot, and then select **Edit**.
1. In the properties pane, select **Requires sign-in?** > **Finish editing**.
1. Select **Publish**.

To block the creation of new users in Microsoft Entra ID, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com/).
1. Select the Azure AD B2C application that you created for your site access.
1. In the left navigation, select **User flows**.
1. At the top of the **User Flows** page, select **New user flow**.
1. On the **Select a user flow type** page, select **Preview**.
1. In the middle of the page, select **Sign in v2**. Then follow the steps in [Set up a B2C tenant in Commerce](/dynamics365/commerce/set-up-b2c-tenant) to configure the flow as your site's standard user flow for Azure AD B2C during testing or development.

## More information

[Set up custom pages for user sign-ins](/dynamics365/commerce/custom-pages-user-logins)
