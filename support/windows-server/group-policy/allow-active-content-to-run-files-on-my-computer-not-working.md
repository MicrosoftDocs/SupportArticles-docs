---
title: Can't allow active content to run files
description: Helps solve an issue where the Allow active content to run files on My Computer Group Policy setting doesn't work.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, fmu
ms.prod-support-area-path: Managing Internet Explorer settings through Group Policy
ms.technology: windows-server-group-policy  
---
# "Allow active content to run files on My Computer" Group Policy setting does not work as expected

This article provides help to solve an issue where the **Allow active content to run files on My Computer** Group Policy setting doesn't work.

_Original product version:_ &nbsp;Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;2002093

## Symptoms

If you use Windows or the Remote Server Administration Tools (RSAT) for Windows to enable he Group Policy Preference setting **Allow active content to run files on My Computer** remain disabled when the policy is applied on the client computers. If you disable the policy setting, you will find that it gets enabled on the client computers after the next Group Policy refresh.

The **Allow active content to run files on My Computer** is configured in the Group Policy Management Editor by navigating to **User Configuration\Preferences\Control Panel Settings\Internet Settings** and selecting **New**, then **Internet Explorer 7**. On the **Advanced** tab, scroll down to the **Security** section to view the **Allow active content to run files on My Computer** setting.

## Cause

To enable **Allow active content to run files on My Computer**, the following registry value must be set to **0**:  

`HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN`

Value Name:  iexplore.exe  
Value Type:  REG_DWORD  
Value Data:  0  
  
When you configure this setting, the value will be written as **"iexplore.exe"=dword:00000001** and therefore the setting will be disabled.

The wrong value is written from the Group Policy Preferences XML setting file:  

```xml
<Reg id="LocalMachineFilesUnlock" type="REG_DWORD" hive="HKEY_CURRENT_USER" key="SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" name="iexplore.exe" value="00000001"/>
```

The default location of the Group Policy Preferences XML setting file is:

%windir%\SYSVOL\sysvol\domain\Policies\\{GUID}\\<user/computer>\Preferences\InternetSettings\InternetSettings.xml

## Resolution

As a workaround you can disable the **Allow active content to run files on My Computer** policy setting and the setting will be enabled when the policy is applied to the client computers.
