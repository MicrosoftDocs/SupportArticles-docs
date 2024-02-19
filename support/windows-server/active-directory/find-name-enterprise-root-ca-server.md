---
title: Find the name of Enterprise Root CA server
description: Helps you to find name of the Enterprise Root Certificate Authority (CA) server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# How to find the name of the Enterprise Root Certificate Authority server

This article helps you to find name of the Enterprise Root Certificate Authority (CA) server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555529

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

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
