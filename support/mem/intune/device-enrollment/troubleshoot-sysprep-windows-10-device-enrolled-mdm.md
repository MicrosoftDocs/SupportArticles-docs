---
title: Sysprep will not run correctly on a Windows 10 device that has been MDM enrolled
description: Provides tips for troubleshooting when Sysprep will not run correctly on a Windows 10 device that has been enrolled in mobile device management.
author: helenclu
ms.author: jchornbe
ms.reviewer: kaushika, jchornbe
ms.date: 10/06/2021
search.appverid: MET150
ms.custom: sap:Windows enrollment
---

# Sysprep will not run correctly on a Windows 10 device that has been MDM enrolled

This article provides troubleshooting tips for when Sysprep will not run correctly on a Windows 10 device that has been enrolled in mobile device management (MDM).

## Symptom

You are told to run **System Preparation** (Sysprep) tool on an operating system (OS) such as an image or a virtual machine (VM), before cloning it. When running Sysprep, you expect that the generalization process will remove all unique information from the original machine that it was created on.

However, this removal doesn't occur for several key items:

- MDM enrollment (such as **Intune**) certificates, identifiers, settings, etc.

- Microsoft Entra join or Microsoft Entra device enrollment certificates and IDs.

This issue causes significant problems for MDM as multiple devices are given the same IDs, and don't receive the necessary configuration from the MDM server.

## Cause

When you run **Sysprep** to generalize a computer, every Windows component is allowed the opportunity to remove information from the system, such as registry keys, certificates, files, folders, and so forth; anything that the component knows will cause issues if that installation were ever cloned.

But that doesn't mean every component removes the information.

Example: If you join a Windows 10 installation to Microsoft Entra ID, or enroll it in Intune, the OS will receive multiple certificates tied to the specific device. Additional enrollment and device ID information will be written to a variety of places in the registry, and then both policy information and settings will be applied. As a result, none of that information will be removed by the sysprep or generalization process.

## Solution

Before you can duplicate or clone a Windows installation (whether physically duplicating the disk drive, or using a VM-based snapshot, or a differencing disk technique), the system must be generalized using **Sysprep.exe**.

When you deploy a duplicated or imaged Windows installation, it is required that Sysprep is used before the capture of the image. Microsoft doesn't provide support for computers that are set up by using SID-duplicating tools other than Sysprep. Re-seal, or generalize, a Windows image before you capture and deploy the image.

For example, when you use the Sysprep tool to generalize an image, Sysprep removes all system-specific information and resets the computer. If you transfer a Windows image to a different computer, you must run the Sysprep command together with the `/generalize` option, even if the other computer has the same hardware configuration. The Sysprep `/generalize` command removes unique information from your Windows installation so that you can reuse that image on a different computer.

Also, never clone a device that is either joined to Microsoft Entra ID, or enrolled into an MDM service such as Intune. Otherwise, all devices using that image will look the same to the user, and Intune won't be able to tell them apart when they all provide the same device ID and certificates.

When you create an image, follow a consistent, repeatable process (such as using **MDT** or **ConfigMgr OSD**), while using a VM and running an automated task sequence that can complete the whole process. Don't join it to either Active Directory or Microsoft Entra ID, and don't set the image into a co-managed state, as that would already be enrolled in Intune. Keep the image in a workgroup, perform customizations, and run `sysprep /generalize` at the end of the process.

To bypass many of the issues explained here, Microsoft recommends that you use [Windows Autopilot](/mem/autopilot/windows-autopilot) to automate the process.
