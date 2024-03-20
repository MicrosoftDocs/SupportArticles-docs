---
title: Support for VM agent extensions in Microsoft Azure
description: Discusses support policy for the VM agent for Microsoft Azure Virtual Machines and for VM agent extensions on IaaS for Microsoft Azure.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
---
# Support for VM agent extensions in Microsoft Azure

This article discusses support policy for the VM agent for Microsoft Azure Virtual Machines and for VM agent extensions on infrastructure as a service (IaaS) for Microsoft Azure.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 2965986

Microsoft Support for VM agent extensions is limited to first-party extensions that are developed and published directly by Microsoft.
Support is available to customers who purchased a valid [Azure support plan.](https://azure.microsoft.com/support/plans/)

Support for third-party VM agent extensions is provided directly by the vendor.

## Agents support matrix

|VM agent extension|Reference|Microsoft Support policy|Link for support|
|---|---|---|---|
|DSC|Azure PowerShell DSC (Desired State Configuration) extension|Supported by Microsoft| [Azure support](https://azure.microsoft.com/support/) |
|MSEnterpriseApplication|System Center Role Authoring Extension|Supported by Microsoft| [Azure support](https://azure.microsoft.com/support/) |
|BGInfo|Background Info extension|Supported by Microsoft| [Azure support](https://azure.microsoft.com/support/) |
|VMAccessagent|VM Extension to enable Remote Desktop and password reset|Supported by Microsoft| [Azure support](https://azure.microsoft.com/support/) |
|Chefclient|Chef software agent|Supported by Chef software|[https://www.chef.io/support/](https://www.chef.io/support/)|
|PuppetEnterpriseAgent|PuppetLabs agent|Supported by PuppetLabs| [https://support.puppet.com/hc/](https://support.puppet.com/hc/)|
|Symantec Endpoint Protection|Symantec antivirus|Supported by Symantec| [http://www.symantec.com/business/support/index?page=contactsupport&key=54619](http://www.symantec.com/business/support/index?page=contactsupport&key=54619) |
|Trend Micro Deep Security Agent|Trend Micro antivirus|Supported by Trend Micro| [http://www.trendmicro.com/us/business/saas/deep-security-as-a-service/index.html](http://www.trendmicro.com/us/business/saas/deep-security-as-a-service/index.html) |
  
## More information

Understanding the difference between the VM agent and VM extensions helps troubleshoot problems by isolating the location of the problem.

The VM agent lets you start, run, and monitor a VM extension that will perform specific tasks in the virtual machine (VM).

The VM agent has to be running for the agent to run extensions.

### How do I know whether the problem is with the agent or with extensions?

The VM agent consists of three services that must be running:

- RDAgent
- Windows Azure Guest Agent
- Microsoft Azure Telemetry Service

Make sure that these three services are running, and then check the extensions installation and startup.

Steps to verify the installation/startup error for the extensions:

When the agent is running, it will log a summary of extensions operations. This summary includes the following:

- Enable
- Install
- Start
- Disable

You can find the summary log at `C:\WindowsAzure\logs\WaAppAgent.log`.

To determine which extension is failing, open the log, and then look for the word "error" in the log.

An example of an error in starting the VMAccess extension is as follows:

```
[00000019] [04/08/2014 23:25:06.83] [INFO] plugin (name: Microsoft.Compute.VMAccessAgent, version: 1.0.3) enabled successfully., Code: 0
[00000028] [04/08/2014 23:25:07.80] [INFO] Successfully installed plugin Microsoft.Compute.BGInfo 1.1.
[00000028] [04/08/2014 23:25:07.80] [INFO] plugin (name: Microsoft.Compute.BGInfo, version: 1.1) enabled successfully. Code: 0
[00000003] [04/08/2014 23:27:04.11] [ERROR] Install command of Microsoft.Compute.VMAccessAgent has not exited on time! Killing it...
```

Use the table that is mentioned before to request support for the extension that is failing.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../includes/third-party-contact-disclaimer.md)]
