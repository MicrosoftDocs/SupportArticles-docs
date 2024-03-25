---
title: Cannot turn off Internet Explorer Enhanced Security
description: Provides information about symptoms and various steps you can take to solve them, depending on the scenario.
ms.date: 07/14/2020
ms.reviewer: ramakoni
---
# Standard users can't turn off Internet Explorer Enhanced Security feature

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information on troubleshooting the issues in which you can't turn off Internet Explorer Enhanced Security.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 933991

## Symptoms

After you configure a Microsoft Windows Server 2003-based terminal server or a later version of the operating system, standard users can't turn off the Internet Explorer Enhanced Security Configuration feature. When a standard user clears the **Internet Explorer Enhanced Security Configuration** check box, the check box remains clear as expected. However, Internet Explorer Enhanced Security Configuration is still enabled.

> [!NOTE]
> You are more likely to experience this problem on a terminal server that you configured from a prepared image (Sysprepped image).

To fix this problem, use one or more of the following methods, as appropriate for your situation.

## Resolution 1: Rebuild the terminal server

You might be unable to remove completely the Enhanced Security Configuration from Internet Explorer, if the terminal server has the following attributes:

- Terminal server is configured to have Enhanced Security Configuration enabled for Internet Explorer.
- Terminal server is in a locked-down environment.

In this case, it may be quicker to rebuild the terminal server. When you rebuild, use an Unattend.txt file together with the Windows Setup program, to disable Internet Explorer Enhanced Security Configuration during the installation of Windows.

## Resolution 2: Modify Internet Explorer settings for administrator accounts

For administrator accounts, you can run the following command to turn off Internet Explorer Enhanced Security Configuration:

```console
rundll32.exe setupapi.dll,InstallHinfSection IESoftenAdmin 128 %windir%\inf\IEHARDEN.INF
```

> [!NOTE]
> You must run this command by using an account that has administrative credentials. For the changes to take effect, you must also restart the computer after you run this command.

## Resolution 3: Remove the IEHarden registry entry for specific standard user accounts

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To turn off Internet Explorer Enhanced Security Configuration for specific user accounts, you can remove the `lEHarden` registry entry from each standard user account profile. To remove the entry, follow these steps:

1. Sign in to the terminal server by using the credentials of the standard user account.

2. Select **Start**, select **Search**, and then search for the Regedit.exe file.

3. Right-click **regedit.exe**, and then select **Run as**.

4. Select **The following user**, enter an account name that has administrative credentials, and then select **OK**.

5. Locate and select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zonemap`

6. In the details pane, right-click **IEHarden**, select **Modify**, enter *0* (zero) in the **Value data** box, and then select **OK**. You can also remove this registry entry.

7. Locate and select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`

8. In the details pane, right-click **lEHardenlENoWarn**, select **Modify**, enter *0* (zero) in the **Value data** box, and then select **OK**. You can also remove this registry entry.

9. Exit Registry Editor, and then start Internet Explorer.

10. On the **Tools** menu, select **Internet Options**.

11. Select the **Advanced** tab, select **Restore Defaults**, and then select **OK**.

## Resolution 4: Create a new default profile for standard user accounts

You may have an environment in which one or more of the following conditions are true:

- You want to turn off Internet Explorer Enhanced Security Configuration for all users.
- You use application publishing for Internet Explorer. In this situation, no shell is available in which to load a user's profile. Therefore, the `.DEFAULT` registry subkey is used for the user profile information.
- You use a Citrix-based terminal server, and no local profile exists for a user or for users. In this situation, the Citrix system uses the `.DEFAULT` registry subkey for the user profile information

In this scenario, follow these steps:

1. Create a user account that has full rights to the Windows desktop. For example, use an account that has administrative credentials.

2. Sign in to the terminal server by using the new account, and then turn off Internet Explorer Enhanced Security Configuration by using the **Add or Remove Programs** item in **Control Panel**.

3. Sign out from the terminal server.

4. Copy the NTUser.dat file from this new account profile to the Default User profile folder on the terminal server.

   > [!NOTE]
   > This action overwrites the existing NTUser.dat file in the Default User profile folder. Therefore, you may want to back up the original NTUser.dat file before you perform this action.

5. Create a Group Policy object to disable or to enable Internet Explorer hardening in the Active Directory directory service.

## References

For more information, see [Internet Explorer Enhanced Security Configuration changes the browsing experience](enhanced-security-configuration-faq.yml).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
