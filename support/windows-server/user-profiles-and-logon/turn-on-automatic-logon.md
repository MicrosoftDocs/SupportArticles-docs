---
title: Configure Windows to automate logon
description: This article describes how to turn on the automatic logon feature in Windows by editing the registry.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: high
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
adobe-target: true
---
# Turn on automatic logon in Windows

This article describes how to configure Windows to automate the logon process by storing your password and other pertinent information in the registry database. By using this feature, other users can start your computer and use the account that you establish to automatically log on.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10, Windows 11  
_Original KB number:_ &nbsp; 324737

> [!IMPORTANT]
> The autologon feature is provided as a convenience. However, this feature may be a security risk. If you set a computer for autologon, anyone who can physically obtain access to the computer can gain access to all the computer's contents, including any networks it is connected to. Additionally, when autologon is turned on, the password is stored in the registry in plain text. The specific registry key that stores this value can be remotely read by the Authenticated Users group. This setting is recommended only for cases in which the computer is physically secured and steps have been taken to make sure that untrusted users cannot remotely access the registry.

## Use Registry Editor to turn on automatic logon

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To use Registry Editor to turn on automatic logon, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *Regedit.exe*, and then press Enter.
3. Locate the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` subkey in the registry.
4. On the **Edit** menu, click **New**, and then point to **String Value**.
5. Type *AutoAdminLogon*, and then press Enter.
6. Double-click **AutoAdminLogon**.
7. In the **Edit String** dialog box, type **1** and then click **OK**.
8. Double-click the **DefaultUserName** entry, type your user name, and then click **OK**.
9. Double-click the **DefaultPassword** entry, type your password, and then click **OK**.

    If the **DefaultPassword** value does not exist, it must be added. To add the value, follow these steps:

    1. On the **Edit** menu, click **New**, and then point to **String Value**.
    2. Type *DefaultPassword*, and then press Enter.
    3. Double-click **DefaultPassword**.
    4. In the **Edit String** dialog, type your password and then click **OK**.

        > [!NOTE]
        > If no DefaultPassword string is specified, Windows automatically changes the value of the `AutoAdminLogon` key from 1 (true) to 0 (false), disabling the AutoAdminLogon feature.


10. If you have joined the computer to a domain, you should add the **DefaultDomainName** value, and the data for the value should be set as the fully qualified domain name (FQDN) of the domain, for example `contoso.com.`.
11. Exit Registry Editor.
12. Click **Start**, click **Shutdown**, and then type a reason in the **Comment** text box.
13. Click **OK** to turn off your computer.
14. Restart your computer. You can now log on automatically.

> [!NOTE]
>
> - To bypass the AutoAdminLogon process and to log on as a different user, press and hold the Shift key after you log off or after Windows restarts.
> - This registry change does not work if the Logon Banner value is defined on the server either by a Group Policy object (GPO) or by a local policy. When the policy is changed so that it does not affect the computer, the autologon feature works as expected.
> - When Exchange Active Sync (EAS) password restrictions are active, the autologon feature does not work. This behavior is by design. This behavior is caused by a change in Windows 8.1 and does not affect Windows 8 or earlier versions. To work around this behavior in Windows 8.1 and later versions, remove the EAS policies in Control Panel.
> - An interactive console logon that has a different user on the server changes the **DefaultUserName** registry entry as the last logged-on user indicator. AutoAdminLogon relies on the **DefaultUserName** entry to match the user and password. Therefore, AutoAdminLogon may fail. You can configure a shutdown script to set the correct **DefaultUserName**.
> - You can use the Sysinternals tool [AutoLogon](/sysinternals/downloads/autologon) to enable this functionality easier. This tool also helps you to use an encrypted version of password.
