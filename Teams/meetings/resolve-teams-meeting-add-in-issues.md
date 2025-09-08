---
title: Resolve issues with Teams Meeting add-in for classic Outlook
description: Provides steps to troubleshoot issues that affect the Teams Meeting add-in for classic Outlook.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meeting Scheduling
  - CSSTroubleshoot
  - CI 162959
  - CI 171788
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 02/25/2025
---

# Resolve issues that affect the Teams Meeting add-in for classic Outlook

> [!IMPORTANT]
> The new Outlook for Windows doesn't support the Teams COM add-in, also known as Teams add-in for Outlook. The new Outlook contains a native Teams meeting capability that enables users to schedule meetings. For more information, see [Schedule a Teams meeting](https://support.microsoft.com/office/schedule-a-microsoft-teams-meeting-from-outlook-883cc15c-580f-441a-92ea-0992c00a9b0f#bkmk_schedule) > **New Outlook (desktop & web)**.

If you're a Microsoft Teams administrator, and your users can't install the Teams Meeting add-in for classic Microsoft Outlook, schedule Outlook meetings from Teams, or schedule Teams meetings from Outlook, the issue might be caused by a problematic installation of the Teams Meeting add-in or because the users' mailboxes are hidden from the Global Address List (GAL).

## Teams Meeting add-in is missing or its installation fails

If you've configured the add-in for all users but it's missing for some users, try the following steps to troubleshoot and resolve the issue.

### Run a self-help diagnostic

As an administrator, you can run the [Teams Add-in Missing in Outlook](https://aka.ms/TeamsAdd-InDiag) diagnostic in the Microsoft 365 admin center to verify that the affected users have the correct policies to enable the Teams Outlook add-in.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Use the following steps:

1. Select the **Run Tests** button to populate the diagnostic in the Microsoft 365 admin center:

   > [!div class="nextstepaction"]
   > [Run Tests: Teams Add-in Missing in Outlook](https://aka.ms/TeamsAdd-InDiag)

2. In the **Username or Email** field under **Run diagnostic**, enter the email address of the user who is experiencing issues when they try to enable the Teams Outlook add-in. Then, select **Run Tests**.

After the diagnostic is finished, select the provided links to resolve the issues that are found.

### Run the classic Teams add-in for classic Outlook troubleshooter

If the policies are assigned correctly, but you still can't install the add-in, or if you're not an administrator, run the [classic Teams add-in for classic Outlook troubleshooter](https://aka.ms/SaRA-TeamsAddin-sarahome) in Get Help.

> [!NOTE]
> To run the troubleshooter, make sure that you're using the same Windows device that classic Outlook is installed on. Additionally, make sure that your device is running Windows 10 or a later version.

To run the troubleshooter, follow these steps:

1. Select the following button to start the troubleshooter.

   > [!div class="nextstepaction"]
   > [Classic Teams add-in for classic Outlook troubleshooter](https://aka.ms/SaRA-TeamsAddin-sarahome)

   If you receive a pop-up window that displays "This site is trying to open Get Help.", select **Open**.
1. Follow the instructions in the Get Help app to run the troubleshooter.

After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the issue.

### Use the Enterprise version of Microsoft Support and Recovery Assistant

[!INCLUDE [Microsoft Support and Recovery Assistant note](../../includes/sara-note-new-teams.md)]

If you have multiple users who are affected by the issues, you can use the [Enterprise version of Microsoft Support and Recovery Assistant](/microsoft-365/troubleshoot/administration/sara-command-line-version#supported-switches). This is a command-line version of the Assistant that can be scripted to detect and fix most issues automatically without requiring user interaction.

### Fix issues manually

If you want to run checks and make fixes manually, follow these steps:

1. Verify that users have the Teams desktop client installed. The meeting add-in can't be installed if you use only the Teams web client.
1. Verify that users are running Outlook 2016 or a later version.
1. Verify that all available updates for the Outlook desktop client are applied.
1. Exit Outlook.
1. Exit Teams.
1. Reregister Microsoft.Teams.AddinLoader.dll:

   1. Open File Explorer, and then navigate to the `%LocalAppData%\Microsoft\TeamsMeetingAddin` folder.
   1. Select the subfolder that has a name that's the same as the version number. If there are multiple subfolders that have the same version number, select the subfolder that has the highest build number. Then, copy the path of this subfolder. For example, `%LocalAppData%\Microsoft\TeamsMeetingAddin\1.0.23334.11`.
   1. Open an elevated Command Prompt window, and then run the following command that's appropriate for your Office installation:

     - For 64-bit Office

       ```powershell
       %SystemRoot%\System32\regsvr32.exe /n /i:user <path copied in step b>\x64\Microsoft.Teams.AddinLoader.dll
       ```

     - For 32-bit Office

       ```powershell
        %SystemRoot%\SysWOW64\regsvr32.exe /n /i:user <path copied in step b>\x86\Microsoft.Teams.AddinLoader.dll
       ```

1. Restart the Teams desktop client.
1. Sign out and then sign in to the Teams desktop client.
1. Restart the Outlook desktop client. Make sure that Outlook isn't running in Administrator mode.

### Check the status of the add-in in Outlook

If you still don't see the Teams Meeting add-in, make sure that it's enabled in Outlook.

1. In Outlook, select **File** > **Options**.
1. In the **Outlook Options** dialog box, select the **Add-ins** tab.
1. Check whether **Microsoft Teams Meeting Add-in for Microsoft Office** is in the **Active Application Add-ins** list.
1. If the add-in isn't in the list of active applications, and you see the Teams Meeting add-in in the **Disabled Application Add-ins** list, select **Manage** > **COM Add-ins**, and then select **Go.**
1. Select the checkbox that's next to **Microsoft Teams Meeting Add-in for Microsoft Office**.
1. Select **OK** on every open dialog box, and then restart Outlook.

### Verify registry settings

If the add-in still doesn't appear, follow these steps to check the registry settings.

> [!WARNING]
> Follow this section's steps carefully. Incorrect registry entries can cause serious system issues. As a precaution, [back up the registry for restoration](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

1. Check the load behavior of the add-in:

   1. Open RegEdit.exe.
   1. Navigate to `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Outlook\Addins\TeamsAddin.FastConnect`.
   1. Check the value of the `LoadBehavior` entry. It should be set to **3**.
   1. If `LoadBehavior` has a value other than **3**, change it to **3**, and then restart Outlook.
      
   If the add-in still doesn't appear, go to step 2.
1. Check whether the *Configure Outlook object model prompt when reading address information* policy setting is configured:

   1. Open RegEdit.exe.
   1. Navigate to `HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Office\16.0\Outlook\Security`. If you applied the policy settings by using [Cloud Policy service](/deployoffice/admincenter/overview-cloud-policy), navigate to `HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Cloud\Office\16.0\Outlook\Security`.
   
      **Note:** Policy settings that are implemented by using Cloud Policy take precedence over policy settings that are implemented by using Group Policy on Windows.
   1. Check for the `promptoomaddressinformationaccess` registry entry and whether a value is set for it. If the value is **0**, this indicates that the policy setting is set to the *Automatically deny* option. If it is, Outlook will automatically deny programmatic access requests from any program. In this situation, go to step 2d.
   1. Check the *Configure trusted add-ins* policy setting.
   
      If this policy setting is configured, Teams administrators can use one of the following options:
      
      - Disable or unconfigure the policy setting.
      - If the policy is required, make sure that *Microsoft.Teams.AddinLoader.dll* is in the list of trusted add-ins and that the corresponding hash value is correct. You can use the [Get-FileHash](/powershell/module/microsoft.powershell.utility/get-filehash) cmdlet to compute the hash value of the .dll file.
      
        **Note:** The *Microsoft.Teams.AddinLoader.dll* file that's used is automatically updated with the Teams client. Therefore, the hash value must be constantly updated to pair with the .dll file.

## Details to join a meeting are missing

When a delegate schedules a Teams meeting in a delegated calendar on behalf of the delegator, the following meeting join details aren't added to the body of the meeting request:

-	Meeting URL
-	Meeting ID and passcode
-	Dial-in numbers

This issue occurs if the delegator's mailbox is hidden from the global address list (GAL). In this case, the Teams Meeting add-in can't get the required information to populate the meeting details.

To fix the issue, run the following Exchange Online PowerShell cmdlet to unhide the delegator's mailbox:

```powershell
Set-Mailbox -Identity <delegator’s email address> -HiddenFromAddressListsEnabled $false
```

Verify that the mailbox is visible in the GAL. Then, ask the delegate to restart Outlook and create a new meeting request.
