---
title: The term Get-VM is not recognized during install of Cloud Connector Edition
description: Describes an error that occurs when you run the cmdlet Install-CcInstance during installation of Cloud Connector Edition. Describes how to resolve the problem.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Cloud Connector Edition
ms.date: 03/31/2022
---

# "The term 'Get-VM' is not recognized as the name of a cmdlet ..." error during install of Cloud Connector Edition

## Symptoms

During a new installation of Cloud Connector Edition, running the cmdlet Install-CcInstance fails, and you receive with the following error message:

```AsciiDoc
Get-VM : The term 'Get-VM' is not recognized as the name of a cmdlet, function, script file, or operable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
At C:\Program Files\WindowsPowerShell\Modules\CloudConnector\Internal\MtCommon.ps1:1824 char:9
+         Get-VM | ForEach-Object {
+         ~~~~~~
    + CategoryInfo          : ObjectNotFound: (Get-VM:String) [], ParentContainsErrorRecordException
 + FullyQualifiedErrorId : CommandNotFoundException
```

## Cause

The Hyper-V Module for Windows PowerShell is not installed.

## Resolution

If you upgraded Windows Server Host from a prior version to 2012 R2 or you removed this Hyper-V feature, you need to install the Hyper-V Module for Windows PowerShell in the Hyper-V Management Tools, under "Features."

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
