---
title: Unhandled exception when launching the console
description: provides a solution for the Microsoft.ConfigurationManagement has stopped working error that occurs when you try to launch the System Center 2012 Configuration Manager console.
ms.date: 12/05/2023
ms.reviewer: kaushika, justini
---
# Unhandled exception when launching the System Center 2012 Configuration Manager SP1 Console

This article provides a solution for the **Microsoft.ConfigurationManagement has stopped working** error that occurs when you try to launch the System Center 2012 Configuration Manager console.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2800707

## Symptoms

When you attempt to launch the System Center 2012 Configuration Manager Service Pack 1 (SP1) console on a machine that has the System Center 2012 Integration Pack for System Center 2012 Configuration Manager installed, you may see the following error:

> **Microsoft.ConfigurationManagement has stopped working**
>
> **Problem signature:**  
> Problem Event Name: CLR20r3  
> Problem Signature 01: LRE420M52QQYT0KWXNWESOVVMQF5I2RH  
> Problem Signature 02: 5.0.7804.1000  
> Problem Signature 03: 50adcdf1  
> Problem Signature 04: System  
> Problem Signature 05: 4.0.30319.17929  
> Problem Signature 06: 4ffa5c88  
> Problem Signature 07: 5b0  
> Problem Signature 08: 19  
> Problem Signature 09: N3CTRYE2KN3C34SGL4ZQYRBFTE4M13NB  
> OS Version: 6.2.9200.2.0.0.400.8  
> Locale ID: 1033  
> Additional Information 1: 5861  
> Additional Information 2: 5861822e1919d7c014bbb064c64908b2  
> Additional Information 3: dac6  
> Additional Information 4: dac6c2650fa14dd558bd9f448e23afd1
>
> Read our privacy statement online: [http://go.microsoft.com/fwlink/?linkid=190175](https://go.microsoft.com/fwlink/?linkid=190175)
>
> If the online privacy statement is not available, please read our privacy statement offline: C:\Windows\system32\en-US\erofflps.txt

## Cause

This issue is caused by the System Center 2012 Orchestrator Integration Pack for System Center 2012 Configuration Manager (7.0) registering two assemblies in the Global Assembly Cache (GAC).

- AdminUI.WqlQueryEngine.dll (5.0.0.0)
- Microsoft.ConfigurationManagement.ManagementProvider.dll (5.0.0.0)

## Resolution

To solve this issue, follow the steps below:

 1. Uninstall the System Center 2012 Integration Pack for System Center 2012 Configuration Manager from **Add/Remove Programs**.
 2. From **Add/Remove Programs**, right-click the System Center 2012 Configuration Manager Console and select **Repair**.
 3. You should now be able to successfully launch the Configuration Manager console.
 4. If desired, install the System Center 2012 SP1 Integration Pack for System Center 2012 Configuration Manager (7.1). This integration pack will not register any assemblies in the GAC.
