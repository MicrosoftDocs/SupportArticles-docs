---
title: Microsoft Teams is stuck in a login loop in Edge, Internet Explorer or Google Chrome
description: Microsoft Teams continous loop in Edge or Internet Explorer when you try to sign in to Teams.microsoft.com. But not in other browsers.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: msteams
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- Microsoft Teams
- Skype for Business Online
---

# Microsoft Teams is stuck in a login loop in Edge, Internet Explorer, Firefox, Safari, or Google Chrome

## Symptoms

When you try to sign in to Microsoft Teams in Microsoft Edge, Internet Explorer, Google Chrome, Mozilla Firefox, or Safari, the site continually loops, and you can never sign in.

## Cause

This issue occurs if your organization uses **Trusted Sites** in Internet Explorer and doesn't enable the URLs for Microsoft Teams. In this case, the Teams web-based application cannot sign in, as the trusted sites for Teams aren't enabled.

## Resolution

Change Microsoft Edge, Internet Explorer, Google Chrome, Mozilla Firefox, or Safari settings using administrator rights or a Group Policy object (GPO).

### Microsoft Edge

1. In the Edge **Settings** window, select **Cookies and site permissions** then select **Manage and delete cookies and site data** under **Cookies and data stored**.
2. Turn on **Allow sites to save and read cookie data (recommended)** and make sure **Block third-party cookies** is turned off. Alternatively, follow step 3 if you need to keep third-party cookies blocked.
3. In the same window, under **Allow**, select **Add** to add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

    :::image type="content" source="media/sign-in-loop/edge.png" alt-text="Screenshot of edge.":::

To change the settings by using GPO, follow these steps:

1. [Download and install the Microsoft Edge administrative template](/deployedge/configure-microsoft-edge#1-download-and-install-the-microsoft-edge-administrative-template).
2. Add the sites listed in step 3 above to the **Content settings** > **CookiesAllowedForUrls** setting, either with a mandatory or recommended policy. For more information, see [Set mandatory or recommended policies](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) and [CookiesAllowedForUrls setting](/deployedge/microsoft-edge-policies#cookiesallowedforurls).

### Internet Explorer

> [!Note]
> Starting on November 30, 2020, the Microsoft Teams web app no longer supports Internet Explorer 11. For more information, go [here](https://aka.ms/AA97tsw).

1. In Windows Control Panel, open **Internet Options**.
2. In the Internet Options window, select **Privacy** and **Advanced**.
3. Select **Accept** for **First-party Cookies** and **Third-party Cookies**, and then select the **Always allow session cookies** check box.

    :::image type="content" source="media/sign-in-loop/ie.png" alt-text="Screenshot of IE.":::

    Alternatively, follow steps 3 and 4 if you need to keep third-party cookies blocked.
4. In the Internet Options window, select **Security** > **Trusted Sites** > **Sites**.
5. Add the following sites:

    - `https://*.microsoft.com`
    - `https://*.microsoftonline.com`
    - `https://*.teams.skype.com`
    - `https://*.teams.microsoft.com`
    - `https://*.sfbassets.com`
    - `https://*.skypeforbusiness.com`

### Google Chrome

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

### Mozilla Firefox

1. In the Firefox **Settings** window, select **the Privacy & Security** tab.
2. Under **Cookies and Site Data**, select **Manage Exceptions**.
3. In the **Address of website** text box, type the following sites, and then select **Allow**.

    - `https://*.microsoft.com`
    - `https://*.microsoftonline.com`
    - `https://*.teams.skype.com`
    - `https://*.teams.microsoft.com`
    - `https://*.sfbassets.com`
    - `https://*.skypeforbusiness.com`

4. Select **Save Changes**.

To change the settings by using GPO:

1. [Download and install the Firefox administrative template](https://support.mozilla.org/kb/customizing-firefox-using-group-policy-windows).
2. Add the sites listed in step 3 above to the **Cookies** setting.

### Safari

If you want to use Teams in Safari, see [Teams preview won't open in Safari](https://support.microsoft.com/office/1aac0a7c-35a8-42c1-a7df-f674afe234df).

> [!NOTE]
> It's always good to validate and enable all trusted URLs for Teams and review the requirements in the following articles:
>
> - [Office 365 URLs and IP address ranges](/office365/enterprise/urls-and-ip-address-ranges#bkmk_teams)
> - [Office 365 U.S. Government GCC High endpoints](/microsoft-365/enterprise/microsoft-365-u-s-government-gcc-high-endpoints?view=o365-worldwide&preserve-view=true)

## More information

There are some known issues you might run into when you sign in to Teams. For more information, see [Why am I having trouble signing in to Microsoft Teams](https://support.microsoft.com/office/why-am-i-having-trouble-signing-in-to-microsoft-teams-a02f683b-61a3-4008-9447-ee60c5593b0f)?

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
