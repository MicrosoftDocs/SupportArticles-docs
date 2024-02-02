---
title: Importing a virtual machine
description: Describes a situation in which you receive an error message when you try to move a virtual machine from a Windows Server 2012 R2 Hyper-V host into a Windows Server 2012 Hyper-V host.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, robtm, taylorb
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
ms.subservice: hyper-v
---
# Importing a VM that is exported from Windows Server 2012 R2 into Windows Server 2012 is not supported

This article describes a situation in which you receive an error message when you try to move a virtual machine from a Windows Server 2012 R2 Hyper-V host into a Windows Server 2012 Hyper-V host.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2868279

## Introduction

Moving a virtual machine (VM) from a Windows Server 2012 R2 Hyper-V host to a Windows Server 2012 Hyper-V host is not a supported scenario under any circumstances.

When you try import a VM that is exported from a Windows Server 2012 R2 Hyper-V host into a Windows Server 2012 Hyper-V host, you receive the following error message:

> Hyper-V did not find virtual machines to import from the location <**folder location**>.  
The operation failed with error code '32784'.

> [!NOTE]
> You can move a VM from a Windows Server 2012 Hyper-V host to a Windows Server 2012 R2 Hyper-V host. This is a supported scenario.
