---
title: Policy to prevent saving credentials doesn't work
description: When you configure Outlook 2010 and Outlook 2013 policy setting not to save Basic Authentication credentials, the credentials dialog shows the Remember my credentials option. However, the policy does prevent saving credentials.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 116784
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Policy to prevent Outlook from saving basic authentication credentials seems not to work

## Symptoms

Consider the following scenario. You have Microsoft Outlook 2010 or Microsoft Outlook 2013 installed on Windows 7 or a later version. Your administrator used the Microsoft Office Group Policy templates to configure Outlook, and these templates are configured not to save Basic Authentication credentials. When you start Outlook, and the credentials dialog window appears, the **Remember my credentials** option is available.

## Cause

This is a limitation of how Outlook 2010 and Outlook 2013 use the credentials user interface.

## More Information

Although the **Remember my credentials** option is available, the policy setting is working correctly. If you check the **Remember my credentials** option, the credentials are not saved to the Windows Credential Manager.

### Outlook 2010

The **Prevent saving credentials for Basic Authentication** policy setting is located in the `Microsoft Outlook 2010\Account Settings\E-mail` section of the Outlook 2010 Group Policy template. If this policy is enabled, the `DisableBasicAuthSavedCreds` value is written to the following Windows registry location on the workstation:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Outlook`

### Outlook 2013

The **Prevent saving credentials for Basic Authentication** policy setting is located in the `Microsoft Outlook 2013\Account Settings\E-mail` section of the Outlook 2013 Group Policy template. If this policy is enabled, the `DisableBasicAuthSavedCreds` value is written to the following Windows registry location on the workstation:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\15.0\Outlook\RPC`
