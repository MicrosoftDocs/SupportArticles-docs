---
title: Error 0x800706ba during certificate enrollment
description: Introduces steps to resolve the error 0x800706ba, The RPC Server is unavailable, which occurs during certificate enrollment.
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
ms.date: 12/12/2023
ms.reviewer: kaushika
ms.prod: windows-server
ms.technology: windows-server-active-directory
ms.custom: sap:active-directory-certificate-services, csstroubleshoot, ikb2lmc
---
# Error 0x800706ba "The RPC Server is unavailable" when you enroll a certificate

When you try to enroll a certificate on a Windows Server, it fails with the error 0x800706ba, "The RPC Server is unavailable." This article introduces steps to resolve this issue.

_Applies to:_ Supported versions of Windows Server  
_Original KB number:_ 4042719, 4516764, 5021150  

## Identify the issue

When you encounter this issue, you may see one or more of the following symptoms.

> [!NOTE]
> When the issue occurs, if we add the user account that's used to request the certificate to the local administrators group on the certificate authority (CA), the enrollment succeeds for a user-based template. However, enrollment against a machine-based template still returns the same error.

### Error messages

You receive error messages that resemble the following during certificate enrollment.

#### Error 1

> An error occurred whilst enrolling for a certificate. The certificate request could not be submitted to the certification authority.  
> Url: \<certificate server FQDN\>\\MyPKI  
> Error: The RPC server is unavailable.  0x800706ba (WIN32: 1322 RPC_S_SERVER_UNAVAILABLE)

#### Error 2

:::image type="content" source="media/error-0x800706ba-certificate-enrollment/progress-window-of-certificate-enrollment.png" alt-text="Screenshot that shows the progress window of certificate enrollment." border="true":::

#### Error 3

:::image type="content" source="media/error-0x800706ba-certificate-enrollment/error-message-during-certificate-enrollment.png" alt-text="Screenshot that shows the error message during certificate enrollment." border="true":::

### Network capture

The network trace shows the successful Lightweight Directory Access Protocol (LDAP) queries to the configuration partition in Active Directory; the templates available are revealed in the trace.

Then, the requesting server tries to do a remote procedure call (RPC) to the CA and gets the response "ACCESS DENIED."

For example:

```output
10167 <time> <requesting server IP address> <CA IP address> ISystemActivator 918 RemoteCreateInstance request  
10174 <time> <CA IP address> <requesting server IP address> DCERPC 86 Fault: call_id: 3, Fragment: Single, Ctx: 1, status: nca_s_fault_access_denied
```

Additionally, you can find the Microsoft Remote Procedure Call (MSRPC) bind attempt and error:

```output
1093    <time>    92.5590216     (0)    SourceIP    52237 (0xCC0D)    DestIP    135 (0x87)    MSRPC    MSRPC:c/o Bind: IRemoteSCMActivator(DCOM) UUID{000001A0-0000-0000-C000-000000000046}  Call=0x3  Assoc Grp=0x8A9E  Xmit=0x16D0  Recv=0x16D0  
1097    <time>    92.5940283     (652)    SourceIP    135 (0x87)    DestIP    52237 (0xCC0D)    MSRPC    MSRPC:c/o Bind Nack:  Call=0x3  Reject Reason: invalid_checksum
```

In a network trace, you find the following error:

Status : MSRPC:c/o Fault: Call=0x3 Context=0x1 Status=0x5 (Access is denied)

For example:

```output
<Certificate_Server> <Client> DCOM  DCOM:RemoteCreateInstance Request, DCOM Version=5.7  Causality Id={7CFF2CD3-3165-4098-93D6-4077D1DF7351}
<Client> <Certificate_Server> MSRPC MSRPC:c/o Fault:  Call=0x3  Context=0x1  Status=0x5  Cancels=0x0 
```

### Event log

If auditing is enabled, a Distributed Component Object Model (DCOM) error can be observed on the CA server detailing an **ANONYMOUS LOGON** attempt:

```output
Log Name: System  
Source: Microsoft-Windows-DistributedCOM  
Date: <date>  
Event ID: 10027  
Task Category: None  
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: <CA FQDN>

Description:  
The machine wide limit settings do not grant Remote Activation permission for COM Server applications to the user NT AUTHORITY\ANONYMOUS LOGON SID (S-1-5-7) from address <IP address> running in the application container Unavailable SID (Unavailable). This security permission can be modified using the Component Services administrative tool.
```

> [!NOTE]
> Event ID 82 is logged in Application logs if auto-enrollment is failing with the same error.

### Other symptoms and logs

- The call should be made with **dce_c_authn_level_pkt_integrity** RPC Integrity level that enforces Kerberos or New Technology LAN Manager (NTLM) as an authentication mechanism. This behavior is enforced by default starting 6B.22 [KB5004442—Manage changes for Windows DCOM Server Security Feature Bypass (CVE-2021-26414)](https://support.microsoft.com/topic/kb5004442-manage-changes-for-windows-dcom-server-security-feature-bypass-cve-2021-26414-f1400b52-c141-43d2-941e-37ed901c769c).
- When the client sends a KRB_AP_REQ request, it's rejected by the server side.
- The server tries to procure an access token for the user who presented the Kerberos Ticket Granting Service (TGS) and fails with error 0xc000015b, "STATUS_LOGON_TYPE_NOT_GRANTED."

## Cause 1: Incorrect group policy configurations

This issue can occur because of one of the following reasons:

1. The group policy **Access this computer from the network** is set, and the user account used to enroll the certificate isn't added. By default, the policy is populated by the groups: **Administrators**, **Backup Operators**, **Everyone**, and **Users**.
2. The group policy **Deny access to this computer from the network** is set, and **Everyone**, **Users** or a security group the user belongs to is added.

These group policies locate at _Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment_.

> [!NOTE]
> You can run `whoami /groups` to identify the groups of the user account or use **Active Directory Users and computers** to identify the groups belonging to the user or the computer account.

Because the user account used for certificate enrollment fails authentication by using Kerberos, the authentication mechanism is downgraded to "anonymous logon." The logon fails on the DCOM level.

### How to identify

1. Open an elevated command prompt on the certificate server.
2. Run the `gpresult /h` command. For example, `gpresult /h appliedgpo.html`.
3. Open the .html file that's generated, and review the section:  
   _Settings \\ Policies \\ Windows Settings \\ Local Policies \\ User Rights Assignment_
   - **Access this computer from the network**
   - **Deny access to this computer from the network**
4. Note the **Winning GPO** name.

   :::image type="content" source="media/error-0x800706ba-certificate-enrollment/screenshot-of-the-gpresult-output.png" alt-text="Screenshot that shows the gpresult output." lightbox="media/error-0x800706ba-certificate-enrollment/screenshot-of-the-gpresult-output.png":::

To resolve this issue, edit the **Winning GPO**.

> [!NOTE]
> The settings configured on the Group Policy Objects (GPOs) are for a reason, so you should talk to your security team before making any changes.

Add the appropriate user groups to the **Access this computer from the network** group policy. For example:

:::image type="content" source="media/error-0x800706ba-certificate-enrollment/properties-of-access-this-computer-from-the-network.png" alt-text="Screenshot that shows the properties window of the 'Access this computer from the network' group policy.":::

Then, remove the group that the user account or the computer account belongs to from the **Deny access to this computer from the network** group policy.

For more information, see [Access this computer from the network - security policy setting](/windows/security/threat-protection/security-policy-settings/access-this-computer-from-the-network).

## Cause 2: Missing "NT Authority\Authenticated Users" in the "Users" group of the certificate server or any other default permissions

Here are the default permissions:

- **Contoso\Domain Users**
- **NT AUTHORITY\Authenticated Users**
- **NT AUTHORITY\INTERACTIVE**

To resolve this issue, open **Local Users and Groups** on the certificate server, locate the **Users** group, and add the missing groups.

## Cause 3: Missing "NT AUTHORITY\Authenticated Users" from the "Certificate Service DCOM Access" local group of the certificate server

To resolve this issue, follow these steps:

1. Open **Local Users and Groups** on the certificate server.
2. Locate the **Certificate Service DCOM Access** group.
3. Add **NT AUTHORITY\Authenticated users**.

## Cause 4: EnableDCOM isn't set to Y on the Client and CA Server

To resolve this issue, follow these steps:

1. Locate this registry key `HKEY_LOCAL_MACHINE\Software\Microsoft\OLE`.
2. Verify if the data of the **EnableDCOM** registry value is set to **Y**.
3. If it's **N**, change it to **Y**, and then restart the computer.

## Cause 5: Remote Procedure Call restrictions aren't applied on the Certificate server

To identify the issue, verify that the GPO is applied to the certificate server. Follow these steps:

1. Open an elevated command prompt on the certificate server.
2. Run the `gpresult /h` command. For example, `gpresult /h appliedgpo.html`.
3. Open the .html file, and identify the winning GPO where the **Restrictions for Unauthenticated RPC Client** group policy is configured to **Not Configured**.

   The group policy locates at _Administrative Templates \\ System \\ Remote Procedure Call \\ Restrictions for Unauthenticated RPC Client_.

## Cause 6: Missing "Certificate Service DCOM Access" from COM Security Access Permissions or Launch and Activation Permissions

When the Active Directory Certificate Services role is installed on a server, the local **Certificate Service DCOM Access** group is automatically granted rights to the Component Services administrative tool. If these default permissions have been removed, you may experience the symptoms described in this article. To verify that the correct permissions are in place, follow these steps:

1. Open the **Component Services** Microsoft Management Console (MMC) snap-in under **Windows Administrative Tools**.
2. In the left pane, expand **Component Services** > **Computers**.  
3. Right-click **My Computer** and select **Properties**, then select the **COM Security** tab.
4. Under **Access Permissions**, select **Edit Limits...**  
5. Verify that the local **Certificate Service DCOM Access** group appears in the **Group or user names** list and is granted both **Local Access** and **Remote Access** permissions. If not, add it and grant the appropriate permissions. Select **OK** to close the **Access Permission** dialog.  
6. Under **Launch and Activation Permissions**, select **Edit Limits...**  
7. Verify that the local **Certificate Service DCOM Access** group appears in the **Group or user names** list and is granted both **Local Activation** and **Remote Activation** permissions. If not, add it and grant the appropriate permissions. Select **OK** to close the **Launch and Activation Permissions** dialog.  

## Reference

For more information, see [Restrictions for Unauthenticated RPC Clients: The group policy that punches your domain in the face](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/restrictions-for-unauthenticated-rpc-clients-the-group-policy/ba-p/399128).
