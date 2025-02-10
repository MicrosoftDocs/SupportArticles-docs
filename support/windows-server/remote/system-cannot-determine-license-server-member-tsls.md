---
title: The system cannot determine if the license server is member of TSLS Group on AD DS
description: Troubleshoot an error when you review the configuration of a Remote Desktop Services (RDS) license server.
ms.date: 02/10/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Licensing for Remote Desktop Services (Terminal Services), csstroubleshoot
---
# The system cannot determine if the license server is member of TSLS Group on Active Directory Domain Services (AD DS) because the AD DS cannot be contacted

This article helps troubleshoot an error when you review the configuration of a Remote Desktop Services (RDS) license server.

You have a domain-joined server running the Remote Desktop license server role. When you review the configuration status from the Remote Desktop Licensing Manager console, you receive the following error message on the configuration window:

> The system cannot determine if the license server is member of TSLS Group on Active Directory Domain Services (AD DS) because the AD DS cannot be contacted.

Here are some possible causes:

- The Remote Desktop license server can't contact any domain controller in the network.
- The Remote Desktop license server isn't a member of the Terminal Server License Servers (TSLS) domain group.
- Security restrictions are enforced on domain controllers to restrict remote calls to Security Account Manager (SAM).

Follow these steps to troubleshoot the error while verifying if the Remote Desktop license server is part of the TSLS domain group.

## Step 1: Verify domain connectivity

If the server is part of the TSLS domain group, verify that the license server can reach a valid domain controller in your domain.

When domain connectivity is lost, you might notice other symptoms such as Group Policy update failures, logon failures, or a loss of trust relationship with the domain controller.

If you notice these symptoms, work with your system administrator to resolve the connectivity issue.

## Step 2: Check group membership

Review the members of the **Terminal Server License Servers** group by using the following steps:

1. On a domain controller, open the **Active Directory Users and Computers** console.
2. Select the **Builtin** container, and then open the **Terminal Server License Servers** group in the right pane.
3. Select **Members**, and then verify that the license server computer object is listed.

## Step 3: Review security restrictions

If you have confirmed that the connectivity is well established with a domain controller in your network, and the issue still persists, you might have security restrictions enforced on your domain controller. These restrictions control which users can enumerate users and groups in Active Directory (AD).

In this case, you're encountering security restrictions that were introduced in Windows Server 2016 and subsequently added to all other Windows operating systems through an update. These restrictions limit the client's ability to make remote SAM calls to the local SAM database and Active Directory.

For more information about this security settings, see the [Network access: Restrict clients allowed to make remote calls to SAM](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls) security policy setting.

This policy, when enabled, affects the license server verification of its membership in the TSLS domain group, if the license server isn't part of the allowed users to make remote calls to AD.

By default, the **Network access: Restrict clients allowed to make remote calls to SAM** security policy setting isn't defined. If you define it, you can edit the default Security Descriptor Definition Language (SDDL) string to explicitly allow or deny users and groups to make remote calls to SAM.

If the policy setting is left blank after being defined, the policy isn't enforced.

To verify if you're encountering these restrictions, check one of the following:

- On the logon domain controller (DC) for the Remote Desktop License Server, check if the following registry key is present:

    `HKLM\System\CurrentControlSet\Control\Lsa\RestrictRemoteSAM`

    If this key is present, this means the DC is configured with the SAM restrictions policy.
- Check if the following Group Policy Object is present and applied on the DC:

    **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options** > **Network access: Restrict clients allowed to make remote calls to SAM**

> [!NOTE]
> This behavior is expected when restricting SAM calls to the DC. However, it has no impact on the RDS Licensing functionality in terms of issuing client access licenses (CALs) and maintaining connectivity with its peers in the RDS farm.

To verify if the Remote Desktop license server is affected by this policy, see [related events](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls#related-events) on the domain controller.

To allow the Remote Desktop license server to make remote SAM calls to Active Directory, use Group Policy to add the Remote Desktop license server computer account to the list of allowed accounts under this policy: **Network access: Restrict clients allowed to make remote calls to SAM**.

> [!NOTE]
> Restarts aren't required to enable, disable or modify the **Network access: Restrict clients allowed to make remote calls to SAM** security policy setting, including audit only mode. Changes become effective without a device restart when they're saved locally or distributed through Group Policy.

## Contact Microsoft Support

If the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.
