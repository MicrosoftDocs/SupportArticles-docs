---
title: Access is denied error when moving mailboxes
description: Describes an issue that triggers an Access is denied error when trying to move mailboxes to Exchange Online in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: hbohl, charw, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# (Access is denied) error when you try to move mailboxes to Exchange Online in a hybrid deployment

_Original KB number:_ &nbsp; 2975731

## Symptoms

Assume that you have a Microsoft Exchange Server hybrid deployment. If you try to create a migration batch for a remote move migration, or if you try to create a move request when you're connected to Exchange Online through remote PowerShell, you receive an error message that resembles the following:

> The call to 'https://\<ServerName>/EWS/mrsproxy.svc' failed. Error details: Access is denied.  
\+ CategoryInfo : NotSpecified: (:) [New-MoveRequest], RemoteTransientException  
\+ FullyQualifiedErrorId : [Server=\<Server>,RequestId=*RequestId*,TimeStamp=*DateTime*] [FailureCategory=Cmdlet-RemoteTransientException] 384B348,Microsoft.Exchange.Management.RecipientTasks.NewMoveRequest  
\+ PSComputerName : \<ComputerName>.outlook.com

If you then run the `Test-MigrationServerAvailability` cmdlet, you receive an error message that resembles the following:

> RunspaceId : *RunspaceId*  
Result : Failed  
Message : The ExchangeRemote endpoint settings could not be determined from the autodiscover response. No MRSProxy was found running at \<Server>.  
ConnectionSettings :  
SupportsCutover : False  
ErrorDetail : internal error:Microsoft.Exchange.Migration.MigrationRemoteEndpointSettings couldNotBeAutodiscoveredException: TheExchangeRemote endpoint settings could not be determined from the autodiscover response. No MRSProxy was found running at '\<Server>'. ---> Microsoft.Exchange.Migration.MigrationServerConnectionFailedException:The connection to the server '\<Server>'could not be completed. ---> Microsoft.Exchange.MailboxReplicationService.RemoteTransientException: The call to 'https://\<ServerName>/EWS/mrsproxy.svc' failed. Error details: Access is denied.. ---> Microsoft.E xchange.MailboxReplicationService.RemotePermanentException : Access is denied.--- End of inner exception stack trace --- at Microsoft.Exchange.MailboxReplicationService.Mailbox ReplicationServiceFault.<>c__DisplayClass1.\<ReconstructAnd Throw>b__0() at Microsoft.Exchange.MailboxReplicationService.Executi onContext.Execute(Action operation) at Microsoft.Exchange.MailboxReplicationService.Mailbox ReplicationServiceFault.ReconstructAndThrow(String serverName, VersionInformation serverVersion) at Microsoft.Exchange.MailboxReplicationService.CommonU tils.CallWCFService[ExceptionT](Action serviceCall, String epAddress, Action`1 faultHandler, VersionInformation serverVersion) at Microsoft.Exchange.MailboxReplicationService.CommonU tils.CallService(Action serviceCall, String epAddress, VersionInformation serverVersion) at Microsoft.Exchange.Migration.MigrationExchangeProxyR pcClient.CanConnectToMrsProxy(Fqdn serverName, Guid mbxGuid, NetworkCredential credentials, LocalizedException& error) --- End of inner exception stack trace --- at Microsoft.Exchange.Migration.DataAccessLayer.Exchang eRemoteMoveEndpoint.VerifyConnectivity() at Microsoft.Exchange.Management.Migration.TestMigrationServerAvailability.InternalProcessEndpoint(BooleanfromAutoDiscover)--- End of inner exception stack trace ---IsValid : TrueIdentity :ObjectState : New

For example, you receive this error message when you run the following command:

```powershell
Test-MigrationServerAvailability -ExchangeRemoteMove -Autodiscover -EmailAddressusername@contoso.com -Credentials (Get-Credential)
```

Additionally, assume that inheritance is not enabled on the computer account of the Exchange 2013 or Exchange 2016 hybrid server. If you enable it, you later discover that it has been disabled.

## Cause

This issue occurs if the computer account of the Exchange 2013 or Exchange 2016 hybrid server is a member of one or more protected groups.  

## Resolution

To resolve this issue, follow these steps:

1. Verify that you're experiencing this issue. To do this, determine whether the computer account of the Exchange 2013 hybrid server has its `adminCount` attribute set to **1**.

   To find the `adminCount` attribute, follow these steps:

   1. Locate **Active Directory Users and Computers**, and then select **View** > **Advanced Features**.
   2. Expand the domain for the server that is running Exchange Server, and then expand **Computers**.
   3. Locate the Exchange 2013 or Exchange 2016 server. Right-click the server, and then select **Properties**.
   4. Locate the **Attribute Editor** tab, and then locate the **adminCount** attribute.

   If the attribute is set to **1**, this means that the computer account is a member, directly or indirectly, of one more of the following protected groups:  

     - Administrators
     - Account Operators
     - Server Operators
     - Print Operators
     - Backup Operators
     - Domain Admins
     - Schema Admins
     - Enterprise Admins
     - Cert Publishers

    The computer account for the Exchange 2013 hybrid server should belong to only the following security groups:

    - Domain Computers
    - Exchange Install
    - Domain Servers
    - Exchange Servers
    - Exchange Trusted Subsystem
    - Managed Availability Servers

2. Set the value of the `adminCount` attribute on the computer account to **0**.
3. Restart the server.

## More information

Members of protected groups don't inherit permissions from the parent container.

Active Directory Domain Services (AD DS) uses a protection mechanism to make sure that access control lists (ACLs) are set correctly for members of sensitive groups. The mechanism runs one time each hour on the primary domain controller (PDC) operations master. The operations master compares the ACL on the user accounts that are members of protected groups against the ACL on the following object:

CN=adminSDHolder,CN=System,DC=\<Domain>,DC=\<Com>

If the ACLs differ, the ACL on the user object is overwritten to reflect the security settings of the `adminSDHolder` object (and ACL inheritance is disabled). This process protects these accounts from being modified by unauthorized users if the accounts are moved to a container or an organizational unit where a malicious user has been delegated administrative credentials to modify user accounts. Be aware that when a user is removed from the administrative group, the process is not reversed and must be changed manually.

If you experience issues when you move mailboxes to Exchange Online in Microsoft 365, you can run the Troubleshoot Microsoft 365 Mailbox Migration tool. This diagnostic is an automated troubleshooting tool. If you're experiencing a known issue, you receive a message that states what went wrong. The message includes a link to an article that contains the solution. Currently, the tool is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
