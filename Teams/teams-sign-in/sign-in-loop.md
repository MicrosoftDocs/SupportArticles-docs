---
title: Teams web client is stuck in a login loop
description: Provides a fix for multiple browsers if the Teams web client continually loops when you try to sign in.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Teams
  - Skype for Business Online
ms.date: 12/30/2022
adobe-target: true
---

# Teams web client is stuck in a login loop

When you try to sign in to Microsoft Teams in Microsoft Edge, Google Chrome, Mozilla Firefox, Safari, or Internet Explorer, the site continually loops, and you're not able to sign in.

This issue occurs if you use the **Trusted Sites** feature in your browser and you don't add the URLs for Microsoft Teams to the list of sites that your browser should trust. In this situation, the Teams web client can't sign in.

To resolve this issue, update the settings for your browser. You must have administrative rights to make the updates. If you're the administrator for your organization, you can use a Group Policy Object (GPO) to make the updates.

Locate your browser among the following sections, and follow the provided steps.

## Microsoft Edge

1. In the Edge **Settings** window, select **Cookies and site permissions** > **Cookies and data stored** > **Manage and delete cookies and site data**.
2. Turn on **Allow sites to save and read cookie data (recommended)**, and make sure that **Block third-party cookies** is turned off.

   Or, iIf you have to keep third-party cookies blocked, do this instead in the same window:

   Under **Allow**, select **Add** to add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

    :::image type="content" source="media/sign-in-loop/edge-cookies-site-permissions.png" alt-text="Screenshot of settings window in edge, showing options under the Cookies and site permissions item and sites added.":::

To change the settings by using  a GPO, follow these steps:

1. Go to the [Microsoft Edge Enterprise landing page](https://aka.ms/EdgeEnterprise) to download the Microsoft Edge policy templates file and extract the contents.
2. Add the sites that are listed here in [step 2 under "Microsoft Edge"](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) to **Content settings** > **CookiesAllowedForUrls** by having either a mandatory or recommended policy. 
 
For more information on configuring Microsoft Edge group policy settings, visit following articles:

- [Configure Microsoft Edge policy settings on Windows devices](/deployedge/configure-microsoft-edge)
- [Add the administrative template to Active Directory](/deployedge/configure-microsoft-edge#add-the-administrative-template-to-active-directory)
- [Set mandatory or recommended policies](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) 
- [CookiesAllowedForUrls setting](/deployedge/microsoft-edge-policies#cookiesallowedforurls)

## Google Chrome

1. In the Chrome **Settings** window, on the **Privacy and security** tab, select **Cookies and other site data**.
2. Under **Sites that can always use cookies**, select **Add**, and then select the **Including third-party cookies on this site** checkbox.
3. Add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

To change the settings by using GPO:

There are two types of policy templates: an ADM and an ADMX template. Verify which type you can use on your network. The templates show which registry keys you can set to configure Chrome, and what the acceptable values are. Chrome looks at the values set in these registry keys to determine how to act.

1. Download [Chrome administrative template](https://enterprise.google.com/chrome/chrome-browser/#download)
2. Open Group Policy editor by navigating to **Start > Run: gpedit.msc**
3. Navigate to **Local Computer Policy > Computer Configuration > Administrative Templates**.
4. Right-click **Administrative Templates**, and select **Add/Remove Templates**.
5. Add the **chrome.adm** template via the dialog.
6. Once complete, a Google / Google Chrome folder will appear under Administrative Templates if it's not already there. If you added the ADM template on Windows 7 or 10, it will appear under Classic Administrative Templates / Google / Google Chrome.
7. Configure policies by opening the template that just added and change the configuration settings. The most commonly-modified policies are:
    - **Set the home page** - The URL that Chrome opens when a user launches the browser or clicks the Home button.
    - **Send anonymous usage statistics and crash information** - To turn off sending any crash information or anonymous statistics to Google, change this setting to be False.
    - **Turn off auto-updates** - Although not normally recommended, you can turn off auto-updates.
    Apply the policies to the target machines. Depending on your network's configuration, this may require time for the policy to propagate, or you may need to propagate those policies manually via administrator tools.

8. Add the sites that are listed in step 2 under "Microsoft Edge" to the **Content settings** > **CookiesAllowedForUrls** setting.

For more information on [Set Chrome Browser policies on managed PCs](https://support.google.com/chrome/a/answer/187202/set-chrome-browser-policies-on-managed-pcs).

You can also download the templates separately and view common policy documentation for all operating systems here: [Zip file of Google Chrome templates and documentation](https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip)

## Mozilla Firefox

1. In the Firefox **Settings** window, select the **Privacy & Security** tab.
2. Under **Cookies and Site Data**, select **Manage Exceptions**.
3. In the **Address of website** text box, enter the following URLs, and then select **Allow**.

    - `https://microsoft.com`
    - `https://microsoftonline.com`
    - `https://teams.skype.com`
    - `https://teams.microsoft.com`
    - `https://sfbassets.com`
    - `https://skypeforbusiness.com`

4. Select **Save Changes**.

To change the settings by using a GPO:

1. Download and install [the Firefox administrative template](https://github.com/mozilla/policy-templates/releases).
2. Add the sites that are listed under "Microsoft Edge" to **Cookies** > **Allowed Sites**.

For more information on [Customizing Firefox Using Group Policy](https://support.mozilla.org/kb/customizing-firefox-using-group-policy-windows).

## Safari

Teams support for Safari is currently in preview. Update the following setting, and then try to access the Teams web client:

1. Select **Preferences** > **Privacy**.
2. Clear the **Prevent cross-site tracking** checkbox.
3. Close Safari, reopen the browser, and then navigate to teams.microsoft.com.

For more information, see [Limits and specifications for Teams](/microsoftteams/limits-specifications-teams#browsers).

## Internet Explorer

> [!Note]
> Starting on November 30, 2020, the Microsoft Teams web client no longer supports Internet Explorer 11. For more information, go [here](https://aka.ms/AA97tsw).

1. In Windows Control Panel, open **Internet Options**.
2. In the Internet Options window, select **Privacy** and **Advanced**.
3. Select **Accept** for **First-party Cookies** and **Third-party Cookies**, and then select the **Always allow session cookies** checkbox.

    :::image type="content" source="media/sign-in-loop/ie-advanced-privacy-settings.png" alt-text="Screenshot of Advanced Privacy Settings dialog. First and Third party Cookies are selected as accept, and Always allow session cookies is selected":::

    Alternatively, follow steps 4 and 5:
4. In the **Internet Options** window, select **Security** > **Trusted Sites** > **Sites**.
5. Add the following sites:

    - `https://*.microsoft.com`
    - `https://*.microsoftonline.com`
    - `https://*.teams.skype.com`
    - `https://*.teams.microsoft.com`
    - `https://*.sfbassets.com`
    - `https://*.skypeforbusiness.com`

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
