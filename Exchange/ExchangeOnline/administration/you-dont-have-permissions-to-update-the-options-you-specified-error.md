---
title: Don't have permissions to update options specified error
description: Describes an error message that Microsoft 365 kiosk users receive when they try to create inbox rules.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Error "You don't have permissions to update the options you specified" when Microsoft 365 kiosk users create inbox rules

_Original KB number:_ &nbsp; 3187154

## Symptoms

When a Microsoft 365 kiosk user tries to create an inbox rule in Outlook on the web, the user receives the following error message:

> You don't have permissions to update the options you specified.

## Cause

This behavior is by design. Inbox rules aren't available in Microsoft 365 kiosk plans.

## Workaround

Do one of the following:

- Assign the user a license that allows creation of inbox rules. For more information, see [Exchange Online Service Description](/office365/servicedescriptions/exchange-online-service-description/exchange-online-service-description).
- Have an administrator create a transport rule for the user. For more information, see [Procedures for mail flow rules in Exchange Server](/Exchange/policy-and-compliance/mail-flow-rules/mail-flow-rule-procedures).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
