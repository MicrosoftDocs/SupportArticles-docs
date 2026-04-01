---
title: Resolve Edge Location Service Issues on Windows
description: Troubleshoot Microsoft Edge geolocation failures when other browsers work correctly. Discover how to resolve issues with the Windows lfsvc service, policies, and permissions.
ms.date: 04/01/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Web Platform and Development\Web Applications: rendering, layout, scripting, accessibility'
---

# Geolocation doesn't work in Microsoft Edge but works in other browsers

## Summary

This article helps you troubleshoot geolocation not working in Microsoft Edge when it works in other browsers like Google Chrome. The most common cause is that the Windows Geolocation service (`lfsvc`) is disabled, typically by a Group Policy. Unlike some browsers that use alternative geolocation methods, Microsoft Edge relies directly on the Windows Location service for geolocation data. This article walks through checking website-level permissions, Windows location privacy settings, the Geolocation service status, Group Policy configurations, and Microsoft Edge geolocation policies to identify and fix the problem.

## Symptoms

You experience all of the following symptoms:

- Geolocation doesn't work in Microsoft Edge on any website, even though location permissions are granted.
- The same websites work correctly in other browsers such as Google Chrome.
- Location permissions are enabled in Microsoft Edge for the tested websites (`edge://settings/privacy/sitePermissions/allPermissions/location`).
- Windows location privacy settings show that Microsoft Edge has location access enabled (**Settings** > **Privacy & security** > **Location**).

## Solution

Work through the following checks in order. After each step, test geolocation in Microsoft Edge (for example, visit a website that requests your location) to check if the issue is resolved.

### Verify website-level location permissions in Microsoft Edge

Make sure Microsoft Edge isn't blocking location access for the specific website.

1. Open Microsoft Edge and go to `edge://settings/privacy/sitePermissions/allPermissions/location`.
1. Under **Allow**, verify that the website you're testing is listed or that the default behavior is set to **Ask (default)** rather than **Block**.
1. If the website is listed under **Block**, remove it from the block list.
1. Check for Microsoft Edge policies that block geolocation on specific URLs:
   1. Go to `edge://policy` and search for [GeolocationBlockedForUrls](/deployedge/microsoft-edge-browser-policies/geolocationblockedforurls).
   1. If the tested website URLs are listed, contact your IT administrator to remove them.

### Verify Windows location privacy settings

Make sure location access is enabled at the operating system level. For more information about Windows location settings, see [Windows location service and privacy](https://support.microsoft.com/windows/windows-location-service-and-privacy-3a8eee0a-5b0b-dc07-eede-2a5ca1c49088).

1. Go to **Settings** > **Privacy & security** > **Location**.
1. Make sure the **Location services** toggle is turned on.
1. Make sure the **Let apps access your location** toggle is turned on.
1. Scroll down and confirm that **Let desktop apps access your location** toggle is also turned on. Microsoft Edge is a desktop app and requires this setting to be enabled.

### Check the Windows Geolocation service (lfsvc)

Microsoft Edge relies directly on the Windows Geolocation service (`lfsvc`) for location data. If this service is disabled, Microsoft Edge can't determine your location, even though other browsers like Chrome (which use alternative geolocation methods) might still work.

1. Select <kbd>Win</kbd>+<kbd>R</kbd>, type `services.msc`, and select <kbd>Enter</kbd>.
1. In the Services list, find **Geolocation Service**.
1. Check the **Status** and **Startup Type**. If the status is **Stopped** and the startup type is **Disabled**, this condition is likely the cause.
1. To fix it manually:
   1. Open **Geolocation Service**.
   1. Set **Startup type** to **Automatic**.
   1. Select **Start** to start the service.
   1. Select **OK**.
1. Restart Microsoft Edge and test geolocation.

Alternatively, to check and start the service from an administrator Command Prompt, run the following commands:

```cmd
sc query lfsvc
sc config lfsvc start=auto
sc start lfsvc
```

> [!NOTE]
> If you can start the service manually but it reverts to **Disabled** after a reboot, a Group Policy is likely overriding the setting. Proceed to the next section.

### Check Group Policy for Geolocation service settings

A Group Policy might disable the Windows Geolocation service. This situation is common in enterprise environments where administrators restrict location services for privacy or compliance reasons.

1. Open a Command Prompt as an administrator and run the following command:

   ```cmd
   gpresult /h gpresult.html
   ```

1. Open the generated *gpresult.html* file in a browser and search for:
   - **lfsvc** or **Geolocation**
   - Check the **System Services** section to confirm if the Geolocation Service is configured.
1. If a Group Policy disables the Geolocation service:
   - If you don't have administrative access, contact your IT administrator to update the policy.
   - If you have administrative access, update the policy yourself:
     1. Open the Group Policy Editor (`gpedit.msc`).
     1. Go to **Computer Configuration** > **Windows Settings** > **Security Settings** > **System Services**.
     1. Find **Geolocation Service**, set it to **Automatic**, and apply the change.
1. Run `gpupdate /force` to refresh policies, and then restart the Geolocation service and Microsoft Edge.

### Verify Microsoft Edge geolocation policies

Microsoft Edge policies might restrict geolocation or block it entirely.

1. Open Microsoft Edge and go to `edge://policy`.
1. Search for the following policies:
   - [DefaultGeolocationSetting](/deployedge/microsoft-edge-browser-policies/defaultgeolocationsetting), which controls the default geolocation setting:
     - **1**: Allow sites to track your location.
     - **2**: Don't allow sites to track your location.
     - **3**: Ask whenever a site wants to track your location.
   - [GeolocationBlockedForUrls](/deployedge/microsoft-edge-browser-policies/geolocationblockedforurls), which blocks geolocation on specific URLs.
   - [GeolocationAllowedForUrls](/deployedge/microsoft-edge-browser-policies/geolocationallowedforurls), which allows geolocation on specific URLs.
1. If **DefaultGeolocationSetting** is set to **2**, geolocation is disabled for all sites. Contact your IT administrator to change it to **1** or **3**.

### Test in a new profile and with extensions disabled

A corrupted profile or a conflicting extension could interfere with geolocation.

1. Open an InPrivate window (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd>) and test geolocation on a website. InPrivate mode disables extensions by default.
1. If geolocation works in InPrivate, disable extensions one by one in your regular profile. Go to `edge://extensions` and toggle off each extension until you find the one interfering.
1. If the issue persists, create a new Microsoft Edge profile:
   1. Select the profile icon > **Add profile** > **Add**.
   1. Test geolocation in the new profile.

## Data collection

If you need to contact Microsoft Support for more help, collect the following diagnostic information and include it with your support request.

1. **Microsoft Edge version**: Go to `edge://settings/help` and note the full version number.
1. **Geolocation service status**: Run `sc query lfsvc` in a Command Prompt and note the output.
1. **Active policies**: Go to `edge://policy` and export the policy list.
1. **Group Policy report**: Run `gpresult /h gpresult.html` in a Command Prompt and save the output.
1. **Windows location settings**: Take a screenshot of **Settings** > **Privacy & security** > **Location**.
1. **Operating system version**: Go to **Settings** > **System** > **About** and note the OS version.

## Related content

- [Location and privacy in Microsoft Edge](https://support.microsoft.com/microsoft-edge/location-and-privacy-in-microsoft-edge-31b5d154-0b1b-90ef-e389-7c7d4ffe7b04)
- [Configure Microsoft Edge policy settings on Windows](/deployedge/configure-microsoft-edge)
- [Manage connections from Windows OS components to Microsoft services](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
