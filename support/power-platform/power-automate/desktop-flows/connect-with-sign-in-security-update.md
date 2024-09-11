---
title: Connect with sign-in security update on AD domain-joined machines
description: Provides security updates for the connect with sign-in connections on Active Directory domain-joined machines in Microsoft Power Automate for desktop.
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.custom: sap:Desktop flows\Unattended flow runtime errors
ms.date: 09/11/2024
---
# Security update for "connect with sign-in" connections on AD domain-joined machines in Power Automate for desktop

## Summary

A potential security vulnerability is identified in Power Automate for desktop versions 2.47 and earlier. Microsoft has issued a [CVE about this issue](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-43479).

> [!IMPORTANT]
> The issue affects only machines that are joined to an Active Directory (AD) domain, not those joined to Microsoft Entra ID. If an attacker can access a machine that isn't registered to your Power Automate environment, they can register it to their own Power Automate environment and then run arbitrary attended desktop flows into your Windows session when it's open and unlocked.
>
> If a machine is Microsoft Entra-joined or isn't AD domain-joined, it isn't vulnerable.

## Mitigation

To mitigate the issue, update your Power Automate for desktop to the following patched versions as soon as possible.

- [2.47.119.24249](https://go.microsoft.com/fwlink/?linkid=2283602)
- [2.46.181.24249](https://go.microsoft.com/fwlink/?linkid=2283601)
- [2.45.404.24249](https://go.microsoft.com/fwlink/?linkid=2283504)
- [2.44.55.24249](https://go.microsoft.com/fwlink/?linkid=2283503)
- [2.43.249.24249](https://go.microsoft.com/fwlink/?linkid=2283280)
- [2.42.331.24249](https://go.microsoft.com/fwlink/?linkid=2283279)
- [2.41.178.24249](https://go.microsoft.com/fwlink/?linkid=2285461)

> [!NOTE]
> Starting with release 2.48, all future versions will include the security fix.

## Impact of the patch

If you use "[connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs)" for attended runs on machines that are [AD domain-joined but not Microsoft Entra-joined](#how-to-determine-if-a-machine-is-ad-domain-joined-or-microsoft-entra-joined), the patched versions (and future versions) of Power Automate for desktop will cause your runs to fail with the `UnallowedTenantForConnectWithSignIn` error code.

Creating and testing connections with sign-in option will also fail with one of these errors：

> Unable to connect. The credentials for the machine are incorrect.

> Tenant \<tenantID> needs to be explicitly allow-listed to authorize 'connect with sign-in' runs on the machine.

To use "connect with sign-in" on such machines, you must add the Power Automate tenant where your machine is registered to the allowlist by following the instructions in ["UnallowedTenantForConnectWithSignIn" error in a  Power Automate desktop flow](troubleshoot-unallowed-tenant-for-connect-with-sign-in.md). We recommend that your AD administrators deploy a Group Policy Object (GPO) in your domain to define the tenant allowlist.

## How to determine if a machine is AD domain-joined or Microsoft Entra-joined

To get your machine's join state, run the [dsregcmd command](/entra/identity/devices/troubleshoot-device-dsregcmd) from a Windows command prompt:

```cmd
dsregcmd /status
```

In the `Device State` section of the output, `AzureAdJoined` indicates whether the machine is joined to Microsoft Entra ID, and `DomainJoined` indicates whether the machine is joined to an AD domain.

:::image type="content" source="media/connect-with-sign-in-security-update/dsrgecmd-output-ad-joined.png" alt-text="Screenshot that shows an output of the dsregcmd status command run on a machine that's joined to an AD domain but not joined to Microsoft Entra ID.":::
