---
title: Create Central Store on domain controller
description: Describes how to create a Central Store on a domain controller. This Central Store is used to store and to replicate registry-based policies for Windows Vista-based clients in a domain.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, timtho
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# How to create the Central Store for Group Policy Administrative Template files in Windows Vista

This article describes how to use the new .admx and .adml files to create and to administer registry-based policy settings in Windows Vista, and how the Central Store is used to store and to replicate Windows Vista policy files in a domain environment.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 929841

## Overview

Windows Vista uses a new format to display registry-based policy settings. These registry-based policy settings appear under **Administrative Templates** in the Group Policy Object Editor. In Windows Vista, these registry-based policy settings are defined by standards-based XML files that have an .admx file name extension. The .admx file format replaces the legacy .adm file format. The .adm file format uses a proprietary markup language.

In Windows Vista, Administrative Template files are divided into .admx files and language-specific .adml files that are available to Group Policy administrators. The changes that are implemented in Windows Vista let administrators configure the same set of policies by using two different languages. Administrators can configure policies by using the language-specific .adml files and the language-neutral .admx files.

## Administrative Template file storage

In earlier operating systems, all the default Administrative Template files are added to the ADM folder of a Group Policy object (GPO) on a domain controller. The GPOs are stored in the SYSVOL folder. The SYSVOL folder is automatically replicated to other domain controllers in the same domain. A policy file uses approximately 2 megabytes (MB) of hard disk space. Because each domain controller stores a distinct version of a policy, replication traffic is increased.

Windows Vista uses a Central Store to store Administrative Template files. In Windows Vista, the ADM folder isn't created in a GPO as in earlier versions of Windows. So domain controllers don't store or replicate redundant copies of .adm files.

> [!NOTE]
> If you use a client that is running an earlier version of Windows to modify a policy that is created or administered on a Windows Vista-based computer, the client creates the ADM folder and replicates the files.

For more information, see [Recommendations for managing Group Policy administrative template (.adm) files](https://support.microsoft.com/help/816662).

## The Central Store

To take advantage of the benefits of .admx files, you must create a Central Store in the SYSVOL folder on a domain controller. The Central Store is a file location that is checked by the Group Policy tools. The Group Policy tools use any .admx files that are in the Central Store. The files that are in the Central Store are later replicated to all domain controllers in the domain.

To create a Central Store for .admx and .adml files, create a folder that is named PolicyDefinitions in the following location: `\\FQDN\SYSVOL\FQDN\policies`

> [!NOTE]
> **FQDN** is a fully qualified domain name.

For example, to create a Central Store for the Test.Microsoft.com domain, create a PolicyDefinitions folder in the following location:  
    `\\Test.Microsoft.Com\SYSVOL\Test.Microsoft.Com\Policies`

Copy all files from the PolicyDefinitions folder on a Windows Vista-based client computer to the PolicyDefinitions folder on the domain controller. The PolicyDefinitions folder on a Windows Vista-based computer stays in the same folder as Windows Vista. The PolicyDefinitions folder on the Windows Vista-based computer stores all .admx files and .adml files for all languages that are enabled on the client computer.

The .adml files on the Windows Vista-based computer are stored in a language-specific folder. For example, English (United States).adml files are stored in a folder that is named "en-US." Korean .adml files are stored in a folder that is named "ko_KR." If .adml files for additional languages are required, you must copy the folder that contains the .adml files for that language to the Central Store. When you've copied all .admx and .adml files, the PolicyDefinitions folder on the domain controller should contain the .admx files and one or more folders that contain language-specific .adml files.

> [!NOTE]
> When you copy the .admx and .adml files from a Windows Vista-based computer, verify that the most recent updates to these files and to Windows Vista are installed. Also, make sure that the most recent Administrative Template files are replicated. This advice also applies to service packs if applicable.

## Group Policy administration

Windows Vista doesn't include Administrative Templates that have an .adm extension. Additionally, earlier versions of Windows can't use the new administrative format. So client computers that are running earlier versions of Windows can't administer new policies that are included with Windows Vista. We recommend that you use computers that are running Windows Vista or later versions of Windows to do Group Policy administration.

## Updating Administrative Template Files

In Group Policy for versions of Windows earlier than Windows Vista, if you change Administrative template policy settings on local computers, the Sysvol share on a domain controller within your domain is automatically updated with the new .ADM files. In turn, those changes are replicated to all other domain controllers in the domain. It might result in increased network load and storage requirements. In Group Policy for Windows Server 2008 and Windows Vista, if you change Administrative template policy settings on local computers, Sysvol won't be automatically updated with the new .ADMX or .ADML files. This change in behavior is implemented to reduce network load and disk storage requirements, and to prevent conflicts between .ADMX files and .ADML files when edits to Administrative template policy settings are made across different locales. To make sure that any local updates are reflected in Sysvol, you must manually copy the updated .ADMX or .ADML files from the PolicyDefinitions file on the local computer to the Sysvol\PolicyDefinitions folder on the appropriate domain controller.

To download the Administrative template files for Windows Server 2008, see [Administrative Templates (ADMX) for Windows Server 2008](https://www.microsoft.com/download/details.aspx?id=14355).
