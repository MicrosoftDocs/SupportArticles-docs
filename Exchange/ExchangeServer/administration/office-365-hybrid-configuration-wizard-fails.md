---
title: Microsoft 365 Hybrid Configuration Wizard fails on Exchange Server 2016 CU7
description: Microsoft 365 Hybrid Configuration Wizard fails to run on Exchange Server 2016 CU7, reporting error-Object reference not set to an instance of an object.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nasira, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Error from Microsoft 365 Hybrid Configuration Wizard: Object not set to an instance of an object

_Original KB number:_ &nbsp;4051381

## Symptoms

When you run the Microsoft 365 Hybrid Configuration Wizard after Exchange Server 2016 Cumulative Update 7 is installed, the wizard fails to run and reports that the Set-FederatedOrganizationIdentifier cmdlet returns error "Object reference not set to an instance of an object."

This message is part of the following full error message that's written to the Hybrid Configuration Wizard log:

```console
017.10.23 11:39:51.552         10276 [Client=UX, Activity=Domain Ownership, Session=OnPremises, Cmdlet=Set-FederatedOrganizationIdentifier, Thread=9] START Set-FederatedOrganizationIdentifier -AccountNamespace 'contoso.com' -DelegationFederationTrust 'Microsoft Federation Gateway' -Enabled: $true -DefaultDomain $null
2017.10.23 11:39:57.693 *ERROR* 10277 [Client=UX, Activity=Domain Ownership, Session=OnPremises, Cmdlet=Set-FederatedOrganizationIdentifier, Thread=9] FINISH Time=6140.9ms Results=PowerShell failed to invoke 'Set-FederatedOrganizationIdentifier': Object reference not set to an instance of an object. An unexpected error has occurred and a Watson dump is being generated: Object reference not set to an instance of an object.
2017.10.23 11:39:57.756 *ERROR* 10224 [Client=UX, Page=DomainProof, Thread=9] Microsoft.Online.CSE.Hybrid.PowerShell.PowerShellInvokeException: PowerShell failed to invoke 'Set-FederatedOrganizationIdentifier': Object reference not set to an instance of an object. An unexpected error has occurred and a Watson dump is being generated: Object reference not set to an instance of an object. ---> System.Management.Automation.RemoteException: Object reference not set to an instance of an object.
                                   at System.Management.Automation.Runspaces.AsyncResult.EndInvoke()
                                   at System.Management.Automation.PowerShell.EndInvoke(IAsyncResult asyncResult)
                                   at Microsoft.Online.CSE.Hybrid.Provider.PowerShell.PowerShellProvider.PowerShellInstance.Invoke(String cmdlet, IReadOnlyDictionary`2 parameters, Int32 millisecondsTimeout)
                                   --- End of inner exception stack trace ---
                                   at Microsoft.Online.CSE.Hybrid.PowerShell.RemotePowershellSession.RunCommandInternal(Cmdlet cmdlet, SessionParameters parameters, Int32 millisecondsTimeout, PowerShellRetrySettings retrySettings, Boolean skipCmdletLogging)
                                   at Microsoft.Online.CSE.Hybrid.Session.PowerShellOnPremisesSession.SetFederatedOrganizationIdentifier(SmtpDomain accountNamespace, String delegationTrustLink, SmtpDomain defaultDomain)
                                   at Microsoft.Online.CSE.Hybrid.App.ViewModel.Pages.DomainProof.DomainInfo.AddFederatedDomain(IOnPremisesSession session, AppData appData)
                                   at System.Collections.Generic.List`1.ForEach(Action`1 action)
                                   at Microsoft.Online.CSE.Hybrid.App.ViewModel.Pages.DomainProof.VerifyActivity(IOnPremisesSession session, EnvironmentBase environment)
```

You may experience the following similar error if you run the cmdlet directly from the Exchange Management Shell:

```console
[PS] C:\>Set-FederatedOrganizationIdentifier -AccountNamespace 'contoso.com' -DelegationFederationTrust 'Microsoft Federation Gateway' -Enabled: $true -DefaultDomain $null

WARNING: An unexpected error has occurred and a Watson dump is being generated: Object reference not set to an instance
of an object.
Object reference not set to an instance of an object.
    + CategoryInfo          : NotSpecified: (:) [Set-FederatedOrganizationIdentifier], NullReferenceException
    + FullyQualifiedErrorId : System.NullReferenceException,Microsoft.Exchange.Management.SystemConfigurationTasks.Set
   FederatedOrganizationIdentifier
    + PSComputerName        : server.contoso.com
```

## Workaround 1

Use this method if you have a second Exchange Server in your domain that's running Exchange Server 2010, Exchange Server 2013, or Exchange Server 2016 Cumulative Update 6 or earlier.

1. Connect Exchange Management Shell to the second Exchange Server and run the following cmdlet:

    ```powershell
    Set-FederatedOrganizationIdentifier -AccountNamespace '<AccountNameSpace>' -DelegationFederationTrust 'Microsoft Federation Gateway' -Enabled: $true -DefaultDomain $null
    ```

1. After the cmdlet is completed successfully, run the Microsoft 365 Hybrid Configuration Wizard on Exchange Server 2016 Cumulative Update 7.

## Workaround 2

[Contact Microsoft Support](https://support.microsoft.com/contactus/?ws=support) to request a copy of the interim update that contains the fix to this issue. The fix will be included in the Exchange Server 2016 Cumulative Update 8.

## Status

Microsoft has confirmed that this is a known issue in Exchange Server 2016 Cumulative Update 7.
