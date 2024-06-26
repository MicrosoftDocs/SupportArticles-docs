---
title: A fatal error occurred while trying to sysprep the machine
description: Helps resolve the fatal error occurred while trying to sysprep the machine when you use the Sysprep tool.
ms.date: 06/26/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, guilhermeg, v-llangford, v-lianna
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# Error "A fatal error occurred while trying to sysprep the machine" when you use the Sysprep tool

This article helps resolve the error "A fatal error occurred while trying to sysprep the machine" when you use the Sysprep tool.

When you use the [System Preparation (Sysprep)](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview) tool, you may receive the following error message:

> A fatal error occurred while trying to sysprep the machine.

Additionally, an error message that resembles the following is logged in the *Setuperr.log* file:

> \<Date\> \<Time\>, Error [0x0f0073] SYSPRP RunExternalDlls:Not running DLLs; either the machine is in an invalid state or we couldn't update the recorded state, dwRet = 31

The fatal error is designed to prevent the deployment of a corrupted image. When you run the Sysprep tool, the progress is tracked through each phase of Sysprep. Sysprep can't roll back when it experiences errors.

To resolve this error, re-create the image.

You can't correct the problem with the image. When the Sysprep tool runs, it clears the *%windir%\\system32\\sysprep\\panther\\setupact.log* file. Therefore, you can't see what failed the last time that the Sysprep tool ran unless you have a copy of the *setupact.log* file that existed before you ran Sysprep.

> [!NOTE]
> Before you create a new image or rerun the Sysprep tool, we recommend that you save the contents of the following folders:
>
> - *%Windir%\\Panther*
> - *%Windir%\\System32\\Sysprep\\Panther*
>
> Make sure that you save the contents of all the subfolders of these two folders.
