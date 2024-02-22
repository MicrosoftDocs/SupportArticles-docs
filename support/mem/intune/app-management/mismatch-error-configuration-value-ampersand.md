---
title: Mismatch error if Intune app configuration value has ampersand
description: Provides the resolution to solve the mismatch between the value type and the configuration value error for a Microsoft Intune app configuration policy.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:iOS app configuration profiles
ms.reviewer: kaushika
---
# Mismatch error when configuration value has an ampersand in Intune

This article provides the methods to solve the mismatch error that occurs if the configuration value has an ampersand (&amp;) in Microsoft Intune.

## Symptoms

Consider the following scenario:

- You [create an app configuration policy](/mem/intune/apps/app-configuration-policies-use-ios#create-an-app-configuration-policy) for managed iOS devices in Intune.
- Under **Configuration settings** > **Configuration settings format**, you select **Use configuration designer**.
- You add a setting in which the **Configuration value** is a URL that contains an ampersand (&amp;). The following is an example:

    **Configuration key:** `ssoAuthEndpoint`  
    **Value type:** String  
    **Configuration value:** `https://sso.contoso.com/idpov/accesslogin/FedSSODispatch.faces?PartnerIdpId=https://sts.windows.net/{GUID}/&TargetResource=https://sso.contoso.com/idprov/pages/home/dispatch.jsp?SpName=MBF`

When you click **OK** to save the configuration setting, you receive the following error message :

> Mismatch between the value type and the configuration value in the configuration settings designer  
> The configuration settings designer has a value type as String but a configuration value as "https://sso.contoso.com/idpov/accesslogin/FedSSODispatch.faces?PartnerIdpId=https://sts.windows.net/{GUID}/&TargetResource=https://sso.contoso.com/idprov/pages/home/dispatch.jsp?SpName=MBF", which has invalid characters XML format doesn't support. Please correct it accordingly.

:::image type="content" source="media/mismatch-error-configuration-value-ampersand/value-mismatch-error.png" alt-text="Screenshot of the Mismatch between the value type and the configuration value in the configuration settings designer error.":::

## Cause

This issue occurs because iOS configuration profiles don't support the ampersand character in XML configuration files.

## Resolution

To fix the issue, use one of the following methods:

- Create a short URL that redirects to the original URL that contains the ampersand, then use the short URL as the **Configuration value**.
- Replace **&amp;** with `&amp;` in the URL. For example:

    `https://sso.contoso.com/idpov/accesslogin/FedSSODispatch.faces?PartnerIdpId=https://sts.windows.net/{GUID}/&amp;TargetResource=https://sso.contoso.com/idprov/pages/home/dispatch.jsp?SpName=MBF`

If you can't use either of these methods, contact [Apple Support](https://support.apple.com/).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
