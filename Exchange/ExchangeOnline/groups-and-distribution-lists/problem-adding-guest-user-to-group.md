---
title: Can't add a guest user to a Microsoft 365 group
description: Fixes an issue in which you receive a There was a problem adding one or more people to the group error message when you try to add a guest user to a Microsoft 365 group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kunalsh, ninob, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Problem adding one or more people to the group when you add an external contact as a guest in Microsoft 365

_Original KB number:_ &nbsp; 4054864

## Symptoms

When you try to add a guest user to a Microsoft 365 group, you receive the following error message:

> There was a problem adding one or more people to the group. For help, contact your administrator.

## Cause

This issue occurs if the guest user who is being added already exists in Microsoft Entra ID.

## Workaround 1

Delete the user object from the on-premises directory.

> [!NOTE]
> This is the preferred method.

## Workaround 2

Replace the user with a mail contact. To do this, save the user properties, delete the user object, and then create a mail contact that has the same properties.

> [!NOTE]
> When the guest is invited, a new user object is created in Microsoft Entra ID, and the object coexists together with the mail contact.

## Workaround 3

Move the user object to an organizational unit (OU) in the on-premises directory, and then exclude that OU from synchronizing through Microsoft Entra Connector.

> [!NOTE]
> This behavior deletes the user object from Microsoft Entra ID, but keeps it available in the on-premises directory. After you make these changes, the guest user can be added to group.
