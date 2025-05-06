---
title: Application event log entries for Outlook add-in load time
description: Introduces the Application event log entries for Outlook add-in load time.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Add-in error
  - CSSTroubleshoot
appliesto:
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.reviewer: gbratton
author: cloud-writer
ms.author: meerak
ms.date: 03/25/2025
---

# Application event log entries for Outlook add-in load time

By default, Microsoft Outlook writes the name of each connected add-in to the Windows Application Log in the Event Viewer when the add-in gets loaded by Outlook. The Application event log entry includes a **Boot Time** value for each add-in, indicating the amount of time it took for the add-in to be loaded. This makes it easy to find out exactly what add-ins are loaded by Outlook, and how long they took to load. This can help you identify add-ins that cause long startup times for Outlook.

For details on how to manage add-ins in Office programs, see [View, manage, and install add-ins in Office programs](https://support.microsoft.com/office/view-manage-and-install-add-ins-in-office-programs-16278816-1948-4028-91e5-76dca5380f8d).

For more information, see [Add-in entries in the Application event log](#add-in-entries-in-the-application-event-log).

## Add-in entries in the Application event log

When you start Outlook, an Application event log entry (Event ID 45) is written with all of the add-ins that are being loaded in the session. The following is an example event in the Application event log, listing some of the add-ins loaded during Outlook startup and the relevant information about each add-in.

```output
Log Name: Application
Source: Outlook
Date: 1/7/2021 1:30:17 PM
Event ID: 45
Task Category: None
Level: Information
Keywords: Classic
User: N/A
Computer: client1.corp.wingtiptoys.com
Description:
Outlook loaded the following add-in(s):

Name: Microsoft Exchange Add-in
Description: Exchange support for Unified Messaging, e-mail permission rules, and calendar availability.
ProgID: UmOutlookAddin.FormRegionAddin
GUID: {F959DBBB-3867-41F2-8E5F-3B8BEFAA81B3}
Load Behavior: 03
HKLM: 1
Location: C:\Program Files\Microsoft Office\Office14\ADDINS\UmOutlookAddin.dll
Boot Time (Milliseconds): 16

Name: Microsoft Outlook Social Connector
Description: Connects to social networking sites and provides people, activity, and status information.
ProgID: OscAddin.Connect
GUID: {2163EB1F-3FD9-4212-A41F-81D1F933597F}
Load Behavior: 03
HKLM: 1
Location: C:\Program Files\Microsoft Office\Office14\SOCIALCONNECTOR.DLL
Boot Time (Milliseconds): 15 

Name: Microsoft Office Communicator 2007 Add-in
Description: Outlook 12 add-in to support Communicator custom forms
ProgID: OcOffice.OcForms
GUID: {2CD5239C-7739-42F1-9C94-2A8E24A9BBD9}
Load Behavior: 03
HKLM: 0
Location: C:\Program Files\Microsoft Office Communicator\ocoffice.dll
Boot Time (Milliseconds): 0 
```

Any add-ins that load after Outlook starts also get an event added to the log. So, if you start Outlook, do some work in it, and then select a feature that starts its own add-in, your Application event log would have one entry with all of the add-ins that loaded when you started Outlook, and another entry with the add-in that loaded after you clicked its associated feature.

The following example event log entry shows the loading of the Microsoft VBA for Outlook add-in that loaded only after starting the Visual Basic Editor. This event log entry occurred about two minutes after the start of Outlook (compare the Date and Time in the preceding event log entry for Outlook startup).

```output
Source: Outlook
Date: 1/7/2021 1:32:24 PM
Event ID: 45
Task Category: None
Level: Information
Keywords: Classic
User: N/A
Computer: client1.corp.wingtiptoys.com
Description:
Outlook loaded the following add-in(s):

Name: Microsoft VBA for Outlook Addin
Description:
ProgID: Microsoft.VbaAddinForOutlook.1
GUID: {799ED9EA-FB5E-11D1-B7D6-00C04FC2AAE2}
Load Behavior: 09
HKLM: 1
Location: C:\PROGRA~1\MICROS~3\Office14\ADDINS\OUTLVBA.DLL
Boot Time (Milliseconds): 78
```

Outlook Group Policy templates include a policy setting to control the generation of the Application event log entries for add-in startup. Expand the **Miscellaneous** node in the policy tree to locate the **Disable Windows event logging for Outlook add-ins** policy setting. When you use this policy, the following registry data is applied to Outlook clients to control this feature.

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Options\Logging`  
DWORD: **DisableAddinLogging**  
Values: 0 (or missing DWORD) = Logging is enabled. 1 = Logging is disabled.

> [!NOTE]
> _x.0_ in the registry key path represents the version of Outlook (16.0 = Outlook 2016, Outlook 2019, Outlook 2021, Outlook for Microsoft 365).
>
> The **DisableAddinLogging** registry value only functions under the `\Policies` path. If you push out this setting (for example, using a logon script) and the **DisableAddinLogging** value isn't under the \Policies hive, Outlook will continue to log add-in loading information in the Application event log.
