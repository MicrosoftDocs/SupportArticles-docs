---
title: Azure AD Hybrid Sync Agent Installation Issues - There is no such object on the server
description: This troubleshooting guide focuses on the situation where the object reference is not set to an instance of an object, which may block you from successfully installing the Azure AD Connect Provisioning Agent.
ms.date: 09/15/2021
---

# Azure AD Hybrid Sync Agent Installation Issues - There is no such object on the server

This troubleshooting guide focuses on the situation where the object reference is not set to an instance of an object, which may block you from successfully installing the Azure AD Connect Provisioning Agent.

## Prerequisites

To install *Cloud Provisioning Agent*, the following prerequisites are required:

- Domain or Enterprise Administrator credentials to execute the installer.
- A Global Administrator Account at the Azure AD Tenant.
- The server for the provisioning agent must be Windows Server 2016 or later, domain-joined, and following directives for Tier 0 based on the Active directory administrative model.
- At least one domain controller running Windows Server 2016, and both a domain functional level and a forest functional level of at least 2012 R2.
- [Network prerequisites](/azure/active-directory/cloud-sync/how-to-prerequisites#in-your-on-premises-environment)

## Scenario 1

When installing Cloud Provisioning Agent you may encounter this error during installation process.

> There is no such object on the server.

:::image type="content" source="media/azure-ad-hybrid-synch-no-such-object-on-server/1-agent-configuration-error-creating gmsa-v1.png" alt-text="Screenshot of the Microsoft Azure Active Directory Connect Provisioning Agent Configuration screen, including the error message Error while creating group managed service account gmsa. Error, there is no such object on the server." border="true":::

The installation wizard's trace file is not clear about what's missing:

```output
[15:16:14.583] [ 16] [ERROR] Exception creating gmsa. Exception: System.DirectoryServices.DirectoryServicesCOMException (0x80072030): There is no such object on the server.

   at System.DirectoryServices.DirectoryEntry.Bind(Boolean throwIfFail)
   at System.DirectoryServices.DirectoryEntry.Bind()
   at System.DirectoryServices.DirectoryEntry.get_NativeObject()
   at System.DirectoryServices.DirectoryEntry.InvokeGet(String propertyName)
   at Microsoft.Online.Deployment.Framework.Providers.GroupManagedServiceAccountProvider.CreateGroupManagedAccount(String serviceAccountName, String serviceDnsName, String username, String password)
[15:16:14.585] [ 16] [ERROR] Exception caught while creating gmsa. Exception: System.DirectoryServices.DirectoryServicesCOMException (0x80072030): There is no such object on the server.
```

To resolve the issue in this scenerio, use the command `dsa.msc` to verify within the domain controller whether the **Managed Service Account** container is present.

:::image type="content" source="media/azure-ad-hybrid-synch-no-such-object-on-server/2-active-directory-users-computers.png" alt-text="Screenshot of the Active Directory Users and Computers window." border="true":::

If the container is missing, contact the Windows Directory Services Team to restore or create the container with the `ADPrep /Domainprep` command.

The following are [Active Directory Domain Service requirements](/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts)

> The Active Directory schema in the gMSA domain's forest needs to be updated to Windows Server 2012 to create a gMSA.
>
> You can update the schema by installing a domain controller that runs Windows Server 2012 or by running the version of adprep.exe from a computer running Windows Server 2012 . The object-version attribute value for the object CN=Schema,CN=Configuration,DC=< name of DC >,DC=Com must be 52.

## Scenario 2

In a similar scenario as above, you may encounter the following error:

> Error when creating group managed service account (gMSA). Error: There is no such object on the server.

:::image type="content" source="media/azure-ad-hybrid-synch-no-such-object-on-server/3-agent-configuration-error-creating-gmsa-v2.png" alt-text="Screenshot of the Microsoft Azure Active Directory Connect Provisioning Agent Configuration screen, including the error message Error while creating group managed service account gmsa. Error, there is no such object on the server." border="true":::

The wizard trace shows the following information:

```output
[01:12:13.924] [  9] [INFO ] IsServiceAccountGMSA:: Checking if service account is gmsa
[01:12:13.924] [  9] [INFO ] Get current service credentials.
[01:12:13.938] [  9] [INFO ] IsServiceAccountGMSA:: Service account: NT SERVICE\AADConnectProvisioningAgent is not gmsa.
[01:12:15.414] [  9] [INFO ] IsServiceAccountGMSA:: Checking if service account is gmsa
[01:12:15.414] [  9] [INFO ] Get current service credentials.
[01:12:15.418] [  9] [INFO ] IsServiceAccountGMSA:: Service account: NT SERVICE\AADConnectProvisioningAgent is not gmsa.
[01:12:15.468] [  9] [ERROR] Exception creating gmsa. Exception: System.DirectoryServices.DirectoryServicesCOMException (0x80072030): There is no such object on the server.

   at System.DirectoryServices.DirectoryEntry.Bind(Boolean throwIfFail)
   at System.DirectoryServices.DirectoryEntry.Bind()
   at System.DirectoryServices.DirectoryEntry.get_NativeObject()
   at System.DirectoryServices.DirectoryEntry.InvokeGet(String propertyName)
   at Microsoft.Online.Deployment.Framework.Providers.GroupManagedServiceAccountProvider.CreateGroupManagedAccount(String serviceAccountName, String serviceDnsName, String username, String password)
[01:12:15.472] [  9] [ERROR] Exception caught while creating gmsa. Exception: System.DirectoryServices.DirectoryServicesCOMException (0x80072030): There is no such object on the server.
```

Once you verify and confirm that Managed Service account container is present at the domain, a client Lightweight Directory Access Protocol (LDAP) trace will show the following information:

```output
9638 [2]0144.1380::04/14/21-14:17:20.2063638 [Microsoft_Windows_LDAP_Client/Debug16 ] Message=ldap_search called for connection 0x4392e0d8: DN is <WKGUID=1eb93889e40c45df9f0c64d23bbb6237,DC=Child,DC=*****,DC=com>. SearchScope is 0x0. AttributesOnly is 0x0. 

9679 [1]0144.1380::04/14/21-14:17:20.2075574 [Microsoft_Windows_LDAP_Client/Debug16 ] Message=4e 61 6d 65 45 72 72 3a 20 44 53 49 44 2d 30 33  NameErr:.DSID-03
9680 [1]0144.1380::04/14/21-14:17:20.2076087 [Microsoft_Windows_LDAP_Client/Debug16 ] Message=31 30 30 32 33 38 2c 20 70 72 6f 62 6c 65 6d 20  100238,.problem.
9681 [1]0144.1380::04/14/21-14:17:20.2076151 [Microsoft_Windows_LDAP_Client/Debug16 ] Message=32 30 30 31 20 28 4e 4f 5f 4f 42 4a 45 43 54 29  2001.(NO_OBJECT)
```

The agent could not find the WellKnown globally unique identifier (GUID) for the Managed Service Accounts (MSA) container.

This error can be verified with the following PowerShell command:

```powershell
$ListOWKO = Get-ADObject (Get-ADRootDSE).DefaultNamingContext -Properties otherwellKnownObjects

$ListOWKO.otherwellKnownObjects
```

The output of the previous command will display the following results:

> B:32:1EB93889E40C45DF9F0C64D23BBB6237:CN=Managed Service Accounts\0ADEL:8b637607-65e8-4a80-b194-f738b26b9414,CN=Deleted Objects,DC=child,DC=< name of DC >,DC=com

:::image type="content" source="media/azure-ad-hybrid-synch-no-such-object-on-server/4-powershell-output-for-attribute.png" alt-text="Screenshot of the output for the command, showing the missing attribute." border="true":::

This orphan metadata value indicates that either the MSA container was previously deleted and wasn't properly restored, or that the value is missing.

The default value for the **OtherWellKnownObjects** attribute is:

> B:32:1EB93889E40C45DF9F0C64D23BBB6237:CN=Managed Service Accounts,DC=child,**DC=< name of DC >,DC=com**

To resolve this issue, open a ticket with Windows Directory Services Team.
