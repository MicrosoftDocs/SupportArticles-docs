---
title: Troubleshoot Microsoft Teams Chat integration with Dynamics 365
description: Provides a solution to an error that occurs in opening chat windows when using Teams Chat in Microsoft Dynamics 365.
ms.reviewer: Usha-Rathnavel
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Microsoft Dataverse\Microsoft Teams
---

# Troubleshoot issue with opening chat windows in Dynamics 365

When you try to open an existing chat or start a new chat from Dynamics 365, an error might be displayed. The error might be displayed because your organization uses Trusted Sites and doesn't enable the URLs for Dynamics 365. To resolve this error, change the settings for your browser using administrator rights or a Group Policy Object (GPO).

## Microsoft Edge

1. Select **Settings and more** (:::image type="icon" source="media/troubleshoot-dynamics365-embedcollab-issues/edge-options.png":::) at the upper-right corner of the screen and then select **Settings**. 

2. In the left navigation pane, select **Cookies and site permissions**. 

3. Under **Cookies and data stored**, select **Manage and delete cookies and site data**.

4. Turn on the **Allow sites to save and read cookie data (recommended)** toggle and ensure that the **Block third-party cookies** toggle is turned off. 
 
    If you need to keep the third-party cookies blocked, go the **Allow** section, and then select **Add**. In the **Add a site** dialog box, enter **[\*.]dynamics.com** in the **Site** field, select **Including third-party cookies on this site** check box, and then select **Add**.

    :::image type="content" source="media/troubleshoot-dynamics365-embedcollab-issues/edge-settings-cookies-error-collab.png" alt-text="Screenshot shows the settings of cookies and site permisisions in Microsoft Edge.":::

**To change the settings by using GPO**:

1. [Download and install the Microsoft Edge administrative template](/deployedge/configure-microsoft-edge#1-download-and-install-the-microsoft-edge-administrative-template).

2. Add the **[\*.]dynamics.com** site to the **Content settings** > **CookiesAllowedForUrls** setting, either with a mandatory or a recommended policy. For more information, see [Set mandatory or recommended policies](/deployedge/configure-microsoft-edge#2-set-mandatory-or-recommended-policies) and [CookiesAllowedForUrls setting](/deployedge/microsoft-edge-policies#cookiesallowedforurls).

## Google Chrome

1. Select **Customize and control Google Chrome** (:::image type="icon" source="media/troubleshoot-dynamics365-embedcollab-issues/google-options.png":::) at the upper-right corner of the screen and then select **Settings**. 

2. In the left navigation pane, select **Privacy and security**, and then select **Cookies and other site data**.

3. Under **General settings**, select **Allow all cookies**. 

    If you need to keep the third-party cookies blocked, go to the **Sites that can always use cookies** section, and then select **Add**. In the **Add a site** dialog box, enter **[\*.]dynamics.com** in the **Site** field, select **Including third-party cookies on this site** check box, and then select **Add**.

    :::image type="content" source="media/troubleshoot-dynamics365-embedcollab-issues/chrome-settings-cookies-error-collab.png" alt-text="Screenshot shows the general settings in Google Chrome.":::

**To change the settings by using GPO**:

1. [Download and install the Chrome administrative template](https://support.google.com/chrome/a/answer/187202).

2. Add the **[\*.]dynamics.com** site to the **Content settings > CookiesAllowedForUrls** setting.
