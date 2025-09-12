---
title: Can't run Hybrid Configuration wizard with an exception error
description: Fixes an issue that occurs when you run the Hybrid Configuration wizard from a server on which the Client Access server role isn't installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Execution of the Set-WebServicesVirtualDirectory cmdlet had thrown an exception when running the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 2821213

## Problem

When you try to run the Hybrid Configuration wizard, you receive one of the following error messages:

> Execution of the Set-WebServicesVirtualDirectory cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.  
> Unable to cast COM object of type 'System.__ComObject' to interface type 'System.Web.Configuration.IRemoteWebConfigurationHostServer'. This operation failed because the QueryInterface call on the COM component for the interface with IID '{*IID*}' failed due to the following error: Interface not registered (Exception from HRESULT: 0x80040155).  
> at System.Management.Automation.PowerShell.CoreInvoke[TOutput](IEnumerable input, PSDataCollection\`1 output, PSInvocationSettings settings)  
> at System.Management.Automation.PowerShell.Invoke(IEnumerable input, PSInvocationSettings settings)  
> at System.Management.Automation.PowerShell.Invoke()  
> at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, Dictionary`2 parameters, Boolean ignoreNotFoundErrors)a  
> '.  
> Additional troubleshooting information is available in the Update-HybridConfiguration log file located at D:\Program Files\Microsoft\Exchange Server\V14\Logging\Update-HybridConfiguration\HybridConfiguration_10_22_2012_17_3_38_634865222180903876.log.

> ERROR:Updating hybrid configuration failed with error 'Subtask Configure execution failed: Configuring organization relationship settings.  
>
> Execution of the Set-WebServicesVirtualDirectory cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
Unable to access the configuration system on the remote server. Make sure that the remote server allows remote configuration.

## Cause

This issue occurs if you run the Hybrid Configuration wizard from a server that doesn't have a Client Access server (CAS) role installed.

## Solution

To resolve this issue, run the Hybrid Configuration wizard from a server that has the CAS role installed.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
