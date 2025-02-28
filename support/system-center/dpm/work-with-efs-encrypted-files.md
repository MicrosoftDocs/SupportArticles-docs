---
title: How DPM works with EFS encrypted files
description: Describes how System Center Data Protection Manager handles encrypted and unencrypted files during synchronization.
ms.date: 04/08/2024
ms.reviewer: Mjacquet, jeffpatt, jbuff
---
# How System Center Data Protection Manager works with Encrypting File System (EFS) encrypted files

This article clarifies how System Center Data Protection Manager (DPM) handles encrypted and unencrypted files during synchronization.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 2476276

## How DPM works with EFS encrypted files

- If a file hasn't changed since the last sync, DPM will not transfer any data.

- If a file has changed and isn't encrypted with EFS, DPM transfers only the changed blocks of a file.

- If a file has changed and the file is protected with EFS, DPM will transfer the entire file.

The behavior above is by design but it is worth noting that in certain situations this may cause unexpected results if you are not aware of it. For example, let's say you are backing up Outlook PST files that are protected by EFS. Because PST files used by an Outlook client are changing continuously, they will be transferred in their entirety at every synchronization. If you have many users with large PST files, this data can consume more network bandwidth and storage space on the DPM server than it would consume if the files were not encrypted.
