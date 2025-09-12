---
title: Can't write to event log from ASP.NET 
description: This article describes that you fail to write to the Windows event log from an ASP.NET or ASP application.
ms.date: 04/10/2020
ms.custom: sap:General Development
ms.reviewer: Isha
---
# Fail to write to the Windows event log from an ASP.NET or ASP application

This article helps you resolve the problem that an unexpected error might be thrown when you write to the Windows event log from an ASP.NET or application service provider (ASP) application.

_Original product version:_ &nbsp; Internet Information Services 8.0 and later versions  
_Original KB number:_ &nbsp; 2028427

## Symptoms

You have an ASP.NET or legacy ASP application running on Internet Information Services (IIS) 8.0 or later. Your application logs events to the Windows Event Logs. Writing to the event logs fails with an error message similar to the following example:  

*ASP.NET application*

> System.Security.SecurityException: Requested registry access is not allowed.  
> System.ComponentModel.Win32Exception: Access is denied  
> InvalidOperationException : Cannot open log for source Application. You may not have write access.

*Legacy ASP application*

> Permission Denied.

## Cause

This problem occurs because by default the user token of the application doesn't have the required user rights to write to the Windows event logs because of limited security access.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To provide the required permissions to the thread identity, modify the security of the event log through the below registry keys on the server machine. You should select the event log that your application is writing to:

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Eventlog\Application\CustomSD`
- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Eventlog\System\CustomSD`

The `CustomSD` registry value is of type REG_SZ and contains a security descriptor in Security Descriptor Definition Language (SDDL) syntax. For more information about SDDL Syntax, see the links in the [More information](#more-information) section below.

> [!NOTE]
> To construct a SDDL string, there are three distinct rights that pertain to event logs: Read, Write, and Clear. These rights correspond to the following bits in the access rights field of the ASCII Compatible Encoding (ACE) string:
> - **1** = Read
> - **2** = Write
> - **4** = Clear

> [!IMPORTANT]
> You can configure the security log in the same way. However, you can change only Read and Clear access permissions. Write access to the security log is reserved only for the Windows Local Security Authority (LSA).

The following example is a sample SDDL that shows the default SDDL string for the Application log. Access rights (in hexadecimal) are bold-faced:

> O:BAG:SYD:(D;;0xf0007;;;AN)(D;;0xf0007;;;BG)(A;;0xf0007;;;SY)(A;;0x5;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x2;;;BA)(A;;0x2;;;LS)(A;;0x2;;;NS)

Entry meanings:

- *O:BA* Object owner is Built-in Admin (BA).
- *G:SY* Primary group is System (SY).
- *D:* It's a discretionary access control list (DACL), rather than an audit entry or SACL.
- *`(D;;0xf0007;;;AN)`* Deny Anonymous (AN) all access. (1=Read + 2=Write + 4=Clear) (First ACE string in this SDDL).
- *`(D;;0xf0007;;;BG)`* Deny Built-in Guests (BG) all access.
- *`(A;;0xf0005;;;SY)`* Allow System Read and Clear (1=Read + 4=Clear), including DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER (indicated by the 0xf0000).
- *`(A;;0x7;;;BA)`* Allow Built-in Admin READ, WRITE, and CLEAR.
- *`(A;;0x7;;;SO)`* Allow Server Operators READ, WRITE, and CLEAR.
- *`(A;;0x3;;;IU)`* Allow Interactive Users READ and WRITE.
- *`(A;;0x3;;;SU)`* Allow Service accounts READ and WRITE.

Add the proper ACE string so that your web page can access the event logs. If your web page is running anonymously (in other words, running using Anonymous authentication in IIS), you'll have to give the IUSR or the custom Anonymous account the proper permissions on this `CustomSD` registry key. The Authenticated Users group should have the required permissions if it's running on Windows-Integrated Authentication.

To do it, append the below entry to the default value of `CustomSD` under the event log that you selected.

- For the Authenticated Users group (if there's a windows-Integrated authentication): **`(A;;0x0003;;;AU)`** where AU = Authenticated Users.

- For IUSR or the custom configured Anonymous account if there's an Anonymous Authentication, find the SID for that account and then create one, which looks like **`(A;;0x3;;;S-1-5-21-1985444312-785446638-2839930158-1121)`** where the last field is the SID for the IUSR account on my machine.

- For Windows Authentication on IIS and ASP.NET impersonation turned on with a specific user account, find the SID for that impersonated account and then create an SDDL string, which looks like: **`(A;;0x3;;;S-1-5-21-1985444312-785446638-2839930158-1121)`** where the last field is the SID for the impersonated account.

To give your group read permissions, add the following to the `CustomSD` value at the end of the current `CustomSD` string:  
**`(A;;0x1;;;[Your Group Name/user account SID])`**

To give your group read and write permissions, add the following to the `CustomSD` value at the end of the current `CustomSD` string:  
**`(A;;0x3;;;[Your Group Name/user account SID])`**

*Windows Server 2008*

Instead, on Windows 2008 server, if you're giving the users and groups in question read access to all event logs, you can just add them to the built-in Event Log Readers group. However, if you don't want to give access to all event logs you still have to resort to using the SDDL, for which you can use `WevtUtil` utility. The following example demonstrates defining access to the System event sign-in Windows 2008 Server:

1. Open the command prompt, and run the following command to dump out the SDDL for the System sign-out to a txt file.

    ```console
    wevtutil gl system > C:\temp\out.txt
    ```

2. Open the text file and copy the *channelAccess:* entry

    ```console
    channelAccess: O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x5;;;SO)(A;;0x1;;;IU)(A;;0x1;;;AU)(A;;0x1;;;SU)(A;;0x1;;;S-1-5-3)(A;;0x2;;;LS)(A;;0x2;;;NS)(A;;0x2;;;S-1-5-33)
    ```

3. Add your user or group to this string and run the following command to apply the new SDDL. Replace the *O:BAG:XXXX* with your SDDL String you created in the previous step:

    ```console
    wevtutil sl System /ca:O:BAG:XXXX
    ```

> [!NOTE]
> Once you edit this value and restart the computer, the new setting will take effect. Be certain that you fully understand SDDL and the default permissions that are placed on each event log before you use this procedure. Also, be certain to test any changes thoroughly before you implement them in a production environment, because you could accidentally configure the access control lists (ACLs) on an event log in such a way that no one can access it.

## More information

- [Event Log](/previous-versions/windows/it-pro/windows-vista/cc722385(v=ws.10))

- [Security Descriptor String Format](/windows/win32/secauthz/security-descriptor-string-format)

- [Eventlog Key](/windows/win32/eventlog/eventlog-key)  
