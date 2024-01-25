---
title: Can't reach this page and unsupported browser error messages in SMSS 19
description: Discusses how to resolve problems that occur in SSMS 19 when you try to sign in by using Microsoft Entra authentication in Internet Explorer.
ms.reviewer: maghan, randolphwest
ms.date: 01/24/2024
ms.custom:
  - "sap:Management Studio"
---

# Browser authentication issues in SQL Server Management Studio 19.1 and later versions

This article helps you resolve problems that occur when you try to log in to SQL Server Management Studio (SSMS) using Microsoft Entra authentication. The problems often occur in tightly secured environments that have restricted Internet access.

> [!NOTE]
> Microsoft Entra ID is the [new name for Azure Active Directory (Azure AD)](/entra/fundamentals/new-name).

## Symptoms

Depending on the version of SSMS that you have installed, you experience either of the following possible symptoms.

### Can't reach this page (SSMS 19.1 and later versions)

When you try to sign in to Azure using Microsoft Entra authentication in SSMS 19.1 and later versions, you receive the following error message:

> **Can't reach this page**
>
> - Make sure the web address `http://localhost:55555` is correct
> - Search for this site on Bing
> - Refresh the page
>
> More information
>
> There was a temporary DNS error. Try refreshing the page.  
> Error Code: `INET_E_RESOURCE_NOT_FOUND`.

**Cause**

The default value for the **Use system default web browser** setting in SSMS 19.1 and later versions is `True`.

This change was implemented because of customer feedback and the retirement of Internet Explorer in June 2022. Users of SSMS 18.*x* builds and the first SSMS 19.0 releases reported that they received an "Unsupported browser" message when they tried to sign in to Microsoft Entra.

**Resolution**

To resolve the error, use the following methods, as appropriate.

**Method 1: Configure browser settings**

If your environment has limited or no direct Internet access:

1. Navigate to **Tools > Options > Azure Services**.
1. Within **Miscellaneous**, change **Use system default web browser** to **False**.

**Method 2: Set the browser default**  

Set your preferred browser as the default. In Microsoft Edge, access **Settings**, navigate to the **Default browser** page, and specify Microsoft Edge as the default browser.
### Unsupported browser (SSMS 19.0.2 and earlier versions)

When you try to sign in to Azure using Microsoft Entra authentication in SSMS 19.0.2 and earlier versions, you receive the following "Unsupported browser" message:

> **Keep your account secure**
>
> Your organization requires that you set up the following authentication methods to prove your identity.
>
> **Update your browser**
>
> Your browser is not supported or up-to-date. Try updating it, or else download and install the latest version of Microsoft Edge.
>
> You could also try to access `https://aka.ms/mysecurityinfo` from another device.

:::image type="content" source="media/cant-reach-this-page/unsupported-browser-message.png" alt-text="Screenshot showing the unsupported browser error message.":::

**Resolution**

To resolve the error, use the following methods, as appropriate.

**Method 1: Set the browser default**

Set your preferred browser as the default. In Microsoft Edge, access **Settings**, navigate to the **Default browser** page, and specify Microsoft Edge as the default browser.

**Method 2: For users of SSMS 19.0.2 and earlier versions**

If you see the **Unsupported browser** message window, follow these steps:

1. Navigate to **Tools > Options > Azure Services**.
1. Within **Miscellaneous**, change **Use system default web browser** to **True**.

## More information

These settings are configured per SSMS installation and there is no global option that can be set for all SSMS users.

Administrators can use PowerShell to set the default browser on a broader scale to ensure compatibility with Microsoft Edge or another preferred browser. For more information, see [Set Microsoft Edge as the default browser](/deployedge/edge-default-browser).
