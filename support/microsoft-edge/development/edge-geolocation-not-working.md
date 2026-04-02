---
title: Resolve Edge Location service issues on Windows
description: Troubleshoot geolocation failures that occur in Microsoft Edge but not in other browsers. Discover how to resolve the problem by using the Windows lfsvc service, policies, and permissions.
ms.date: 04/01/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Web Platform and Development\Web Applications: rendering, layout, scripting, accessibility'
---

# Geolocation doesn't work in Microsoft Edge but works in other browsers

## Summary

This article helps you troubleshoot a problem that prevents geolocation from working in Microsoft Edge although it works in other browsers, such as Google Chrome. The most common cause is that the Windows Geolocation service (`lfsvc`) is disabled (typically, though Group Policy). Unlike some browsers that use alternative geolocation methods, Edge relies directly on the Windows Location service for geolocation data. To identify and fix the problem, this article discusses how to check website-level permissions, Windows location privacy settings, the Geolocation service status, Group Policy configurations, and Edge geolocation policies.

## Symptoms

You experience all the following symptoms:

- Geolocation doesn't work in Edge on any website, even though location permissions are granted.
- The same websites work correctly in other browsers, such as Google Chrome.
- Location permissions are enabled in Edge for the tested websites (`edge://settings/privacy/sitePermissions/allPermissions/location`).
- Windows location privacy settings show that Edge has location access enabled (**Settings** > **Privacy & security** > **Location**).

## Solution

Work through the following checks in the given order. After each step, test geolocation in Edge (for example, visit a website that requests your location) to check whether the issue is resolved.

### Verify website-level location permissions in Edge

Make sure that Edge isn't blocking location access for the specific website:

1. Open Edge, and go to `edge://settings/privacy/sitePermissions/allPermissions/location`.
1. Under **Allow**, verify that the website that you're testing is listed or that the default behavior is set to **Ask (default)** instead of **Block**.
1. If the website is listed under **Block**, remove it from the block list.
1. Check for Edge policies that block geolocation on specific URLs:
   1. Go to `edge://policy`, and search for [GeolocationBlockedForUrls](/deployedge/microsoft-edge-browser-policies/geolocationblockedforurls).
   1. If the tested website URLs are listed, contact your IT administrator to remove them.

### Verify Windows location privacy settings

Make sure that location access is enabled at the operating system level. For more information about Windows location settings, see [Windows location service and privacy](https://support.microsoft.com/windows/windows-location-service-and-privacy-3a8eee0a-5b0b-dc07-eede-2a5ca1c49088):

1. Go to **Settings** > **Privacy & security** > **Location**.
1. Make sure that the **Location services** toggle is turned on.
1. Make sure that the **Let apps access your location** toggle is turned on.
1. Scroll down and verify that the **Let desktop apps access your location** toggle is turned on. This setting must be enabled because Edge is a desktop app.

### Check the Windows Geolocation service (lfsvc)

Edge relies directly on the Windows Geolocation service (`lfsvc`) for location data. If this service is disabled, Edge can't determine your location, even though other browsers that use alternative geolocation methods might still work. Check the status of lfsvc:

1. Press <kbd>Win</kbd>+<kbd>R</kbd>, enter `services.msc`, and then press <kbd>Enter</kbd>.
1. In the **Services** list, find **Geolocation Service**.
1. Check the **Status** and **Startup Type**. If the status is **Stopped** and the startup type is **Disabled**, this condition is likely the cause.
1. To fix the problem manually:
   1. Open **Geolocation Service**.
   1. Set **Startup type** to **Automatic**.
   1. Select **Start** to start the service.
   1. Select **OK**.
1. Restart Edge, and test geolocation.

Alternatively, to check and start the service from an administrative Command Prompt window, run the following commands:

```cmd
sc query lfsvc
sc config lfsvc start=auto
sc start lfsvc
```

> [!NOTE]
> If you can start the service manually, but it reverts to **Disabled** after a restart, a Group Policy setting is likely overriding the service setting. Go to the next section.

### Check Group Policy for Geolocation service settings

A Group Policy setting might disable the Windows Geolocation service. This situation is common in enterprise environments where administrators restrict location services for privacy or compliance.

1. Open a Command Prompt window as an administrator, and run the following command:

   ```cmd
   gpresult /h gpresult.html
   ```

1. Open the generated *gpresult.html* file in a browser, and search for **lfsvc** or **Geolocation**. Then, check the **System Services** section to verify that the Geolocation service is configured.
1. If a Group Policy setting disables the Geolocation service:
   - If you don't have administrative access, contact your IT administrator to update the policy.
   - If you have administrative access, update the policy yourself:
     1. Open the Group Policy Editor (`gpedit.msc`).
     1. Go to **Computer Configuration** > **Windows Settings** > **Security Settings** > **System Services**.
     1. Find **Geolocation Service**, set it to **Automatic**, and then apply the change.
1. To refresh policies, run `gpupdate /force`, and then restart the Geolocation service and Edge.

### Verify Edge geolocation policies

Edge policies might restrict geolocation or block it entirely. Verify the policies:

1. Open Edge, and go to `edge://policy`.
1. Search for the following policies:
   - [DefaultGeolocationSetting](/deployedge/microsoft-edge-browser-policies/defaultgeolocationsetting). This policy controls the default geolocation setting:
     - **1**: Allow sites to track your location.
     - **2**: Don't allow sites to track your location.
     - **3**: Ask whenever a site wants to track your location.
   - [GeolocationBlockedForUrls](/deployedge/microsoft-edge-browser-policies/geolocationblockedforurls). This policy blocks geolocation on specific URLs.
   - [GeolocationAllowedForUrls](/deployedge/microsoft-edge-browser-policies/geolocationallowedforurls), This policy allows geolocation on specific URLs.
1. If **DefaultGeolocationSetting** is set to **2**, geolocation is disabled for all sites. Contact your IT administrator to change it to **1** or **3**.

### Test in a new profile by having extensions disabled

A corrupted profile or a conflicting extension could interfere with geolocation. Test the settings:

1. Open an InPrivate window (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd>), and test geolocation on a website. By default, InPrivate mode disables extensions.
1. If geolocation works in an InPrivate window, disable extensions one by one in your regular profile. Go to `edge://extensions`, and toggle off each extension until you find the one that's interfering.
1. If the problem persists, create a new Edge profile:
   1. Select the profile icon > **Add profile** > **Add**.
   1. Test geolocation in the new profile.

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information, and include it in your support request.

1. **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
1. **Geolocation service status**: Run `sc query lfsvc` at a command prompt, and note the output.
1. **Active policies**: Go to `edge://policy`, and export the policy list.
1. **Group Policy report**: Run `gpresult /h gpresult.html` at a command prompt, and save the output.
1. **Windows location settings**: Take a screenshot of **Settings** > **Privacy & security** > **Location**.
1. **Operating system version**: Go to **Settings** > **System** > **About**, and note the OS version.

## Related content

- [Location and privacy in Microsoft Edge](https://support.microsoft.com/microsoft-edge/location-and-privacy-in-microsoft-edge-31b5d154-0b1b-90ef-e389-7c7d4ffe7b04)
- [Configure Microsoft Edge policy settings on Windows](/deployedge/configure-microsoft-edge)
- [Manage connections from Windows OS components to Microsoft services](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
