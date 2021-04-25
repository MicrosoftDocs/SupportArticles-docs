---
title: ADSTS50011 error when running the Hybrid Configuration Wizard
description: Describes an issue in which one of the old reply URLs used by the wizard has been removed from the service.
author: Norman-sun
ms.author: ninob
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: ninob
appliesto:
- Exchange Online
search.appverid: MET150
---

# ADSTS50011 error when running the Hybrid Configuration Wizard

## Symptom

When you run the **Hybrid Configuration Wizard (HCW)**, you receive the following error message:

`ADSTS50011: The reply URL specified in the request does not match the reply URLs configured for the application: 'a0c73c16-a7e3-4564-9a95-2bdf47383716'.`

## Cause

One of the old reply URLs used by the wizard has been removed from the service, and the version of the HCW that you are running isn't aware of that update.

## Resolution

Please install the updated version of [Hybrid Configuration Wizard](https://aka.ms/hybridwizard).

## More information

Hybrid Configuration Wizard, which is aware of this change, was released in September 2020.

To resolve this problem, update your HCW. If you are running **Version 16.*x*** of HCW or earlier, HCW will not update by itself, and a manual uninstall and reinstall will be needed to update HCW to the latest version.

See [March 2020 significant update to Hybrid Configuration Wizard](https://techcommunity.microsoft.com/t5/exchange-team-blog/march-2020-significant-update-to-hybrid-configuration-wizard/ba-p/1238753) for more information.
