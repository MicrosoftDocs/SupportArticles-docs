---
title: Regional settings are default to English
description: Fixes an issue in which the regional settings are default to English when deploying a virtual machine by using a template in Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, jeffpatt
---
# Regional settings default to English when deploying a virtual machine using a template

This article helps you fix an issue in which the regional settings are default to English when deploying a virtual machine by using a template in Virtual Machine Manager (VMM).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2709539

## Symptoms

Consider the following scenario:

- A virtual machine is configured to use regional settings other than en-US (example: ja-JP or fr-FR).
- A VM template is created from this virtual machine using System Center 2012 Virtual Machine Manager or System Center 2012 Virtual Machine Manager Service Pack 1 (SP1).

In this scenario, virtual machines that are created using this template are configured to use the en-US regional settings.

## Cause

Deploying virtual machines using this scenario will override the guest operating system language setting with en-US by default.

## Resolution 1

1. Launch the VMM console.
2. Select the **Settings** option.
3. Select PowerShell and execute the commands below on the respective template.

   ```powershell
   $template = Get-SCVMtemplate | where {$_.Name -eq "Template_Name"}  
   $settings = $template.UnattendSettings;  
   $settings.add("oobeSystem/> Microsoft-Windows-International-Core/UserLocale","cy-GB");  
   $settings.add("oobeSystem/Microsoft-Windows-International-Core/SystemLocale","cy-GB");  
   $settings.add("oobeSystem/Microsoft-Windows-International-Core/UILanguage","cy-GB");  
   $settings.add("oobeSystem/Microsoft-Windows-International-Core/InputLocale","0452:00000452");  
   Set-SCVMTemplate -VMTemplate $template -UnattendSettings $settings
   ```

> [!NOTE]
> For the steps above, the regional settings (such as cy-GB) will vary based on the language being used.

## Resolution 2

Create an unattend.xml with the specific locale settings required. Below is a sample unattand.xml file set to *en-us* but you can replace the *en-us* entries with the language code of your choice.

```xml
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <InputLocale>en-us</InputLocale>
            <SystemLocale>en-us</SystemLocale>
            <UILanguage>en-us</UILanguage>
            <UILanguageFallback>en-us</UILanguageFallback>
            <UserLocale>en-us</UserLocale>
        </component>
    </settings>
    <cpi:offlineImage cpi:source="wim:c:/install.wim#Windows Server 2012 SERVERDATACENTER" xmlns:cpi="urn:schemas-microsoft-com:cpi" />
</unattend>
```

Refer to the following sites for the regional settings that should be used for each language:

- [Language Pack Default Values](/previous-versions/windows/it-pro/windows-vista/cc766191(v=ws.10))
- [Default Input Locales](/previous-versions/windows/it-pro/windows-vista/cc766503(v=ws.10))

## More information

- [FI-B322 - Scripts used during MMS 2012 PowerShell session](/archive/blogs/hectorl/fi-b322-scripts-used-during-mms-2012-powershell-session)
