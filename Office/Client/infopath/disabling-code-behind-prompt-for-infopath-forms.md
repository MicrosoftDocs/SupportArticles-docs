---
title: Disabling code-behind prompt for InfoPath forms
description: Describes how to resolve an InfoPath issue where you are prompted for confirmation before running code in a form.
author: helenclu
ms.author: luche
ms.reviewer: dmahugh
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: Admin
ms.topic: troubleshooting
appliesto: 
  - Microsoft InfoPath
ms.date: 03/31/2022
---
# Disabling code-behind prompt for InfoPath forms

## Symptoms

When a domain-trusted InfoPath form with code behind is launched, a dialog appears and prompt for confirmation before the code runs. This prompt interferes with automated solutions, such as a server-side process that prints InfoPath forms.

## Cause

The confirmation prompt for code behind was added in KB [3162075](https://support.microsoft.com/en-us/help/3162075/description-of-the-security-update-for-infopath-2013-may-8-2018) (May 2018), to address a security vulnerability.

## Resolution

A new registry key setting has been added in build 15.0.5093.1000 which allows customers to opt out of the security vulnerability prompt and revert to the old behavior, where no dialog will appear for domain-trusted InfoPath forms.

The registry key is at this location:

`HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\InfoPath\Security\AllowFormCodeExec`

When the key's value is 0 (the default value), the dialog will appear to prompt for confirmation before running code-behind InfoPath forms in domain-trusted solutions. Changing this key to a non-zero value will prevent the dialog from appearing.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
