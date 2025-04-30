---
title: Set event log security locally or via Group Policy
description: This article provides the methods to set event log security access rights.
ms.date: 04/29/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jamirc
ms.custom:
- sap:group policy\group policy management (gpmc or gpedit)
- pcy:WinComm Directory Services
---
# How to set event log security locally or by using Group Policy  

You can customize security access rights to their event logs in Windows. These settings can be configured locally or through Group Policy. This article describes how to use both of these methods.

_Applies to:_ &nbsp; All versions of Windows  
_Original KB number:_ &nbsp; 323076

## Summary

You can grant users one or more of the following access rights to event logs:

- Read
- Write
- Clear

> [!IMPORTANT]
> You can configure the security log in the same way. However, you can change only Read and Clear access permissions. Write access to the security log is reserved only for the Windows Local Security Authority (LSA) and identities that have the **Manage auditing and security log** privilege enabled.

You can use an Administrative Template Policy for the purpose. For example, the path for the System Eventlog is:

> Computer Configuration\Administrative Templates\Windows Components\Event log Service\System

The setting is *configure log access* and it takes the same Security Descriptor Definition Language (SDDL) string.

Microsoft suggests moving to this method.

## Configure event log security locally

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

The security of each log is configured locally through the values in the registry key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Eventlog`.

For example, the Application log Security Descriptor is configured through the following registry value:  `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Eventlog\Application\CustomSD`

And the System log Security Descriptor is configured through `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Eventlog\System\CustomSD`.

The Security Descriptor for each log is specified by using SDDL syntax. For more information about SDDL syntax, see the Platform SDK, or see the article mentioned in the [References](#references) section of this article.

To construct an SDDL string, note that there are three distinct rights that pertain to event logs: Read, Write, and Clear. These rights correspond to the following bits in the access rights field of the ACE string:

- 1= Read
- 2 = Write
- 4 = Clear

The following is a sample SDDL that shows the default SDDL string for the Application log. The access rights (in hexadecimal) are bold-faced for illustration:

> O:BAG:SYD:(A;;**0xf0007**;;;SY)(A;;**0x7**;;;BA)(A;;**0x3**;;;BO)(A;;**0x5**;;;SO)(A;;**0x1**;;;IU)(A;;**0x3**;;;SU)(A;;**0x1**;;;S-1-5-3)(A;;**0x2**;;;S-1-5-33)(A;;**0x1**;;;S-1-5-32-573)

For example, the first ACE denies Anonymous Users read, write, and clear access to the log. The sixth ACE permits Interactive Users to read and write to the log.

## Use the computer's local group policy to set your application and system log security

1. Select **Start**, select **Run**, type *gpedit.msc*, and then select **OK**.
2. In the Group Policy Editor, expand the following folder tree under **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Event log Service**.
3. For the example of application eventlog, in the subfolder **Application**, double-click **Configure log access**, select **Enable**, type the SDDL string that you want for the log security, and then select **OK**.
4. It's not necessary to set **Configure Log Access (Legacy)**. The option is for operating systems older than Windows Vista.

## Use group policy to set your application and system log security

1. Start the Group Policy Management Console.
2. Select the OU where the target computers are, or the domain root if you want to define this for all machines in the domain.
3. Select an existing policy to add the permissions to, or create a new policy with the Eventlog access permissions.
4. Right-Click the policy and select **Edit**.
5. The Local Group Policy MMC snap-in appears.
6. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then select **Security Options**.
7. Double-click **Event log: Application log SDDL**, type the SDDL string that you want for the log security, and then select **OK**.
8. Double-click **Event log: System log SDDL**, type the SDDL string that you want for the log security, and then select **OK**.

## References

For more information about SDDL syntax and about how to construct an SDDL string, see [Security Descriptor String Format](/windows/win32/secauthz/security-descriptor-string-format).
