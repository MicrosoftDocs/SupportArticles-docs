---
title: Outlook continually prompts for password when you try to connect to Microsoft 365
description: Describes an Outlook connection issue referenced in an OffCAT diagnostic rule. Provides a resolution.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - OutlookPwdPrompt
ms.author: meerak
appliesto: 
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
  - Exchange Online
ms.date: 10/30/2023
---

# Outlook continually prompts for your password when you try to connect to Microsoft 365

## Symptoms

When you try to create an Outlook profile or connect to a Microsoft 365 mailbox, you're continually prompted for credentials while the client displays a "trying to connect..." message. If you cancel the credentials prompt, you receive the following error message:

> The connection to Microsoft Exchange is unavailable. Outlook must be online or connected to complete this action.

## Cause

This issue can occur if the **Logon network security** setting on the **Security** tab of the **Microsoft Exchange** dialog box is set to a value other than **Anonymous Authentication**.

:::image type="content" source="media/continually-prompts-password-office-365/logon-network-security.png" alt-text="Screenshot of the Security tab of the Microsoft Exchange dialog box, checking if the Logon network security setting is set to Anonymous Authentication.":::

## Resolution

> [!NOTE]
> Microsoft Outlook 2016 and some recent builds of Outlook 2013 are not affected by this issue. Those versions have been updated to prevent the problem that is described in the "Symptoms" section. These versions have the **Logon network security** setting disabled or removed from the Microsoft Exchange email account settings.

### For newer versions of Outlook

**Run a self-diagnostics tool**

You may be a Microsoft 365 customer who is experiencing the error that is described in the "Symptoms" section when you try to connect to an Exchange Online mailbox. You may also already be running newer versions of Outlook 2013 or Outlook 2016. If both conditions are true, you can run diagnostics to determine the issue that might cause the error. The diagnostics will perform automated checks and provide possible solutions to fix the detected issue. Select **Diag: Outlook keeps asking for my password** to launch the diagnostic.

>[!div class="nextstepaction"]
>[Diag: Outlook keeps asking for my password](https://aka.ms/SaRA-OutlookPwdPrompt)

If you are connecting to an Exchange On-Premises mailbox, see the following articles for additional troubleshooting:

- [Outlook prompts for password when Modern Authentication is enabled](https://support.microsoft.com/help/3126599)

Additionally, you can view the following forum thread for common causes:

- [Why does Outlook keep prompting for password](https://social.technet.microsoft.com/Forums/en-US/bcd2d9c2-1a1b-4446-bf32-69fee8cdf11b/why-does-outlook-keep-prompting-for-password?forum=outlook)

### For affected versions of Outlook

If you have an older version of Outlook, change the **Logon network security** setting to **Anonymous Authentication** to fix this issue. To do this, follow these steps:

1. Exit Outlook.
2. Open Control Panel, and then do one of the following:

   - In Windows 10, Windows 8.1, or Windows 7, click **Start**, type control panel in the search box, and then press Enter.
   - In Windows 8, swipe in from the right side to open the charms, tap or click **Search**, and then type control panel in the search box. Or, type control panel at the **Start** screen, and then tap or click Control Panel in the search results.

3. In Control Panel, locate and double-click **Mail**.
4. Click **Show Profiles**, select your Outlook profile, and then click **Properties**.
5. Click **E-mail Accounts**.
6. Select your email account, and then click **Change**.
7. In the **Change Account** dialog box, click **More Settings**.
8. In the **Microsoft Exchange** dialog box, select the **Security** tab.
9. On the **Logon network security** list, select **Anonymous Authentication**, and then click **OK**.
10. Click **Next**, click **Finish**, and then click **Close** on the **Account Settings** dialog box.
11. Click **Close** on the **Mail Setup** dialog box, and then click **OK** to close the **Mail control** panel.
  
## More information

To locate and view the registry setting for Anonymous Authentication in the Outlook profile, follow these steps.

> [!IMPORTANT]
> Modifying the Outlook profile by using the "Profiles" registry path is not supported and may cause your Outlook profile to be in an unsupported state. Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you access it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Open the Registry Editor.

   - In Windows 10, Windows 8.1, or Windows 8, press the Windows logo key+R to open the **Run** dialog box, type regedit.exe, and then click **OK**.
   - In Windows 7, click **Start**, type regedit in the **Start Search** box, and then press Enter. If you're prompted for an administrator password or for confirmation, type the password, or click **Allow**.
2. Locate the registry path appropriate for your version of Outlook:

   - For Outlook 2013

     HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Profiles
   - For Outlook 2010 and 2007

     HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles
3. Under this subkey, locate and expand the name of your Outlook profile.
4. Under the profile, locate and expand the **9375CFF0413111d3B88A00104B2A6676** key.
5. Under the **9375CFF0413111d3B88A00104B2A6676** key, you see a subkey for each account in your profile. Select the first subfolder (00000001), and then examine the data of the **Account Name** binary value by double-clicking the value. Repeat this process until you find the Account Name value that includes your SMTP address. For example, the Account Name value points to **guidopica@contoso.com** under the **\00000003** subkey.
6. Under the **\0000000x** subkey, locate the Service UID binary value. It represents a GUID (for example, c3 d1 9a 7b 80 1b c4 4a 96 0a e5 b6 3b f9 7c 7e).
7. Locate the subfolder in your profile that matches the GUID value identified in step 6 (for example, \c3d19a7b801bc44a960ae5b63bf97c7e).
8. Under the subfolder that you found in step 7, examine the **01023d0d** binary value. It represents a GUID (for example, 5f cf d5 f1 ba 5c 6f 45 b3 57 cc 5e 0d 16 94 58).
9. Locate the subfolder in your profile that matches the GUID value identified in step 8 (for example, \5fcfd5f1ba5c6f45b357cc5e0d169458).
10. Under the subkey found in step 9, examine the value of the **00036619** binary value. This value determines whether Outlook is using Anonymous Authentication.

    Binary: **00036619**

    Data: **01 f0 00 80** == **Anonymous Authentication**

    Any other value represents an authentication method other than Anonymous.

    :::image type="content" source="media/continually-prompts-password-office-365/00036619-binary-value.png" alt-text="Screenshot of the Security tab of the Microsoft Exchange dialog box, checking the value of the 00036619 binary value." border="false":::
