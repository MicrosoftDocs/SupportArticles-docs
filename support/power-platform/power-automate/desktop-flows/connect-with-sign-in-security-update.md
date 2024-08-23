---
title: Connect with sign-in security update for Power Automate for desktop on domain-joined machines
description: Explains the security update 
ms.reviewer: padib，aartigoyle, johndund, quseleba
ms.date: 08/21/2024
---
# Power Automate Desktop security update for connect with sign-in connections on Active Directory joined machines

A potential security issue was identified in Power Automate for Desktop. Please update PAD to the versions provided in this article.

## Impact
 
The issue can only affect machines that are joined to an Active Directory domain and not joined to an Entra-ID tenant.
If an attacker is able to access one such machine, and if that machine isn’t already registered to your Power Automate environment, they can register it to their own Power Automate environment and then run arbitrary attended desktop flows into your Windows session when it is already opened and unlocked.
If a machine is Entra ID-joined, or if it is not Active Directory domain-joined, it is not vulnerable.

## Mitigation

We are releasing patched versions of the last six PAD releases with a fix for this issue.
* [2.47](https://go.microsoft.com/fwlink/?linkid=2283602)
* [2.46](https://go.microsoft.com/fwlink/?linkid=2283601)
* [2.45](https://go.microsoft.com/fwlink/?linkid=2283504)
* [2.44](https://go.microsoft.com/fwlink/?linkid=2283503)
* [2.43](https://go.microsoft.com/fwlink/?linkid=2283280)
* [2.42](https://go.microsoft.com/fwlink/?linkid=2283279)
Please update your machines as soon as possible. Starting with release 2.48 of PAD, all future versions will have the security fix already included.

## Breaking change
 
If you are using [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) for attended runs on machines that are AD-joined but not Entra ID-joined, the patched versions of PAD will break your runs with the UnallowedTenantForConnectWithSignIn error code.

To use connect with sign-in on such machines, the Power Automate tenant that your machine is registered to needs to be allow-listed following the instructions found [in this article]().
We recommend that your Active Directory administrators deploy a GPO in your domain to define the tenant allow-list.

## How to determine if a machine is joined to Active Directory or Entra ID

You can get your machine's join info by running this command from a Windows command prompt:

```CMD
dsregcmd /status
```

In the output, in the `Device State` section, `AzureAJoined` indicates whether the machine is joined to an Entra ID tenant, and `DomainJoined` indicates whether the machine is joined to an Active Directory domain.

:::image type="content" source="media/connect-with-sign-in-security-update/dsrgecmd-output-AD-joined.png" alt-text="Screenshot that shows the output of the 'dsregcmd /status' command on machine that joined to an Active Directory domain but not joined to an Entra ID tenant.":::
