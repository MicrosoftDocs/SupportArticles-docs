---
title: Resolve the new Teams installation issues
description: Describes how to resolve common issues when users try to download and install the new Microsoft Teams client.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 187488
  - CSSTroubleshoot
ms.reviewer: dansteve, heidip
appliesto: 
  - New Microsoft Teams
search.appverid:
  - MET150
ms.date: 03/06/2024
---
# Resolve installation issues of the new Teams client

## Policy settings prevent download and installation

If users receive the following error message when they install the app, it means that there are some restrictions that prevent them from downloading and installing the app:

> Due to org policy, you can't install the new Teams. For more info, contact your IT admin.

:::image type="content" source="media/fix-new-teams-installation-issues/new-teams-org-policies.png" alt-text="Screenshot of the error message when your organization policies restrict installation of new Teams.":::

It's possible that the MSIX package installation is blocked by registry keys that are set by Group Policy or a third-party tool. For a complete list of registry keys, see [How Group Policy works with packaged apps - MSIX](/windows/msix/group-policy-msix).

The registry keys that could block new Teams MSIX package installation are:

- `BlockNonAdminUserInstall`
- `AllowAllTrustedApps`
- `AllowDevelopmentWithoutDevLicense`

> [!IMPORTANT]
> If `AllowAllTrustedApps` is disabled, the new Teams app (MSIX) installation fails. This issue has been fixed in the Windows October cumulative update KB5031455. If this optional October update isn't available for your OS build, the November security update includes the fix.
>
>- [**Windows 10: October 26, 2023—KB5031445 (OS Build 19045.3636)**](https://support.microsoft.com/topic/october-26-2023-kb5031445-os-build-19045-3636-preview-03f350cb-57f9-45e6-bfd7-438895d3c7fa)
>- [**Windows 11: October 26, 2023—KB5031455 (OS Build 22621.2506)** ](https://support.microsoft.com/topic/october-26-2023-kb5031455-os-build-22621-2506-preview-6513c5ec-c5a2-4aaf-97f5-44c13d29e0d4)

These registry keys can be found at one of these locations:

- `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock`
- `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx`

There are a few policies that could alter these registry keys and block app installation in your organization due to restricted policy set by the admins. Some of the known GPO policies that could prevent installation include:

- Prevent non-admin users from installing packaged Windows apps
- Allow all trusted apps to install (disabled)

### To check this setting for your computer

1. In Windows, search for **Edit Group Policy**. Or, right-click the Windows key, select **Run**, and then enter *gpedit.msc*. This action opens the **Local Group Policy Editor**.
1. Navigate to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **App package Deployment**, check the following policy settings:

    - *Prevent non-admin users from installing packaged Windows apps*
    - *Allow all trusted apps to install*
1. Make sure that these settings are set to **Not configured**.

> [!NOTE]
> For admins who are bulk deploying new Teams to their organization's computers, see [Bulk upgrade to the new Microsoft Teams client](/microsoftteams/new-teams-bulk-install-client).

## Fix the App switcher toggle

- Before you turn on the **Try the new Teams** toggle, restart the current client to make sure that you have the latest changes. In addition, if there are any pending Windows updates, including security updates, install them before you try the new Teams.
- If you don't see the **Try the new Teams** toggle, make sure that you have the minimum required versions of Windows and Teams.
- After you successfully switch to new Teams: If you can't find the toggle on the top left to switch between new Teams and Microsoft Teams classic (work or school), start the version you want by going to the Start menu and searching for it, or by selecting it from the task bar.

## Policies that can block the user from seeing the App switcher toggle

The following list of policies can block users from seeing the app switcher toggle:

- Your admin has set up [sign in restrictions](/microsoftteams/sign-in-teams#how-to-restrict-teams-sign-in-on-desktop-devices).
- If the user is on a VDI computer (such as Citrix and VMware).
- If the user is signed in to classic Teams with a *Teams for Life* account and a work account.
- If the user is signed in to classic Teams with a *Teams for Life* account.

### How do I know which one of the above policies is blocking me?

1. Open logs in this path: `%appdata%/Microsoft/Teams`.
1. Open logs.txt.
1. Search for **appswitcher_appstateservice_check**.
1. Check the **enggComplete** flag:

   - If true, Microsoft turned on the setting for you.
   - If false, you didn't have the setting turned on from Microsoft yet, or you need to restart the app.
1. Check the **isAboveWin10Vibranium** flag:

   - If true, the OS version is greater than or equal to the version required for the app switcher.
   - If false, the OS is older than what Microsoft supports.
1. Check the code to find out the cause.

   |Code|Meaning|
   |:-----|:-----|
   |TFLONLY|You're only signed in to *Teams for Life*.|
   |TFLANDTFW|You're signed in to *Teams for Life* and *Teams for Work*.|
   |SPECIALCLOUD|You're signed in to a special cloud that isn't supported.|
   |CROSSCLOUD|You're signed in to a government cloud.|
   |VDI|You're signed in to a VDI machine (VMware, Citrix, AVD/WV).|
   |SIGNINRESTRICTED|You're signed in to the specified tenant but the App switcher toggle doesn't appear.|

## Update and restart message in the title bar

Issue: After a user opts into the new Teams, they might receive an **Update and restart** message in the title bar.

Action: This message is an expected behavior. Select the link to restart the app.

## Windows 10 users receive an error message

Issue: Windows 10 users receive the following error message when they download and install the new Teams:

> We've run into an issue

Action: [Download and install WebView2 Runtime](https://developer.microsoft.com/microsoft-edge/webview2/#download-section). Then restart the Teams desktop app and try again.

## Some people don't see the toggle to opt in

Make sure that the user has the minimum requirements met on their computer. Next, have them sign out and sign back into the Teams desktop app.  

If the toggle still doesn't appear, follow these steps:

1. Right-click the Teams app icon in the taskbar, and then select **Quit**.
1. Open File Explorer. In the address bar, enter the following path: `%appdata%/Microsoft/Teams`, and then press Enter.
1. Delete all contents of the folder (don't worry, the Teams app and your custom settings won't be deleted). If you get any messages that a certain file or folder can't be deleted, select **Skip**.
1. Restart the Teams app, then right-click the icon and select **Quit**.
1. Restart the Teams app one more time, and you should see the toggle switch.

## Download and install even if Group Policy is set to disabled

You might still be able to download and install the new Teams even if you have the **Allow all trusted apps to install**  Group Policy set to **Disabled**.

- If you're running Windows 10 or Windows 11 patch 10D version or higher, you can still download and install the new Teams app.
- If you're running Windows 11 21H1 SV1 (Build 10.0.22000), you'll remain blocked. You must upgrade to a newer version of Windows 11 to use the new Teams.
