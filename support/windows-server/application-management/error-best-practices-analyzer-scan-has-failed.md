---
title: Error "The Best Practices Analyzer scan has failed" when running Best Practice Analyzer
description: Provides a resolution for the error "The Best Practices Analyzer scan has failed" when running Best Practice Analyzer
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:application-compatibility-toolkit-act, csstroubleshoot
---
# Error "The Best Practices Analyzer scan has failed" when running Best Practice Analyzer 

This article provides a resolution for the error "The Best Practices Analyzer scan has failed" when running Best Practice Analyzer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2028818

## Symptoms

When you run a Best Practices Analyzer (BPA) in Windows Server 2008 R2 Server Manager, it returns the following error:  
>The Best Practices Analyzer scan has failed.  
There has been a Best Practice Analyzer engine error for Model Id: 'Microsoft/Windows/FileServices' during execution of the Model. (Inner Exception: One or more model documents are invalid: {0}Discovery exception occurred processing file '{0}'.  
Windows PowerShell updated your execution policy successfully, but the setting is overridden by a policy defined at a more specific scope.  Due to the override, your shell will retain its current effective execution policy of "RemoteSigned". Type "Get-ExecutionPolicy -List" to view your execution policy settings. For more information, please see "Get-Help Set-ExecutionPolicy.")

## Cause

The BPA error will occur if you enable the **Turn on Script Execution** policy to control PowerShell script execution and set it to **Allow only signed scripts** or **Allow local scripts and remote signed scripts**. The error will also occur if the **Turn on Script Execution** is set to **Disabled**.  

The error will not occur if the policy is set to **Allow all scripts**.

## Resolution

Remove, disable, or set to "Not Configured" the following Group Policy setting that is being applied to the server with the BPA error.  
 >**Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell**  
 **Turn on Script Execution**
  
The BPA will start working once the policy change applies. No reboot is required for the change to take effect.
