---
title: Teams doesn't load
description: Provides a fix for when the Teams client doesn't load.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Identity and Auth\Client Sign-in (window, mac, linux, web)
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - Microsoft Teams
ms.date: 05/15/2025
adobe-target: true
---

# Teams doesn't load

When you try to open Microsoft Teams in Microsoft Edge, Google Chrome, Mozilla Firefox, or Safari, or access Teams from within an app such as Outlook on the web, the Teams app doesn't load.

This issue occurs if you use the **Trusted Sites** feature in your browser and you don't add the URLs for Microsoft Teams to the list of sites that your browser should trust. In this situation, the Teams client is unable to load.

To resolve this issue, update your browser settings by using the steps in the appropriate section.

> [!NOTE]  
>
> - You must have administrative rights to make the updates. If you're the administrator for your organization, you can use a Group Policy Object (GPO) to make the updates simultaneously for all users.
> - Microsoft recommends that you block third-party cookies from your browser. Third-party cookies can put your privacy and security at risk by exposing your personal information, or opening your device to vulnerabilities. Microsoft recommends that you explicitly allow specific cookies from domains that you trust.

## Microsoft Edge

1. In the Edge **Settings** window, select **Cookies and site permissions** > **Cookies and data stored** > **Manage and delete cookies and site data**.
2. Turn on **Allow sites to save and read cookie data (recommended)**, and make sure that **Block third-party cookies** is turned off.

   Alternatively, if you have to keep third-party cookies blocked, do this instead in the same window:

   Under **Allow**, select **Add** to add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

    :::image type="content" source="media/sign-in-loop/edge-cookies-site-permissions.png" alt-text="Screenshot of the settings window in edge showing options added under cookies and site permissions.":::

To change the settings by using a GPO:

1. Go to the [Microsoft Edge Enterprise landing page](https://aka.ms/EdgeEnterprise) to download the Microsoft Edge policy templates file and extract the contents.
2. Add the sites that are listed in [step 2](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) to **Content settings** > **CookiesAllowedForUrls** by having either a mandatory or recommended policy.

For more information about how to configure Microsoft Edge Group Policy settings, see the following articles:

- [Configure Microsoft Edge policy settings on Windows devices](/deployedge/configure-microsoft-edge)
- [Add the administrative template to Active Directory](/deployedge/configure-microsoft-edge#add-the-administrative-template-to-active-directory)
- [Set mandatory or recommended policies](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) 
- [CookiesAllowedForUrls setting](/deployedge/microsoft-edge-policies#cookiesallowedforurls)

## Google Chrome

1. In the Chrome **Settings** window, open the **Privacy and security** tab, and then select **Cookies and other site data**.
2. Under **Sites that can always use cookies**, select **Add**, and then select the **Including third-party cookies on this site** checkbox.
3. Add the following sites:

    - [*.]microsoft.com
    - [*.]microsoftonline.com
    - [*.]teams.skype.com
    - [*.]teams.microsoft.com
    - [*.]sfbassets.com
    - [*.]skypeforbusiness.com

To change the settings by using a GPO:

There are two types of policy templates: an ADM and an ADMX template. Verify which type you can use on your network. The templates show which registry keys you can set to configure Chrome and what the acceptable values are. Chrome accesses the values that are set in these registry keys to determine how to act.

1. Download [Chrome administrative template](https://enterprise.google.com/chrome/chrome-browser/#download).
2. Open Group Policy editor by navigating to **Start > Run: gpedit.msc**.
3. Navigate to **Local Computer Policy > Computer Configuration > Administrative Templates**.
4. Right-click **Administrative Templates**, and select **Add/Remove Templates**.
5. Add the **chrome.adm** template through the dialog box. A *Google*/*Google Chrome* folder appears under **Administrative Templates** if it's not there already. If you add the ADM template on Windows 10 or 7, the folder appears under *Classic Administrative Templates*/*Google*/*Google Chrome*.
6. Configure policies by opening the template that you just added, and then change the configuration settings. The most commonly modified policies are:
    - **Set the home page**: The URL that Chrome opens when a user opens the browser or selects the **Home** button.
    - **Send anonymous usage statistics and crash information**: To turn off sending any crash information or anonymous statistics to Google, change this setting to **False**.
    - **Turn off auto-updates**: Although we don't usually recommended it, you can turn off auto-updates.

    Apply the policies to the target computers. Depending on your network configuration, the policy might require some time to propagate. Or, you might have to propagate the policies manually through the administrator tools.
7. Add the sites that are listed in step 2 under [Microsoft Edge](#microsoft-edge) to the **Content settings** > **CookiesAllowedForUrls** setting.

For more information, see [Set Chrome Browser policies on managed PCs](https://support.google.com/chrome/a/answer/187202/set-chrome-browser-policies-on-managed-pcs).

You can also download the templates separately and view common policy documentation for all operating systems by referring to [Zip file of Google Chrome templates and documentation](https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip)

## Mozilla Firefox

1. In the Firefox **Settings** window, select the **Privacy & Security** tab.
2. Under **Cookies and Site Data**, select **Manage Exceptions**.
3. In the **Address of website** text box, enter the following URLs, and then select **Allow**:

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

For more information, see [Customizing Firefox Using Group Policy](https://support.mozilla.org/kb/customizing-firefox-using-group-policy-windows).

## Safari

Teams support for Safari is currently in preview. Update the following setting, and then try again to access the Teams web client:

1. Select **Preferences** > **Privacy**.
2. Clear the **Prevent cross-site tracking** checkbox.
3. Close Safari, reopen the browser, and then navigate to teams.microsoft.com.

For more information, see [Limits and specifications for Teams](/microsoftteams/limits-specifications-teams#browsers).

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
