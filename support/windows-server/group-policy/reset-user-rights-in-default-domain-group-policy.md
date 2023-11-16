---
title: Reset user rights in the default domain GPO
description: Describes how to reset user rights in the default domain Group Policy object (GPO) in Windows Server 2003.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, cenki
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.technology: windows-server-group-policy
---
# How to reset user rights in the default domain group policy in Windows Server 2003

This article describes how to reset user rights in the default domain Group Policy object (GPO) in Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324800

## Summary

The default domain GPO contains many default user-rights settings. Sometimes, if you change the default settings, unexpected restrictions may be put on user rights. If the changes are unexpected or if the changes were not recorded so that you do not know which changes were made, you may have to reset the user-rights settings to their default values.

### Reset User Rights for the Default Domain GPO

To restore user rights to use the default settings for the default domain GPO, follow the procedures that are described in this section in the order that they are presented.

> [!WARNING]
> Make sure that you use caution when you perform the following procedures. If you configure the GPO template incorrectly, you may cause your domain controllers to be inoperable.

#### Edit the Gpttmpl.inf File

To edit the Gpttmpl.inf file, follow these steps.

> [!IMPORTANT]
> Back up the Gpttmpl.inf file before you perform this procedure.

1. Start Windows Explorer and open the following folder, where **Sysvol_path** is the path of the Sysvol folder:
  
    **Sysvol_path**\\Sysvol\\**DomainName**\\Policies\\{31B2F340-016D-11D2-945F-00C04FB984F9}\\Machine\Microsoft\\Windows NT\\SecEdit

    > [!NOTE]
    > The default path of the Sysvol folder is %SystemRoot%\\Sysvol.
2. Right-click **Gpttmpl.inf**, and then click **Open**.
3. To completely reset the user rights to the default settings, replace the existing information in the Gpttmpl.inf file with the following default user-rights information. To do so, paste the following text in the appropriate section of your current Gpttmpl.inf file:

    ```inf
    Unicode=yes  
    [System Access]  
    MinimumPasswordAge = 0  
    MaximumPasswordAge = 42  
    MinimumPasswordLength = 0  
    PasswordComplexity = 0  
    PasswordHistorySize = 1  
    LockoutBadCount = 0  
    RequireLogonToChangePassword = 0  
    ForceLogoffWhenHourExpire = 0  
    ClearTextPassword = 0  
    [Kerberos Policy]  
    MaxTicketAge = 10  
    MaxRenewAge = 7  
    MaxServiceAge = 600  
    MaxClockSkew = 5  
    TicketValidateClient = 1  
    [Version]  
    signature="$CHICAGO$"  
    Revision=1
    ```

4. On the **File** menu, click **Save**, and then click **Exit**.

    > [!NOTE]
    > The permissions settings that result from this procedure are the same as the permissions that are compatible with pre-Microsoft Windows 2000 users and permissions that are compatible only with Windows 2000 users.

#### Edit the Gpt.ini File

The Gpt.ini file controls the GPO template version numbers. You must edit the Gpt.ini file to increase the GPO template version number. To do so:

1. Start Windows Explorer and open the following folder, where **Sysvol_path** is the path of the Sysvol folder:
    **Sysvol_path**\\Sysvol\\Domain\\Policies\\{31B2F340-016D-11D2-945F-00C04FB984F9}

    > [!NOTE]
    > The default path of the Sysvol folder is %SystemRoot%\\Sysvol.

2. Right-click **Gpt.ini**, and then click **Open**.
3. Increase the version number to a number that is sufficient to guarantee that typical replication does not outdate the new version number before the policy is reset. Increment the number either by adding the number "0" to the end of the version number or the number "1" to the beginning of the version number.
4. On the **File** menu, click **Save**, and then click **Exit**.

#### Use GPUpdate to Refresh the Group Policy

Apply the new GPO by using the GPUpdate tool to manually reapply all policy settings. To do so:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type cmd, and then click **OK**.
3. At the command prompt, type the following line, and then press ENTER: GPUpdate /Force

4. Type exit and then press ENTER to quit the command prompt.

    > [!NOTE]
    > To look for errors in policy processing, review the event log.

Use Event Viewer to verify that the GPO was successfully applied. To do so:

1. Click **Start**, point to **Administrative Tools**, and then click **Event Viewer**.
2. Click **Application**.

Look for Event ID 1704 to verify that the GPO was successfully applied.
