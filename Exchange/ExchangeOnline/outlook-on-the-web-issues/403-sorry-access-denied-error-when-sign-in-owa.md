---
title: 403 Sorry Access denied if signing in to OWA
description: Describes an issue in which users receive a 403 Sorry! Access denied error if trying to sign in to Outlook Web App in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Outlook on the web / OWA
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# 403 Sorry Access denied error when a user tries to sign in to Outlook Web App in Microsoft 365

_Original KB number:_ &nbsp; 2988732

## Symptoms

When a user tries to sign in to Outlook Web App in Microsoft 365, the user receives an error message that resembles the following:

> 403  
> Sorry! Access denied :(
>
> The page may not be available or you might not have permission to open the page. Please contact your administrator for the required credentials. For new credentials to take effect, you have to close this window and log on again

## Cause

This issue may occur if the MyBaseOptions user role is not enabled in the Default Role Assignment Policy.

## Resolution

To resolve this issue, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://portal.office.com).
2. Select **Admin**, and then select **Exchange** to open the Exchange admin center.
3. Select **permissions**, and then select **user roles**.
4. Double-click **Default Role Assignment Policy**.
5. In the **Default Role Assignment Policy** window, make sure that the **MyBaseOptions** check box is selected under **Other roles**, and then select **save**.

## More information

For more info about permissions in Exchange Online, see [Permissions in Exchange Online](/exchange/permissions-exo/permissions-exo).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
