---
title: The processor is not supported together with the Windows version error
description: Discusses issues in which you receive the processor is not supported together with the Windows version that you are currently using error or the 80240037 error code when you scan or download Windows updates.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
adobe-target: true
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# Windows Update "Processor Not Supported" errors

This article discusses the errors "Processor not supported" and "80240037" encountered during Windows Update.

_Original KB number:_ 4012982

## Symptoms

When you try to scan or download updates through Windows Update, you receive the following error message:
> Unsupported hardware  
> Your PC uses a processor that is designed for the latest version of Windows. Because the processor is not supported together with the Windows version that you are currently using, your system will miss important security updates.

:::image type="content" source="media/processor-not-supported-together-with-windows-version/unsupported-hardware-error.svg" alt-text="The details of the Unsupported hardware error message.":::

Additionally, you may see the following error message in the Windows Update window:
> Windows could not search for new updates  
An error occurred while checking for new updates for your computer.
Error(s) found:  
Code 80240037 Windows Update encountered an unknown error.  

## Solution

Since these errors occur when Windows detects an incompatible processor, ensure that Windows is compatible with the processor you're using. Refer to the following documentation for the latest processor generations and models that are supported in different Windows editions:

- For supported [Windows Client Processors](/windows-hardware/design/minimum/windows-processor-requirements#windows-client-edition-processors)

- For supported [Windows Server Processors](/windows-hardware/design/minimum/windows-processor-requirements#windows-server-processors)

- For supported [Windows IoT Core Processors](/windows-hardware/design/minimum/windows-processor-requirements#windows-iot-core-processors)

## Additional resources

- [Windows Processor Requirements](/windows-hardware/design/minimum/windows-processor-requirements)
- [Windows Server support and installation instructions for the AMD EPYC 7000 Series server processors](../../windows-server/deployment/windows-server-support-installation-for-amd-role-family-processor.md)
- [Lifecycle support policy FAQ -Windows products](/lifecycle/faq/windows#%2Fhelp%2F18581%2Flifecycle-support-policy-faq-windows-products%23b4)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
