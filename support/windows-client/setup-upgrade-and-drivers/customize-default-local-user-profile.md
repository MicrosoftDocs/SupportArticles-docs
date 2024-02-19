---
title: Customize default local user profile
description: Describes how to customize a default user profile or a mandatory user profile in Windows 7.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Customize the default local user profile when you prepare an image of Windows

This article describes how to customize the default local user profile settings when you create an image in Windows 7.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 973289

## Summary

After you deploy the image, the default local user profile settings are applied to all new users who log on to the computer.

To customize a default user profile or a mandatory user profile, you must first customize the default user profile. Then, the default user profile can be copied to the appropriate shared folder to make that user profile either the default user profile or a mandatory user profile.

When the default user profile is customized as described in this article, it reconstructs the source profile in a format that is appropriate for use by multiple users. This is the only supported method of customizing the default user profile for the Windows operating system. If you try to use other methods to customize the default user profile, it may result in extraneous information being included in this new default user profile. Such extraneous information could lead to serious problems with applications and system stability.

This article supersedes all previously published procedures about how to customize default local user profiles when you prepare images.

## Customize a default user profile

The only supported method for customizing the default user profile is by using the `Microsoft-Windows-Shell-Setup\CopyProfile` parameter in the Unattend.xml answer file. The Unattend.xml answer file is passed to the System Preparation Tool (Sysprep.exe).

### Step 1: Configure the default user profile

1. Log on to Windows by using the built-in local Administrator account.

    > [!NOTE]
    > You cannot use a domain account for this process.

2. Open the User Accounts control panel, and remove all added user accounts except for the one Administrator-level user account that you used to log on to Windows.

3. Configure the settings that you want to copy to the default user profile. This includes desktop settings, favorites, and **Start** menu options.

    > [!NOTE]
    > Customizing the **Start** menu and the **Taskbar** is limited in Windows 7.

### Step 2: Create an Unattend.xml file that contains the Copy Profile parameter

Create an Unattend.xml file that contains the Copy Profile parameter (`Microsoft-Windows-Shell-Setup\CopyProfile`). By using this Copy Profile parameter, the settings of the user who is currently logged on are copied to the default user profile. This parameter must be set to **true** in the specialize pass.

Windows System Image Manager (Windows SIM) creates and manages unattended Windows Setup answer files in a graphical user interface (GUI).

Answer files are XML-based files that are used during Windows Setup to configure and to customize the default Windows installation.

Use the Windows System Image Manager tool to create the Unattend.xml file. The Windows System Image Manager tool is included as part of the Windows Automated Installation Kit (Windows AIK). Obtain the AIK for your operating system from one of the following websites:

- [Windows Automated Installation Kit (AIK) for Windows Vista](https://www.microsoft.com/download/details.aspx?id=10333)

- [Automated Installation Kit (AIK) for Windows Vista SP1 and Windows Server 2008](https://www.microsoft.com/download/details.aspx?id=9085)

- [The Windows Automated Installation Kit (AIK) for Windows 7 and Windows Server 2008 R2](https://www.microsoft.com/download/details.aspx?id=5753)

- [The Windows Automated Installation Kit (AIK) Supplement for Windows 7 SP1 and Windows Server 2008 R2 SP1](https://www.microsoft.com/download/details.aspx?id=5188)

For more information about Windows AIK, see [Windows Automated Installation Kit (AIK)](https://social.technet.microsoft.com/wiki/contents/articles/5443.windows-automated-installation-kit-aik.aspx). Directions about how to create an answer file can be found in the Help information that is included with Windows AIK. For more information about how to create an answer file, see [Work with Answer Files in Windows SIM](/previous-versions/windows/it-pro/windows-7/dd799285(v=ws.10)).

### Step 3: Customize the default user profile in the Unattend.xml file

1. Open an elevated command prompt. To do this, click **Start**, type *cmd* in the **Search** box, right-click cmd in the Programs list, and then click **Run as administrator**.

    If you are prompted for an administrator password or for confirmation, type the password or provide confirmation.

2. At the command prompt, type the following command, and then press ENTER:

    ```console
    %systemroot%\system32\sysprep\sysprep.exe /oobe /shutdown /generalize /unattend:c:\answerfile\unattend.xml
    ```

    > [!NOTE]
    > Sysprep.exe is located in the `%systemdrive%\Windows\System32\sysprep` directory.

3. To confirm that the CopyProfile command successfully completed, open the `%systemroot%\panther\unattendgc\setupact.log` file.
4. Search for lines that resemble the following (in the specialize pass):

    > [shell unattend] CopyProfileDirectory from c:\Users\Administrator succeeded.  
    > [shell unattend] CopyProfile succeeded.

    This line confirms whether the CopyProfile command succeeded and which user profile was copied to the default user profile.

5. Capture the image.

6. Deploy the image. For more information about how to use Sysprep to capture and deploy an image, see [Sysprep Technical Reference](/previous-versions/windows/it-pro/windows-vista/cc766049(v=ws.10)).

> [!NOTE]
>
> - You must use the `/generalize` switch with sysprep.exe so that the Copy Profile parameter can be used. The `/unattend` option is used to point to the desired Unattend.xml file. Therefore, in this example, the Unattend.xml file is located in the `c:\answerfile` folder.
> - The built-in administrator account profile is deleted when you perform a clean Windows installation or when you run the Sysprep tool. The CopyProfile setting is processed before the built-in administrator account is deleted. Therefore, any customizations that you make will appear in the new user account profile. This includes the built-in administrator account profile settings.
> - If there are multiple user profiles, Windows sysprep may select an unexpected profile to copy to the default user profile.
> - Not all customizations will propagate to new profiles. Some settings are reset by the new user logon process. To configure those settings, use Group Policy settings or scripting.

## What to consider if you use automated image build and deployment systems

- When you use tools such as the Microsoft Deployment Toolkit or System Center Configuration Manager, the CopyProfile setting is not required when you run the Sysprep command. These tools usually replace or change the Unattend.xml file after the image is deployed to the disk but before the operating system has started for the first time after you run the Sysprep command. Therefore, the Unattend.xml file that is used in the Microsoft Deployment Toolkit or System Center Configuration Manager deployment process must contain the CopyProfile setting.

- If you set the CopyProfile setting to **true** when you run Setup from the Windows 7 installation media during the image build process, the administrator profile settings may be unintentionally copied into the default user profile. The administrator profile settings are typically present in the Install.wim file on the installation media.

## Turn the default user profile into a network default user profile

To turn the default user profile into a network default user profile, follow these steps:

1. Use an account that has administrative credentials to log on to the computer that has the customized default user profile.
2. Use the `Run` command to connect to the NETLOGON shared folder of a domain controller. For example, the path resembles the following:  
    `\\<Server_name>\NETLOGON`

3. Create a new folder in the NETLOGON shared folder, and name it *Default User.v2*.
4. Click **Start**, right-click **Computer**, click **Properties**, and then click **Advanced system settings**.
5. Under **User Profiles**, click **Settings**. The **User Profiles** dialog box shows a list of profiles that are stored on the computer.
6. Select **Default Profile**, and then click **Copy To**.
7. In the **Copy profile to** text box, type the network path of the Windows default user profile folder that you created in step 3. For example, type the path `\\<Server_name>\NETLOGON\Default User.v2`.
8. Under **Permitted to use**, click **Change**, type the name *Everyone*, and then click **OK**.
9. Click **OK** to start to copy the profile.
10. Log off from the computer when the copying process is completed.

## Turn the default user profile into a mandatory user profile

You can configure the default local user profile to become a mandatory profile. By doing this, you can have one central profile that is used by all users. To do this, you have to prepare the mandatory profile location, copy the local default user profile to the mandatory profile location, and then configure a user's profile location to point to the mandatory profile.

### Step 1: Prepare the mandatory profile location

1. On a central file server, create a new folder or use an existing folder that you use for roaming user profiles. For example, you can use the folder name *Profiles*:  
    `\Profiles`

2. If you are creating a new folder, share the folder by using a name that is suitable for your organization.

    > [!NOTE]
    > The share permissions for shared folders that contain roaming user profiles must enable Full Control permissions for the **Authenticated Users** group. The share permissions for folders that are dedicated to storing mandatory user profiles should enable Read permissions for the **Authenticated Users** group and enable Full Control permissions for the **Administrators** group.

3. Create a new folder in the folder that is created or identified in step 1. The name of this new folder should start with the logon name of the user account if the mandatory user profile is for a specific user. If the mandatory user profile is for more than one user, name it accordingly. For example, the following domain has a mandatory profile, and the folder name begins with the word *mandatory*:  
    `\Profiles\mandatory`

4. Finish naming the folder by adding *.v2* after the name. The example that is used in step 3 has the folder name *mandatory*. Therefore, the final name of the following folder for this user is *mandatory.v2*:  
    `\Profiles\mandatory.v2`

### Step 2: Copy the default user profile to the mandatory profile location

1. Log on to the computer that has the customized local default user profile by using an account that has administrative credentials.
2. Click **Start**, right-click **Computer**, click **Properties**, and then click **Advanced System Settings**.
3. Under **User Profiles**, click **Settings**. The **User Profiles** dialog box shows a list of profiles that are stored on the computer.
4. Select **Default Profile**, and then click **Copy To**.
5. In the **Copy profile to** text box, type the network path of the Windows default user folder that you created in the [Step 1: Prepare the mandatory profile location](#step-1-prepare-the-mandatory-profile-location) section. For example, type the following path:  
    `\\<Server_name>\Profiles\mandatory.v2`

6. Under **Permitted to use**, click **Change**, type the name *Everyone*, and then click **OK**.
7. Click **OK** to start to copy the profile.
8. Log off from the computer when the copying process is completed.
9. On the central file server, locate the folder that you created in the [Step 1: Prepare the mandatory profile location](#step-1-prepare-the-mandatory-profile-location) section.
10. Click **Organize**, and then click **Folder options**.
11. Click the **View** tab, click to select the **Show hidden files and folders** check box, click to clear the **Hide extensions for known file types** check box, click to clear the **Hide protected operating system files** check box, click **Yes** to dismiss the warning, and then click **OK** to apply the changes and close the dialog box.
12. Locate and right-click the NTUSER.DAT file, click **Rename**, change the name of the file to NTUSER.MAN, and then press ENTER.

> [!NOTE]
> Previously it was possible to copy profiles by using the System Control Panel item. This copy to default profile option is now disabled as it could add data that made the profile unusable.

### Step3: Prepare a user account

1. As a domain administrator, open the Active Directory Users and Computers management console from a Windows Server 2008 R2 or Windows Server 2008 computer.
2. Right-click the user account to which you want to apply the mandatory user profile, and then click **Properties**.
3. Click the **Profile** tab, type the network path that you created in the [Step 1: Prepare the mandatory profile location](#step-1-prepare-the-mandatory-profile-location) section in the profile path text box. However, don't add *.v2* at the end. In our example, the path would be as follows:  
    `\\<Server_name>\Profiles\mandatory`

4. Click **OK**, and then close the Active Directory Users and Computers management console. The user will now use the customized mandatory user profile.

## Still need help

If this article does not answer your question, [ask a question](https://answers.microsoft.com) and pose it to other community members at Microsoft Community.

## Resources

If you are having issues logging on to a user profile, see the website:

- [Fix a corrupted user profile](https://support.microsoft.com/help/14039/windows-fix-corrupted-user-profile)

- [Create a user account](https://support.microsoft.com/help/13951/windows-create-user-account)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
