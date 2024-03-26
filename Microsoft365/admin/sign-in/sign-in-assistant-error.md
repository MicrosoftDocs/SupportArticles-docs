---
title: Microsoft Online Services Sign In Assistant Error
description: Describes an error that occurs when you try to activate Office Professional Plus. Troubleshooting information is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 03/31/2022
---

# "Microsoft Online Services Sign In Assistant Error" when you activate Office Professional Plus

## Problem

When you try to activate Office Professional Plus on your computer, you receive the following error message:

```output
"Microsoft Online Services Sign In Assistant Error"

The Microsoft Online Services Sign In Assistant has experienced an error. The error must be resolved before your subscription for this product can be verified.

To retry subscription verification, first resolve error message 80048820 or try to manually install the Microsoft Online Services Sign In Assistant by visiting the Sign In Assistant help site and then click Retry.

Otherwise, click Cancel to verify your subscription and reinstall the Sign In Assistant at a later time.
```

## Cause

This issue occurs if one of the following conditions is true:

- An issue occurred with the Microsoft Online Services Sign-in Assistant.
- An issue occurred during the attempt to connect to services that are used by Office Professional Plus.

## Solution

To troubleshoot this issue, follow these steps:

1. Make sure that Microsoft Online Services Sign-in Assistant is installed on the computer. To do this, open Control Panel, and then in the **Add or Remove Programs** or **Programs and Features** tool, verify that Office Professional Plus is in the list of installed programs.

1. Make sure that the services that are used by Office Professional Plus are started. To do this, follow these steps:

    1. Click Start, click Run, type services.msc, and then click OK.

    2. In the list of services, verify that the Office Software Protection Platform service and the Microsoft Office 2010 Subscription Agent service are started. To do this, right-click each service (one at a time), click Properties, and then see whether the Service status is displayed as Started.

        If the service isn't started, click Start, click Automatic in the **Startup type** box, and then click OK.

1. Browse to this [website](https://login.microsoftonline.com), and then make sure that you can successfully sign in by using your user ID.

1. Browse to the [website](https://osub.microsoft.com/). You should see a "403 - Forbidden: Access Denied" error message in the web browser.

1. If the problem persists, enable tracing for Microsoft Online Services Sign-in Assistant, and then analyze the log files. For more information about how to enable tracing and troubleshoot Microsoft Online Services Sign-in Assistant issues, see the following Microsoft Knowledge Base article:

      [2433327](https://support.microsoft.com/help/2433327) How to enable and disable a trace for the Microsoft Online Services Sign-in Assistant to troubleshoot non-browser based sign-in issues.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
