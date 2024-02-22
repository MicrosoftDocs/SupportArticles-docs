---
title: The length of the property is too long error
description: Describes an issue that triggers a The length of the property is too long error when you try to create a new mail contact by using the Exchange admin center in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# The length of the property is too long error when creating a new mail contact in EAC

_Original KB number:_ &nbsp; 3002659

## Symptoms

When you create a mail contact by using the Exchange admin center in Exchange Online, you receive an error message that resembles the following:

> Error  
The length of the property is too long. The maximum length is 64 and the length of the value provided is 67.

## Cause

This problem occurs if an existing contact (the `DisplayName` parameter) or an existing external contact (the `ExternalEmailAddress` parameter) has the same name that you try to use for the new mail contact.

## Resolution

Give the new contact a name that doesn't conflict with an existing mail contact or an existing external contact.

## More information

The error message that's described in the Symptoms section is not the correct error message for the scenario. This is a known issue in Microsoft 365. You receive the correct error message if you try to create a duplicate contact by using Exchange Online PowerShell.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
