---
title: Reports don't run when RBAC is enabled
description: Helps troubleshoot an issue in which Configuration Manager reports don't run when role-based access control (RBAC) is enabled because of Kerberos or Active Directory permission issues.
ms.date: 08/06/2026
ms.reviewer: payur, iliaershov
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Reports and subscriptions
ai-usage: ai-assisted
---
# Reports don't run when RBAC is enabled

## Summary

Configuration Manager uses role-based access control (RBAC) to restrict report data to what the user running the report is authorized to see. To enforce these permissions, the Reporting Services service account must be able to read the group membership of the report user from Active Directory. If the service account lacks the necessary permissions or can't complete Kerberos authentication with a domain controller, the RBAC check fails and reports don't run.

This article helps you identify the cause of this failure and resolve it.

## Symptoms

You install the Reporting Services point role on a server that runs SQL Server Reporting Services (SSRS). You can browse the reports from both the Configuration Manager console and the Reporting Services website.

However, attempting to run the report fails with the error message that resembles the following message:

> Exception of type 'Microsoft.ReportingServices.ReportProcessing.ReportProcessingException' was thrown. (rsProcessingError)

You see more details when running the report locally from the machine hosting Configuration Manager Reporting Point role. In this case, the error message resembles the following message:

>DefaultValue expression for the report parameter 'UserTokenSIDs' contains an error: The user name or password is incorrect. (rsRuntimeErrorInExpression)

The preceding symptoms disappear when you disable Role-Based Access Control (RBAC) in Configuration Manager Reporting by setting the following registry value to 0 on the SSRS machine:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\SRSRP`

`EnableRbacReporting = 0`

However, the value is restored to 1 within a short period of time.

## Cause

This problem occurs when the Reporting Services service account can't read the group membership of the user running the report.

It happens when the Reporting Services service account isn't a member of the [Windows Authorization Access Group](/windows-server/identity/ad-ds/manage/understand-security-groups#windows-authorization-access) for the domain the user belongs to. The Windows Authorization Access Group is a built-in group that grants its members the ability to read the `tokenGroupsGlobalAndUniversal` attribute of user objects in Active Directory. This attribute contains the SIDs of all global and universal groups that the user is a member of. You can find this requirement in the [Requirements and limitations](/intune/configmgr/core/servers/manage/configuring-reporting#requirements-and-limitations) section of "Configure Reporting" in the Configuration Manager documentation.

> [!NOTE]
> Virtual service accounts, such as `NT SERVICE\SQLServerReportingServices`, and machine accounts usually have access to the `tokenGroupsGlobalAndUniversal` attribute by default.

However, other possibilities exist. To troubleshoot the problem, review the Resolution section.

## Resolution

The Reporting Point role adds an `SRSResources.dll` binary to the Reporting Services installation folder to control RBAC permissions. This binary creates a log file in the `%temp%` folder of the Reporting Services service account named `SCCMReporting.log`. By default, the Reporting Services service account is `NT SERVICE\SQLServerReportingServices`. In this case, you can find the log file in the following folder: `C:\Windows\ServiceProfiles\SQLServerReportingServices\AppData\Local\Temp`. If you use a domain account for the Reporting Services service account, the log file is created in the `%temp%` folder of that domain account.

Starting in [Configuration Manager current branch, version 2509](/intune/configmgr/core/plan-design/changes/whats-new-in-version-2509), `SCCMReporting.log` contains detailed information about the RBAC permission check. A typical log entry resembles the following:

```output
Trying to open registry key SOFTWARE\Microsoft\SMS\SRSRP for reading
EnableRbacReporting key exists.  Value = 1
Successfully created WindowsIdentity object to perform RBAC check for the user CONTOSO\ReportUser
```

To complete the RBAC check, the Reporting Services service account creates a [`WindowsIdentity`](/dotnet/api/system.security.principal.windowsidentity) object for `CONTOSO\ReportUser` by contacting a domain controller that hosts the Key Distribution Center (KDC) service in the service account's domain.

If the operation fails, `SCCMReporting.log` recommends that you verify the service account's membership in the Windows Authorization Access Group and records the error returned by the domain controller. The following sample error message happens when the Reporting Services service account lacks permissions to read the `tokenGroupsGlobalAndUniversal` attribute of `CONTOSO\ReportUser`:

```output
Failed to create WindowsIdentity object to perform RBAC check for the user: CONTOSO\ReportUser. Make sure the account running SSRS service is the member of Windows Authorization Access Group for the user's domain
The error message received from the Domain Controller is: The user name or password is incorrect.
```

Use the error returned by the domain controller to determine the next troubleshooting steps. For more information, see [Windows Security troubleshooting](/troubleshoot/windows-server/windows-security/windows-security-overview).

### Case study

The following `SCCMReporting.log` excerpt shows the Kerberos error `KDC_ERR_ETYPE_NOSUPP` ("The encryption type requested isn't supported by the KDC"):

```output
Failed to create WindowsIdentity object to perform RBAC check for the user: CONTOSO\ReportUser. Make sure the account running SSRS service is the member of Windows Authorization Access Group for the user's domain
The error message received from the Domain Controller is: The encryption type requested is not supported by the KDC.
```

This error indicates a Kerberos encryption type mismatch, not a problem with Windows Authorization Access Group membership or permissions.

#### Why this happens

To perform the RBAC check, `SRSResources.dll` creates a `WindowsIdentity` object for the report user under the security context of the Reporting Services service account. This operation requires Kerberos authentication with the Key Distribution Center (KDC) service on a domain controller. The KDC must select an encryption type that the requesting account and the KDC both support. If no supported encryption type is available, the KDC returns `KDC_ERR_ETYPE_NOSUPP` ("The encryption type requested isn't supported by the KDC"), and the `WindowsIdentity` object can't be created.

Windows security updates released in 2026 [phase out RC4 as the default encryption type for Kerberos service tickets](https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/what-changed-in-rc4-with-the-january-2026-windows-update-and-why-it-is-important/4504732):

- The January update introduces auditing and preparation controls.
- Beginning with the April update, `DefaultDomainSupportedEncTypes` defaults to `0x18`, which enables `AES128-CTS-HMAC-SHA1-96` and `AES256-CTS-HMAC-SHA1-96`, for accounts without an explicit Kerberos encryption type configuration.
- The July update removes Audit mode and the temporary rollback control, leaving Enforcement mode as the only supported configuration.

An account can still depend on RC4 if it doesn't have AES-SHA1 keys or if its processed `msDS-SupportedEncryptionTypes` value doesn't include the AES-SHA1 encryption types. For example, an account created before AES-SHA1 support was introduced might not have AES-SHA1 keys if its password hasn't changed since then. When the KDC enforces AES-SHA1 and the Reporting Services service account supports only RC4, the Kerberos request fails.

For more information about identifying and remediating RC4 dependencies, see [Detect and remediate RC4 usage in Kerberos](/windows-server/security/kerberos/detect-remediate-rc4-kerberos).

#### Steps to resolve

1. **Enable AES on the Reporting Services service account.**
   Open the account properties in **Active Directory Users and Computers**, select the **Account** tab, and then select one or both of the following options under **Account options**:

   - **This account supports Kerberos AES 128 bit encryption**
   - **This account supports Kerberos AES 256 bit encryption**

   Selecting both options sets `msDS-SupportedEncryptionTypes` to `0x18` (24 decimal), which enables `AES128-CTS-HMAC-SHA1-96` and `AES256-CTS-HMAC-SHA1-96`. Make sure that **Use Kerberos DES encryption types for this account** isn't selected.

1. **Change the service account password if the account doesn't have AES-SHA1 keys.**
   Changing the password generates AES-SHA1 keys. After you change the password in Active Directory, update the password for the Reporting Services service and restart the service.

1. **Re-run the report.**
   After the Reporting Services service account has AES-SHA1 keys and is configured to support AES-SHA1 encryption types, run the report again. The `SCCMReporting.log` file should contain the following entry:

   ```output
   Successfully created WindowsIdentity object to perform RBAC check for the user CONTOSO\ReportUser
   ```

Proactively, review the following steps:

1. **Review the Kerberos encryption type configuration on domain controllers.**
   On each domain controller, also verify that `DefaultDomainSupportedEncTypes` under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Kdc` isn't configured to require RC4. See also [How to manage Kerberos KDC usage of RC4 for service account ticket issuance changes related to CVE-2026-20833](https://support.microsoft.com/kb/5073381).

1. **Review the KDC events on the domain controller.**
   During the initial deployment phase, events 201, 202, 205, 206, and 207 identify configurations that depend on RC4. During the enforcement phase, events 203, 204, 208, and 209 identify blocked requests and policy issues. Use these events to verify whether the Reporting Services service account depends on RC4.

   For event descriptions and remediation guidance, see [Detect and remediate RC4 usage in Kerberos](/windows-server/security/kerberos/detect-remediate-rc4-kerberos).
