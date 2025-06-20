---
title: Public folder permissions for Exchange Server
description: This article describes the permissions that can be granted to a public folder in Microsoft Exchange Server. It is especially applicable in a dedicated deployment of the Microsoft Business Productivity Online Suite.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Collaboration and Public Folders\Issues with Public Folder Migration
  - CSSTroubleshoot
appliesto: 
- Exchange Server
search.appverid: MET150
ms.reviewer: kellybos, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# Public folder permissions for Exchange Server

This article describes the permissions that can be granted to a public folder in Microsoft Exchange Server.

## Client permissions

Many permissions can be granted to a public folder. The following list describes client permissions:

- ReadItems - The user can read items in the specified public folder.
- CreateItems - The user can create items in the specified public folder and send email messages to the public folder if it is mail-enabled.
- EditOwnedItems - The user can edit the items that the user owns in the specified public folder.
- DeleteOwnedItems - The user can delete items that the user owns in the specified public folder.
- EditAllItems - The user can edit all items in the specified public folder.
- DeleteAllItems - The user can delete all items in the specified public folder.
- CreateSubfolders - The user can create subfolders in the specified public folder.
- FolderOwner - The user is the owner of the specified public folder. The user can view and move the public folder, create subfolders, and set permissions for the folder. The user cannot read, edit, delete, or create items.
- FolderContact - The user is the contact for the specified public folder.
- FolderVisible - The user can view the specified public folder but cannot read or edit items in the folder.

## Public folder roles with permissions

The following table lists the predefined public folder roles and the permissions that are included in each role. The table headers reflect the permissions that were described earlier in this article.

|Role|Create Items|Read Items|Create Subfolders|Folder Owner|Folder Contact|Folder Visible|Edit OwnedItems|Edit AllItems|Delete OwnedItems|Delete AllItems|
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|None||||||X|||||
|Owner|X|X|X|X|X|X|X|X|X|X|
|PublishingEditor|X|X|X|||X|X|X|X|X|
|Editor|X|X||||X|X|X|X|X|
|PublishingAuthor|X|X|X|||X|X||X||
|Author|X|X||||X|X||X||
|Non-EditingAuthor|X|X||||X|||X||
|Reviewer||X||||X|||||
|Contributor|X|||||X|||||
