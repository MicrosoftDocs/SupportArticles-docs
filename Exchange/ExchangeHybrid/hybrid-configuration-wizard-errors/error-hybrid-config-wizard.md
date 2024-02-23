---
title: ADSTS50011 error when running HCW
description: Describes an issue in which one of the old reply URLs used has been removed from the service.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# ADSTS50011 error when running the Hybrid Configuration wizard

## Symptom

When you run the **`Hybrid Configuration wizard (HCW)`**, you receive the following error message:

`ADSTS50011: The reply URL specified in the request does not match the reply URLs configured for the application: 'a0c73c16-a7e3-4564-9a95-2bdf47383716'.`

## Cause

One of the old reply URLs used by the wizard has been removed from the service, and the version of the HCW that you're running isn't aware of that update.

## Resolution

Install the updated version of [Hybrid Configuration wizard](https://aka.ms/hybridwizard).

## More information

Hybrid Configuration Wizard, which is aware of this change, was released in September 2020.

To resolve this problem, update your HCW. If you're running **Version 16.*x*** of HCW or earlier, HCW won't update by itself. A manual uninstall and reinstall will be needed to update HCW to the latest version.

For more information, see [March 2020 significant update to Hybrid Configuration Wizard](https://techcommunity.microsoft.com/t5/exchange-team-blog/march-2020-significant-update-to-hybrid-configuration-wizard/ba-p/1238753).
