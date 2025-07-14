---
title: Missing an argument for parameter error
description: Describes an issue in which you receive an error message when the required argument isn't used for the Set-SPPowerPointServiceApplication command. This problem occurs in a PowerPoint Online environment.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.reviewer: alfong
appliesto: 
  - PowerPoint for the web
search.appverid: MET150
ms.date: 12/17/2023
---
# Missing an argument for parameter when you use the Set-SPPowerPointServiceApplication command

_Original KB number:_ &nbsp; 982964

## Symptoms

Consider the following scenario:

- You run a Microsoft Office Online program that installs PowerPoint Services on a server. This server is running Microsoft SharePoint Server 2010 or Microsoft SharePoint Foundation 2010.
- You start the SharePoint 2010 Management Shell on the server. To do this, click **Start**, click **All Programs**, click **Microsoft SharePoint 2010**, and then click **SharePoint 2010 Management Shell**.
- You enter a command at the console prompt that uses one of the following parameters for the `Set-SPPowerPointServiceApplication` command:

  - `DisableBinaryScan`  
  - `EnableSandboxedEditing`
  - `EnableSandboxedViewing`
  - `EnableViewing97To2003Formats`
  - `EnableViewingOpenXmlFormats`

For example, you enter the following command to enable the viewing of PowerPoint Online OpenXML-formatted documents on the server that's running PowerPoint Services:

```powershell
Get-SPPowerPointServiceApplication | Set-SPPowerPointServiceApplication -EnableViewingOpenXmlFormats
```

In this scenario, you receive an error message that resembles the following:

> Set-SPPowerPointServiceApplication : Missing an argument for parameter 'EnableViewingOpenXmlFormats'. Specify a parameter of type 'System.Boolean' and try again.  
> At line:1 char:101  
> \+ Get-SPPowerPointServiceApplication | Set-SPPowerPointServiceApplication -EnableViewingOpenXmlFormats <<<<  
> \+ CategoryInfo : InvalidArgument: (:) [Set-SPPowerPointServiceApplication], ParameterBindingException  
> \+ FullyQualifiedErrorId : MissingArgument,Microsoft.Office.Server.Powerpoint.SharePoint.PowerShell.SetSPPowerPointServiceApplication

## Cause

This issue occurs because the parameters for the `Set-SPPowerPointServiceApplication` command require a separate Boolean argument, such as **$true** or **$false**, for the value.

## Resolution

To resolve this issue, provide the required argument when you use the `Set-SPPowerPointServiceApplication` command.

For example, type the following command to enable the viewing of PowerPoint Online OpenXML-formatted documents on the server that is running PowerPoint Services:

```powershell
Get-SPPowerPointServiceApplication | Set-SPPowerPointServiceApplication -EnableViewingOpenXmlFormats:$true
```

## More information

For more information about the `Set-SPPowerPointServiceApplication` command, see [Set-SPPowerPointServiceApplication](/previous-versions/office/office-2010/ff608176(v=office.14)).
