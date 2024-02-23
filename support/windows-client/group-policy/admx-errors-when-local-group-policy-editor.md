---
title: .admx errors when running Local Group Policy Editor (gpedit.msc)
description: Describes an issue that occurs after you change the system language
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# .admx errors when running Local Group Policy Editor (gpedit.msc)  

This article provides a workaround for .admx errors when running Local Group Policy Editor (gpedit.msc).  

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 3049255

## Symptoms  

This issue occurs when the following conditions are true:

- You install an additional language pack on a computer.
- You set both the Override for Windows display language and Override for default input method options for the new language under the Advanced settings of the Language in Control Panel.
- You change the system language.

For example, you receive the following error messages when you change to the Japanese language on the computer:

|Error files|Text of the errors in Japanese|Screenshot of the errors|
|---|---|---|
|InetRes.admx|管理用テンプレート<br/><br/>リソース '$(string.Advanced_EnableSSL3Fallback)' (属性 displayName で参照) が見つかりませんでした。ファイル C:\Windows\PolicyDefinitions\inetres.admx、行 795、列 308<br/><br/>|:::image type="content" source="media/admx-errors-when-local-group-policy-editor/inetres-admx.png" alt-text="The details of the Inetres.admx error in Japanese." border="false":::<br/>|
|Pinting.admx|管理用テンプレート<br/><br/>リソース '$(string.ShowJobTitleInEventLogs)' (属性 displayName で参照) が見つかりませんでした。ファイル C:\Windows\PolicyDefinitions\Printing.admx、行 721、列 7<br/><br/>|:::image type="content" source="media/admx-errors-when-local-group-policy-editor/pinting-admx.png" alt-text="The details of the Printing.admx error in Japanese." border="false":::<br/>|
  
## Cause

This issue occurs because several system core files have to be updated when they are related to the newly installed language.

## Workaround

To work around the issue, reinstall the following update, depending on the error that you receive:
  
- When you receive the Inetres.admx error, reinstall the update 3021952 that is described in [Description of the security update for Internet Explorer: February 10, 2015 (MS15-009)](https://support.microsoft.com/help/3021952).
- When you receive the Printing.admx error, reinstall the update 2934018 that is one of the updates available in [Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 update: April 2014 (2919355)](https://support.microsoft.com/help/2919355).

>[!NOTE]  
>
> - When you install this update (2919355) from Windows Update, updates 2932046, 2937592, 2938439, 2934018, and 2959977 are included in the installation.
> - We recommend that you download and install any needed language pack before you install updates.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
