---
title: Issues in Configuration Manager after installing June 2022 Windows security updates
description: This article provides solutions for the issues that may occur in Configuration Manager after you install the June 2022 security updates for Windows.
ms.date: 09/07/2022
ms.reviewer: kaushika, payur, v-weizhu
---
# Issues in Configuration Manager after installing June 2022 security updates for Windows

_Applies to:_ &nbsp; Configuration Manager (current branch)

Microsoft Endpoint Configuration Manager uses the Distributed Component Object Model (DCOM) Remote Protocol at multiple parts of functionality. With the June 2022 security updates for Windows, [hardening changes in DCOM](#dcom-hardening-changes) are enabled by default. This article provides solutions for issues that may occur in Configuration Manager after the June 2022 security updates for Windows are installed.

## Symptoms

After installing the June 2022 security updates for Windows or later, a Configuration Manager administrator encounters one of the following issues:

- The Configuration Manager console fails to access the SMS Provider remotely under any user account. However, under the same credential, a local connection to the SMS Provider is successful.

- When the Configuration Manager administrator connects remotely to client computers, the same issue (under any user account, the remote connection fails, but the local connection is successful) occurs for Configuration Manager tools like Support Center or Policy Spy.

- Content fails to be distributed to a remote distribution point.

Error codes that are recorded in the respective log files or client applications may resemble the following:

|Error code|Error message|
|---|---|
|0x80070005|Access is Denied.|
|0x800706ba|The RPC server is unavailable.|

For example, when the administrator tries to open a console remotely, the *SmsAdminUI.log* file displays the following error message:

> Insufficient privilege to connect, error: 'Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))'
System.UnauthorizedAccessException  
> Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))  
> at System.Management.ThreadDispatch.Start()  
> at System.Management.ManagementScope.Initialize()  
> at System.Management.ManagementObjectSearcher.Initialize()  
> at System.Management.ManagementObjectSearcher.Get()  
> at Microsoft.ConfigurationManagement.ManagementProvider.WqlQueryEngine.WqlConnectionManager.Connect(String configMgrServerPath)  
> at Microsoft.ConfigurationManagement.AdminConsole.SmsSiteConnectionNode.GetConnectionManagerInstance(String connectionManagerInstance)

## Resolution

To resolve these issues, install the latest cumulative update for Windows on both computers that initiate the connection (the remote console or site server) and receive it (the SMS Provider, distribution point, or remote client). Besides enhancing security, installing the update can ensure the same level of DCOM hardening and logging capabilities.

The latest versions of Configuration Manager make security changes, so we recommend that you upgrade to [Configuration Manager, version 2203](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2203) or a later version.

## DCOM hardening changes

In 2021, the Windows DCOM Server Security Feature Bypass vulnerability was discovered and released in [CVE-2021-26414](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-26414). Later, Microsoft released security updates that improved DCOM protocol hardening. However, some applications require a code change to comply with the new security level. Therefore, Microsoft addressed this vulnerability with a phased approach, which is configurable by the `RequireIntegrityActivationAuthenticationLevel` registry key. See the following timeline:

|Update release|Behavior change|
|---|---|
|June 8, 2021|Hardening changes disabled by default but with the ability to enable them using a registry key.|
|June 14, 2022|Hardening changes enabled by default but with the ability to disable them using a registry key.|
|March 14, 2023|Hardening changes enabled by default with no ability to disable them. By this point, you must resolve any compatibility issues with the hardening changes and applications in your environment.|

For more information, see [KB5004442—Manage changes for Windows DCOM Server Security Feature Bypass (CVE-2021-26414)](https://support.microsoft.com/topic/kb5004442-manage-changes-for-windows-dcom-server-security-feature-bypass-cve-2021-26414-f1400b52-c141-43d2-941e-37ed901c769c).

## Verify DCOM hardening issue

To verify the DCOM hardening issue, check the following Event IDs in the System event logs on the server and client computers. For more information, see the "New DCOM error events" section in [KB5004442](https://support.microsoft.com/topic/kb5004442-manage-changes-for-windows-dcom-server-security-feature-bypass-cve-2021-26414-f1400b52-c141-43d2-941e-37ed901c769c).

To log these events, install at least the October 2021 Cumulative Update for Windows. The following time-correlated events should mention Configuration Manager applications and the usernames they're running under:

- Server-side event

    |Event ID|Message|
    |---|---|
    |10036|The server-side authentication level policy does not allow the user %1\\%2 SID (%3) from address %4 to activate DCOM server. Please raise the activation authentication level at least to RPC_C_AUTHN_LEVEL_PKT_INTEGRITY in client application. <br/><br/>(%1 – domain, %2 – user name, %3 – User SID, %4 – Client IP Address)|

- Client-side events

    |Event ID|Message|
    |---|---|
    |10037|Application %1 with PID %2 is requesting to activate CLSID %3 on computer %4 with explicitly set authentication level at %5. The lowest activation authentication level required by DCOM is 5(RPC_C_AUTHN_LEVEL_PKT_INTEGRITY). To raise the activation authentication level, please contact the application vendor.|
    |10038|Application %1 with PID %2 is requesting to activate CLSID %3 on computer %4 with default activation authentication level at %5. The lowest activation authentication level required by DCOM is 5(RPC_C_AUTHN_LEVEL_PKT_INTEGRITY). To raise the activation authentication level, please contact the application vendor.<br/><br/> (%1 – Application Path, %2 – Application PID, %3 – CLSID of the COM class the application is requesting to activate, %4 – Computer Name, %5 – Value of Authentication Level)|

If you want to temporarily disable the DCOM hardening, set the value of the `RequireIntegrityActivationAuthenticationLevel` registry key to `0x00000000`:

- Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole\AppCompat`
- Value Name: `RequireIntegrityActivationAuthenticationLevel`
- Type: dword
- Value Data: `0x00000000`

To enable the DCOM hardening, set the registry value to `0x00000001`. If this registry key isn't defined, it will be enabled by default.

> [!NOTE]
> This registry key will be ignored starting from March 14, 2023. Upgrade the operating systems before this date.

If the issue persists after completing the steps above, [contact Microsoft Support](https://support.microsoft.com/contactus).
