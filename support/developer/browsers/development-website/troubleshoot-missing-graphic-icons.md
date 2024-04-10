---
title: Graphic icons missing on webpages
description: Describes some scenarios where web fonts' icons are missing.
ms.date: 07/14/2020
ms.reviewer: ramakoni
---
# Troubleshooting missing graphic icons on Internet Explorer webpages

[!INCLUDE [](../../../includes/browsers-important.md)]

When you load web applications that use font icons, you notice that the icons are not displayed correctly in Internet Explorer. This problem can occur in webpages that use such popular font icon sources as font-awesome, @font-face, graphic shell icons, and GDI fonts. This article outlines some of these scenarios, potential causes of the problem, and the steps that you can take to resolve the problem.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 4551929

## Partial list of scenarios

- Website graphic shell icons are missing.
- Web font-face icons are missing.
- Font-awesome icons are missing.
- Fonts are blocked when you run Internet Explorer 11 on Windows 10.
- Office 365 icons are missing - right navigation doesn't display the icons.
- CRM right navigation doesn't display the icons.
- Yammer right navigation doesn't display the icons.
- MSN icons are missing.
- Microsoft.com website icons are missing.
- Web icons are missing when you browse websites by running Internet Explorer 11 on Windows 7 (See the [Cause 2 - Allow Font Downloads GPO is disabled](#cause-2---allow-font-downloads-gpo-is-disabled) section).
- OneDrive site in SharePoint the settings wheel is missing in the navigation bar.

Microsoft recommends that users switch to Microsoft Edge to avoid these scenarios. If you have to continue using Internet Explorer, you can use the following solutions to mitigate the problem, depending on the cause.

## Cause 1 - Blocking Untrusted Fonts feature is configured in Windows 10

As discussed in this article [Block untrusted fonts in an enterprise](/windows/security/threat-protection/block-untrusted-fonts-in-enterprise), this feature might have been turned on either through Group Policy or through registry settings.

You can determine whether this feature is contributing to the problem by checking for the following errors in the console information under Developer Tools in the browser window:

[CSS3111](/previous-versions/windows/internet-explorer/ie-developer/samples/hh180764(v=vs.85)): @font-face encountered unknown error

Shell-icons-0.4.0.eot

:::image type="content" source="media/troubleshoot-missing-graphic-icons/CSS3111-error.png" alt-text="Screenshot of CSS3111 error.":::

[CSS3114](/previous-versions/windows/internet-explorer/ie-developer/samples/hh180764(v=vs.85)): @font-face failed OpenType embedding permission check. Permission must be Installable.

MWFMDL2.ttf

> [!NOTE]
> You can open Developer Tools by pressing F12 key on your keyboard.

After you verify the error, you can check for the presence of either of the following registry keys to determine whether the feature is enabled through Group Policy or a registry setting.

Case 1: Block Untrusted Fonts feature enabled through Group Policy

The following registry key set to **1000000000000**:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\MitigationOptions`

Case 2: Block Untrusted Fonts feature enabled through the registry

The following registry key set to **1000000000000**:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel\MitigationOptions`

To test whether the problem of missing fonts is resolved by disabling the Block Untrusted Fonts feature, you can use the appropriate settings to turn off this feature, as documented in [Turn on and use the Blocking Untrusted Fonts feature](/windows/security/threat-protection/block-untrusted-fonts-in-enterprise#turn-on-and-use-the-blocking-untrusted-fonts-feature).

For more information, review the following document:

- [Untrusted Font Blocking policy](https://gpsearch.azurewebsites.net/#10949)

## Cause 2 - Allow Font Downloads GPO is disabled

In environments in which the Block Untrusted Fonts feature is turned off, administrators can use the **Allow Font Downloads** Group Policy Object (GPO) to configure the zones that allow font downloads.

This GPO can be configured. It's enabled by default for the following Internet Explorer zones:

- Internet Zone
- Local Intranet Zone
- Trusted sites Zone
- Restricted sites Zone

The web font icon can be missing if the **Allow Font Downloads** GPO is disabled in one of these zones and the website that is experiencing the problem fits into that zone. For example, the GPO may be enabled only on the Trusted sites and Local Intranet zones, but the website is not in either of these zones. In this situation, you can do either of the following to mitigate the problem:

- Add the website to one of the zones that is already enabled to allow font downloads.
- Enable the **Allow Font Downloads** GPO for the additional zones that the websites fit into.

> [!IMPORTANT]
> Enabling this policy to new zones or adding the website to zones that allow font download may expose your system to websites that use malicious fonts. You should always make sure to add only trusted websites to the zones that are enabled for this policy.

For more information about how to configure **Allow Font Download** through Group Policy, go to the following policy information webpages:

Computer Configuration: [https://gpsearch.azurewebsites.net/#746](https://gpsearch.azurewebsites.net/#746)

User Configuration: [https://gpsearch.azurewebsites.net/#747](https://gpsearch.azurewebsites.net/#747)

> [!TIP]
> You can also review the **Font download** configuration for every zone that's listed on the Security Settings page in Internet Explorer property pages.

Related article:

[Office 365 app launcher and menu bar icons are blank](/office365/troubleshoot/Enterprise/blank-app-launcher-and-menu-bar)

## Cause 3 - An antivirus application prevents the font icons from displaying

If neither the Cause 1 nor Cause 2 scenarios help you resolve the missing icons problem, try disabling any installed antivirus application. These applications are known to prevent font icons from displaying in Internet Explorer 11.
