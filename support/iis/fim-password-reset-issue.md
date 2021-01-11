---
title: FIM 2010 password reset issue
description: This article provides resolutions for the problem where FIM is unable to reset passwords on a group of user objects.
ms.date: 03/24/2020
ms.prod-support-area-path: IISAdmin service and Inetinfo process operation
---
# Forefront Identity Manager 2010 password reset issue

This article helps you resolve the problem where Forefront Identity Manager is unable to reset passwords on a group of user objects.

_Original product version:_ &nbsp; Forefront Identity Manager 2010  
_Original KB number:_ &nbsp; 2028194

## Symptoms

You are using the Forefront Identity Manager (FIM) self-service password reset client, and are in the process of resetting your password. You have successfully answered the challenge questions. When you click the **Reset** button on the **Enter Your New Password** page, a dialog returns the error:

> An error occurred when attempting to reset password, please try again.

On the server running the FIM service, a corresponding Applications and Service Event logs the error:

> "PWReset Activity"s MIIS Password Set call failed with ma-access-denied" is written to the FIM event log.

## Cause

The return code **ma-access-denied** indicates that the relevant Active Directory Management Agent (AD MA) doesn't have the right to set the password on a specific target user object.

This article discusses the specific scenario where Forefront Identity Manager is unable to reset passwords on a group of user objects whose Security Descriptor attribute is managed by the domain to match the AdminSDHolder object"s Security Descriptor.

For more information about the AdminSDHolder, see the [More Information](#more-information) section in this article.

## Resolution

Use one of the following resolutions:

1. Grant sufficient permissions to the Active Directory Management Agent account can reset passwords on these user objects.
2. Remove the user objects whose security descriptor is managed by the AdminSDHolder from the set of users that are enabled for Self-Service Password Reset in FIM.

### Detailed options to resolve this problem  

- Decide these accounts are too important and don"t allow them to use FIM to reset their passwords by taking those users out of the password reset users set.
- Remove users who will be managing their password reset options through FIM from the groups listed below.
- If the users who will be managing password reset using FIM are in one of the following groups and in no other, consider removing one or more of these groups from the management of the AdminSDHolder ([Delegated permissions are not available and inheritance is automatically disabled](https://support.microsoft.com/help/817433/)).
  - Account Operators
  - Server Operators
  - Print Operators
  - Backup Operators

- Grant Change Password and Reset Password rights to the Active Directory MA account on the AdminSDHolder object.
  - This solution will allow the Active Directory MA account to reset the password of every user who is a member of the groups listed below under `AdminSDHolder Secured Groups`.
  - To grant these permissions on the AdminSDHolder object, the `dsacls` command must be used. See examples under `Granting Permissions on the AdminSDHolder Object` in the [More Information](#more-information) section.

## More information

To secure the Administrative accounts in the Active Directory, there is a process that automatically runs against members of the following groups to set the security descriptor to match that of the AdminSDHolder object in the Active Directory.

- Administrators
- Account Operators
- Server Operators
- Print Operators
- Backup Operators
- Domain Admins
- Schema Admins
- Enterprise Admins
- Cert Publishers

How and why this process is in place is important to understand before making any changes to the permissions on these objects via a change in the Security Descriptor of the AdminSDHolder object. There are many good articles published on the Microsoft website. Simply search for AdminSDHolder from [Microsoft Docs](https://docs.microsoft.com/).

### Granting permissions on the AdminSDHolder Object

> [!IMPORTANT]
> When making a change to the AdminSDHolder security descriptor, please realize this change is applied on every object whose security descriptor is managed by the Active Directory to match the AdminSDHolder. This includes, among others, members of the Domain Admins and Enterprise Admins security groups. To delegate Change Password and Reset Password rights to AdminSDHolder, use `dsacls` at a command line as follows:

```console
dsacls "cn=adminsdholder,cn=system,dc=mydomain,dc=com" /G "mydomain\svc_fimadma:CA;Reset Password"
dsacls "cn=adminsdholder,cn=system,dc=mydomain,dc=com" /G "mydomain\svc_fimadma:CA;Change Password"
```

> [!NOTE]
> Please modify the distinguished name and AD MA account in the commands above to match your system.

### References

- [AdminSDHolder, Protected Groups and SDPROP](/previous-versions/technet-magazine/ee361593(v=msdn.10))

- [Delegated permissions are not available and inheritance is automatically disabled](https://support.microsoft.com/help/817433)

- [How Security Principals Work](/previous-versions/windows/it-pro/windows-server-2003/cc779144(v=ws.10))
