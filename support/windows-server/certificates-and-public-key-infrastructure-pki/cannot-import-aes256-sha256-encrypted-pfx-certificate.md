---
title: Can't import an AES256-SHA256-encrypted PFX certificate
description: Provides a workaround for an issue in which you can't import a certificate that uses AES256-SHA256 encryption into certain versions of Windows or Windows Server.
ms.date: 01/15/2025
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:certificates-and-public-key-infrastructure-pki
- pcy:WinComm Directory Services
keywords: 
---
# Can't import an AES256-SHA256-encrypted PFX certificate

This article provides a workaround for an issue in which you can't import a certificate that uses AES256-SHA256 encryption into certain versions of Windows or Windows Server.

> [!NOTE]
> Windows 11, Windows 2019, and later versions of Windows support AES256-SHA256 encrypted PFX files. Therefore, the issue outlined in this article does not apply to these versions of Windows.

## Symptoms

On a computer that runs one of the operating systems that's listed in the "Applies to" section, you use the Certificate Import Wizard to import a PFX file that uses AES256-SHA256 encryption. The operation fails and generates a message that resembles the following text:

> The password you entered is incorrect.

## Cause

The affected versions of Windows and Windows Server don't support AES256-SHA256 encryption for imported PFX files.

## Workaround

Use TripleDES-SHA1 encryption for PFX files that you want to import into the affected versions of Windows or Windows Server. Newer versions of Windows and Windows Server support both TripleDES-SHA1 and AES256-SHA256 encryption for PFX files.
