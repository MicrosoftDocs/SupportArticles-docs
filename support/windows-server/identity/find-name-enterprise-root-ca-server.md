---
title: Find the name of Enterprise Root CA server
description: Helps you to find name of the Enterprise Root Certificate Authority (CA) server.
ms.date: 09/28/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory Certificate Services
ms.technology: ActiveDirectory
---
# How to find the name of the Enterprise Root Certificate Authority server

This article helps you to find name of the Enterprise Root Certificate Authority (CA) server.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555529

## Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if microsoft or any of its suppliers has been advised of the possibility of damages.

## Summary

The following content describes two options to find the name of the Enterprise Root Certificate Authority server.

## Option 1

1. Sign in by using domain administrator to computer that connects to the domain.

2. Go to **Start** -> **Run** -> Write **cmd** and press on **Enter** button.

3. Write "**certutil.exe**" command and press on **Enter** button.

## Option 2

1. Sign in by using domain administrator to computer that connects to the domain.

2. Install Windows Support Tools.

3. Go to **Start** -> **Run** -> Write **adsiedit.msc** and press on **Enter** button.

4. Navigate to:

    CN=Certification Authorities,CN=Public Key

    Services,CN=Services,CN=Configuration,DC=ntdomain,DC=com

    Under **Certification Authorities**, you'll find your Enterprise Root Certificate Authority server.
