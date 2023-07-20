---
title: Language features not displayed to standard users
description: Provides the information that language features aren't displayed to standard users starting from Windows 10, version 1809.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, kimberj, arrenc
ms.custom: sap:setup, csstroubleshoot
ms.technology: windows-client-deployment
---
# Language features aren't displayed in Windows 10

_Applies to:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 4507173

In versions of Windows prior to Windows 10, version 1809, language features such as **Speech** and **Handwriting** are visible to standard users. When standard users try to add a language feature, a User Account Control (UAC) is prompted and admin credentials are required. Starting from version 1809, language features aren't displayed to standard users as shown here:

:::image type="content" source="media/language-features-not-displayed/install-language-features.png" alt-text="Screenshot of the Install language features dialog." border="false":::

Use the [Deployment Image Servicing and Management (DISM) cmdlet](/windows-hardware/manufacture/desktop/dism-operating-system-package-servicing-command-line-options) to include these features in a Windows image.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
