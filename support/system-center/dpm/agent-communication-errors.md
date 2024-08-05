---
title: DPM agent communication errors
description: Fixes communication issues that occur on a System Center Data Protection Manager agent.
ms.date: 04/08/2024
ms.reviewer: Mjacquet, dewitth
---
# Communication issues on a Data Protection Manager agent

This article helps you fix error messages about communication issues that occur on a Data Protection Manager (DPM) agent.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 970090

## Symptoms

On a DPM agent, you receive the following error messages about communication issues:

> A DPM agent failed to communicate with the DPM service on \<*server*> because of a communication error. Make sure that \<*server*> is remotely accessible from the computer running the DPM agent. If a firewall is enabled on \<*server*>, make sure that it is not blocking requests from the computer running the DPM agent (Error code: 0x800706ba, full name: \<*server*>).

> DPM failed to communicate with the protection agent on \<*server*> because access is denied. (ID 42 Details: Access is denied (0x80070005))

> Error 270: The agent operation failed on \<*server*> because DPM could not communicate with the DPM protection agent. The computer may be protected by another DPM server, or the protection agent may have been uninstalled on the protected computer.

## Cause

This problem occurs if a DPM machine account is missing from one of the following security groups on the protected server:

- DPMRADmTrustedMachines
- DPMRADCOMTrustedMachines
- Distributed COM Users

## Resolution

If the DPM machine account is missing from any of the security groups that are listed in the Cause section, manually add the DPM machine account.

For example, if the DPM server's name is *DPM01*, and if this name belongs to the *Contoso* domain, you should see *Conotoso\DPM01* as a member of each group on the protected server.

In a situation where the protected server is a domain controller, a failed installation of the protection agent could result in the removal of the **DPMRADmTrustedMachines** and **DPMRADCOMTrustedMachines** groups. You can resolve this problem by running the following command:

```console
<drive letter>:\Program Files\Microsoft Data Protection Manager\bin\SetDpmServer.exe -dpmServerName <DPM server name>
```

For example, the last part of this command might resemble the following:

```console
SetDpmServer.exe -dpmServerName DPM01
```

> [!NOTE]
>
> - *DPM01* is the actual DPM server name.
> - This command will re-create the two groups in Active Directory, and it will add the DPM machine account to these groups and to the **Distributed COM Users** group.
