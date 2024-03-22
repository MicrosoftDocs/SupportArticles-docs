---
title: Can't import a virtual machine by using Hyper-V Manager or SCVMM on a Hyper-V server
description: Fixes an issue where you may receive a 0x80070057 error message when you import a virtual machine on a Hyper-V server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dewitth
ms.custom: sap:Virtualization and Hyper-V\Installation and configuration of Hyper-V, csstroubleshoot
---
# You cannot import a virtual machine by using Hyper-V Manager or System Center Virtual Machine Manager (SCVMM) on a Hyper-V server

This article helps fix a 0x80070057 error that occurs when you try to import a virtual machine that has been exported by using Hyper-V Manager or System Center Virtual Machine Manager (SCVMM) on a Hyper-V server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 968968

## Symptoms

When you try to import a virtual machine that has been exported by using Hyper-V Manager, you cannot import the virtual machine by using Hyper-V Manager on a different Hyper-V server. Additionally, you receive an error message that resembles the following:

> A Server error occurred while attempting to import the virtual machine. Failed to import the virtual machine from import directory **\<Directory Path>**. Error: One or more arguments are invalid (0x80070057).

When you try to use System Center Virtual Machine Manager (SCVMM) to import a virtual machine that was exported by using Hyper-V Manager, you receive the following error message:

> Error (12700) VMM cannot complete the Hyper-V operation on the **\<server FQDN>** server because of the error: Failed to import the virtual machine from import directory **\<Directory Path>**. Error: One or more arguments are invalid (0x80070057) (Unknown error (0x8005))

## Workaround

To work around this issue, follow these steps:

1. Locate the exported virtual machine folder, and then open the .exp file.
2. In the line between \<VALUE> and \</VALUE>, delete the GUID. Here is a sample that shows a code example from the .exp file and the value that you should remove:

    ```xml
    <PROPERTY NAME="ScopeOfResidence" TYPE="string">
        <VALUE>
          222dea57-bedd-465c-8fe4-54f2ad7ae699         ** => DELETE THIS GUID**
        </VALUE>
      </PROPERTY>
    ```

3. Save the changes, and then exit Notepad.
4. Import the modified virtual machine again.

If you want to resolve this issue automatically, you can run a Visual Basic script on a Hyper-V server before you import a virtual machine to the Hyper-V server:

```vb
Option Explicit

Dim WMIService
Dim VMList
Dim VM
Dim VMSystemGlobalSettingData
Dim VMManagementService
Dim Result

'Get instance of 'virtualization' WMI service on the local computer
Set WMIService = GetObject("winmgmts:\\.\root\virtualization")
  
'Get a VMManagementService object
Set VMManagementService = WMIService.ExecQuery("SELECT * FROM Msvm_VirtualSystemManagementService").ItemIndex(0)

'Get all the MSVM_ComputerSystem object
Set VMList = WMIService.ExecQuery("SELECT * FROM Msvm_ComputerSystem")

For Each VM In VMList
   if VM.Caption = "Virtual Machine" then
       Set VMSystemGlobalSettingData = (VM.Associators_("MSVM_ElementSettingData", "Msvm_VirtualSystemGlobalSettingData")).ItemIndex(0)
       VMSystemGlobalSettingData.ScopeOfResidence = ""  
       Result = VMManagementService.ModifyVirtualSystem(VM.Path_.Path, VMSystemGlobalSettingData.GetText_(1))
    end if
Next  
```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
