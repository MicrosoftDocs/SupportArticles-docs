---
title: Some cmdlets fails to run with Add-PSSnapin
description: This article discusses that you can't run script that contains Add-PSSnapin and Test-WebServicesConnectivity cmdlets in PowerShell ISE. This problem occurs after you upgrade an Exchange Server environment to Exchange Server 2010 SP3. This article provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kartik, v-six
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Service Pack 3
ms.date: 01/24/2024
---
# Some cmdlets fail in PowerShell ISE after an upgrade to Exchange Server 2010 SP3

_Original KB number:_ &nbsp; 2859999

## Symptoms

Consider the following scenario:

- You upgrade an Exchange Server Service Pack 2 (SP2) Rollup 6 environment to Exchange Server 2010 SP3.
- The Exchange Server 2010 SP3 management tools are installed on a client computer.
- You use PowerShell Integrated Scripting Environment (ISE) to open a local Windows PowerShell instance on the client computer.
- You add the Exchange snap-ins. For example, you add the following Exchange snap-in:  
  Add-PSSnapin Microsoft.exchange.powershell.e2010

In this scenario, some Exchange cmdlets no longer work. For example, the following cmdlets no longer work:

- `Test-WebServicesConnectivity -ClientAccessServer "Servername" -TrustanySSLcertificate`
- `Set-CASMailbox`

> [!NOTE]
> Other cmdlets might also not work in this scenario.

Additionally, you receive the following error message in PowerShell ISE:

```console
Add-PSSSnapin Microsoft.Exchange.Management.PowerShell.E2010
PS H:\> Test-WebServicesConnectivity -ClientAccessServer <Clinet Access Server Name>
ARNING: An unexpected error has occurred and a Watson dump is being generated: Operation is not valid due to the current state of the object.
Test-WebServicesConnectivity : Operation is not valid due to the current state of the object.
```

Also, the following error is logged in the Application log:

```console
Time : -
ID : 8
Level : Error
Source : MSExchange CmdletLogs
Machine : -
Message: (PID 12460, Thread 9) Task Test-WebServicesConnectivity throwing unhandled exception: System.InvalidOperationException: Operation is not valid due to the current state of the object.
at Microsoft.Exchange.Data.Storage.ExchangePrincipal.get_ServerFullyQualifiedDomainName()
at Microsoft.Exchange.Monitoring.TestCasConnectivity.ResetAutomatedCredentialsAndVerify(TestCasConnectivityRunInstance instance)
at Microsoft.Exchange.Monitoring.TestCasConnectivity.BuildRunInstanceForSiteMBox(String deviceId)
at Microsoft.Exchange.Monitoring.TestCasConnectivity.BuildRunInstances()
at Microsoft.Exchange.Monitoring.TestCasConnectivity.InternalProcessRecord()
at Microsoft.Exchange.Configuration.Tasks.Task.ProcessRecord().
```

## Workaround

To work around this issue, open a remote session to an Exchange server by using the following cmdlets at the beginning of the ISE script:

```powershell
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<FQDN of Exchange 2010 server>/PowerShell/ -Authentication Kerberos import-pssession $session add-pssnapin microsoft.exchange* test-webservicesconnectivity -clientaccessserver CASSERVER -trustanysslcertificate
```

## Scenarios where Exchange cmdlets can be run

- In Exchange Management Shell on an Exchange server.
- In Exchange Management Shell on a computer that has Management Tools installed.
- In PowerShell on an Exchange server after the Exchange snap-ins are loaded.
- In PowerShell ISE on an Exchange server after the Exchange snap-ins are loaded.

> [!NOTE]
> Running cmdlets in a local PowerShell instance isn't supported in Exchange Server 2010, unless this use is explicitly documented as being required in Exchange Server 2010 TechNet documentation. For more information, see [Local Runspaces are not supported in Exchange 2010](/archive/blogs/dvespa/local-runspaces-are-not-supported-in-exchange-2010).

## Scenarios where Exchange cmdlets can't be run

- From PowerShell on a computer that isn't running Exchange Server but that has the Exchange Server SP3 management tools installed.
- From PowerShell ISE on a computer that isn't running Exchange Server but that has the Exchange Server SP3 management tools installed.
