---
title: Windows LAPS troubleshooting guidance
description: Provides troubleshooting guidance for Windows LAPS using Windows events.
ms.date: 06/20/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jsimmons, sandeo, mimanans, sdabbiru, deverett, raviks, v-lianna
ms.custom:
- sap:windows local admin password solution (laps)
- pcy:WinComm Directory Services
---
# Windows LAPS troubleshooting guidance

This guide provides the fundamental concepts to use when troubleshooting Windows Local Administrator Password Solution (Windows LAPS) issues.

Windows LAPS is a Windows feature that automatically manages and backs up the password of a local administrator account on your Microsoft Entra joined or Windows Server Active Directory-joined devices. You also can use Windows LAPS to automatically manage and back up the Directory Services Repair Mode (DSRM) account password on your Windows Server Active Directory domain controllers. An authorized administrator can retrieve the DSRM password and use it. For more information, see [What is Windows LAPS?](/windows-server/identity/laps/laps-overview)

> [!NOTE]
>
> - This article is for Windows LAPS (the new feature), not for the legacy LAPS or the older version of LAPS.
> - This article lists only some of the top possible root causes. Other causes may also exist but remain undiscovered.
> - The following list contains the most common event IDs and might not include all Windows LAPS events.

## Troubleshooting Windows LAPS using Windows events

To view Windows LAPS events, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **LAPS** > **Operational** in Event Viewer.

> [!NOTE]
>
> - Windows LAPS processing starts with Event ID 10003 and ends with Event ID 10004.
> - If the processing of the current cycle fails for any reason, Event ID 10005 is logged.

Windows LAPS has two scenarios:

- Windows LAPS Active Directory

    Client machines are configured to store the password in Active Directory.
- Windows LAPS Azure  Microsoft Entra ID

    Client machines are configured to store the password in Microsoft Entra ID.

The following table lists the event IDs that are logged in different scenarios:

|Event ID  |Scenario  |
|---------|---------|
|10006     |Windows LAPS Active Directory         |
|10011     |Windows LAPS Active Directory         |
|10012     |Windows LAPS Active Directory         |
|10013     |Windows LAPS Active Directory and Microsoft Entra ID         |
|10017     |Windows LAPS Active Directory         |
|10019     |Windows LAPS Active Directory and Microsoft Entra ID         |
|10025     |Windows LAPS Microsoft Entra ID         |
|10026     |Windows LAPS Microsoft Entra ID         |
|10027     |Windows LAPS Active Directory and Microsoft Entra ID         |
|10028     |Windows LAPS Microsoft Entra ID         |
|10032     |Windows LAPS Microsoft Entra ID         |
|10034     |Windows LAPS Active Directory        |
|10035     |Windows LAPS Active Directory         |
|10048     |Windows LAPS Active Directory and Microsoft Entra ID         |
|10049     |Windows LAPS Active Directory and Microsoft Entra ID         |
|10056     |Windows LAPS Active Directory         |
|10057     |Windows LAPS Active Directory         |
|10059     |Windows LAPS Microsoft Entra ID         |
|10065     |Windows LAPS Active Directory         |

## Event ID 10006

```output
LAPS password encryption is required but the Active Directory domain is not yet at 2016 domain functional level. The password was not updated and no changes will be made until this is corrected
```

By default, Windows LAPS encrypts the password of the managed account on the client machine. To support the encryption, the domain functional level should be Windows Server 2016.

### Resolution

1. Raise the domain functional level if needed.
2. Disable the **Enable password encryption** Group Policy for client machines.
    > [!NOTE]
    > We don't recommend disabling the password encryption stored on the domain controller.

## Event ID 10011

```output
LAPS failed when querying Active Directory for the current computer state
```

Windows LAPS periodically (every hour) queries Active Directory for the computer state, and the client machine uses the Netlogon service to discover a domain controller on it.

### Resolution

If you're in an environment where you have connectivity only to a writable domain controller, open the network ports between the client machine and the domain controller.

For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).

## Event ID 10012

```output
The Active Directory schema has not been updated with the necessary LAPS attributes
```

To introduce Windows LAPS, you need to extend the schema with Windows LAPS attributes. Or, if you're using Windows LAPS in legacy LAPS emulation mode, you need to extend the schema with the legacy LAPS attributes. This issue occurs for one of the following reasons:

- Root cause 1

    The schema hasn't been extended with the new Windows LAPS attributes.
- Root cause 2

    A transient Active Directory replication exists between the local domain controller (DC) and the primary domain controller (PDC).
- Root cause 3

    An Active Directory replication issue on the local domain controller.

### Resolution to root cause 1

Run the `Update-LapsADSchema` PowerShell cmdlet to update the Active Directory schema by using Schema Admin privileges.

If you're using the legacy LAPS emulation, extend the schema with the `Update-AdmPwdADSchema` PowerShell cmdlet (this action requires installing the legacy LAPS product first).

### Resolution to root cause 2

Due to the replication latency, the schema attributes haven't been replicated to the local domain controller. You can use the LDP or ADSIEDIT snap-in to identify if the Windows LAPS schema attributes have been replicated. Force Active Directory replication of the schema partition with the schema master by using the following command:

```console
repadmin /replicate DC2.contoso.com PDC.contoso.com CN=Schema,CN=Configuration,DC=contoso,dc=com /force
```

> [!NOTE]
>
> - Replace `DC2.contoso.com` with the name of the DC identified by Event ID 10055 in the Windows LAPS event logs.
> - Replace `PDC.contoso.com` with the name of the PDC in your environment. You can identify the PDC by using the `nltest /dsgetdc:contoso.com /pdc /force` command.

### Resolution to root cause 3

There's an Active Directory replication issue between the local domain controller and other domain controllers in the domain. You can view Event ID 10055 in Windows LAPS event logs to verify the name of the domain controller and run the `repadmin /showreps` command to identify any replication errors.

For more information, see [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems).

## Event ID 10013

```output
LAPS failed to find the currently configured local administrator account
```

Windows LAPS reads the local administrator's name from Group Policy or the Intune setting **Name of administrator account to manage**. If this setting isn't configured, it will look for the local account with a security identifier (SID) ending with 500 (administrator). If Windows LAPS can't find the account, Event ID 10013 is logged.

Starting with Windows 11, version 24H2 and Windows Server 2025, a feature to create the managed user has been added. For more information, see [Windows LAPS account management modes](/windows-server/identity/laps/laps-concepts-account-management-modes). For earlier versions, the account must already exist.

### Resolution

Verify and make sure the managed user is present in local users by using one of the following methods:

- Use *lusrmgr.msc* to open **Local Users and Groups**.
- Run the `net user` command.
    > [!NOTE]
    > Make sure there are no trailing spaces at the beginning and the end of the account.

## Event ID 10017

```output
LAPS failed to update Active Directory with the new password. The current password has not been modified
```

This is a status event at the end of a Windows LAPS processing cycle. This event has no root cause, so you need to review the earlier processing of the events where Windows LAPS has encountered an issue.

### Resolution

1. Open an elevated PowerShell command prompt and run the `Invoke-lapsPolicyProcessing` cmdlet.
2. Open Event Viewer and go to **Applications and Services Logs** > **Microsoft** > **Windows** > **LAPS** > **Operational**.
3. Filter for the latest processing of events starting from Event ID 10003 through Event ID 10005.
4. Fix any errors prior to Event ID 10017.

## Event ID 10019

```output
LAPS failed to update the local admin account with the new password
```

Windows LAPS can't update the password of the locally managed user account on the local machine. Windows LAPS found the managed user, but had trouble changing the password.

### Resolution

- Identify if there's a resource issue like a memory leak or out of memory issue. Reboot the machine to verify if you observe a similar error.
- A third-party application or filter driver that's managing the same managed user doesn't allow Windows LAPS to manage the password.

## Event ID 10025

```output
Azure discovery failed
```

The device (Microsoft Entra joined or hybrid joined) that's configured with Windows LAPS to store passwords in Microsoft Entra ID should discover the Enterprise Registration Endpoint.

### Resolution

1. Verify that you can connect successfully to the registration endpoint (`https://enterpriseregistration.windows.net`). If you open Microsoft Edge or Google Chrome and connect to the registration endpoint (`https://enterpriseregistration.windows.net`), you get a message "Unsupported method or endpoint." This message means you can connect to the Enterprise Registration Endpoint.
2. If you're using a proxy server, verify that your proxy is configured under the system context. You can open an elevated command prompt and run the `netsh winhttp show proxy` command to display the proxy.

## Event ID 10026

```output
LAPS was unable to authenticate to Azure using the device identity
```

This issue occurs if there's an issue with the device's Primary Refresh Token (PRT).

### Resolution

1. Verify that you have enabled the Windows LAPS feature in your Azure tenant.
2. Verify that the machine isn't deleted or disabled in your Azure tenant.
3. Open a command prompt, run the `dsregcmd /status` command and check the following sections for any errors:
    - `Device status`
    - `SSO data`
    - `Diagnostic data`
4. Verify the error message by using [the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd) and troubleshoot the issue.
5. Troubleshoot Microsoft Entra hybrid joined devices by using [Troubleshoot Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current).
6. Use the [Device Registration Troubleshooter Tool](/samples/azure-samples/dsregtool/dsregtool/) to identify and fix any device registration issues.
7. If you receive an error message, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes) for the description of the error and further troubleshooting.  

## Event ID 10027

```output
LAPS was unable to create an acceptable new password. Please verify that the LAPS password length and complexity policy is compatible with the domain and local password policy settings
```

Windows LAPS can't update the password of the locally managed user account on the local machine. Windows LAPS found the managed user, but had trouble changing the password.

### Resolution

1. Check the password policy on the machine by running the `net accounts` command in a command prompt. Validate any of the password policies if they don't meet the criteria of Windows LAPS configured password policy, like the password complexity, password length, or password age.
2. Identify if the setting is applied via a local Group Policy Object (GPO), a Domain GPO, or Local Security Settings by running the `GPRESULT /h` command. Modify the GPO or security settings to match the Windows LAPS GPO password settings. The settings are configured via the **Password Settings** setting in GPO or Intune (MDM).

    > [!NOTE]
    > Your password policies configured in Active Directory, local GPO, or security settings should match the Windows LAPS password settings, or should contain settings lower than those in the Windows LAPS **Password Settings** configuration.

3. Check if you have any third-party password filters that might be blocking setting the password.
    1. Download [Process Explorer](/sysinternals/downloads/process-explorer).
    2. Extract and run Process Explorer as an administrator.
    3. Select the *LSASS.exe* process on the left pane.
    4. Select **View** > **Show Lower Pane**.
    5. Select **View** > **Lower Pane View** > **DLLs**.

        :::image type="content" source="media/windows-laps-troubleshooting-guidance/process-explorer-dlls-thumbnail.png" alt-text="Screenshot of the Process Explorer with loaded dlls or modules." lightbox="media/windows-laps-troubleshooting-guidance/process-explorer-dlls.png":::

4. The lower pane displays the loaded DLLs or modules. Identify if there are any third-party modules by using the **Company Name** field (any modules other than Microsoft).

    Review the DLL list to identify if the name of the third-party DLL (module) has some keywords like "security," "password," or "policies." Uninstall or stop the application or service that might be using this DLL.

<a name='machine-joined-to-azure-ad'></a>

### Machine joined to Microsoft Entra ID

Microsoft Entra ID or hybrid joined devices can be managed by using mobile device management (MDM) (Intune), local GPOs, or any similar third-party software.

1. Check the password policy on the machine by running the `net accounts` command in a command prompt. Validate any of the password policies if they don't meet the criteria of Windows LAPS configured password policy, like the password complexity, password length, or password age.
2. Identify if the conflicting policy is applied via Intune, local GPO, or a similar third-party software like Intune to manage the password policies on the machine.

## Event ID 10028

```output
LAPS failed to update Azure Active Directory with the new password
```

The Windows LAPS client machine periodically updates passwords. This event appears if the client machine configured with Windows LAPS can't update the password to Microsoft Entra ID.

### Resolution

1. Verify that you have enabled the Windows LAPS feature in your Azure tenant.
2. Verify that the machine isn't deleted or disabled in your Azure tenant.
3. Open a command prompt and run the `dsregcmd /status` command to check the following sections for any errors:
    - `Device status`
    - `SSO data`
    - `Diagnostic data`
4. Verify the error message by using [the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd) and troubleshoot the issue.
5. Use [Troubleshoot Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current) to troubleshoot Microsoft Entra hybrid joined devices.
6. Use the [Device Registration Troubleshooter Tool](/samples/azure-samples/dsregtool/dsregtool/) to identify and fix any device registration issues.
7. If you receive an error message, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes) for the description of the error and further troubleshooting.

## Event ID 10032

```output
LAPS was unable to authenticate to Azure using the device identity
```

There might be issues related to Microsoft Entra authentication when using device PRT.

### Resolution

1. Verify that you have enabled Windows LAPS feature in your Azure tenant.
2. Verify that the machine isn't deleted or disabled in your Azure tenant.
3. Open a command prompt and run the `dsregcmd /status` command to check the following sections for any errors:
    - `Device status`
    - `SSO data`
    - `Diagnostic data`
4. Verify the error message by using [the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd) and troubleshoot the issue.
5. Use [Troubleshoot Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current ) to troubleshoot Microsoft Entra hybrid joined devices.
6. Use the [Device Registration Troubleshooter Tool](/samples/azure-samples/dsregtool/dsregtool/) to identify and fix any device registration issues.
7. If you receive an error message, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes) for the description of the error and further troubleshooting.

## Event ID 10034

```output
The configured encryption principal is an isolated (ambiguous) name. This must be corrected before the configured account's password can be managed. Please specify the name in either user@domain.com or domain\user format.
```

The encryption principal is configured via the **Configure authorized password decryptors** setting by using GPO or MDM (Intune). It appears that the setting isn't configured properly.

### Resolution

Correct the Intune or GPO configuration. This setting accepts two values:

- SID of a domain group or user
- Group name in \<Domain Name\>\\\<Group Name\>, \<Domain Name\>\\\<User Name\>, or \<User Name\>@\<Domain Name\>

> [!NOTE]
> Verify that there are no trailing spaces at the beginning and the end of the setting.

## Event ID 10035

```output
The configured encryption principal name could not be mapped to a known account. This must be corrected before the configured account's password can be managed.
```

The encryption principal is configured via the **Configure authorized password decryptors** setting by using GPO or MDM (Intune). The setting accepts an SID or a domain group name in either \<Domain Name\>\\\<Group Name\>, \<Domain Name\>\\\<User Name\>, or \<User Name\>@\<Domain Name\>. The error occurs when the Windows LAPS client can't resolve an SID to a name or a name to an SID.

### Resolution

1. Verify that the domain group exists in Active Directory and hasn't been deleted.
2. If the group is newly created, wait for the Active Directory replication to converge on the local domain controller of the client machine.
3. Use the Sysinternal tool PsGetSid to manually resolve the SID or name.
    1. Download [PsGetSid](/sysinternals/downloads/psgetsid).
    2. Extract the downloaded file and open an elevated command prompt on the client machine where you're experiencing the issue.
    3. Run the `psgetsid -accepteula <SID> or <Name>` command. Use the SID or name mentioned in Event ID 10035.
4. Check if there are any Active Directory replication errors in the forest and troubleshoot them. For more information, see [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems).

## Event ID 10048

```output
The currently pending post-authentication reset timer has been retried the maximum allowed number attempts and will no longer be scheduled
```

The post-authentication retry is the number of retry operations tried reset the password with the appropriate directory (Microsoft Entra ID or Active Directory). If this number exceeds the maximum of 100 on a boot, this event is triggered.

### Resolution

1. Identity if there's a problem connecting to the appropriate directory, such as Active Directory or Microsoft Entra ID.
2. Troubleshoot any other errors during the processing of Windows LAPS events.

## Event ID 10049

```output
LAPS attempted to reboot the machine as a post-authentication action but the operation failed
```

Windows LAPS can be configured for a post-authentication action by using the **Post-authentication actions** setting with GPO or MDM (Intune). In this scenario, the setting is configured to reboot the machine if it detects a post-authentication action. This event denotes that the machine can't reboot.

### Resolution

1. Identify if there's any application blocking a shutdown of the machine.
2. Identify if you have necessary privileges to shut down the machine.

## Event ID 10056

```output
LAPS failed to locate a writable domain controller
```

Windows LAPS client uses Lightweight Directory Access Protocol (LDAP) modify operation to write passwords to Active Directory from the Windows LAPS client. Windows LAPS needs to discover a writable domain controller in the domain to write the password of the managed account.

### Resolution

1. Open a command prompt on the client machine and run the command:

    ```console
    nltest /dsgetdc:<Domain Name> /force /writable
    ```

    If you get error 1355 (domain controller for the domain cannot be found), it means you need to troubleshoot the writable DC discovery issue.
2. If you're in an environment where you have connectivity only to a writable domain controller, open the network ports between the client machine and the domain controller. For more information, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).

## Event ID 10057

```output
LAPS was unable to bind over LDAP to the domain controller with an <Error Code>:
```

During a scheduled background processing, Windows LAPS needs to connect to a domain controller. This processing is done using the machine context. This error appears if there's any Active Directory authentication issue between the client machine and the domain controller.

### Resolution

1. Verify that the machine account isn't deleted in Active Directory.
2. Validate any secure channel issues between the client and the domain controller by running an elevated command:

    ```console
    nltest /sc_query:<Domain Name>
    ```

3. Rejoin the machine to the domain.

    > [!NOTE]
    > Ensure that you know the local administrator's password.

## Event ID 10059

```output
Azure returned a failure code
```

The event also contains an HTTP error. The error occurs when connecting, authenticating, or updating the password to Microsoft Entra ID.

### Resolution

1. Verify that you can successfully connect to the Microsoft Entra registration endpoint (`https://enterpriseregistration.windows.net`).
2. Verify that you have enabled the Windows LAPS feature in your Azure tenant.
3. Verify that the machine isn't deleted or disabled in your Azure tenant.
4. Open a command prompt and run the `dsregcmd /status` command to check the following sections for any errors:
    - `Device status`
    - `SSO data`
    - `Diagnostic data`
5. Verify the error message by using [the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd) and troubleshoot the issue.
6. Use [Troubleshoot Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current) to troubleshoot Microsoft Entra hybrid joined devices.
7. Use the [Device Registration Troubleshooter Tool](/samples/azure-samples/dsregtool/dsregtool/) to identify and fix any device registration issues.
8. If you receive an error message, see [Microsoft Entra authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes) for the description of the error and further troubleshooting.  

## Event ID 10065

```output
LAPS received an LDAP_INSUFFICIENT_RIGHTS error trying to update the password using the legacy LAPS password attribute. You should update the permissions on this computer's container using the Update-AdmPwdComputerSelfPermission cmdlet, for example:
```

This error occurs because the Windows LAPS client machine needs to write passwords of the managed user.

This issue can also occur if you move the machine to a different organizational unit (OU), and the destination OU doesn't have the Self Permission to the computer.

### Resolution

1. If you haven't run the Windows LAPS PowerShell cmdlet to assign the Self Permission to the computer account, run the following cmdlet:

    ```PowerShell
    Set-LapsADComputerSelfPermission -Identity <OU Name>
    ```

    For example:

    ```PowerShell
    Set-LapsADComputerSelfPermission -Identity LAPSOU
    Set-LapsADComputerSelfPermission -Identity OU=LAPSOU,DC=contoso,DC=Com
    ```

    > [!NOTE]
    You can use a distinguished name (DN) if you have the same name for the OU but in different hierarchies.

2. Verify that the computer account has the Self Permission on the OU where the machine account exists.

### Logon to a domain controller with a domain administrator privilege

1. Open *LDP.exe*.
2. Select **Connection** > **Connect** and configure the server and port as follows:

    :::image type="content" source="media/windows-laps-troubleshooting-guidance/ldp-connection-connect.png" alt-text="Screenshot of the LDP tool with the Connect window opened.":::

3. Select **Connection** > **Bind**, configure the following settings, and then select **OK**.

    :::image type="content" source="media/windows-laps-troubleshooting-guidance/ldp-connection-bind.png" alt-text="Screenshot of the LDP tool with the Bind window opened.":::

4. Select **View** > **Tree**. Then, from the drop-down list of **BaseDN**, select the domain where your client machine is located.

    :::image type="content" source="media/windows-laps-troubleshooting-guidance/ldp-view-tree.png" alt-text="Screenshot of the LDP tool with the Tree View window opened.":::

5. Browse the domain tree to identify the OU where you have the client machines located. Right-click the OU, and select **Security descriptor** > **Edit**.

    :::image type="content" source="media/windows-laps-troubleshooting-guidance/ldp-security-descriptor-edit.png" alt-text="Screenshot of the LDP tool with the domain tree on the left pane.":::

6. Sort the **Trustee** column and find the following user rights for `NT AUTHORITY\SELF` permissions for the `msLAPS-Password` attribute.
    :::image type="content" source="media/windows-laps-troubleshooting-guidance/ldp-trustee.png" alt-text="Screenshot of the LDP tool with the Security descriptor window opened and sorted by the Trustee column.":::
