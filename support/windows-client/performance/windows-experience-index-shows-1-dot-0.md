---
title: Windows Experience Index shows 1.0 for graphics subscore
description: Provides a solution to an issue where WinSAT fails to generate the correct Windows Experience Index score when you build an image for Windows 7 deployment.
ms.date: 09/16/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, jushua
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
ms.subservice: performance
---
# Windows Experience Index shows "1.0" for graphics subscore

This article provides a solution to an issue where WinSAT fails to generate the correct Windows Experience Index score when you build an image for Windows 7 deployment.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2716476

## Symptoms

Consider the following scenario:

- You're building an image for Windows 7 deployment. All supplemental components are also installed.
- You run the WinSAT prepop command to generate a Windows Experience Index score.
- You run sysprep to seal the image for deployment.

After the Out of Box Experience (OOBE) phase, you may find the Windows Experience Index score is "1.0", and you also find the Graphics Subscore is "1.0".

If you go to C:\\Windows\\Performance\\WinSAT\\DataStore folder and check the file named DWM.Assessment (Prepop).WinSAT.xml, you may find the following sentence logged into the file:

```xml
<LimitsApplied>
    <GraphicsScore>
        <LimitApplied Friendly="Limiting DWM Score to 1.0 - no DWM performance score">NoScore</LimitApplied>
    </GraphicsScore>
</LimitsApplied>
```

## Cause

Windows 7 introduced the Diagnostics Performance kernel component (PerfTrack), which wasn't included in earlier versions of Windows. Due to some timing factors, PerfTrack may occasionally stop the Circular Kernel Context Logger (CKCL) while WinSAT is using it for a performance assessment. If this happens, WinSAT will fail to generate the correct score and will return a score of 1.0 for the assessment.

## Resolution

If you rerun the Windows Assessment (WinSAT), the graphics score should be calculated correctly.

If you are a system builder or OEM and you frequently encounter this issue, consider the following steps to work around the problem:

1. Add the following commands to a batch file and run the batch in WinPE against the image:

    ```console
    reg load HKLM\TempHiv %WinDRV%\Windows\system32\config\system
    reg add HKLM\TempHiv\ControlSet001\Control\Diagnostics\Performance /v DisableDiagnosticTracing /t REG_DWORD /d 1 /f
    reg unload HKLM\TempHiv
    ```

2. Reboot, then run WINSAT prepop.
3. Run sysprep tool.
4. Restart the system in WinPE and then run the following commands:

    ```console
    reg load HKLM\TempHiv %WinDRV%\Windows\system32\config\system
    reg add HKLM\TempHiv\ControlSet001\Control\Diagnostics\Performance /v DisableDiagnosticTracing /t REG_DWORD /d 0/f
    reg unload HKLM\TempHiv
    ```

## More information

[Configure Windows System Assessment Tests Scores](/previous-versions/windows/it-pro/windows-7/dd744241(v=ws.10))
