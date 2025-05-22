---
title: Sign-in link redirects back to an e-commerce site in Dynamics 365 Commerce
description: Provides a resolution for an issue where a sign-in link redirects back to the e-commerce site instead of going to the sign-in page in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 05/22/2025
ms.custom: sap:Channel management\Issues with B2C channel configuration
---
# Sign-in link redirects back to an e-commerce site

This article provides a resolution for an issue where a sign-in link redirects back to the e-commerce site instead of going to the sign-in page in Microsoft Dynamics 365 Commerce.

## Symptoms

After you configure a new [Microsoft Azure Active Directory B2C (Azure AD B2C)](/dynamics365/commerce/set-up-b2c-tenant) tenant in Commerce site builder, users who select the **Sign in** link are redirected back to the main e-commerce landing page without going to the sign-in page.

## Resolution

To solve this issue, follow these steps to confirm that the reply URL is correctly configured in the Azure AD B2C application:

1. Go to the [Azure portal](https://portal.azure.com/).
1. Select the Azure AD B2C application that you created for your site access.
1. Select the application that you created during the Azure AD B2C setup.
1. Under **Reply URL**, make sure that the list includes entries for both the site domain URL and the e-commerce-generated URL, as shown in the following example.

   :::image type="content" source="media/sign-in-redirects-back/aad-b2c-reply-url.png" alt-text="Screenshot that shows the Azure AD B2C Reply URL entries.":::

> [!NOTE]
> Both the site domain URL and the e-commerce-generated URL must be in a valid URL format that doesn't include leading or trailing slashes.

## More information

[Register a web application in Azure Active Directory B2C](/azure/active-directory-b2c/tutorial-register-applications?tabs=app-reg-ga#register-a-web-application)
