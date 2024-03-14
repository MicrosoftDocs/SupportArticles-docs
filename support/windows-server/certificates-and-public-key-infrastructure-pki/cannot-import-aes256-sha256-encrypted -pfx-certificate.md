---
title: Can't mport a AES256-SHA256-encrypted PFX certificate
description: 
ms.date: 03/14/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: <sap/see CI>, csstroubleshoot
keywords: 
---

# Can't mport a AES256-SHA256-encrypted PFX certificate

This article 

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2 and earlier versions; Windows 10 and earlier versions

## Symptoms

On a computer that runs one of the operating systems that's listed in the "Applies to" section, you use the Certificate Import wizard to import a PFX file that uses AES256-SHA256 encryption. The operation fails and generates a message that resembles the following:

> The password you entered is incorrect.

## Cause

The affected versions of Windows and Windows Server do not support AES256-SHA256 encryption for imported PFX file.

## Resolution

Use TripleDES-SHA1 encryption for PFX files that you want to import to the affected versions of Windows or Windows Server. Newer versions of Windows and Windows Server support both TripleDES-SHA1 and AES256-SHA256 encryption for PFX files.

