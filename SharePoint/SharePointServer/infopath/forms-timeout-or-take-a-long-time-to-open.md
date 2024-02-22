---
title: Forms time out or take a long time to open
description: Fixes an issue in which a form is timeout or takes a long time to open when you try to open it in InfoPath 2010 or InfoPath 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: TAPANM
appliesto: 
  - InfoPath 2010
  - InfoPath 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# Forms time out or take a long time to open in InfoPath 2010 or InfoPath 2013

_Original KB number:_ &nbsp; 2984138

## Symptoms

Assume that a Microsoft InfoPath 2010 or Microsoft InfoPath 2013 form has a data connection to a Microsoft SharePoint Server 2010 or a Microsoft SharePoint Server 2013 list. When you try to open an existing or new form, the page will time out or takes more than a few minutes to open. You may also receive the following error message:

> An unexpected error occurred.

In addition, you may also see that the CPU usage for the worker process w3wp.exe spikes gradually and remains high until you recycle the worker process.

## Cause

This problem may occur if performance optimization settings are set incorrectly or still need to be set to the original optimization settings, in order for this form to open correctly.

## Resolution

If you want to enable the original performance optimization settings for the InfoPath form, use the following PowerShell commands. Run the commands from the SharePoint 2010 Management Shell or SharePoint 2013 Management Shell on a front-end web server in the SharePoint farm.

```powershell
$f = Get-SPInfoPathFormsService
$f.Properties.Add("AllowEventPropagation", $false)
$f.Update()
```

To remove the performance optimization settings, run the following PowerShell commands:

```powershell
$f = Get-SPInfoPathFormsService
$f.Properties.Remove("AllowEventPropagation")
$f.Update()
```

## More information

For Microsoft SharePoint 2013, the performance optimization settings may need to be set on an environment that doesn't have the following hotfix or a Cumulative Update that includes this hotfix:

[An InfoPath 2010 form does not work after you upgrade to SharePoint Server 2013](https://support.microsoft.com/help/2775307)

For Microsoft SharePoint 2010, the performance optimization settings may need to be set on an environment that doesn't have the following hotfix or a Cumulative Update that includes this hotfix:

[Equations in an InfoPath 2010 form are not calculated correctly after you apply hotfix package 2687391 in SharePoint Server 2010](https://support.microsoft.com/help/2775306)
