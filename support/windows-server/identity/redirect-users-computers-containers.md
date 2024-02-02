---
title: Redirect users and computers containers
description: Describes how to use redirusr and redircmp to redirect user, computer, and group accounts in Active Directory domains.
ms.date: 12/22/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Redirect the users and computers containers in Active Directory domains

You can use redirusr and redircmp to redirect user, computer, and group accounts that are created by earlier-version APIs. So they are put in admin-specified organizational unit (OU) containers.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324949

## Summary

In a default installation of an Active Directory domain, user, computer, and group accounts are put in CN=objectclass containers instead of a more desirable OU class container. Similarly, the accounts that were created by using earlier-version APIs are put in the CN=Users and CN=computers containers.

> [!IMPORTANT]
> Some applications require specific security principals to be located in default containers like CN=Users or CN=Computers. Verify that your applications have such dependencies before you move them out of the CN=users and CN=computes containers.

## More information

Users, computers, and groups created by earlier-version APIs place objects in the DN path that's specified in the WellKnownObjects attribute. The WellKnownObjects attribute is located in the domain NC head. The following code example shows the relevant paths in the WellKnownObjects attribute from the CONTOSO.COM domain NC head.

Dn: DC=CONTOSO,DC=COM

```conosle
wellKnownObjects (11):
B:32:6227F0AF1FC2410D8E3BB10615BB5B0F:CN=NTDS Quotas,DC=CONTOSO,DC=COM;
B:32:F4BE92A4C777485E878E9421D53087DB:CN=Microsoft,CN=Program Data,DC=CONTOSO,DC=COM;
B:32:09460C08AE1E4A4EA0F64AEE7DAA1E5A:CN=Program Data,DC=CONTOSO,DC=COM;
B:32:22B70C67D56E4EFB91E9300FCA3DC1AA:CN=ForeignSecurityPrincipals,DC=CONTOSO,DC=COM;
B:32:18E2EA80684F11D2B9AA00C04F79F805:CN=Deleted Objects,DC=CONTOSO,DC=COM;
B:32:2FBAC1870ADE11D297C400C04FD8D5CD:CN=Infrastructure,DC=CONTOSO,DC=COM;
B:32:AB8153B7768811D1ADED00C04FD8D5CD:CN=LostAndFound,DC=CONTOSO,DC=COM;
B:32:AB1D30F3768811D1ADED00C04FD8D5CD:CN=System,DC=CONTOSO,DC=COM;
B:32:A361B2FFFFD211D1AA4B00C04FD7D83A:OU=Domain Controllers,DC=CONTOSO,DC=COM;
B:32:AA312825768811D1ADED00C04FD8D5CD:CN=Computers,DC=CONTOSO,DC=COM;
B:32:A9D1CA15768811D1ADED00C04FD8D5CD:CN=Users,DC=GPN,DC=COM;
```

For example, the following operations use earlier-version APIs, which rely on the paths defined in the WellKnownObjects attribute:

- Domain Join UI
- NET COMPUTER
- NET GROUP
- NET USER
- NETDOM ADD, where the `/ou` command is either not specified or supported
  
It's helpful to make the default container for user, computer, and security groups an OU for several reasons, including:

- Group policies can be applied on OU containers but not on CN class containers, where security principals are put by default.

- The best practice is to arrange security principals into an OU hierarchy that mirrors your organizational structure, geographic layout, or administration model.

If you're redirecting the CN=Users and CN=Computers folders, be aware of the following issues:

- The target domain must be configured to run in the Windows Server 2003 domain functional level or higher. For the Windows Server 2003 domain functional level, it means that:

  - Windows Server 2003 `ADPREP /FORESTPREP` or newer
  - Windows Server 2003 `ADPREP /DOMAINPREP` or newer
  - All domain controllers in the target domain must run Windows Server 2003 or newer.
  - Windows Server 2003 domain functional level or higher must be enabled.

- Unlike CN=USERS and CN=COMPUTERS, OU containers are subject to accidental deletions by privileged user accounts, including administrators.

    CN=USERS and CN=COMPUTERS containers are system-protected objects that can't, and mustn't, be removed for backward compatibility. But they can be renamed. Organizational units are subject to accidental tree deletions by administrators.

    Windows Server 2003 versions of the Active Directory Users & Computers snap-in can follow the steps in [Protect an Organizational Unit from Accidental Deletion](https://gallery.technet.microsoft.com/scriptcenter/c307540f-bd91-485f-b27e-995ae5cea1e2).

    Windows Server 2008 and newer versions of the Active Directory Users and Computers snap-in feature a **Protect object against accidental deletion** check box that you can select when you create a new OU container. You can also select it on the **Object** tab of the **Properties** dialog box for an existing OU container.

    A scripted option is documented in [Script to Protect Organizational Units (OUs) from Accidental Deletion](https://gallery.technet.microsoft.com/scriptcenter/c307540f-bd91-485f-b27e-995ae5cea1e2).

- Redirecting CN=USERS affects the default location for new users, groups, and trust user accounts. Trust user accounts are hidden in most UI admin tools, but you can show and move them in tools like LDIFDE and LDP. The CN of the account is \<downlevel domain name>$, for example, "contoso$".

- If you experience Exchange Server Active Directory preparation failures, make sure you're running the latest cumulative update and security update.

## Redirect CN=Users to an administrator-specified OU

1. Log on with domain administrator credentials in the domain where the CN=Users container is being redirected.

2. Transition the domain to the Windows Server 2003 domain functional level or newer in either the Active Directory Users and Computers snap-in (Dsa.msc) or the Domains and Trusts (Domains.msc) snap-in. For more information about increasing the domain functional level, see [How to raise domain and forest functional levels](https://support.microsoft.com/help/322692).

3. Create the OU container where you want users and groups who are created with earlier-version APIs to be located, if the OU container that you want doesn't exist.

4. Run *Redirusr.exe* at the command prompt by using the following syntax. In the command, _container-dn_ is the distinguished name of the OU that will become the default location for newly created user and group objects created by down-level APIs:

    ```console
    c:\windows\system32\redirusr container-dn
    ```

    Redirusr is installed in the `%SystemRoot%\System32` folder on Windows Server 2003-based or newer computers. For example, to change the default location for users who are created with down-level APIs such as Net User to the OU=MYUsers OU container in the `CONTOSO.COM` domain, use the following syntax:

    `c:\windows\system32>redirusr ou=myusers,DC=contoso,dc=com`
    > [!NOTE]
    > When *Redirusr.exe* is run to redirect the CN=Users container to an OU specified by an administrator, the CN=Users container will no longer be a protected object. This means that the Users container can now be moved, deleted, or renamed. If you use ADSIEDIT to view attributes on the CN=Users container, you will see that the systemflags attribute was changed from **-1946157056** to **0**. This is by design.
    >
    > To delete the container, you have to move out the default users and groups to other OUs and containers, and also the trust user accounts. These trust accounts can be shown and moved using tools like LDIFDE and LDP. We recommend keeping the container unchanged and the default accounts in place for consistency.

## Redirect CN=Computers to an administrator-specified OU

1. Log on with Domain Administrator credentials in the domain where the CN=computers container is being redirected.

2. Transition the domain to the Windows Server 2003 domain in the Active Directory Users and Computers snap-in (Dsa.msc) or in the Domains and Trusts (Domains.msc) snap-in. For more information about increasing the domain functional level, see [How to raise domain and forest functional levels](https://support.microsoft.com/help/322692).

3. Create the OU container where you want computers that are created with earlier-version APIs to be located, if the desired OU container doesn't exist.

4. Run *Redircmp.exe* at a command prompt by using the following syntax. In the command, _container-dn_ is the distinguished name of the OU that will become the default location for newly created computer objects that are created by down-level APIs:

    ```console
    redircmp container-dn
    ```

    *Redircmp.exe* is installed in the `%Systemroot%\System32` folder in Windows Server 2003 or later versions. To change the default location for a computer created with earlier-version APIs, such as Net Computer, to the OU=MyComputers container in the CONTOSO.COM domain, use the following syntax:

    ```console
    C:\windows\system32>redircmp ou=mycomputers,DC=contoso,dc=com
    ```

    > [!NOTE]
    > When *Redircmp.exe* is run to redirect the CN=Computers container to an OU specified by an administrator, the CN=Computers container will no longer be a protected object. This means that the Computers container can now be moved, deleted, or renamed. If you use ADSIEDIT to view attributes on the CN=Computers container, you will see that the systemflags attribute was changed from **-1946157056** to **0**. This is by design.

## Description of error messages

Here are error messages that occur in some cases.

### Error messages that you receive if the PDC is offline

Redircmp and Redirusr change the wellKnownObjects attribute on the primary domain controller (PDC). If the PDC of the domain that is being changed is offline or inaccessible, you receive the following error messages.

- Error message 1:

    > C:\>redirusr OU=userOU,DC=udc,dc=jkcertcontoso,dc=loc com
    >  
    > Error, could not locate the Primary Domain Controller for the current domain: The specified domain either does not exist or could not be contacted. Redirection was NOT successful.

- Error message 2:

    > C:\>redircmp OU=computerOU,DC=contoso,dc=com DC=udc,dc=jkcert,dc=loc
    >  
    > Error, could not locate the Primary Domain Controller for the current domain: The specified domain either does not exist or could not be contacted. Redirection was NOT successful.

### Error messages that you receive if the domain functional level isn't Windows Server 2003

You try to redirect the users or computer OU in a domain that hasn't transitioned to the Windows Server 2003 domain functional level. In this situation, you receive the following error messages:

- Error message 1:

    > C:\>redirusr OU=usersou,DC=contoso,dc=comDC=company,DC=com
    >
    > Error, unable to modify the wellKnownObjects attribute. Verify that the domain functional level of the domain is at least Windows Server 2003: Unwilling To Perform Redirection was NOT successful.

- Error message 2:

    > C:\>redircmp ou=computersou,DC=contoso,dc=comdc=company,dc=com
    >
    > Error, unable to modify the wellKnownObjects attribute. Verify that the domain functional level of the domain is at least Windows Server 2003: Unwilling To Perform

### Error messages that you receive if you log on without the required permissions

If you try to redirect the users or computer OU by using incorrect credentials in the target domain, you may receive the following error messages:

- Error message 1

    > C:>redircmp OU=computersou,DC=contoso,dc=comDC=company,DC=com
    >
    > Error, unable to modify the wellKnownObjects attribute. Verify that the domain functional level of the domain is at least Windows Server 2003: Insufficient Rights Redirection was NOT successful.

- Error message 2:

    > C:\>redirusr OU=usersou,DC=contoso,dc=comDC=company,DC=com
    >
    > Error, unable to modify the wellKnownObjects attribute. Verify that the domain functional level of the domain is at least Windows Server 2003: Insufficient Rights Redirection was NOT successful.

### Error messages that you receive if you redirect to an OU that doesn't exist

You try to redirect the users or computer OU to an OU that doesn't exist. In this situation, you may receive the following error messages:

- Error message 1:

    > C:\>redircmp OU=nonexistantou,DC=contoso,dc=com dc=rendom,dc=com
    >
    > Error, unable to modify the wellKnownObjects attribute. Verify that the domain functional level of the domain is at least Windows Server 2003: No Such Object Redirection was NOT successful.

- Error message 2:

    > C:\>redirusr OU=nonexistantou,DC=contoso,dc=com DC=company,DC=com
    >
    > Error, unable to modify the wellKnownObjects attribute. Verify that the domain functional level of the domain is at least Windows Server 2003: No Such Object Redirection was NOT successful.

### Error messages that you receive in Exchange Server 2000 setup /domainprep when CN=Users is redirected

If Exchange Server 2000 and Exchange Server 2003 `setup /domainprep` is unsuccessful, you receive the following error message:

> Setup failed while installing sub-component Domain-level permissions with error code 0x80072030) (please consult the installation logs for a detailed description). You may cancel the installation or try the failed step again. (Retry / Cancel)

The following data appears in the Exchange Server 2000 Setup log that is parsed with log parser. Exchange Server 2003 should be similar.

```output
[HH:MM:SS] Completed DomainPrep of Microsoft Exchange 2000 component
[HH:MM:SS] ScGetExchangeServerGroups (K:\admin\src\libs\exsetup\dsmisc.cxx:301) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] ScCreateExchangeServerGroups (K:\admin\src\libs\exsetup\dsmisc.cxx:373) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] CAtomPermissions::ScAddDSObjects (K:\admin\src\udog\exsetdata\components\domprep\a_permissions.cxx:144) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] mode = 'DomainPrep' (61966) CBaseAtom::ScSetup (K:\admin\src\udog\setupbase\basecomp\baseatom.cxx:775) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] Setup encountered an error during Microsoft Exchange Domain Preparation of DomainPrep component task. CBaseComponent::ScSetup (K:\admin\src\udog\setupbase\basecomp\basecomp.cxx:1031) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] CBaseComponent::ScSetup (K:\admin\src\udog\setupbase\basecomp\basecomp.cxx:1099) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] CCompDomainPrep::ScSetup (K:\admin\src\udog\exsetdata\components\domprep\compdomprep.cxx:502) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] CComExchSetupComponent::Install (K:\admin\src\udog\BO\comboifaces.cxx:694) Error code 0X80072030 (8240): There is no such object on the server.
[HH:MM:SS] Setup completed
```
