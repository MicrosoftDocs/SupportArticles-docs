---
title: System Center 2016 Operations Manager APM Agent causing heap corruption in SharePoint
description: Provides workarounds for an issue in which heap corruption occurs in SharePoint because of System Center 2016 Operations Manager APM Agent.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Other
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# System Center 2016 Operations Manager APM Agent causing heap corruption in SharePoint  

## Symptoms  

Heap corruption occurs in the SharePoint IIS worker process (w3wp.exe) in an environment that includes System Center 2016 Operations Manager Application Performance Monitoring (APM) Agent (Microsoft Monitoring Agent version: 8.0.10918.0).

Additionally, the following information is logged in the Windows Server application log:  

```
Image path: C:\Program Files\Microsoft Monitoring Agent\Agent\APMDOTNETAgent\V8.0.10918.0\x64\MicrosoftInstrumentationEngine_x64.dllFile version: 14.0.22325.0  
Stack  
ntdll!RtlReportCriticalFailure+0x62   
ntdll!RtlpReportHeapFailure+0x26 ntdll!RtlpHeapHandleError+0x12   
ntdll!RtlpLogHeapFailure+0xa4   
ntdll!RtlFreeHeap+0x72   
ole32!CoTaskMemFree+0x36 mscorwks!DebuggerMethodInfo::SetInstrumentedILMap+0x20 mscorwks!Debugger::SetILInstrumentedCodeMap+0xa1 mscorwks!ProfToEEInterfaceImpl::SetILInstrumentedCodeMap+0x5d mscordbc!CorProfInfo::SetILInstrumentedCodeMap+0x2b MicrosoftInstrumentationEngine_x64!MicrosoftInstrumentationEngine::CMethodInfo::ApplyFinalInstrumentation+0x19c   
```

## Cause   

This is a known issue in Operations Manager 2016. This issue occurs because the APM agent is installed and uses the .NET Framework 2.0 application pool.   

## Workaround  

To work around this issue, use one of the following methods:  

- Uninstall the Operations Manager 2016 monitoring agent.  

  **Note** You have to restart the computer to completely unload all .dll files.   

- Reinstall the Operations Manager 2016 agent without APM. To do this, run the following command:

  **msiexec /i MoMAgent.msi NOAPM=1**

  **Note** The NOAPM=1 parameter causes the Operations Manager agent to install without the .NET Framework application performance monitoring. For more information, see [Install Agent Using the Command Line](/previous-versions/system-center/system-center-2012-R2/hh230736(v=sc.12)?f=255&MSPPError=-2147217396).  

## More information  

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
