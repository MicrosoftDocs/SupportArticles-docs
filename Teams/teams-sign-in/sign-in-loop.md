---
title: Teams web client is stuck in a login loop 
description: The Teams web client continually loops when you try to sign in. 
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: msteams
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- Microsoft Teams
- Skype for Business Online
---

# Teams web client is stuck in a login loop

When you try to sign in to Microsoft Teams in Microsoft Edge, Google Chrome, Mozilla Firefox, Safari, or Internet Explorer the site continually loops, and you're not able to sign in.

This issue occurs if you use the **Trusted Sites** feature in your browser and don't add the URLs for Microsoft Teams to the list of sites that your browser should trust. Therefore the Teams web client is not able to sign in.

To resolve this issue, you need to update the settings for your browser. You need administrative rights to make the updates. If you're the administrator for your organization, you can use a Group Policy Object (GPO) to make the updates.

Select your browser from the following list and follow the provided steps.

## Microsoft Edge

1. In the Edge **Settings** window, select **Cookies and site permissions** then select **Manage and delete cookies and site data** under **Cookies and data stored**.
2. Turn on **Allow sites to save and read cookie data (recommended)** and make sure **Block third-party cookies** is turned off. Alternatively, follow step 3 if you need to keep third-party cookies blocked.
3. In the same window, under **Allow**, select **Add** to add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

    :::image type="content" source="media/sign-in-loop/edge-cookies-site-permissions.png" alt-text="Screenshot of Settings window in edge, showing options under the Cookies and site permissions item and sites added.":::

To change the settings by using GPO, follow these steps:

1. [Download and install the Microsoft Edge administrative template](/deployedge/configure-microsoft-edge#1-download-and-install-the-microsoft-edge-administrative-template).
2. Add the sites listed in step 3 above to the **Content settings** > **CookiesAllowedForUrls** setting, either with a mandatory or recommended policy. For more information, see [Set mandatory or recommended policies](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) and [CookiesAllowedForUrls setting](/deployedge/microsoft-edge-policies#cookiesallowedforurls).

## Google Chrome

1. In the Chrome **Settings** window, on the **Privacy and security** tab, select **Cookies and other site data**.
2. Under **Sites that can always use cookies**, select **Add**, and then select the **Including third-party cookies on this site** check box.
3. Add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

To change the settings by using GPO:

1. [Download and install the Chrome administrative template](https://support.google.com/chrome/a/answer/187202/set-chrome-browser-policies-on-managed-pcs).
2. Add the sites listed in step 3 above to the **Content settings** > **CookiesAllowedForUrls** setting.

## Mozilla Firefox

1. In the Firefox **Settings** window, select the **Privacy & Security** tab.
2. Under **Cookies and Site Data**, select **Manage Exceptions**.
3. In the **Address of website** text box, type the following URLs, and then select **Allow**.

    - `https://microsoft.com`
    - `https://microsoftonline.com`
    - `https://teams.skype.com`
    - `https://teams.microsoft.com`
    - `https://sfbassets.com`
    - `https://skypeforbusiness.com`

4. Select **Save Changes**.

To change the settings by using GPO:

1. [Download and install the Firefox administrative template](https://support.mozilla.org/kb/customizing-firefox-using-group-policy-windows).
2. Add the sites listed in step 3 above to the **Cookies** > **Allowed Sites** setting.

## Safari

Teams support for Safari is currently in preview. Update the following setting and then try to access the Teams web client:

1. Select **Preferences** > **Privacy**.
2. Uncheck the **Prevent cross-site tracking** setting.
3. Close Safari, then reopen it and navigate to teams.microsoft.com.

For more information, see [Teams preview won't open in Safari](https://support.microsoft.com/office/1aac0a7c-35a8-42c1-a7df-f674afe234df).

## Internet Explorer

> [!Note]
> Starting on November 30, 2020, the Microsoft Teams web client no longer supports Internet Explorer 11. For more information, go [here](https://aka.ms/AA97tsw).

1. In Windows Control Panel, open **Internet Options**.
2. In the Internet Options window, select **Privacy** and **Advanced**.
3. Select **Accept** for **First-party Cookies** and **Third-party Cookies**, and then select the **Always allow session cookies** check box.

    :::image type="content" source="media/sign-in-loop/ie-advanced-privacy-settings.png" alt-text="Screenshot of Advanced Privacy Settings dialog. First and Third party Cookies are selected as accept, and Always allow session cookies is checked.":::

    Alternatively, follow steps 3 and 4 .
4. In the Internet Options window, select **Security** > **Trusted Sites** > **Sites**.
5. Add the following sites:

    - `https://*.microsoft.com`
    - `https://*.microsoftonline.com`
    - `https://*.teams.skype.com`
    - `https://*.teams.microsoft.com`
    - `https://*.sfbassets.com`
    - `https://*.skypeforbusiness.com`

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
