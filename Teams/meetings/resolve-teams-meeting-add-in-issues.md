---
title: Resolve issues with Teams Meeting add-in for Outlook
description: Provides steps to troubleshoot and fix issues with the Teams Meeting add-in for Outlook.
author: helenclu
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 162959
  - CI 171788
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Resolve issues with Teams Meeting add-in for Outlook

If you're a Microsoft Teams administrator and your users aren't able to install the Teams Meeting add-in for Outlook, schedule Outlook meetings from Teams, or schedule Teams meetings from Outlook, try the following steps to troubleshoot and resolve the issue.

## Check policies

Verify that the following policies are assigned to the affected users:

- A Teams Upgrade policy which enables scheduling meetings in Teams. For more information, see [Set your coexistence and upgrade settings](/microsoftteams/setting-your-coexistence-and-upgrade-settings).

- A Teams Meeting policy that permits the Outlook add-in to be installed. For more information, see [Meeting policy settings](/microsoftteams/meeting-policies-in-teams-general#outlook-add-in).

## Use the Teams Add-in Missing in Outlook diagnostic

If you're an administrator, you can use the following diagnostic tool to validate that a user has the correct policies to enable the Teams Outlook add-in. 

1. Select the following **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Teams Add-in Missing in Outlook](https://aka.ms/TeamsAdd-InDiag)

2. In the **Username or Email** field under **Run diagnostic**, enter the email address of the user who is experiencing issues when they try to enable the Teams Outlook add-in. Then, select **Run Tests**.
3. The tests will return the best next steps to resolve any tenant or policy configuration issues and validate that the user is correctly configured to enable the Teams Outlook add-in.

## Use Microsoft Support and Recovery Assistant

If the policies are assigned correctly, but you're still unable to install the add-in, or if you're not an administrator, download and run Microsoft Support and Recovery Assistant by selecting the button below. The Assistant is the recommended solution to perform automated troubleshooting steps and make the required fixes.

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA-TeamsAddInScenario)

## The Enterprise version of the Assistant

If you're an administrator who has multiple users affected by the issues with the Teams Meeting add-in, you can use the Enterprise version of the Assistant. The Enterprise version of the Assistant is a command-line version that can be scripted to detect and fix most of the issues automatically without requiring user interaction. For details about using the Enterprise version of the Assistant to troubleshoot issues with the Teams Meeting add-in, see [Enterprise version of Microsoft Support and Recovery Assistant](/microsoft-365/troubleshoot/administration/sara-command-line-version#supported-switches).  

## Fix the issue manually

If you'd like to perform the checks and make the fixes manually, do the following:

- If the users are running Windows 7, install the [Update for Universal C Runtime in Windows](https://support.microsoft.com/topic/update-for-universal-c-runtime-in-windows-c0514201-7fe6-95a3-b0a5-287930f3560c). This update is required for the Teams Meeting add-in to work.

- Verify that the users have the Teams desktop client installed. The meeting add-in can't be installed when using only the Teams web client.

- Verify that the users are running Outlook 2013 or later.

- Verify that all available updates for the Outlook desktop client have been applied.

- Exit Outlook.

- Exit Teams.

- Run one of the following commands that's appropriate for your Office installation to re-register Microsoft.Teams.AddinLoader.dll:

    - **64 Bit Office:** `%SystemRoot%\System32\regsvr32.exe /n /i:user %LocalAppData%\Microsoft\TeamsMeetingAddin\1.0.18012.2\x64\Microsoft.Teams.AddinLoader.dll`

    - **32 Bit Office:** `%SystemRoot%\SysWOW64\regsvr32.exe /n /i:user %LocalAppData%\Microsoft\TeamsMeetingAddin\1.0.18012.2\x86\Microsoft.Teams.AddinLoader.dll`

    **Note** There might be multiple folders with the same version number under *\TeamsMeetingAddin*. Select the folder with the highest build number.

- Restart the Teams desktop client.

- Sign out and then sign into the Teams desktop client.

- Restart the Outlook desktop client and make sure that Outlook isn't running in admin mode.

## Check the status of the add-in in Outlook

If you still don't see the Teams Meeting add-in, make sure it's enabled in Outlook.

- In Outlook, select **File** > **Options**.

- In the **Outlook Options** dialog box, select the **Add-ins** tab.

- Check whether **Microsoft Teams Meeting Add-in for Microsoft Office** is listed in the **Active Application Add-ins** list.

- If the add-in is not listed in the list of active applications, and you see the Teams Meeting Add-in listed in the **Disabled Application Add-ins** list, select **Manage** > **COM Add-ins** and then select **Go…**

- Select the checkbox next to **Microsoft Teams Meeting Add-in for Microsoft Office**.

- Select **OK** on all the dialog boxes that are open and restart Outlook.

## Verify registry settings

If the add-in still doesn't appear, follow these steps to check the registry settings.

> [!WARNING]
> Follow this section's steps carefully. Incorrect registry entries can cause serious system issues. As a precaution, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

1. Check the load behavior of the add-in:

   1. Open RegEdit.exe.
   1. Navigate to `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\TeamsAddin.FastConnect`.
   1. Check the value of `LoadBehavior`. It should be set to **3**.
   1. If `LoadBehavior` has a value other than 3, change it to 3 and restart Outlook.
  
   If the add-in still doesn't appear, go to step 2.
2. Check whether the *Configure Outlook object model prompt when reading address information* policy setting is configured:

   1. Open RegEdit.exe.
   1. Navigate to `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook\Security`. If you applied the policy settings by using [Cloud Policy service](/deployoffice/admincenter/overview-cloud-policy), navigate to `HKEY_CURRENT_USER\Software\Policies\Microsoft\Cloud\Office\16.0\Outlook\Security`.

      **Note:** Policy settings that are implemented by using Cloud Policy take precedence over policy settings that are implemented by using Group Policy on Windows.
   1. Check for the `promptoomaddressinformationaccess` registry value and whether a value is set for it. If the value is 0, it indicates that the policy setting is set to the *Automatically deny* option. If it is, Outlook will automatically deny programmatic access requests from any program. In this situation, go to step d.
   1. Check the *Configure trusted add-ins* policy setting.

      If this policy setting is configured, Teams administrators can use one of the following options:

      - Disable or unconfigure the policy setting.
      - If the policy is required, make sure that *Microsoft.Teams.AddinLoader.dll* is in the list of trusted add-ins and that the corresponding hash value is correct. You can use the [Get-FileHash](/powershell/module/microsoft.powershell.utility/get-filehash) cmdlet to compute the hash value of the .dll file.

        **Note:** The *Microsoft.Teams.AddinLoader.dll* file that's used is automatically updated with the Teams client. Therefore, the hash value must be constantly updated to pair with the .dll file.
