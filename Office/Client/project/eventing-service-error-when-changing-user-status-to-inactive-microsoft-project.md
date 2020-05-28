---
title: Eventing service error message when changing the status of users to inactive in Microsoft Project
description: Describes how to handle an 'Eventing service' error when deactivating a user in Microsoft Project.
author: todmccoy
ms.author: v-todmc
ms.reviewer: 
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: Admin
ms.custom: CSSTroubleshoot
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal 
appliesto:
- Microsoft Project
---

# "Eventing service" error message when changing the status of users to inactive in Microsoft Project

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms
When you deactivate a user in Microsoft Project, you see the following message:

> The resource could not be saved due to the following reasons:<br />Error encountered with the eventing service. The eventing service is either not running or has not been installed. Please contact your administrator for more details.

## Cause
The user is in a disabled state in the Active Directory. 

## Resolution
To resolve this, change the status of the user account to inactive in the Project Instance using the option available in Manage Users. Then disable the account in Active Directory.