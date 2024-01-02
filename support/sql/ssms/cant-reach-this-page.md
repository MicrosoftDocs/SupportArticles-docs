---
title: Can't reach this page error message
description: "On SQL Server Management Studio 19, you get an Internet Explorer message 'Can't reach this page' when trying to sign in using Microsoft Entra authentication."
ms.reviewer: maghan, randolphwest
ms.date: 02/01/2024
ms.custom:
  - "sap:Management Studio"
---

# Browser authentication issues in SQL Server Management Studio 19.1 and later versions

This article helps you resolve the problem of difficulties logging in with Microsoft Entra authentication in SQL Server Management Studio (SSMS) 19.1 and later versions, specifically if you receive the "Can't reach this page" error in Internet Explorer. This problem often arises in tightly secured environments with restricted Internet access.

> [!NOTE]
> Microsoft Entra ID is the [new name for Azure Active Directory (Azure AD)](/entra/fundamentals/new-name).

## Symptoms

Depending on the version of SSMS you installed, you experience two possible symptoms.

### Can't reach this page (SSMS 19.1 and later versions)

When you try to sign in to Azure using Microsoft Entra authentication in SSMS 19.1 and later versions, you receive the following error message, "Can't reach this page":

:::image type="content" source="media/cant-reach-this-page/internet-explorer-error.png" alt-text="Screenshot showing the 'Can't reach this page' error message.":::

The text from the screenshot shows an error similar to the following example:

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

### Unsupported browser (SSMS 19.0.2 and earlier versions)

When you try to sign in to Azure using Microsoft Entra authentication in SSMS 19.0.2 and earlier versions, you receive the following error message, "Unsupported browser":

:::image type="content" source="media/cant-reach-this-page/unsupported-browser-message.png" alt-text="Screenshot showing the unsupported browser error message.":::

The text from the screenshot shows an error similar to the following example:

> **Keep your account secure**
>
> Your organization requires that you set up the following authentication methods to prove your identity.
>
> **Update your browser**
>
> Your browser is not supported or up-to-date. Try updating it, or else download and install the latest version of Microsoft Edge.
>
> You could also try to access `https://aka.ms/mysecurityinfo` from another device.

## Cause

The default value for the **Use system default web browser** setting in SSMS 19.1 and later versions is set to `True`.

This change was implemented due to customer feedback about the retirement of Internet Explorer in June 2022. Users of SSMS 18 builds, and the first SSMS 19.0 release, reported receiving an "Unsupported browser" message when trying to sign in to Microsoft Entra, prompting this adjustment.

## Resolution

Use one of the following options to resolve the error.

### Set default browser

If your environment has limited or no direct Internet access:

1. Navigate to **Tools > Options > Azure Services**.
1. Within **Miscellaneous**, change **Use system default web browser** to **False**.

### Configure browser settings

Alternatively, set your preferred browser as the default. In Microsoft Edge, access **Settings**, navigate to the **Default browser** page, and specify Microsoft Edge as the default browser.

### For users of SSMS 19.0.2 and earlier versions

If you see the **Unsupported browser** dialog, follow these steps:

1. Navigate to **Tools > Options > Azure Services**.
1. Within **Miscellaneous**, change **Use system default web browser** to **True**.

## More information

This setting is per SSMS and user installation, lacking a global option for all SSMS users.

Administrators can use PowerShell to set the default browser on a broader scale, ensuring compatibility with Microsoft Edge or another preferred browser. For more information, see [Set Microsoft Edge as the default browser](/deployedge/edge-default-browser).
