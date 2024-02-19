---
title: Access is denied when using the "runas" command, Run as Administrator, or Run as a different user option
description: Describes an issue where you can't use the "runas" command, "Run as Administrator" option, or the "Run as a different user" option. Provides some workarounds.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: nedpyle, kaushika
ms.custom: sap:desktop-shell, csstroubleshoot
---
# Error when you use the runas command, the Run as Administrator option, or the Run as a different user option after you upgrade Windows Server: Access is denied

This article provides some workarounds for an issue where you can't use the `runas` command, the **Run as Administrator** option, or the **Run as a different user** option after you upgrade Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 977513

## Symptoms

Consider the following scenario:  

- You upgrade a computer that's running Windows Server.
- You sign in as a standard user.
- You try to use one of the following features:
  - `runas` command
  - **Run as Administrator** option
  - **Run as a different user** option

In this scenario, you receive the following error message:

> Access is denied

## Cause

The discretionary access control list (DACL) for the Secondary Logon service isn't set correctly when you upgrade Windows Server. This problem prevents a standard user from starting this service and from running an application as a different user.

## Workaround 1: Use the Sc.exe command prompt utility

You can use the Sc.exe command prompt utility to set the security to the default configuration after you upgrade the server.

> [!NOTE]
> You should log on as an administrator before you run these commands.

To do so, follow these steps:  

1. Open a Command Prompt window.
2. At the command prompt, type the following command, and then press ENTER:

    ```console
    net stop seclogon
    ```

3. At the command prompt, type the following command, and then press ENTER:

    ```console
    sc sdset seclogon D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWRPDTLOCRRC;;;IU)(A;;CCLCSWDTLOCRRC;;;SU)(A;;CCLCSWRPDTLOCRRC;;;AU)S:(AU;FA;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)
    ```

    > [!NOTE]
    > This command is wrapped for readability.
4. Close the Command Prompt window.
5. Try to use one of the following features:
   - `runas` command
   - **Run as Administrator** option
   - **Run as a different user** option

    Also, make sure that you can switch users and that the Secondary Logon service starts correctly.

## Workaround 2: Use Group Policy

You can use the Group Policy Management Console to configure a domain-based policy that sets security to the default configuration after you upgrade the server. A new Group Policy object (GPO) should be created for this workaround. And it should be linked so that the new GPO is applied to only the affected computers.

To do so, follow these steps:

1. Edit Group Policy in the Group Policy Management Console.
2. Locate the policy: **Computer Configuration\Policies\Windows Settings\Security Settings\System Services**.  
3. Open the **Secondary Logon** service.
4. Select the **Define this policy setting** check box, and then select **Enabled**.
5. Set the service startup mode to **Manual**.
6. Expand the **Security** node to make sure that the following properties and objects are set to **Allow**.

    |Property|Objects|
    |---|---|
    |Authenticated Users|Query Template, Query Status, Enumerate Dependents, Start, Pause, and continue, Interrogate, Read Permissions, User-Defined Control|
    |Builtin\Administrators|Full Control|
    |Interactive|Query Template, Query Status, Enumerate Dependents, Start, Pause, and continue, Interrogate, Read Permissions, User-Defined Control|
    |Service|Query Template, Query Status, Enumerate Dependents, Pause, and continue, Interrogate, User-Defined Control|
    |System|Query Template, Query Status, Enumerate Dependents, Start, Pause, and continue, Interrogate, Stop|

7. Select **OK** to apply the security changes.
8. Select **OK** to apply the Group Policy changes.
9. Apply the GPO to the affected computers by waiting for Group Policy to update or by starting the update manually.
10. Try to use one of following features:

    - `runas` command
    - **Run as Administrator** option
    - **Run as a different user** option

    Also, make sure that you can switch users and that the Secondary Logon service starts correctly.

> [!NOTE]
> We don't recommend this workaround because the permissions are reapplied during Group Policy updates. However, you have to fix the incorrect security only one time after the upgrade.

## More information

For more information about the `runas` command, visit the following Microsoft TechNet Web site:

[Runas](https://technet.microsoft.com/library/bb490994.aspx)

For more information about how to use the Group Policy Management Console, visit the following Microsoft TechNet Web site:

[Group Policy Management Console](https://technet.microsoft.com/library/cc753298.aspx)
