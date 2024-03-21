---
title: A Group Policy setting isn't available in the security policy settings list
description: Describes a problem in which the System objects Default owner for objects created by members of the Administrators group Group Policy setting isn't available in the security policy settings list. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: v-jomcc, kaushika
ms.custom: sap:Group Policy\Problems Applying Group Policy, csstroubleshoot
---
# A Group Policy setting isn't available in the security policy settings list

This article describes a problem in which the "System objects: Default owner for objects created by members of the Administrators group" Group Policy setting isn't available in the security policy settings list. 

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947721

## Symptoms

When you try to access the "System objects: Default owner for objects created by members of the Administrators group" Group Policy setting on a computer that is running Windows Vista or newer, this setting isn't available in the security policy settings list.

When the setting is present in your security group policy, it will be ignored by Windows Vista and newer domain members.

## Cause

Windows Vista, Windows 7, Windows Server 2008, and Windows Server 2008 R2 don't support this setting any longer. When enabled, User Account Control (UAC) will ensure the user account is being used as owner for all objects created locally. For remote access, the administrators' group will be used there's no restricted token for network sessions.

Since the support for the setting was removed, the system security policy "System objects: Default owner for objects created by members of the Administrators group" setting isn't available in the Security Templates user interface anymore.

## Resolution

You can add the "System objects: Default owner for objects created by members of the Administrators group" Group Policy setting to the Security Templates user interface.

Hint: This procedure will NOT make Windows Vista and newer honor the setting as Windows XP and Windows Server 2003 do.

To be able to create this Group Policy setting for some computers that are running Windows XP or Windows Server 2003, follow these steps on a computer that is running Windows Server 2008:

1. Log on to as a local administrator to configure the Group Policy setting.
2. Make a backup copy of the c:\windows\inf\Sceregvl.inf file.
3. Take ownership of this file and give the Administrators group full access user rights. To do this, follow these steps:

    > [!NOTE]
    > This file is owned by the TrustedInstaller  group. Therefore, the Administrators have only read-only access user rights.

    1. Right-click the c:\windows\inf\Sceregvl.inf file, and then click **Properties**.
    2. Click the **Security** tab.
    3. Click **Advanced**.
    4. Click the **Owner** tab.
    5. Click **Edit**.
    6. Under **Change Owner to**, click the **Administrators** group, and then click **OK**.
    7. Click **OK** three times.
4. To give the Administrators group full access user rights to the file, follow these steps.

    > [!NOTE]
    > After you give the Administrators group full access user rights, you can edit and save changes to the file.
      1. Right-click the c:\windows\inf\Sceregvl.inf file, and then click **Properties**.
      2. Click the **Security** tab.
      3. Click **Edit**.
      4. Under **Group or User names**, click the **Administrators** group.
      5. Under **Permissions for Administrators**, click to select the **Allow** check box for **Full control**, and then click **OK**.
      6. Click **OK** to close the **Sceregvl.inf Properties** dialog box.
5. Open and edit the c:\windows\inf\Sceregvl.inf file by using Notepad.
6. Copy the following text that should all be in one line:

    MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\nodefaultadminowner,3,"System objects: Default owner for objects created by members of the Administrators group",3,0|Administrators group,1|Object Creator

7. Paste the text just after the following line in the file:(MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy,4,%SCENoAp plyLegacyAuditPolicy%,0)

8. Save the changes to the file, and then exit Notepad.
9. Reset the file ownership and permissions for the c:\windows\inf\Sceregvl.inf file back to the default settings. To do this, follow these steps:
      1. Right-click the c:\windows\inf\Sceregvl.inf file, and then click **Properties**.
      2. Click the **Security** tab.
      3. Click **Advanced**.
      4. Click the **Owner** tab.
      5. Click **Edit**.
      6. Click **Other users or groups**.
      7. Click **Locations**.
      8. Under **Locations**, click your local computer name, and then click **OK**.
      9. In the **Select Users or Group** window, type NT SERVICE\TrustedInstaller under **Enter the object name to select**, and then click **OK**.
      10. In the **Advanced Security Settings for Sceregvl.inf** window, click the **TrustedInstaller** account under **Change Owner to**, and then click **OK**.
      11. Click **OK** three times.
10. Reset the Administrators group access permissions for the c:\windows\inf\Sceregvl.inf file back to only **Read & execute** and **Read**. To do this, follow these steps:
      1. Right-click the c:\windows\inf\Sceregvl.inf file, and then click **Properties**.
      2. Click the **Security** tab.
      3. Click **Edit**.
      4. Under **Group or User names**, click the **Administrators** group.
      5. Under **Permissions for Administrators**, click to clear all the check boxes except the **Read & execute** check box and the **Read** check box, and then click **OK**.
      6. Click **OK** to close the **Sceregvl.inf Properties** dialog box.
11. Reregister the client-side extension for the Group Policy Scecli.dll file. To do this, open an elevated command prompt, type the following command, and then press ENTER:REGSVR32 scecli.dll
Click **OK**.
12. To apply the "System objects: Default owner for objects created by members of the Administrators group" Group Policy setting in the Local Security Policy settings, follow these steps.

> [!NOTE]
> If the computer is a domain controller, use the "Domain Controller security Policy" snap-in.

  1. Click **Start**, click **Control Panel**, click **Administrative Tools**, and then click **Local Security Policy**.
  2. Move to the Security Settings\Local Policies\Security Options location.
  3. In the right pane of the window, right-click the "System objects: Default owner for objects created by members of the Administrators group" Group Policy setting, and then click **Properties**.
  4. In the drop-down box, click **Object Creator**, and then click **OK**.
  5. You may receive a warning in a **Windows Security** message box. Read the warning, and then click **Yes**.
