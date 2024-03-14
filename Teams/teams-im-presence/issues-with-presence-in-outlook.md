---
title: User presence status issues in Outlook
description: Fixes an issue in which the status of a user presence is displayed incorrectly.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 126269
  - CSSTroubleshoot
ms.reviewer: sylviebo, premgan
appliesto: 
  - Microsoft Teams
  - Outlook
search.appverid: 
  - MET150
ms.date: 03/14/2024
---
# User presence status issues in Outlook

## Symptoms

You see any of the following issues when you check the presence status for a user in Outlook:

- The presence indicator is not visible.
- The displayed presence is incorrect.
- The presence status is **Status unknown**.

## Resolution

### Use the Microsoft Support and Recovery Assistant

[!INCLUDE [Microsoft Support and Recovery Assistant note](../../includes/sara-note-new-teams.md)]

To fix these issues, download and run the Assistant for automated troubleshooting steps and fixes.

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA-TeamsPresenceScenario)

### Fix the issue manually

Follow these manual steps and check whether the issue is resolved after each step:

1. Make sure that the Teams app is installed on your computer. For more information, see [How do I get Microsoft Teams](https://support.microsoft.com/office/how-do-i-get-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b).

2. Make sure that the Teams app on your computer is running.

   > [!NOTE]
   > The presence feature in Outlook requires Microsoft Teams to be installed, running and configured to display presence.

3. For the contact whose presence you can’t see, verify that their email address and Teams sign-in address are the same. If they are not, the contact should correct the addresses as necessary, sign out of Teams, and then sign back in.

4. Check the registry settings on your computer to verify that Teams is registered as the default instant messaging (IM) app.

   > [!WARNING]
   > Incorrectly editing the registry may severely damage your system.

   1. Start Registry Editor.

   1. Locate the following subkey:

      `HKEY_CURRENT_USER\Software\IM Providers`

   1. Verify the following values:

      - **Name**: DefaultIMApp
      - **Type**: REG_SZ
      - **Data**: Teams

      If the values that you see don’t match these, update the values.

5. Check whether the .tlb file is present in the correct path. The location of the .tlb file is different for 64-bit and 32-bit versions of Office.

   **For 64-bit Office**

   `C:\users\<username>\appdata\local\microsoft\teamspresenceaddin\uc.tlb`

   **For 32-bit Office**

   `C:\users\<username>\appdata\local\microsoft\teamspresenceaddin\uc.win32.tlb`

   **Note:** The name of the .tlb file is different for each version.

   If you don’t know the bit version of Office that’s installed on your computer, see [What version of Office am I using?](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19).

6. Check that all the following registry subkeys are correct for the version of Office that you’re running. If not, fix the incorrect entry to match the following values.

    #### [For 64-bit Office](#tab/64)

      |For 64-bit Office|
      |-|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0`<br/>**Name**: (Default)<br/>**Type**: REG_SZ<br/>**Data**: `Unified Collaboration API 1.0 Type Library`
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0\0\Win64`<br/>**Name**: (Default)<br/>**Type**: REG_SZ<br/>**Data**: `C:\Users\<username>\AppData\Local\Microsoft\TeamsPresenceAddin\Uc.tlb`|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0\FLAGS`<br/>**Name**: (Default)<br/>**Type**: REG_SZ<br/>**Data**: 0|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0\HELPDIR`<br>**Name**: (Default)<br>**Type**: REG_SZ<br>**Data**: `C:\Users\<username>\AppData\Local\Microsoft\TeamsPresenceAddin\Uc.tlb`|

    #### [For 32-bit Office](#tab/32)

      |For 32-bit Office|
      |-|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0`<br>**Name**: (Default)<br>**Type**: REG_SZ<br>**Data**: `Unified Collaboration API 1.0 Type Library`|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0\0\Win32`<br>**Name**: (Default)<br>**Type**: REG_SZ<br>**Data**: `C:\Users\<username>\AppData\Local\Microsoft\TeamsPresenceAddin\Uc.win32.tlb`|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0\FLAGS`<br>**Name**: (Default)<br>**Type**: REG_SZ<br>**Data**: 0|
      |Subkey: `HKEY_CURRENT_USER\Software\Classes\TypeLib\{B9AA1F11-F480-4054-A84E-B5D9277E40A8}\1.0\HELPDIR`<br>**Name**: (Default)<br>**Type**: REG_SZ<br>**Data**: `C:\Users\<username>\AppData\Local\Microsoft\TeamsPresenceAddin\Uc.win32.tlb`|


7. If the issue persists, uninstall and re-install Teams. For more information about how to uninstall the Teams app, see [Uninstall or remove apps and programs in Windows 10](https://support.microsoft.com/windows/uninstall-or-remove-apps-and-programs-in-windows-10-4b55f974-2cc6-2d2b-d092-5905080eaf98). To re-install Teams, see [How do I get Microsoft Teams](https://support.microsoft.com/office/how-do-i-get-microsoft-teams-fc7f1634-abd3-4f26-a597-9df16e4ca65b)

### Contact an administrator

If these steps don't resolve the issue, an administrator should create a support request in the Teams Admin Center, and provide the following information:

- The sign-in address of the user who is experiencing the issue and seeing an inaccurate presence status for a contact.

- The sign-in address of the contact whose presence is shown as **Status unknown** to the user.

- The desktop and web logs from both the user and the contact. For information about how to collect logs, see [Use log files in troubleshooting Microsoft Teams](/microsoftteams/log-files).

  - For presence issues that affect contacts who are internal to your organization, provide the output from running Microsoft Support and Recovery Assistant.

## Known issues

- Outlook currently shows **Status unknown** for federated (external) Teams contacts.
- In the 32-bit version of Outlook, the presence status icons related to "Out of Office" aren't currently displayed.
- When a user sets up automatic Out of Office replies in Outlook, the presence status icon in Outlook doesn't match Teams. Others see the presence status of this user as *Away* or *Offline* in Outlook, but as *Out of Office* in Teams.  
