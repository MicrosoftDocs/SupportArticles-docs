---
title: Active Directory replication error 8453
description: This article describes how to troubleshoot Active Directory replication error 8453.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication error 8453: Replication access was denied

This article describes how to troubleshoot a problem where Active Directory replication fails and generates error 8453: Replication access was denied.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2022387

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

## Summary

This error 8453 has the following primary causes:

- The destination domain controller doesn't have the required permissions to replicate the naming context/partition.
- The administrator who manually started replication doesn't have permissions to do so.

    > [!NOTE]
    > This condition doesn't affect periodic or scheduled replication.

### Top cause

For period or scheduled replication, if the destination domain controller is a Read-only Domain Controller (RODC):

The Enterprise Read-Only Domain Controllers security group doesn't have **Replicating Directory Changes** permissions on the root of the naming context (NC) for the partition that doesn't replicate and returns error 8453.

### Top solution

On each NC that RODCs don't replicate and that returns error 8453, grant **Replicating Directory Changes** permissions to the forest-root domain's Enterprise Read-only Domain Controllers security group.

**Example:**

A RODC `childdc2.child.contoso.com` doesn't replicate the `contoso.com` partition and returns error 8453. To troubleshoot this situation, follow these steps:

1. Open ADSIEDIT.msc on a `contoso.com` domain controller.
2. Open a connection to the `contoso.com` domain NC (default naming context).
3. Open the properties of the **dc=contoso,dc=com NC**, and select the **Security** tab.
4. Select **Add**, and enter the following entry in the text box:  
    _Contoso\Enterprise Read-Only Domain Controllers_

    > [!NOTE]
    > This group exists only in the forest-root domain.

5. Select **Check Names**, and then select **OK**.
6. In the **Permissions for Enterprise Read-Only Domain Controllers** dialog box, clear the **Allow** check boxes that are automatically selected:

   - Read
   - Read domain password & lockout policies
   - Read Other domain parameters

7. Select the **Allow** box next to **Replicating Directory Changes**, and then select **OK**.

If these steps don't resolve the problem, see the rest of this article.

## Symptoms

When this problem occurs, you experience one or more of the following symptoms:

- The DCDIAG Replication test (`DCDIAG /TEST:NCSecDesc`) reports that the tested domain controller **failed test replications** and has a status of 8453: Replication access was denied:

  ```output
  Starting test: Replications  
  [Replications Check,<destination domain controller] A recent replication attempt failed:  
  From <source DC> to <Destination DC  
  Naming Context: <DN path of failing directory partition>  
  The replication generated an error (8453):  
  Replication access was denied.  
  The failure occurred at <date> <time>.  
  The last success occurred at <date> <time>.  
  %#% failures have occurred since the last success.  
  The machine account for the destination <destination DC>.  
  is not configured properly.  
  Check the userAccountControl field.  
  Kerberos Error.  
  The machine account is not present, or does not match on the.  
  destination, source or KDC servers.  
  Verify domain partition of KDC is in sync with rest of enterprise.  
  The tool repadmin/syncall can be used for this purpose.  
  ......................... <DC tested by DCDIAG> failed test Replications
  ```

- The DCDIAG NCSecDesc test (`DCDIAG /TEST:NCSecDesc`) reports that the domain controller that was tested by DCDIAG **failed test NCSecDec** and that one or more permissions are missing on the NC head of one or more directory partitions on the tested domain controller that was tested by DCDIAG:

  ```output
  Starting test: NCSecDesc  
  Error NT AUTHORITY\ENTERPRISE DOMAIN CONTROLLERS doesn't have  
  Replicating Directory Changes                               <- List of missing access  
  Replication Synchronization                                 <- rights required for each Manage Replication Topology                                       <- security group could vary  
  Replicating Directory Changes In Filtered Set               <- depending in missing  
  access rights for the naming context:                          <- right in your environment  
  DC=contoso,DC=com  
  Error CONTOSO\Domain Controllers doesn't have  
  Replicating Directory Changes All  
  access rights for the naming context:  
  DC=contoso,DC=com  
  Error CONTOSO\Enterprise Read-Only Domain Controllers doesn't have  
  Replicating Directory Changes  
  access rights for the naming context:  
  DC=contoso,DC=com  
  ......................... CONTOSO-DC2 failed test NCSecDesc
  ```

- The DCDIAG MachineAccount test (`DCDIAG /TEST:MachineAccount`) reports that the domain controller that was tested by DCDIAG **failed test MachineAccount** because the **UserAccountControl** attribute on the domain controllers computer account is missing the **SERVER_TRUST_ACCOUNT** or **TRUSTED_FOR_DELEGATION** flags:

  ```output
  Starting test: MachineAccount  
  The account CONTOSO-DC2 is not trusted for delegation . It cannot  
  replicate.  
  The account CONTOSO-DC2 is not a DC account. It cannot replicate.  
  Warning: Attribute userAccountControl of CONTOSO-DC2 is:  
  0x288 = ( HOMEDIR_REQUIRED | ENCRYPTED_TEXT_PASSWORD_ALLOWED | NORMAL_ACCOUNT )  
  Typical setting for a DC is  
  0x82000 = ( SERVER_TRUST_ACCOUNT | TRUSTED_FOR_DELEGATION )  
  This may be affecting replication? 
  ......................... CONTOSO-DC2 failed test MachineAccount
  ```

- The DCDIAG KCC event log test indicates the hexadecimal equivalent of Microsoft-Windows-ActiveDirectory_DomainService event 2896:

    B50 hex = 2896 decimal. This error may be logged every 60 seconds on the infrastructure master domain controller.

  ```output
  Starting test: KccEvent  
  The KCC Event log test  
  An error event occurred. EventID: 0xC0000B50  
  Time Generated: 06/25/2010 07:45:07
  
  Event String:  
  A client made a DirSync LDAP request for a directory partition. Access was denied due to the following error.
  
  Directory partition:  
  <DN path of directory partition>
  
  Error value:  
  8453 Replication access was denied.
  
  User Action  
  The client may not have access for this request. If the client requires it, they should be assigned the control access right "Replicating Directory Changes" on the directory partition in question.
   ```

- REPADMIN.EXE reports that a replication attempt failed and returned an 8453 status.

    REPADMIN commands that commonly indicate the 8453 status include but aren't limited to the following.  

  - `REPADMIN /KCC`
  - `REPADMIN /REHOST`
  - `REPADMIN /REPLICATE`
  - `REPADMIN /REPLSUM`
  - `REPADMIN /SHOWREPL`
  - `REPADMIN /SHOWREPS`
  - `REPADMIN /SHOWUTDVEC`
  - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS`showing inbound replication from CONTOSO-DC2 to CONTOSO-DC1 that fail and return the **replication access was denied** error is as follows:

    ```output
    Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID:  
    DSA invocationID:  
    DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2  
    Last attempt @ <date> <time> failed, result 8453 (0x2105):  
    Replication access was denied.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.
    ```

- The **replicate now** command in Active Directory Sites and Services (DSSITE.MSC) returns a **replication access was denied** error.

    Right-clicking the connection object from a source domain controller and then selecting **replicate now** fails. And a **replication access was denied** error is returned. The following error message is displayed:

    ```output
    Dialog title text: Replicate Now  
    Dialog message text: The following error occurred during the attempt to synchronize naming context <%directory partition name%> from Domain Controller <Source DC> to Domain Controller <Destination DC>:  
    Replication access was denied  
    
    The operation will not continue  
    Buttons in Dialog: OK
    ```

    :::image type="content" source="media/replication-error-8453/replication-access-was-denied-error.png" alt-text="The Replication access was denied error that occurs after running the replicate now command." border="false":::

- NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events that have the 8453 status are logged in the Active Directory Directive Services (AD DS) event log.

Active Directory events that commonly indicate the 8453 status include but aren't limited to the following events:

|Event Source|Event ID|Event String|
|---|---|---|
|Microsoft-Windows-ActiveDirectory_DomainService|1699|This directory service failed to retrieve the changes requested for the following directory partition. As a result, it was unable to send change requests to the directory service at the following network address. |
|Microsoft-Windows-ActiveDirectory_DomainService|2896|A client made a DirSync LDAP request for a directory partition. Access was denied due to the following error.|
|NTDS General|1655|Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.|
|NTDS KCC|1265|The attempt to establish a replication link with parameters<br/>Partition: \<partition DN path><br/>Source DSA DN: \<DN of source DC NTDS Settings object><br/>Source DSA Address: \<source DCs fully qualified CNAME><br/>Inter-site Transport (if any): \<dn path><br/>failed with the following status:|
|NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|
  
## Cause

Error 8453 (Replication Access was denied) has multiple root causes, including:

- The **UserAccountControl** attribute on the destination domain controller computer account is missing either of the following flags:  
  **SERVER_TRUST_ACCOUNT** or **TRUSTED_FOR_DELEGATION**

- The default permissions don't exist on one or more directory partitions to allow scheduled replication to occur in the operating system's security context.

- The default or custom permissions don't exist on one or more directory partitions to allow users to trigger ad-hoc or immediate replication by using DSSITE.MSC **replicate now**, `repadmin /replicate`, `repadmin /syncall`, or similar commands.

- The permissions that are required to trigger ad-hoc replication are correctly defined on the relevant directory partitions. However, the user isn't a member of any security groups that have been granted the replication directory changes permission.

- The user who triggers ad-hoc replication is a member of the required security groups, and those security groups have been granted the **Replicate Directory Changes** permission. However, membership in the group that's granting the replicating directory changes permission is removed from the user's security token by the [User Account Control](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772207(v=ws.10)) split user access token feature. This feature was introduced in Windows Vista and Windows Server 2008.

    > [!NOTE]
    > Don't confuse the User Account Control split token security feature that was introduced in Vista and Windows Server 2008 with the **UserAccountControl** attribute that's defined on domain controller role computer accounts that are stored by the Active Directory service.

- If the destination domain controller is an RODC, RODCPREP hasn't been run in domains that are currently hosting read-only domain controllers, or the Enterprise Read-Only Domain Controllers group doesn't have **Replicate Directory Changes** permissions for the partition that is not replicating.

- DCs that are running new operating system versions were added to an existing forest where Office Communication Server has been installed.

- You have Lightweight Directory Services (LDS) instances. And the **NTDS Settings** object for the affected instances is missing from the LDS configuration container. For example, you see the following entry:

    > CN=NtDs Settings,CN=Server1$ADAMINST1,CN=Server,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,CN={A560B9B8-6B05-4000-9A1F-9A853DB6615A}

Active Directory errors and events, such as those mentioned in the [Symptoms](#symptoms) section, may also occur and generate an error 5 message (Access is denied).

The steps for error 5 or error 8453 mentioned in the [Resolution](#resolution) section won't resolve replication failures on computers that are currently failing replication and generating the other error message.

Common root causes for Active Directory operations failing that are generating error 5 messages include:

- Excessive Time Skew
- The fragmentation of UDP-formatted Kerberos packets by intermediate devices on the network
- Missing **access this computer from network** rights.
- Broken secure channels or intra-domain trusts
- **CrashOnAuditFail = 2** entry in the registry

## Resolution

To resolve this problem, use the following methods.

### Run a health-check by using DCDIAG + DCDIAG /test:CheckSecurityError

1. Run DCDIAG on the destination DC that's reporting the 8453 error or event.
2. Run DCDIAG on the source domain controller on which the destination domain controller is reporting the 8453 error or event.
3. Run `DCDIAG /test:CheckSecurityError` on the destination domain controller.
4. Run `DCDIAG /test:CheckSecurityError` on the source DC.

### Fix invalid UserAccountControl

The **UserAccountControl** attribute includes a bitmask that defines the capabilities and state of a user or computer account. For more information about **UserAccountControl** flags, see [User-Account-Control attribute](/windows/win32/adschema/a-useraccountcontrol).

The typical **UserAccountControl** attribute value for a _writeable_ (_full_) DC computer account is 532480 decimal or 82000 hex. **UserAccountControl** values for a DC computer account can vary, but must contain the **SERVER_TRUST_ACCOUNT** and **TRUSTED_FOR_DELEGATION** flags, as shown in the following table.

| Property flag| Hex value| Decimal value |
|---|---|---|
| **SERVER_TRUST_ACCOUNT**| 0x2000| 8192 |
| **TRUSTED_FOR_DELEGATION**| 0x80000| 524288 |
| **UserAccountControl Value**| 0x82000| 532480 |
  
The typical **UserAccountControl** attribute value for a read-only domain controller computer account is 83890176 decimal or 5001000 hex.

| Property flag| Hex value| Decimal value |
|---|---|---|
| **WORKSTATION_TRUST_ACCOUNT**| 0x1000| 4096 |
| **TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION**| 0x1000000| 16777216 |
| **PARTIAL_SECRETS_ACCOUNT**| 0X4000000| 67108864 |
| **Typical UserAccountControl Value for RODC**| 0x5001000| 83890176 |
  
- **The UserAccountControl attribute on the destination domain controller is missing the SERVER_TRUST_ACCOUNT flag**  

    If the DCDIAG MachineAccount test fails and returns a **failed test MachineAcccount** error message, and the **UserAccountControl** attribute on the tested domain controller is missing the **SERVER_TRUST_ACCOUNT** flag, add the missing flag in the tested domain controller's copy of Active Directory.

    1. Start ADSIEDIT.MSC on the console of the domain controller that's missing the **SERVER_TRUST_ACCOUNT** as reported by DCDIAG.
    2. Right-click ADSIEDIT in the top-left pane of ADSIEDIT.MSC, and then select **connect to**.
    3. In the **Connection Settings** dialog box, click **Select a well known naming context**, and then select **Default naming context** (the computer account domain partition).
    4. Click **Select or type a domain or server**. And select the name of the domain controller that's failing in DCDIAG.
    5. Select **OK**.
    6. In the domain naming context, locate and right-click the domain controller computer account, and select **Properties**.
    7. Double-click the **UserAccountControl** attribute, and then record its decimal value.
    8. Start Windows Calculator in programmer mode (Windows Server 2008 and later versions).
    9. Enter the decimal value for **UserAccountControl**. Convert the decimal value to its hexadecimal equivalent, add **0x80000** to the existing value, and then press the equals sign (=).
    10. Convert the newly calculated **UserAccountContorl** value to its decimal equivalent.
    11. Enter the new decimal value from Windows Calculator to the **UserAccountControl** attribute in ADSIEDIT.MSC.
    12. Select **OK** twice to save.

- **The UserAccountControl attribute on the destination domain controller is missing the TRUSTED_FOR_DELEGATION flag**  

    If the DCDIAG MachineAccount test returns a **failed test MachineAcccount** error message, and the **UserAccountControl** attribute on the tested domain controller is missing the **TRUSTED _FOR_DELEGATION** flag, add the missing flag in the tested domain controller's copy of Active Directory.

    1. Start Active Directory Users and Computers (DSA.MSC) on the console of the domain controller that was tested by DCDIAG.
    2. Right-click the domain controller computer account.
    3. Select the **Delegation** tab.
    4. On the domain controller machine account, select the **Trusted this computer for delegation to any service (Kerberos only)** option.

        :::image type="content" source="./media/replication-error-8453/trusted-computer-for-delegation-to-service.png" alt-text="The Trusted this computer for delegation to any service option under the Delegation tab in the D C Properties dialog box." border="false":::

### Fix invalid default security descriptors

Active Directory operations take place in the security context of the account that started the operation. Default permissions on Active Directory partitions allow the following operations:

- Members of the Enterprise Administrators group can start ad-hoc replication between any domain controller in any domain in the same forest.
- Members of the Built-in Administrators group can start ad-hoc replication between domain controllers in the same domain.
- Domain Controllers in the same forest can start replication by using either change notification or replication schedule.

Default permissions on Active Directory partitions don't allow the following operations by default:

- Members of the Built-in Administrators group in one domain can't start ad-hoc replication to domain controllers in that domain from domain controllers in different domains.
- Users that aren't members of the Built-in Administrators group can't start ad-hoc replication from any other domain controller in the same domain or forest.

By design, these operations fail until default permissions or group memberships are modified.

Permissions are defined at the top of each directory partition (_NC head_), and are inherited throughout the partition tree. Verify that explicit groups (groups that the user is directly a member of) and implicit groups (groups that explicit groups have nested membership of) have the required permissions. Also verify that Deny permissions assigned to implicit or explicit groups don't take precedence over the required permissions. For more information about default directory partitions, see [Default Security of the Configuration Directory Partition](/previous-versions/windows/it-pro/windows-2000-server/cc961739(v=technet.10)).

- **Verify that default permissions exist in the top of each directory partition that is failing and returning replication access was denied**  

    If ad-hoc replication is failing between domain controllers in different domains, or between domain controllers in the same domain for non-domain administrators, see the [Grant non-domain admins permissions](#grant) section.

    If ad-hoc replication is failing for members of the Enterprise Administrators group, focus on NC head permissions that are granted to the Enterprise Administrators group.

    If ad-hoc replication is failing for members of a Domain Administrators group, focus on the permissions that are granted to the built-in Administrators Security group.

    If a scheduled replication that's started by domain controllers in a forest is failing and returning error 8453, focus on permissions for the following security groups:

  - Enterprise Domain Controllers
  - Enterprise Read-Only Domain Controllers

    If a scheduled replication is started by domain controllers on a read-only domain controller (RODC) is failing and returning error 8453, verify that the Enterprise Read-Only Domain Controllers security group is granted the required access on the NC head of each directory partition.

    The following table shows the default permission that's defined on the schema, configuration, domain, and DNS applications by various Windows versions.

    |DACL required on each directory partition|Windows Server 2008 and later|
    |---|---|---|---|
    | Manage Replication Topology|X|
    | Replicating Directory Changes|X|
    | Replication Synchronization|X|
    | Replicating Directory Changes All|X|
    |Replicating Changes in Filter Set|X|

    > [!NOTE]
    > The DCDIAG NcSecDesc test may report false positive errors when it's run in environments that have mixed system versions.

    The DSACLS command can be used to dump the permissions on a given directory partition by using the following syntax:  
    DSACLS \<DN path of directory partition>

    For example, use the following command:

    ```console
    C:\>dsacls dc=contoso,dc=com
    ```

    The command can be targeted to a remote domain controller by using the syntax:

    ```console
    c:\>dsacls \\contoso-dc2\dc=contoso,dc=com
    ```

    Be wary of DENY permission on NC heads removing the permissions for groups that the failing user is a direct or nested member of.

### Add required permissions that are missing

Use the Active Directory ACL editor in ADSIEDIT.MSC to add the missing DACLS.

### <a id="grant"></a>Grant non-domain admins permissions

Grant non-domain admins the following permissions:

- To replicate between domain controllers in the same domain for non-enterprise administrators
- To replicate between domain controllers in different domains

Default permissions on Active Directory partitions don't allow the following operations:

- Members of the Built-in Administrators group in one domain can't initiate ad-hoc replication from domain controllers in different domains.
- Users that aren't members of the built-in domain admins group to initiate ad-hoc replication between domain controllers in the same domain or different domain.

These operations fail until permissions on directory partitions are modified.

To resolve this problem, use either of the following methods:

- Add users to existing groups that have already been the granted the required permissions to replicate directory partitions. (Add the Domain administrators for replication in the same domain, or the Enterprise Administrators group to trigger ad-hoc replication between different domains.)

- Create your own group, grant that group the required permissions on directory partitions throughout the forest, and then add users to those groups.

For more information, see [KB303972](https://support.microsoft.com/help/303972). Grant the security group in question the same permissions listed in the table in the [Fix invalid default security descriptors](#fix-invalid-default-security-descriptors) section.

### Verify group membership in the required security groups

After the correct security groups have been granted the required permissions on directory partitions, verify that users who start replication have effective membership in direct or nested security groups that are granted replication permissions. To do it, follow these steps:

1. Log on by using the user account in which ad-hoc replication is failing and returning **replication access was denied**.
2. At a command prompt, run the following command:

    ```console
    WHOAMI /ALL
    ```

3. Verify membership in the security groups that have been granted the replicating directory changes permissions on the relevant directory partitions.

    If the user was added to the permitted group that was changed after the last user logon, log on a second time, and then run the `WHOAMI /ALL` command again.

    If this command still does not show membership in the expected security groups, open an elevated Command Prompt window, on the local computer, and run `WHOAMI /ALL` at the command prompt.

    If the group membership differs between the `WHOAMI /ALL` output that is generated by elevated and non-elevated command prompts, see [When you run an LDAP query against a Windows Server 2008-based domain controller, you obtain a partial attribute list](https://support.microsoft.com/help/976063).

4. Verify that the expected nested group memberships exist.

    If a user is getting permissions to run ad-hoc replication as a member of nested group, which is a member of group that has been directly granted replication permissions, verify the nested group membership chain. We've seen ad-hoc Active Directory replication failures because the Domain Administrators and Enterprise Administrators groups were removed from the built-in Administrators groups.

### RODC replication

If computer-initiated replication is failing on RODCs, verify that you have run `ADPREP /RODCPREP` and that the Enterprise Read-Only Domain Controller group is granted the **Replicate Directory Changes** right on each NC head.

### Missing NTDS Settings object for LDS server

In Active Directory Lightweight Directory Services (LDS), it's possible to delete the object without a metadata cleanup in DBDSUTIL. It may cause this problem. To restore the instance to the configuration set, you must uninstall the LDS instance on the affected servers, and then run the ADAM configuration wizard.

> [!NOTE]
> If you have added LDAPS support for the instance, you must configure the certificate in the service store again, because uninstalling the instance also removes the service instance.
