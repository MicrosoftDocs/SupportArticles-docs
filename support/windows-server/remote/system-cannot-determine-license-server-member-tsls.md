---
title: System Cannot Determine If the License Server Is Member of TSLS Group on AD DS
description: Troubleshoot an error when you review the configuration of a Remote Desktop Services (RDS) license server.
ms.date: 02/13/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, mamash, v-lianna
ms.custom:
- sap:remote desktop services and terminal services\licensing for remote desktop services (terminal services)
- pcy:WinComm User Experience
---
# The system cannot determine if the license server is member of TSLS Group on Active Directory Domain Services (AD DS)

This article helps troubleshoot an error that occurs when you review the configuration of a Remote Desktop Services (RDS) license server.

You have a domain-joined server running the Remote Desktop license server role. When you review the configuration status from the Remote Desktop Licensing Manager console, you receive the following error message in the configuration window:

> The system cannot determine if the license server is member of TSLS Group on Active Directory Domain Services (AD DS) because the AD DS cannot be contacted.

Here are some possible causes:

- The Remote Desktop license server can't contact any domain controller (DC) in the network.
- The Remote Desktop license server isn't a member of the Terminal Server License Servers (TSLS) domain group.
- Security restrictions are enforced on DCs to restrict remote calls to the Security Account Manager (SAM).

Follow these steps to troubleshoot the error while verifying if the Remote Desktop license server is part of the TSLS domain group.

## Step 1: Verify domain connectivity

If the server is part of the TSLS domain group, verify that the license server can reach a valid DC in your domain.

When domain connectivity is lost, you might notice other symptoms, such as Group Policy update failures, logon failures, or a loss of trust relationship with the DC.

If you notice these symptoms, work with your system administrator to resolve the connectivity issue.

## Step 2: Check group membership

Review the members of the **Terminal Server License Servers** group by using the following steps:

1. On a DC, open the **Active Directory Users and Computers** console.
2. Select the **Builtin** container, and then open the **Terminal Server License Servers** group in the right pane.
3. Select **Members**, and then verify that the license server computer object is listed.

## Step 3: Review security restrictions

If you have confirmed that the connectivity is well established with a DC in your network and the issue persists, you might have security restrictions enforced on your DC. These restrictions control which users can enumerate users and groups in Active Directory (AD).

In this case, you're encountering security restrictions that were introduced in Windows Server 2016 and later added to all other Windows operating systems through an update. These restrictions limit the client's ability to make remote SAM calls to the local SAM database and AD.

For more information about this security setting, see the [Network access: Restrict clients allowed to make remote calls to SAM](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls) security policy setting.

This policy, when enabled, affects the verification of the license server's membership in the TSLS domain group if the license server isn't among the users allowed to make remote calls to AD.

By default, the **Network access: Restrict clients allowed to make remote calls to SAM** security policy setting isn't defined. If you define it, you can edit the default Security Descriptor Definition Language (SDDL) string to explicitly allow or deny users and groups to make remote calls to SAM.

If the policy setting is left blank after being defined, the policy isn't enforced.

To verify if you're encountering these restrictions, check one of the following points:

- On the logon DC for the Remote Desktop license server, check if the following registry key is present:

    `HKLM\System\CurrentControlSet\Control\Lsa\RestrictRemoteSAM`

    If this key is present, it means the DC is configured with the SAM restriction policy.

- Check if the following Group Policy Object is present and applied to the DC:

    **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options** > **Network access: Restrict clients allowed to make remote calls to SAM**

> [!NOTE]
> This behavior is expected when SAM calls are restricted to the DC. However, it doesn't affect the RDS Licensing functionality in terms of issuing client access licenses (CALs) and maintaining connectivity with its peers in the RDS farm.

To verify if the Remote Desktop license server is affected by this policy, see the [related events](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls#related-events) on the DC.

To allow the Remote Desktop license server to make remote SAM calls to AD, use Group Policy to add the Remote Desktop license server computer account to the list of allowed accounts under this policy: **Network access: Restrict clients allowed to make remote calls to SAM**.

> [!NOTE]
> Restarts aren't required to enable, disable, or modify the **Network access: Restrict clients allowed to make remote calls to SAM** security policy setting, including audit-only mode. Changes become effective without a device restart when they're saved locally or distributed through Group Policy.

## Contact Microsoft Support

If the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.
