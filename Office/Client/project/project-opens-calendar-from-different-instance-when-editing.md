---
title: Microsoft Project opens a calendar from a different instance when editing
description: "Describes what to do if Microsoft Project opens a calendar from a PWA instance other than the one currently being edited."
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
ms.date: 2/5/2019
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: luche
appliesto:
- Microsoft Project
---

# Microsoft Project opens a calendar from a different instance when editing

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms
When you open a calendar created from a Project Work App (PWA) instance in a Microsoft Project client, a calendar from a different PWA instance opens instead.

## Cause
Project client uses a site ID when opening a calendar. If both instances of the PWA are created from the same site collection, then the site ID will be same for both instances of the PWA.

> [!Note] 
> This can happen when the production content database uses the same database to provision PWA in a test or QA environment.

## Resolution
To resolve this issue, designate one account in the Project client as the default account by using the following steps:
1.    Select **Info**, select **Manage Accounts**, then select **Configure Accounts**.
![In the Accounts screen, select one to be the default.](media/project-opens-calendar-from-different-instance-when-editing/95806-1.png)
2.    Select an account and click **Set as Default**.
 
3.    Select **OK**.

>    [!Note] To edit the calendar of a production environment PWA, select the Production account and then select **OK**.

4.    Close the Project client and open the calendar again.

## More information
### How to check the Site ID
To check the Site ID, access the following registry location in the local machine (the profile name will be the name of the profile created to connect to the PWA instance):

```text
HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\MS Project\Profiles\<Profile Name>
```

![To check the site ID, check the profile name in the registry. ](media/project-opens-calendar-from-different-instance-when-editing/95806-2.png)