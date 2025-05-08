---
title: Troubleshoot Authentication Errors When Joining Windows-based Computers to a Domain
description: Troubleshooting guide for authentication related error messages that occurs when you join Windows-based computers to a domain.
ms.date: 05/08/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Troubleshoot authentication errors that occur when you join Windows-based computers to a domain

This article describes several authentication related error messages that can occur when you join client computers that are running Windows to a domain. This article also provides troubleshooting suggestions for these errors.

## Where to find the NetSetup.log file

The **NetSetup.log** file contains most information about domain join activities. The file is located on the client machine at **%windir%\\debug\\Netsetup.log**. This log file is enabled by default. No need to explicitly enable it.

## You have exceeded the maximum number of computer accounts you are allowed to create in this domain

Make sure that you have permissions to add computers to the domain, and that you don't exceed the quota that is defined by your domain administrator.

To join a computer to the domain, the user account must be granted **Create computer object** permissions in Active Directory.

> [!NOTE]
> By default, a nonadministrator user can join a maximum of 10 computers to an Active Directory domain.

## Logon failure: The target account name is incorrect

Check that the domain controllers (DCs) are registered by using correct IP addresses on the Domain Name System (DNS) server, and that their Service Principal Names (SPNs) are registered correctly in their Active Directory accounts.

## Logon failure: the user has not been granted the requested logon type at this computer

Make sure that you have permissions to add computers to the domain. To join a computer to the domain, the user account must be granted the **Create computer object**  permission in Active Directory.

Additionally, make sure that the specified user account is allowed to log on locally to the client computer. To do this, configure the **Allow log on locally** setting in Group Policy under **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment**.

## Logon failure: unknown user name or bad password

Make sure that you use the correct user name and password combination of an existing Active Directory user account when you're prompted for credentials to add the computer to the domain.

## No mapping between account names and security IDs was done

This error is likely a transient error that is logged when a domain join searches the target domain to determine whether a matching computer account was already created or whether the join operation has to dynamically create a computer account on the target domain.

## Not enough storage is available to complete this operation

This error can occur when the Kerberos token size is larger than the maximum default size. If this situation, you have to increase the Kerberos token size of the computer that you try to join to the domain. For more information, see:

- ["Not enough storage is available to complete this operation" error message when you use a domain controller to join a computer to a domain](../../windows-client/windows-security/not-enough-storage-available-complete-operation-error.md)
- [Problems with Kerberos authentication when a user belongs to many groups](../windows-security/kerberos-authentication-problems-if-user-belongs-to-groups.md)

## The account is not authorized to login from this station

This problem is related to mismatched Server Message Block (SMB) signing settings between the client computer and the DC that is being contacted for the domain join operation. To further investigate the current and recommended values in your environment, see:

- [Error message: The account isn't authorized to login from this station](account-not-authorized-login-from-this-station.md)
- [Client, service, and program issues can occur if you change security settings and user rights assignments](https://support.microsoft.com/help/823659/client-service-and-program-issues-can-occur-if-you-change-security-set)

## The account specified for this service is different from the account specified for other services running in the same process

Make sure that the DC through which you're trying to join the domain has the Windows Time service started.
