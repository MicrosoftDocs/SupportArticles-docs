---
title: "'Eventing service' error message when changing the status of users to inactive in Microsoft Project '"
ms.author: v-todmc
author: v-todmc
manager: joselr
ms.date: 2/25/2019
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---
# “Eventing service” error message when changing the status of users to inactive in Microsoft Project 

## Symptoms
The following error message is received when deactivating users in Microsoft Project:

> [!Error]
> The resource could not be saved due to the following reasons:

> Error encountered with the eventing service. The eventing service is either not running or has not been installed. Please contact your administrator for more details

## Resolution
To resolve this, go to Manage Users in the instance of Project and change the status of the user account to **Inactive**. Then disable the account in Active Directory.

## More information