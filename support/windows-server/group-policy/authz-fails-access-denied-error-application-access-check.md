---
title: Access checks fail because of AuthZ
description: Addresses an issue in which AuthZ fails and returns an Access Denied error when an application does access checks in Windows Server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-jesits
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# AuthZ fails with an Access Denied error when an application does access checks in Windows Server

This article provides a solution to an issue in which AuthZ fails with an Access Denied error when an application does access checks in Windows Server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4055652

## Symptoms

Consider the following scenario:

- You're working in an Active Directory environment that's based on Windows Server 2008 R2 or a later version.
- You run an application that uses the Authorization (AuthZ) interface. Such applications include Microsoft Exchange 2016 and Microsoft Exchange 2013.

In this scenario, when the application tries to do an access check, AuthZ fails and returns an Access Denied error message.

## Cause

This issue occurs because the **Network access: Restrict clients allowed to make remote calls to SAM** policy is enabled. The policy controls which users can enumerate users and groups in the local Security Accounts Manager (SAM) database and in Active Directory.

This policy is introduced after the following versions of Windows or Windows updates are installed:

- Windows 10 Version 1607 and later versions
- Windows 10 Version 1511 with [KB 4103198](https://support.microsoft.com/help/4013198) installed
- Windows 10 Version 1507 with [KB 4012606](https://support.microsoft.com/help/4012606) installed
- Windows 8.1 with [KB 4102219](https://support.microsoft.com/help/4012219/march-2017-preview-of-monthly-quality-rollup-for-windows-8-1-and-windows-server-2012-r2) installed
- Windows 7 with [KB 4012218](https://support.microsoft.com/help/4012218/march-2017-preview-of-monthly-quality-rollup-for-windows-7-sp1-and-windows-server-2008-r2-sp1) installed
- Windows Server 2016 RS1 and later versions
- Windows Server 2012 R2 with [KB 4012219](https://support.microsoft.com/help/4012219/march-2017-preview-of-monthly-quality-rollup-for-windows-8-1-and-windows-server-2012-r2) installed
- Windows Server 2012 with [KB 4012220](https://support.microsoft.com/help/4012220/march-2017-preview-of-monthly-quality-rollup-for-windows-server-2012) installed
- Windows Server 2008 R2 with [KB 4012218](https://support.microsoft.com/help/4012218/march-2017-preview-of-monthly-quality-rollup-for-windows-7-sp1-and-windows-server-2008-r2-sp1) installed

## Policy and registry names

|Name|Description|
|---|---|
|Policy name|**Network access: Restrict clients allowed to make remote calls to SAM**|
|Location|**Computer Configuration**\\**Windows Settings**\\**Security Settings**\\**Local Policies**\\**Security Options**|
|Registry subkey|`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\RestrictRemoteSam`|
|Registry type|REG_SZ|
|Registry value|A string that contains the SDDL of the security descriptor to be deployed.|
  
:::image type="content" source="media/authz-fails-access-denied-error-application-access-check/network-access-restrict-clients-allowed-to-make-remote-calls-to-sam-policy.png" alt-text="Restrict clients allowed to make remote calls to SAM policy setting dialog box.":::

When you define the policy by using the Windows Server 2016 Admin Tools, the default is to allow only administrators access to this interface.

The error that's mentioned in the "Symptoms" section occurs if the following conditions are true:

- The policy is enabled on the domain controllers.
- The account for the server that is running Exchange Server is not allowed to use the interface.

## Resolution

To fix this issue, use one of the following methods.

### Method 1: Update the policy to allow access

In the group, the servers that have to access the interface are added as members.

For example, the "Exchange Servers" universal group requires this access.

If the application does not have a group that contain the required accounts, you may have to create and maintain such a group. This is the recommended solution because it provides access to a group that's specific to the task.

### Method 2: Disable the policy

Clear the **RestrictRemoteSAM** registry entry or remove the policy.

> [!Note]
> On domain controllers, you can define per-object permissions to control the visibility of the accounts. These permissions are honored by the remote SAM RPC calls. You cannot do this for the accounts of members or standalone computers.

## More Information

For more information, see the following article:  
[Network access: Restrict clients allowed to make remote calls to SAM](/windows/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls)

### Issue example in Exchange Server

Consider the following scenario:

- You're running Active Directory together with Windows Server 2008 R2 or a later version.
- You're running Microsoft Exchange 2016 or Microsoft Exchange 2013 as an email collaboration platform.

> [!Note]
> Although this example specifies Exchange Server, this issue applies similarly to other applications that use AuthZ in this manner.

In this scenario, offline address book (OAB) generation on the server that's running Exchange Server 2016 fails.

Also, you see an entry for Event 17004 (source: MSExchange Mailbox Assistants Provider) that resembles the following. This entry is logged in the Application log on the server on which the "SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}" arbitration mailbox that's used for generating the OAB is mounted.  

> Generation of OAB "\\Default Offline Address Book" failed.  
Dn: CN=Default Offline Address Book,CN=Offline Address Lists,CN=Address Lists  
Container,CN=Companyname,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=company,DC=com   ObjectGuid: 543b7f18-2750-4969-9afd-e333a0542406  
Stats:  
S:Exp=Microsoft.Exchange.Security.Authorization.AuthzException: AuthzInitializeContextFromSid failed for User SID: S-1-5-21-.... ---> System.ComponentModel.Win32Exception: Access is denied  
   --- End of inner exception stack trace ---  
   at  
Microsoft.Exchange.Security.Authorization.ClientSecurityContext.InitializeContextFromSecurityAccessToken(AuthzFlags flags)  
   at Microsoft.Exchange.Security.Authorization.ClientSecurityContext..ctor(ISecurityAccessToken securityAccessToken, AuthzFlags flags)  
   at Microsoft.Exchange.MailboxAssistants.Assistants.OABGenerator.PropertyManager..ctor(OfflineAddressBook offlineAddressBook, SecurityIdentifier userSid, String userDomain, Boolean habEnabled, Boolean ordinalSortedMultivaluedProperties, Int32 httpHomeMdbFixRate, IOABLogger logger)  
   at Microsoft.Exchange.MailboxAssistants.Assistants.OABGenerator.OABGenerator.Initialize()  
   at Microsoft.Exchange.MailboxAssistants.Assistants.OABGenerator.OABGeneratorAssistant.  BeginProcessingOAB(AssistantTaskContext assistantTaskContext)  
   at Microsoft.Exchange.MailboxAssistants.Assistants.OABGenerator.OABGeneratorAssistant.<>c__DisplayClass12.\<SafeExecuteOabTask>b__e()  
   at Microsoft.Exchange.Common.IL.ILUtil.DoTryFilterCatch(Action tryDelegate, Func\`2 filterDelegate, Action\`1 catchDelegate)  
   at Microsoft.Exchange.MailboxAssistants.Assistants.OABGenerator.OABGeneratorAssistant.SafeExecuteOabTask(OABGeneratorTaskContext context)  
   at Microsoft.Exchange.MailboxAssistants.Assistants.OABGenerator.OABGeneratorAssistant.<>c__DisplayClassc.\<ProcessAssistantStep>b__9()  
   at Microsoft.Exchange.Common.IL.ILUtil.DoTryFilterCatch(Action tryDelegate, Func\`2 filterDelegate, Action\`1 catchDelegate)  

When the offline address book is generated, Exchange verifies whether the Mailbox-Assistant is allowed to run the task. The **SystemMailbox{bb558c35-97f1-4cb9-8ff7-d53741dc928c}** system mailbox is a disabled user account in the users container of the forest root domain. Exchange uses the AuthZ engine of Windows for this task.  

When you examine the network trace of what the server that's running Exchange Server is doing, you notice a failed Kerberos S4U request that resembles the following:
> KerberosV5 10.10.10.11 16268 10.10.10.10 Kerberos(88) KRB_TGS_REQ, Realm: AND.CORP, Sname: XXXXX
>
> **PADataType PA-FOR-USER (129)** 12408 48 Int64
>
> UserRealm AND 296 56 String
>
> UserName **SM_0ddc5cc213b943a5b** 16 280 KerberosV5.PrincipalName
>
> -> _This tells you AuthZ is trying Kerberos S4U_.
>
> 2017-10-27T16:34:52.1334577 0,0041316 10772 15016 KerberosV5 10.10.10.10 Kerberos(88) 10.10.10.11 16268 KRB_ERROR, KDC_ERR_CLIENT_REVOKED: Clients credentials have been revoked, status:  
>STATUS_ACCOUNT_DISABLED
>
> -> _This is excpected as the System Mailbox account is disabled_.

AuthZ tries to recover from this failure by querying the **tokenGroupsGlobalAndUniversal** attribute of the system mailbox, and then continuing to enumerate the Domain-Local groups. The LDAP session is encrypted. Therefore, you can't see the result in a network trace.

The next step is to retrieve the Domain-Local groups. AuthZ uses SAM RPC to retrieve these group memberships. When the program connects to the domain controller, you receive a failure notice that resembles the following:  
> 12035 SAMR 10.10.10.11     6457 10.10.10.16     SMB(445) _SamrConnect5Request{ServerName=\\\\`Cont-DC1.company.com`,DesiredAccess=32,InVersion=1,InRevisionInfo=SAMPR_REVISION_INFO{V1=SAMPR_REVISION_INFO_V1{Revision=3,SupportedFeatures=0}}}  
FileId     Persistent = **0x0000002800008761**, Volatile = 0x0000002800000005  576     128  SMB2.SMB2Fileid

This fails and returns the following message:  
> 12036 MSRPCE     0     10.10.10.16     SMB(445)   10.10.10.11     6457 RpcconnFaultHdrT, Call: 0x00000002, Context:  
0x0001, Status: **ERROR_ACCESS_DENIED**, Cancels: 0x00  
SMB2 0    10.10.10.16     SMB(445)   10.10.10.11     6457 IoctlResponse, Status: Success, FileName:  
samr@# **0x0000002800008761**, CtlCode: FSCTL_PIPE_TRANSCEIVE

In the system event log of the domain controller, Event 16969 is logged, as follows:  
> Log Name:      System  
Source:        Microsoft-Windows-Directory-Services-SAM  
Event ID:      16969  
Level:         Warning  
Description:  
8 remote calls to the SAM database have been denied in the past 900 seconds throttling window.  
For more information please see [https://go.microsoft.com/fwlink/?LinkId=787651](/windows/security/threat-protection/security-policy-settings/network-access-restrict-clients-allowed-to-make-remote-sam-calls).

If you have the throttling disabled, you will see one 16965 event for each access denial incident together with the client information.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
