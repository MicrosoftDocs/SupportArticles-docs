---
title: SSPR_0029 - Your organization hasn't properly set up the on-premises configuration for password reset
description: Troubleshoot password writeback generic error code SSPR_0029 - Your organization hasn't properly set up the on-premises configuration for password reset.
ms.date: 08/17/2022
ms.reviewer: jarrettr, nualex, v-leedennis
ms.service: active-directory
ms.subservice: enterprise-users
keywords:
#Customer intent: As a Microsoft Entra administrator, I want to fix the on-premises configuration for password reset so that users can successfully reset or change their password.
---
# Troubleshoot error SSPR_0029: Your organization hasn't properly set up the on-premises configuration for password reset

This article helps you troubleshoot the self-service password reset (SSPR) error "SSPR_0029: Your organization hasn't properly set up the on-premises configuration for password reset" that occurs after the user or admin enters and confirms a new password on the SSPR page.

## Symptoms

A user or administrator takes the following steps, and then receives an `SSPR_0029` error:

1. At a Microsoft account sign-in page or Microsoft Azure sign-in page in the <https://login.microsoftonline.com> domain, a user or admin selects **Can't access your account?**, **Forgot my password**, or **reset it now**.

1. The user or admin selects the **Work or school account** account type. Then, they're redirected to the SSPR page at <https://passwordreset.microsoftonline.com> to start the **Get back into your account** flow.

1. On the **Who are you?** screen, the user or admin enters their user ID, completes a case-insensitive captcha security challenge, and then selects **Next**.

1. On the **Why are you having trouble signing in?** screen, the user or admin selects **I forgot my password** > **Next**.

1. On the **choose a new password** screen, the user or admin enters and confirms a new password string, and then selects **Finish**. Then, a **We're sorry** screen appears and presents the following message:

    > SSPR_0029: Your organization hasn't properly set up the on-premises configuration for password reset.
    >
    > If you're an administrator, you can get more information from the Troubleshoot password writeback article. If you're not an administrator, you can provide this information when you contact your administrator.

## Cause 1: Can't use password writeback to reset the password of a synchronized Windows Active Directory administrator

You're a synchronized Windows Active Directory admin who belongs (or used to belong) to an on-premises Active Directory [protected group](/windows-server/identity/ad-ds/plan/security-best-practices/appendix-c--protected-accounts-and-groups-in-active-directory), and you can't use SSPR and password writeback to reset your on-premises password.

### Solution: None (behavior is by design)

For security, administrator accounts that exist within a local Active Directory protected group can't be used together with password writeback. Administrators can change their password in the cloud, but can't reset a forgotten password. For more information, see [How does self-service password reset writeback work in Microsoft Entra ID](/azure/active-directory/authentication/concept-sspr-writeback).

## Cause 2: AD DS Connector account doesn't have the right Active Directory permissions

The synchronized user is missing the correct permissions in Active Directory.

### Solution: Resolve Active Directory permission issues

To resolve issues that affect Active Directory permissions, see [Password Writeback access rights and permissions][access-rights-permissions].

### Workaround: Target a different Active Directory domain controller

> [!NOTE]
> Password writeback has a dependency on the legacy API [NetUserGetInfo](/windows/win32/api/lmaccess/nf-lmaccess-netusergetinfo). The `NetUserGetInfo` API requires a complex set of allowed permissions in Active Directory that can be difficult to identify, especially when a Microsoft Entra Connect server is running on a domain controller. For more information, see [Applications using NetUserGetInfo and similar APIs rely on read access to certain Active Directory objects](../../windows-server/identity/netuser-netgroup-fails-with-access-denied.md).

Do you have a scenario in which a Microsoft Entra Connect server is running on a domain controller, and it isn't possible to resolve Active Directory permissions? In this case, we recommend that you deploy Microsoft Entra Connect server on a member server instead of a domain controller. Or, configure your Active Directory connector to **Only use preferred domain controllers** by using the following steps:

1. On the **Start** menu, search for and select **Synchronization Service Manager**.

1. In the **Synchronization Service Manager** window, select the **Connectors** tab.

1. Right-click the Active Directory connector from the list of connectors, and then select **Properties**.

1. In the **Connector Designer** pane of the **Properties** dialog box, select **Configure Directory Partitions**.

1. In the **Configure Directory Partitions** pane, select the **Only use preferred domain controllers** option, and then select **Configure**.

1. In the **Configure Preferred DCs** dialog box, add one or more server names that point to a different domain controller (or domain controllers) than the local host.

1. To save your changes and return to the main window, select **OK** three times, including in the **Warning** dialog box that shows an advanced configuration disclaimer.

## Cause 3: Servers aren't allowed to make remote calls to Security Accounts Manager (SAM)

In this case, two similar application error events are logged: Event ID 33004 and 6329. Event ID 6329 differs from 33004 because it contains an `ERROR_ACCESS_DENIED` error code in the stack trace when the server tries to make a remote call to SAM:

> ERR_: MMS(####): admaexport.cpp(2944): Failed to acquire user information: Contoso\MSOL_############. Error Code: ERROR_ACCESS_DENIED

This situation can occur if the Microsoft Entra Connect server or the domain controller has or had a hardening security setting applied with a Domain Group Policy Object (GPO) or in the Local Security Policy of the server. To check whether this is the case, follow these steps:

1. Open an administrative Command Prompt window, and run the following commands:

    ```console
    md C:\Temp
    gpresult /h C:\Temp\GPreport.htm
    start C:\Temp\GPreport.htm
    ```

1. Open the *C:\Temp\gpresult.htm* file in your web browser, and expand **Computer Details** > **Settings** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies/Security Options** > **Network Access**. Then, check whether you have a setting that's named [Network access: Restrict clients allowed to make remote calls to SAM](/windows/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls).

1. To open the Local Security Policy snap-in, select **Start**, enter *secpol.msc*, press Enter, and then expand **Local Policies** > **Expand Security Options**.

1. In the list of policies, select [Network access: Restrict clients allowed to make remote calls to SAM](/windows/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls). The **Security Setting** column will show **Not Defined** if the setting isn't enabled, or it displays an `O:BAG:...` security descriptor value if the setting is enabled. If the setting is enabled, you can also select the **Properties** icon to see the Access Control List (ACL) that's currently applied.

    > [!NOTE]
    > By default, this policy setting is turned off. When this setting is applied on a device through a GPO or a Local Policy setting, a registry value that's named **RestrictRemoteSam** is created in the **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\\** registry path. However, this registry setting can be difficult to clear after it's defined and applied to the server. Disabling the Group Policy setting or clearing the **Define this policy setting** option in Group Policy Management Console (GPMC) doesn't remove the registry entry. Therefore, the server still restricts which clients are allowed to make remote calls to SAM.
    >
    > How do you accurately verify that the Microsoft Entra Connect server or the domain controller is still restricting remote calls to SAM? You check whether the registry entry remains present by running the [Get-ItemProperty](/powershell/module/microsoft.powershell.management/get-itemproperty#example-3--get-the-value-name-and-data-of-a-registry-entry-in-a-registry-subkey) cmdlet in PowerShell:
    >
    > ```powershell
    > Get-ItemProperty -Path HKLM:\System\CurrentControlSet\Control\Lsa -Name RestrictRemoteSam
    > ```

Does the PowerShell output show that a **RestrictRemoteSam** registry entry is still present? If so, you have two possible solutions.

### Solution 1: Add the AD DS Connector account to the list of allowed users

Keep the **Network access: Restrict clients allowed to make remote calls to SAM** policy setting enabled and applied on the Microsoft Entra Connect server, but add the Active Directory Domain Services (AD DS) Connector account (*MSOL_* account) to the list of allowed users. For instructions, see the following steps:

1. If you don't know the name of your AD DS Connector account, see [Identify the AD DS Connector account][identify-ad-ds-connector].

1. In the GPMC or Local Security Policy snap-in, go back to the property dialog box for that policy setting.

1. Select **Edit Security** to display the **Security Settings for Remote Access to SAM** dialog box.

1. In the **Group or user names** list, select **Add** to display the **Select Users or Groups** dialog box. In the **Enter the object names to select** box, enter the name of the AD DS Connector account (*MSOL_* account), and then select **OK** to exit that dialog box.

1. Select the AD DS Connector account in the list. Under **Permissions for \<account name>**, in the **Remote Access** row, select **Allow**.

1. Select **OK** two times to accept the policy setting changes and return to the list of policy settings.

1. Open an administrative Command Prompt window, and run the [gpupdate](/windows-server/administration/windows-commands/gpupdate) command to force a Group Policy update:

    ```console
    gpupdate /force
    ```

### Solution 2: Remove the [Network access: Restrict clients allowed to make remote calls to SAM](/windows/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls) policy setting, then manually delete the RestrictRemoteSam registry entry

1. If the security setting is applied from the Local Security Policy, go to step #4.

1. Open the GPMC snap-in from a Domain Controller, and edit the respective Domain GPO.

1. Expand **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Computer Configuration** > **Local Policies** > **Security Options**.

1. In the list of security options, select **Network access: Restrict clients allowed to make remote calls to SAM**, open **Properties**, and then disable **Define this policy setting**.

1. Open an administrative Command Prompt window, and run the [gpupdate](/windows-server/administration/windows-commands/gpupdate) command to force a Group Policy update:

    ```console
    gpupdate /force
    ```

1. To generate a new Group Policy result report (*GPreport.htm*), run the [gpresult](/windows-server/administration/windows-commands/gpresult) command, and then open the new report in a web browser:

    ```console
    md C:\Temp
    gpresult /h C:\Temp\GPreport.htm
    start C:\Temp\GPreport.htm
    ```

1. Check the report to make sure that the policy setting for **Network access: Restrict clients allowed to make remote calls to SAM** isn't defined.

1. Open an administrative PowerShell console.

1. To remove the **RestrictRemoteSam** registry entry, run the [Remove-ItemProperty](/powershell/module/microsoft.powershell.management/remove-itemproperty) cmdlet:

    ```powershell
    Remove-ItemProperty -Path HKLM:\System\CurrentControlSet\Control\Lsa -Name RestrictRemoteSam
    ```

    > [!NOTE]
    > If you delete the **RestrictRemoteSam** registry entry without removing the Domain GPO setting, this registry entry will be re-created on the next Group Policy refresh cycle, and the `SSPR_0029` error will reoccur.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[access-rights-permissions]: password-writeback-access-rights-permissions.md
[identify-ad-ds-connector]: password-writeback-access-rights-permissions.md#identify-the-ad-ds-connector-account
