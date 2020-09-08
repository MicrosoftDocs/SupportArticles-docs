---
title: Can't allow active content to run files
description: Helps solve an issue where the Allow active content to run files on My Computer Group Policy setting doesn't work.
ms.date: 09/08/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Managing Internet Explorer settings through Group Policy
ms.technology: GroupPolicy  
---
# "Allow active content to run files on My Computer" Group Policy Setting Does Not Work as Expected on Windows Server 2008 or Windows Vista RSAT

This article provides help to solve an issue where the **Allow active content to run files on My Computer** Group Policy setting doesn't work.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2002093

## Symptoms

If you use Windows Server 2008 or the Remote Server Administration Tools (RSAT) for Windows Vista to enable the Group Policy Preference setting **Allow active content to run files on My Computer**, the setting will remain disabled when the policy is applied on the client computers. If you disable the policy setting, you will find that it gets enabled on the client computers after the next Group Policy refresh.

The **Allow active content to run files on My Computer** is configured in the Group Policy Management Editor by navigating to **User Configuration\Preferences\Control Panel Settings\Internet Settings** and selecting **New**, then **Internet Explorer 7**. On the **Advanced** tab, scroll down to the **Security** section to view the **Allow active content to run files on My Computer** setting.

## Cause

To enable **Allow active content to run files on My Computer**, the following registry value must be set to **0:**  

HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN

Value Name:  iexplore.exe
Value Type:  REG_DWORD
Value Data:  0
  
When you configure this setting in Windows Server 2008 or Windows Vista RSAT the value will be written as **"iexplore.exe"=dword:00000001** and therefore the setting will be disabled.

The wrong value is written from the Group Policy Preferences XML setting file:

\<Reg id="LocalMachineFilesUnlock" type="REG_DWORD" hive="HKEY_CURRENT_USER" key="SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" name="iexplore.exe" value="00000001"/>
 
The default location of the Group Policy Preferences XML setting file is:

`%windir%\SYSVOL\sysvol\domain\Policies\{GUID}\<user/computer>\Preferences\InternetSettings\InternetSettings.xml`

## Resolution

Modify the setting using Windows Server 2008 R2 or Windows 7 RSAT. The issue only exists when modifying the setting from Windows Server 2008 or Windows Vista RSAT.

As a workaround you can disable the **Allow active content to run files on My Computer** policy setting and the setting will be enabled when the policy is applied to the client computers.
For more information about Remote Server Administration Tools for Windows 7, visit the following Microsoft Web site:
 [https://www.microsoft.com/download/details.aspx?FamilyID=7d2f6ad7-656b-4313-a005-4e344e43997d](https://www.microsoft.com/download/details.aspx?FamilyID=7d2f6ad7-656b-4313-a005-4e344e43997d)
