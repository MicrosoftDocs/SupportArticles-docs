---
title: (Specified RunAs account is invalid) error when configuring workflow manager
description: Describes an issue in which the service account does not work with another domain\user except the administrator user in Workflow Manager 1.0.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - Workflow Manager 1.0
ms.reviewer: valerieg, christys
ms.date: 12/17/2023
---
# (Specified RunAs account is invalid) error when you configure Workflow Manager 1.0

_Original KB number:_ &nbsp; 3026799

## Symptoms

Assume that you have installed Workflow Manager 1.0 as a part of a SharePoint Server 2013 build on a non-SharePoint server. Then, you configure a new Workflow farm in Workflow Manager 1.0. The validated service account that is provided in the Configure Service Account  section works effectively with the Active Directory administrator user. However, it does not work with the other domain\user. Additionally, you receive the following error message:

> Specified RunAs account is invalid.

> [!NOTE]
> This issue occurs because of a permissions problem.

## Resolution

The setup account or service account has read permissions in Active Directory to view a User object. However, the account does not have read permissions for CN=Computers. Read permissions are required for CN=Computers to install Workflow Manager and Service Bus. Currently, there are no workarounds for this issue.
