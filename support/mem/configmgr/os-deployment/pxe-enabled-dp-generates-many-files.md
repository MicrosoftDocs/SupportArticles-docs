---
title: A PXE distribution point generates many files
description: A PXE enabled distribution point creates many files if it uses a self-signed certificate. Provides a resolution.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, jchornbe, mansee
---
# A PXE enabled distribution point that uses a self-signed certificate generates many files

This article provides a solution for the issue that a PXE enabled distribution point (DP) generates many files if it uses a self-signed certificate in System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2713467

## Symptoms

A PXE enabled DP will generate a number of files under `C:\ProgramData\Microsoft\Crypto\RSA\S-1-5-18` for each PXE request that it services on the network. This issue occurs whether the device sending the PXE request has a task sequence deployed to it or not. The generation of files will continue and may consume available hard disk space.

## Cause

This issue occurs whenever a self-signed certificate is used for the DP.

## Resolution

To work around this problem, request a CA issued certificate for the PXE enabled DP and specify the PFX file under the properties of the DP. Step-by-step instructions on how to do create the PFX file are available in [Deploying the Client Certificate for Distribution Points](/previous-versions/system-center/system-center-2012-R2/gg682023(v=technet.10)).
