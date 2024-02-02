---
title: Event ID 10016 is logged in Windows
description: Describes an issue in which DCOM event ID 10016 is logged in Windows. Provides a resolution.
ms.date: 11/30/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: high
ms.reviewer: kaushika, hikono
ms.custom: sap:dcom-service-startup-and-permissions, csstroubleshoot
ms.subservice: application-compatibility
adobe-target: true
---
# DCOM event ID 10016 is logged in Windows

This article provides a workaround to solve the event 10016 that's logged in Windows when accessing DCOM components.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4022522

## Symptoms

On a computer that's running Windows 10, Windows Server 2019, or Windows Server 2016, the following event is logged in the system event logs.

```output
Source:        Microsoft-Windows-DistributedCOM  
Event ID:      10016  
Description: The application-specific permission settings do not grant Local Activation permission for the COM Server application with CLSID  
{D63B10C5-BB46-4990-A94F-E40B9D520160}  
and APPID  
{9CA88EE3-ACB7-47C8-AFC4-AB702511C276}  
to the user NT AUTHORITY\SYSTEM SID (S-1-5-18) from address LocalHost (using LRPC) running in the application container Unavailable SID (Unavailable). This security permission can be modified using the Component Services administrative tool.d

Source:        Microsoft-Windows-DistributedCOM  
Event ID:      10016  
Description: The application-specific permission settings do not grant Local Activation permission for the COM Server application with CLSID  
{260EB9DE-5CBE-4BFF-A99A-3710AF55BF1E}  
and APPID  
{260EB9DE-5CBE-4BFF-A99A-3710AF55BF1E}  
to the user machine\user SID (S-1-5-21-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxx) from address LocalHost (using LRPC) running in the application container Microsoft.Windows.ShellExperienceHost_10.0.14393.726_neutral_neutral_cw5n1h2txyewy SID (S-1-15-2-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx). This security permission can be modified using the Component Services administrative tool.

Source:        Microsoft-Windows-DistributedCOM  
Event ID:      10016  
Description: The machine-default permission settings do not grant Local Activation permission for the COM Server application with CLSID  
{C2F03A33-21F5-47FA-B4BB-156362A2F239}  
and APPID  
{316CDED5-E4AE-4B15-9113-7055D84DCC97}  
to the user NT AUTHORITY\LOCAL SERVICE SID (S-1-5-19) from address LocalHost (using LRPC) running in the application container Unavailable SID (Unavailable). This security permission can be modified using the Component Services administrative tool.

Source:        Microsoft-Windows-DistributedCOM  
Event ID:      10016  
Description: The application-specific permission settings do not grant Local Activation permission for the COM Server application with CLSID  
{6B3B8D23-FA8D-40B9-8DBD-B950333E2C52}  
and APPID  
{4839DDB7-58C2-48F5-8283-E1D1807D0D7D}  
to the user NT AUTHORITY\LOCAL SERVICE SID (S-1-5-19) from address LocalHost (using LRPC) running in the application container Unavailable SID (Unavailable). This security permission can be modified using the Component Services administrative tool.
```

## Cause

These 10016 events are recorded when Microsoft components try to access DCOM components without the required permissions. In this case, this behavior is expected and by design.

A coding pattern has been implemented where the code first tries to access the DCOM components with one set of parameters. If the first attempt is unsuccessful, it tries again with another set of parameters. The reason why it doesn't skip the first attempt is because there are scenarios where it can succeed. In those scenarios, it's preferable.

## Workaround

These events can be safely ignored because they don't adversely affect functionality and are by design. It's the recommend action for these events.

If desired, advanced users and IT professionals can suppress these events from view in the Event Viewer. To do it, create a filter and manually edit the filter's XML query similar to the following one:

```xml
<QueryList>
  <Query Id="0" Path="System">
    <Select Path="System">*</Select>
    <Suppress Path="System">
      *[System[(EventID=10016)]]
      and
      *[EventData[
        (
          Data[@Name='param4'] and Data='{D63B10C5-BB46-4990-A94F-E40B9D520160}' and
          Data[@Name='param5'] and Data='{9CA88EE3-ACB7-47C8-AFC4-AB702511C276}' and
          Data[@Name='param8'] and Data='S-1-5-18'
        )
        or
        ( Data[@Name='param4'] and Data='{260EB9DE-5CBE-4BFF-A99A-3710AF55BF1E}' and
          Data[@Name='param5'] and Data='{260EB9DE-5CBE-4BFF-A99A-3710AF55BF1E}'
        )
        or
        (
          Data[@Name='param4'] and Data='{C2F03A33-21F5-47FA-B4BB-156362A2F239}' and
          Data[@Name='param5'] and Data='{316CDED5-E4AE-4B15-9113-7055D84DCC97}' and
          Data[@Name='param8'] and Data='S-1-5-19'
        )
        or
        (
          Data[@Name='param4'] and Data='{6B3B8D23-FA8D-40B9-8DBD-B950333E2C52}' and
          Data[@Name='param5'] and Data='{4839DDB7-58C2-48F5-8283-E1D1807D0D7D}' and
          Data[@Name='param8'] and Data='S-1-5-19'
        )
      ]]
    </Suppress>
  </Query>
</QueryList>
```

In this query:

- **param4** corresponds to the COM Server application CLSID.
- **param5** corresponds to the APPID.
- **param8** corresponds to the security context SID.

All of them are recorded in the 10016 event logs.

For more information about manually constructing Event Viewer queries, see [Consuming Events](/windows/win32/wes/consuming-events).

You can also work around this issue by modifying the permissions on DCOM components to prevent this error from being logged. However, we don't recommend this method because:

- These errors don't adversely affect functionality
- Modifying the permissions can have unintended side effects.
