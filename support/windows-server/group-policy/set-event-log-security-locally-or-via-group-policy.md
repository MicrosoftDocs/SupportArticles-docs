---
title: Set event log security locally or via Group Policy
description: This article provides the methods to set event log security access rights.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jamirc
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# How to set event log security locally or by using Group Policy  

You can customize security access rights to their event logs in Windows Server 2012. These settings can be configured locally or through Group Policy. This article describes how to use both of these methods.

_Applies to:_ &nbsp; Windows Server 2012 Standard, Windows Server 2012 Datacenter  
_Original KB number:_ &nbsp; 323076

## Summary

You can grant users one or more of the following access rights to event logs:

- Read
- Write
- Clear

> [!IMPORTANT]
> You can configure the security log in the same way. However, you can change only Read and Clear access permissions. Write access to the security log is reserved only for the Windows Local Security Authority (LSA).

You can use an Administrative Template Policy for the purpose. The path for the System Eventlog, for example, is:

> Computer Configuration\Administrative Templates\Windows Components\Event log Service\System

The setting is *configure log access* and it takes the same Security Descriptor Definition Language (SDDL) string.

Microsoft suggests moving to this method once you are on Windows Server 2012.

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

> O:BAG:SYD:(D;; 0xf0007 ;;;AN)(D;; 0xf0007 ;;;BG)(A;; 0xf0007 ;;;SY)(A;; 0x5 ;;;BA)(A;; 0x7 ;;;SO)(A;; 0x3 ;;;IU)(A;; 0x2 ;;;BA)(A;; 0x2 ;;;LS)(A;; 0x2 ;;;NS)

For example, the first ACE denies Anonymous Users read, write, and clear access to the log. The sixth ACE permits Interactive Users to read and write to the log.

## Modify your local policy to permit customization of the security of your event logs

1. Back up the %WinDir%\Inf\Sceregvl.inf file to a known location.
2. Open %WinDir%\Inf\Sceregvl.inf in Notepad.
3. Scroll to the middle of file, and then put the pointer immediately before [Strings].
4. Insert the following lines:

   > MACHINE\System\CurrentControlSet\Services\Eventlog\Application\CustomSD,1,%AppLogSD%,2  
   MACHINE\System\CurrentControlSet\Services\Eventlog\System\CustomSD,1,%SysLogSD%,2

5. Scroll to the end of the file, and then insert the following lines:

   > AppLogSD="Event log: Specify the security of the application log in Security Descriptor Definition Language (SDDL) syntax"  
   SysLogSD="Event log: Specify the security of the System log in Security Descriptor Definition Language (SDDL) syntax"

6. Save and then close the file.

7. Select **Start**, select **Run**, type *regsvr32 scecli.dll* in the **Open** box, and then press ENTER.

8. In the **DllRegisterServer in scecli.dll succeeded** dialog box, select **OK**.

## Use the computer's local group policy to set your application and system log security

1. Select **Start**, select **Run**, type *gpedit.msc*, and then select **OK**.
2. In the Group Policy editor, expand **Windows Setting**, expand **Security Settings**, expand **Local Policies**, and then expand **Security Options**.
3. Double-click **Event log: Application log SDDL**, type the SDDL string that you want for the log security, and then select **OK**.
4. Double-click **Event log: System log SDDL**, type the SDDL string that you want for the log security, and then select **OK**.

## Use group policy to set your application and system log security for a domain, site, or organizational unit in Active Directory

> [!IMPORTANT]
> To view the group policy settings that are described in this article in the Group Policy editor, first complete the following steps, and then continue to the [Use group policy to set your application and system log security](#use-group-policy-to-set-your-application-and-system-log-security) section:

1. Use a text editor such as Notepad to open the Sceregvl.inf in the %Windir%\Inf folder.
2. Add the following lines to the [Register Registry Values] section:

   > MACHINE\System\CurrentControlSet\Services\Eventlog\Application\CustomSD,1,%AppCustomSD%,2  
   MACHINE\System\CurrentControlSet\Services\Eventlog\Security\CustomSD,1,%SecCustomSD%,2  
   MACHINE\System\CurrentControlSet\Services\Eventlog\System\CustomSD,1,%SysCustomSD%,2  
   MACHINE\System\CurrentControlSet\Services\Eventlog\Directory Service\CustomSD,1,%DSCustomSD%,2  
   MACHINE\System\CurrentControlSet\Services\Eventlog\DNS Server\CustomSD,1,%DNSCustomSD%,2  
   MACHINE\System\CurrentControlSet\Services\Eventlog\File Replication Service\CustomSD,1,%FRSCustomSD%,2

3. Add the following lines to the [Strings] section:

   > AppCustomSD="Eventlog: Security descriptor for Application event log"  
   SecCustomSD="Eventlog: Security descriptor for Security event log"  
   SysCustomSD="Eventlog: Security descriptor for System event log"  
   DSCustomSD="Eventlog: Security descriptor for Directory Service event log"  
   DNSCustomSD="Eventlog: Security descriptor for DNS Server event log"  
   FRSCustomSD="Eventlog: Security descriptor for File Replication Service event log"

4. Save the changes you made to the Sceregvl.inf file, and then run the `regsvr32 scecli.dll` command.
5. Start Gpedit.msc, and then double-click the following branches to expand them:

    **Computer Configuration**  
    **Windows Settings**  
    **Security Settings**  
    **Local Policies**  
    **Security Options**

6. View the right panel to find the new Eventlog settings.

### Use group policy to set your application and system log security

1. In the Active Directory Sites and Services snap-in or the Active Directory Users and Computers snap-in, right-click the object for which you want to set the policy, and then select **Properties**.
2. Select the **Group Policy** tab.
3. If you must create a new policy, select **New**, and then define the policy's name. Otherwise, go to step 5.
4. Select the policy that you want, and then select **Edit**.

   The Local Group Policy MMC snap-in appears.

5. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then select **Security Options**.
6. Double-click **Event log: Application log SDDL**, type the SDDL string that you want for the log security, and then select **OK**.
7. Double-click **Event log: System log SDDL**, type the SDDL string that you want for the log security, and then select **OK**.

## References

For more information about SDDL syntax and about how to construct an SDDL string, see [Security Descriptor String Format](/windows/win32/secauthz/security-descriptor-string-format).
