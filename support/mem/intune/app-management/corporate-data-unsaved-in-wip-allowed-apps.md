---
title: Can't save data in WIP-allowed apps on Intune Windows device
description: Fixes an issue in which you can't save corporate data in Windows Information Protection (WIP)allowed apps on a Windows device that's enrolled in Intune through a Microsoft Entra hybrid join or a Configuration Manager co-management.
ms.date: 10/14/2021
search.appverid: MET150
ms.custom: sap:Use app protection policies
ms.reviewer: kaushika
---
# Corporate data unsaved in WIP-allowed apps on Microsoft Entra hybrid join or co-management device in Intune

This article helps you fix an issue in which you can't save corporate data in WIP-allowed apps on a Windows device that's enrolled in Microsoft Intune through a Microsoft Entra hybrid join or co-management.

## Symptoms

Consider the following scenario:

- You are using a Windows-based device.
- The device is enrolled in Intune through a Microsoft Entra hybrid join or Configuration Manager co-management.
- A Windows Information Protection (WIP) policy is applied to the device.

In this scenario, when you use WIP-allowed apps, such as Microsoft Word and Microsoft Excel, you experience the following issues:

- When you try to save the document as a **Work** file, you receive the following error message:

    > Word cannot complete the save due to a file permission error.

    :::image type="content" source="media/corporate-data-unsaved-in-wip-allowed-apps/file-permission-error.png" alt-text="Screenshot of the file permission error.":::

- Any file that's downloaded from cloud resources is automatically saved as **Personal**. When you try to change the file to **Work**, you receive the following error message:

    > An unexpected error is keeping you from applying properties to the file. If you continue to receive this error, you can use the error code to search for help with this problem.  
    > Error 0x8007177C: Recovery policy configured for this system contains invalid recovery certificate.

    :::image type="content" source="media/corporate-data-unsaved-in-wip-allowed-apps/error-0x8007177c.png" alt-text="Screenshot of error 0x8007177C.":::

- When you try to create a work document, you receive the following error message:
Word cannot complete the save.

     :::image type="content" source="media/corporate-data-unsaved-in-wip-allowed-apps/cannot-complete-save.png" alt-text="Screenshot of Word cannot complete the save error.":::

## Cause

These issues occur if the Encrypting File System (EFS) Data Recovery Agent (DRA) certificate in your organization's policy in Group Policy has expired. In this case, you can't encrypt your files by using the certificate.

## Solution

To fix the issue, follow these steps:

1. Export the old DRA certificate and private key in case you need to decrypt files that have been encrypted by using this certificate.
2. [Create and verify an EFS DRA certificate](/windows/security/information-protection/windows-information-protection/create-and-verify-an-efs-dra-certificate).
3. Update the policy in Group Policy to use the new DRA certificate.
