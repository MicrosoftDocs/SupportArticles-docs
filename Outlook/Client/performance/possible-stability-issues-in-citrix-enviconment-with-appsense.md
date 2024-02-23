---
title: Stability issues in Citrix environment with AppSense
description: Provides a resolution if you are experiencing one or more of the issues that are described in the Symptoms section of this article in a Citrix environment with AppSense software installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Possible Outlook stability issues in a Citrix environment with specific versions of AppSense software installed

_Original KB number:_ &nbsp; 2899877

## Symptoms

When using Microsoft Outlook in a Citrix environment with specific versions of AppSense software installed, some issues related to program stability have been seen by Microsoft support teams. This includes, but is not limited to, the following symptoms:

- Outlook crashes while printing
- High CPU
- Email messages remaining (stuck) in the Outbox folder
- Outlook stops responding (hang)
- Poor performance

> [!NOTE]
> The use of Outlook in a Citrix environment with AppSense software does not necessarily mean you will see these symptoms, even if you have the versions specified below under Cause. And, there are definitely other causes for these symptoms. This article is merely intended to help you identify possible causes of these symptoms when using Outlook.

## Cause

The symptoms listed above have been seen with the following versions of AppSense files.

| File| File version| Environment Manager (EM) version |
|---|---|---|
|Pvc.dll|8.2.125.0|8.2.125.0|
|LockDownMgr.dll|8.1.591.0|8.1.591.0|

## Resolution

If you are experiencing one or more of the above symptoms in a Citrix environment with AppSense software installed, we recommend you first review the version of the AppSense Environment Manager you have installed.

| File| File Version| Environment Manager (EM) version| Fixed EM version |
|---|---|---|---|
|Pvc.dll|8.2.125.0|8.2.125.0|8.4.309.0|
|LockDownMgr.dll|8.1.591.0|8.1.591.0|8.2.206.0|

If your version is lower than the version listed under Fixed EM version in the above table, see [AppSense Web site](https://www.citrix.com/) (registration required) to install the latest available version of the AppSense Environment Manager.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
