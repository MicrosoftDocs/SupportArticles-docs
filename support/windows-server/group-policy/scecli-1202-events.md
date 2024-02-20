---
title: Troubleshoot SCECLI 1202 events
description: Describes ways to troubleshoot and to resolve SCECLI 1202 events.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Troubleshoot SCECLI 1202 events

This article describes ways to troubleshoot and to resolve SCECLI 1202 events.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324383

## Summary

The first step in troubleshooting these events is to identify the Win32 error code. This error code distinguishes the type of failure that causes the SCECLI 1202 event. Below is an example of a SCECLI 1202 event. The error code is shown in the **Description** field. In this example, the error code is 0x534. The text after the error code is the error description. After you determine the error code, find that error code section in this article, and then follow the troubleshooting steps in that section.

> 0x534: No mapping between account names and security IDs was done.

or

> 0x6fc: The trust relationship between the primary domain and the trusted domain failed.

## Error code 0x534: No mapping between account names and security IDs was done

These error codes mean that there was a failure to resolve a security account to a security identifier (SID). The error typically occurs either because an account name was mistyped, or because the account was deleted after it was added to the security policy setting. It typically occurs in the **User Rights** section or the **Restricted Groups** section of the security policy setting. It may also occur if the account exists across a trust and then the trust relationship is broken.

To troubleshoot this issue, follow these steps:

1. Determine the account that is causing the failure. To do so, enable debug logging for the Security Configuration client-side extension:

    1. Start Registry Editor.
    2. Locate and then select the following registry subkey:

        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{827D319E-6EAC-11D2-A4EA-00C04F7 9F83A}`  

    3. On the **Edit** menu, select **Add Value**, and then add the following registry value:

        - Value name: ExtensionDebugLevel
        - Data type: DWORD
        - Value data: 2

    4. Exit Registry Editor.

2. Refresh the policy settings to reproduce the failure. To refresh the policy settings, type the following command at the command prompt, and then press ENTER:

    ```console
    secedit /refreshpolicy machine_policy /enforce
    ```

    This command creates a file that is named *Winlogon.log* in the `%SYSTEMROOT%\Security\Logs` folder.

3. Find the problem account. To do so, type the following command at the command prompt, and then press ENTER:

    ```console
    find /i "cannot find" %SYSTEMROOT%\security\logs\winlogon.log
    ```

    The Find output identifies the problem account names, for example, **Cannot find MichaelPeltier**. In this example, the user account MichaelPeltier doesn't exist in the domain. Or it has a different spelling, such as MichellePeltier.

    Determine why this account can't be resolved. For example, look for typographical errors, a deleted account, the wrong policy that applies to this computer, or a trust problem.

4. If you determine that the account must be removed from the policy, find the problem policy and the problem setting. To determine which setting contains the unresolved account, type the following command at the command prompt on the computer that's producing the SCECLI 1202 event, and then press ENTER:

    ```console
    c:\>find /i "account name" %SYSTEMROOT%\security\templates\policies\gpt*.*
    ```

    For this example, the syntax and the results are:

    ```console
    c:\>find /i "MichaelPeltier" %SYSTEMROOT%\security\templates\policies\gpt*.*
    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00000.DOM

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00001.INF

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00002.INF
    SeInteractiveLogonRight = TsInternetUser,*S-1-5-32-549,*S-1-5-32-550,MichaelPeltier,*S-1-5-32-551,*S-1-5-32-544,*S-1-5-32-548

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00003.DOM
    ```

    It identifies GPT00002.inf as the cached security template from the problem Group Policy object (GPO) that contains the problem setting. It also identifies the problem setting as SeInteractiveLogonRight. The display name for SeInteractiveLogonRight is *Logon locally*.

    For a map of the constants (for example, SeInteractiveLogonRight) to their display names (for example, Logon locally), see the Microsoft Windows 2000 Server Resource Kit, Distributed Systems Guide. The map is in the **User Rights** section of the Appendix.

5. Determine which GPO contains the problem setting. Search the cached security template that you identified in step 4 for the text `GPOPath=`. In this example, you would see:

    `GPOPath={6AC1786C-016F-11D2-945F-00C04FB984F9}\MACHINE`

    {6AC1786C-016F-11D2-945F-00C04FB984F9} is the GUID of the GPO.

6. To find the friendly name of the GPO, use the Resource Kit utility Gpotool.exe. Type the following command at the command prompt, and then press ENTER:

    ```console
    gpotool /verbose
    ```

    Search the output for the GUID that you identified in step 5. The four lines that follow the GUID contain the friendly name of the policy. For example:

    ```output
    Policy {6AC1786C-016F-11D2-945F-00C04FB984F9}
    Policy OK
    Details:
    ------------------------------------------------------------
    DC: domcntlr1.wingtiptoys.com
    Friendly name: Default Domain Controllers Policy
    ```

Now you've identified the problem account, the problem setting, and the problem GPO. To resolve the problem, remove or replace the problem entry.

## Error code 0x2: The system cannot find the file specified

This error is similar to 0x534 and to 0x6fc. It's caused by an irresolvable account name. When the 0x2 error occurs, it typically indicates that the irresolvable account name is specified in a Restricted Groups policy setting.

To troubleshoot this issue, follow these steps:

1. Determine which service or which object is having the failure. To do so, enable debug logging for the Security Configuration client-side extension:

    1. Start Registry Editor.
    2. Locate and then select the following registry subkey:

        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{827D319E-6EAC-11D2-A4EA-00C04F7 9F83A}`
  
    3. On the **Edit** menu, select **Add Value**, and then add the following registry value:

        - Value name: ExtensionDebugLevel
        - Data type: DWORD
        - Value data: 2

    4. Exit Registry Editor.

2. Refresh the policy settings to reproduce the failure. To refresh the policy settings, type the following command at the command prompt, and then press ENTER:

    ```console
    secedit /refreshpolicy machine_policy /enforce
    ```

    This command creates a file that's named *Winlogon.log* in the `%SYSTEMROOT%\Security\Logs` folder.

3. At the command prompt, type the following command, and then press ENTER:

    ```console
    find /i "cannot find" %SYSTEMROOT%\security\logs\winlogon.log
    ```

    The Find output identifies the problem account names, for example, **Cannot find MichaelPeltier**. In this example, the user account MichaelPeltier doesn't exist in the domain. Or it has a different spelling--for example, MichellePeltier.

    Determine why this account can't be resolved. For example, look for typographical errors, a deleted account, the wrong policy applying to this computer, or a trust problem.

4. If you determine that the account has to be removed from the policy, find the problem policy and the problem setting. To find what setting contains the unresolved account, type the following command at the command prompt on the computer that's producing the SCECLI 1202 event, and then press ENTER:

    ```console
    c:\>find /i "account name" %SYSTEMROOT%\security\templates\policies\gpt*.*
    ```

    For this example, the syntax and the results are:

    ```console
    c:\>find /i "MichaelPeltier" %SYSTEMROOT%\security\templates\policies\gpt*.*
    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00000.DOM

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00001.INF

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00002.INF
    SeInteractiveLogonRight = TsInternetUser,*S-1-5-32-549,*S-1-5-32-550,JohnDough,*S-1-5-32-551,*S-1-5-32-544,*S-1-5-32-548

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00003.DOM
    ```

    It identifies GPT00002.inf as the cached security template from the problem GPO that contains the problem setting. It also identifies the problem setting as SeInteractiveLogonRight. The display name for SeInteractiveLogonRight is *Logon locally*.

    For a map of the constants (for example, SeInteractiveLogonRight) to their display names (for example, Logon locally), see the Windows 2000 Server Resource Kit, Distributed Systems Guide. The map is in the **User Rights** section of the Appendix.

5. Determine which GPO contains the problem setting. Search the cached security template that you identified in step 4 for the text `GPOPath=`. In this example, you would see:

    `GPOPath={6AC1786C-016F-11D2-945F-00C04FB984F9}\MACHINE`

    {6AC1786C-016F-11D2-945F-00C04FB984F9} is the GUID of the GPO.

6. To find the friendly name of the GPO, use the Resource Kit utility Gpotool.exe. Type the following command at the command prompt, and then press ENTER:

    ```console
    gpotool /verbose
    ```

    Search the output for the GUID you identified in step 5. The four lines that follow the GUID contain the friendly name of the policy. For example:

    ```output
    Policy {6AC1786C-016F-11D2-945F-00C04FB984F9}
    Policy OK
    Details:
    ------------------------------------------------------------
    DC: domcntlr1.wingtiptoys.com
    Friendly name: Default Domain Controllers Policy
    ```

You have now identified the problem account, the problem setting, and the problem GPO. To resolve the problem, search the Restricted Groups section of the security policy for instances of the problem account (in this example, MichaelPeltier), and then remove or replace the problem entry.

## Error code 0x5: Access denied

This error typically occurs when the system hasn't been granted the correct permissions to update the access control list of a service. It may occur if the Administrator defines permissions for a service in a policy but doesn't grant the System account Full Control permissions.

To troubleshoot this issue, follow these steps:

1. Determine which service or which object is having the failure. To do so, enable debug logging for the Security Configuration client-side extension:

    1. Start Registry Editor.
    2. Locate and then select the following registry subkey:

        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{827D319E-6EAC-11D2-A4EA-00C04F7 9F83A}` 
    3. On the **Edit** menu, select **Add Value**, and then add the following registry value:
        - Value name: ExtensionDebugLevel
        - Data type: DWORD
        - Value data: 2
    4. Exit Registry Editor.

2. Refresh the policy settings to reproduce the failure. To refresh the policy settings, type the following command at the command prompt, and then press ENTER:

    ```console
    secedit /refreshpolicy machine_policy /enforce
    ```

    This command creates a file that is named *Winlogon.log* in the `%SYSTEMROOT%\Security\Logs` folder.

3. At the command prompt, type the following, and then press ENTER:

    ```console
    find /i "error opening" %SYSTEMROOT%\security\logs\winlogon.log
    ```

    The Find output identifies the service with the misconfigured permissions, for example, **Error opening Dnscache**. *Dnscache* is the short name for the DNS Client service.

4. Find out which policy or which policies are trying to modify the service permissions. To do so, type the following command at the command prompt, and then press ENTER:

    ```console
    find /i "service" %SYSTEMROOT%\security\templates\policies\gpt*.*".
    ```

    Below is a sample command and its output:

    ```console
    d:\>find /i "dnscache" %windir%\security\templates\policies\gpt*.*

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00000.DOM

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00001.INF

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00002.INF
    Dnscache,3,"D:AR(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;LA)"

    ---------- D:\WINNT\SECURITY\TEMPLATES\POLICIES\GPT00003.DOM
    ```

5. Determine which GPO contains the problem setting. Search the cached security template that you identified in step 4 for the text `GPOPath=`. In this example, you would see:

    `GPOPath={6AC1786C-016F-11D2-945F-00C04FB984F9}\MACHINE`

    {6AC1786C-016F-11D2-945F-00C04FB984F9} is the GUID of the GPO.
6. To find the friendly name of the GPO, use the Resource Kit utility Gpotool.exe. Type the following command at the command prompt, and then press ENTER:

    ```console
    gpotool /verbose
    ```

    Search the output for the GUID that you identified in step 5. The four lines that follow the GUID contain the friendly name of the policy. For example:

    ```output
    Policy {6AC1786C-016F-11D2-945F-00C04FB984F9}
    Policy OK
    Details:
    ------------------------------------------------------------
    DC: domcntlr1.wingtiptoys.com
    Friendly name: Default Domain Controllers Policy
    ```

Now you have identified the service with the misconfigured permissions and the problem GPO. To resolve the problem, search the System Services section of the security policy for instances of the service with the misconfigured permissions. And then take corrective action to grant the System account Full Control permissions to the service.

## Error code 0x4b8: An extended error has occurred

The 0x4b8 error is generic and can be caused by many different problems. To troubleshoot these errors, follow these steps:

1. Enable debug logging for the Security Configuration client-side extension:

    1. Start Registry Editor.
    2. Locate and then select the following registry subkey:

        `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{827D319E-6EAC-11D2-A4EA-00C04F7 9F83A}`
  
    3. On the **Edit** menu, select **Add Value**, and then add the following registry value:
        - Value name: ExtensionDebugLevel
        - Data type: DWORD
        - Value data: 2
    4. Exit Registry Editor.

2. Refresh the policy settings to reproduce the failure. To refresh the policy settings, type the following command at the command prompt, and then press ENTER:

    ```console
    secedit /refreshpolicy machine_policy /enforce
    ```

    This command creates a file that is named Winlogon.log in the `%SYSTEMROOT%\Security\Logs` folder.

3. See [ESENT event IDs 1000, 1202, 412, and 454 are logged repeatedly in the Application log](https://support.microsoft.com/help/278316). This article describes known issues that cause the 0x4b8 error.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
