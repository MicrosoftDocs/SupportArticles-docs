---
title: Turn off diagnostic log collection in Support and Recovery Assistant
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.collection: Adm_O365
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - BCS160
  - MET150
  - MOE150
ms.assetid: 5f76de29-9ee3-47de-84ce-2d49fdc32174
description: Learn about diagnostic log collection in Support and Recovery Assistant. 
ms.date: 05/28/2025
---

# Turn off diagnostic log collection in Support and Recovery Assistant

By default, [Support and Recovery Assistant](https://diagnostics.office.com/#/Download/?env=SOC) collects diagnostic logs to help troubleshoot problems in the following scenarios. 
  
- Support and Recovery Assistant sometimes collects diagnostic logs when the tool fails to solve a user's problem.

- Support and Recovery Assistant collects diagnostic logs when a user chooses to run advanced diagnostics. Typically this happens at the request of an admin or Microsoft support engineer.
    
    :::image type="content" source="media/diagnostic-log-collection-in-support-and-recovery-assistant/support-recovery-assistant.png" alt-text="Screenshot of Microsoft Support and Recovery Assistant page.":::
 
Microsoft 365 uses diagnostic logs to improve the tool to provide better troubleshooting in the future. Microsoft support engineers can also use these logs to analyze your user's specific issue more throughly. As an admin, you can make a registry edit to prevent users from collecting diagnostic logs if your organization wants to limit data sharing.
  
> [!CAUTION]
> Registry Editor is a tool intended for advanced users. Follow the steps in this article carefully to make sure you only make changes to data collection for Support and Recovery Assistant. Before making changes to the registry, create a backup in case something goes wrong. For more information about creating a backup, see [How to back up and restore the registry in Windows](https://support.microsoft.com/en-us/kb/322756). 
  
## Option 1 - Create a new registry entry

To turn off data collection in Support and Recovery Assistant, you need to create the following registry entry. 
  
Subkey: HKEY_LOCAL_MACHINE\Software\Microsoft\Support and Recovery Assistant
  
DWORD Value: UploadDiagnosticLogsDisabled
  
Value: 1
  
For details about creating registry values, see [How to add, modify, or delete registry subkeys and values by using a .reg file](https://support.microsoft.com/kb/310516). 
  
With the registry entry in place, Support and Recovery Assistant can't collect diagnostic logs. If you want to re-enable log collection later, you can either change the value to 0 or delete the registry entry. 
  
## Option 2 - Edit an existing registry subkey

If you previously created a registry entry for Support and Recovery Assistant, you can edit the entry to turn off data collection. Use the following steps to edit an existing registry subkey to disable data collection. 
  
1. Open Registry Editor.
    
2. Go to the following registry subkey location:
    
    HKEY_LOCAL_MACHINE\Software\Microsoft\Support and Recovery Assistant
    
3. Double-click the **Reg_DWORD** named **UploadDiagnosticLogsDisabled**. (If you don't see **UploadDiagnosticLogsDisabled**, you need to add it using the instructions in Option 1 - Create a new registry entry.)
    
4. In **Value data**, type 1, and select **OK**.
    
5. Close Registry Editor.
    
After editing this registry value, users can't collect diagnostic logs.
  
## Determine if Support and Recovery Assistant is collecting data

Support and Recovery Assistant will collect log data if either of the following settings are present.
  
- The **UploadDiagnosticLogsDisabled** DWORD Value is set to anything besides **1**.
    
- The  `HKEY_LOCAL_MACHINE\Software\Microsoft\Support and Recovery Assistant` subkey is not present. 
    
## Related article

[Download Microsoft Support and Recovery Assistant](https://diagnostics.outlook.com/)
