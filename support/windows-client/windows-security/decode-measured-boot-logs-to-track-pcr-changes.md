---
title: Decode Measured Boot logs to track PCR changes
description: Provides instructions for installing and using a tool for analyzing log information to identify changes to PCRs.
ms.date: 08/25/2022
ms.reviewer: kaushika
ms.technology: windows-client-security
ms.prod: windows-client
author: Teresa-Motiv
ms.author: v-tappelgate
manager: dcscontentpm
ms.collection: Windows Security Technologies\BitLocker
ms.topic: troubleshooting
ms.custom: sap:bitlocker, csstroubleshoot
audience: itpro
localization_priority: medium
---
# Decode Measured Boot logs to track PCR changes

Platform Configuration Registers (PCRs) are memory locations in the Trusted Platform Module (TPM). BitLocker and its related technologies depend on specific PCR configurations. Additionally, specific change in PCRs can cause a device or computer to enter BitLocker recovery mode.  

By tracking changes in the PCRs, and identifying when they changed, you can gain insight into issues that occur or learn why a device or computer entered BitLocker recovery mode. The Measured Boot logs record PCR changes and other information. These logs are located in the C:\\Windows\\Logs\\MeasuredBoot\\ folder.

This article describes tools that you can use to decode these logs: TBSLogGenerator and PCPTool.

For more information about Measured Boot and PCRs, see the following articles:

- [TPM fundamentals: Measured Boot with support for attestation](/windows/security/information-protection/tpm/tpm-fundamentals#measured-boot-with-support-for-attestation)  
- [Understanding PCR banks on TPM 2.0 devices](/windows/security/information-protection/tpm/switch-pcr-banks-on-tpm-2-0-devices)

## Use TBSLogGenerator to decode Measured Boot logs

Use TBSLogGenerator to decode Measured Boot logs that you have collected from Windows 11, Windows 10, and earlier versions. You can install this tool on the following systems:

- A computer that is running Windows Server 2016 and that has a TPM enabled
- A Gen 2 virtual machine (running on Hyper-V) that is running Windows Server 2016 (you can use the virtual TPM)

To install the tool, follow these steps:

1. Download the Windows Hardware Lab Kit from one of the following locations:

   - [Windows Hardware Lab Kit](/windows-hardware/test/hlk/)
   - Direct download link for Windows Server 2016: [Windows HLK, version 1607](https://go.microsoft.com/fwlink/p/?LinkID=404112)

2. Accept the default installation path.

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/install-windows-hardware-lab-kit.png" alt-text="Screenshot of the Specify Location page of the Windows Hardware Lab Kit installation wizard." border="false":::

3. Under **Select the features you want to install**, select **Windows Hardware Lab Kit&mdash;Controller + Studio**.

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/windows-hardware-lab-kit-controller-studio.png" alt-text="Screenshot of the Select features page of the Windows Hardware Lab Kit installation wizard." border="false":::

4. Finish the installation.

To use TBSLogGenerator, follow these steps:

1. After the installation finishes, open an elevated Command Prompt window and navigate to the following folder:

   *C:\\Program Files (x86)\\Windows Kits\\10\\Hardware Lab Kit\\Tests\\amd64\\NTTEST\\BASETEST\\ngscb*

   This folder contains the TBSLogGenerator.exe file.

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/tbsloggenerator-file.png" alt-text="Screenshot of the properties and location of the TBSLogGenerator.exe file." border="false":::

2. Run the following command:

   ```console
   TBSLogGenerator.exe -LF <LogFolderName>\<LogFileName>.log > <DestinationFolderName>\<DecodedFileName>.txt
   ```

   where the variables represent the following values:

   - `<LogFolderName>` = the name of the folder that contains the file to be decoded
   - `<LogFileName>` = the name of the file to be decoded
   - `<DestinationFolderName>` = the name of the folder for the decoded text file
   - `<DecodedFileName>` = the name of the decoded text file

   For example, the following figure shows Measured Boot logs that were collected from a Windows 10 computer and put into the *C:\\MeasuredBoot\\ folder*. The figure also shows a Command Prompt window and the command to decode the *0000000005-0000000000.log* file:

    ```console
    TBSLogGenerator.exe -LF C:\MeasuredBoot\0000000005-0000000000.log > C:\MeasuredBoot\0000000005-0000000000.txt
    ```

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/measured-boot-logs.png" alt-text="Screenshot of the Command Prompt window that shows an example of how to use TBSLogGenerator." border="false":::

   The command produces a text file that uses the specified name. In the case of the example, the file is *0000000005-0000000000.txt*. The file is located in the same folder as the original `.log` file.

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/text-original-log-file.png" alt-text="Screenshot of the Windows Explorer window that shows the text file that TBSLogGenerator produces." border="false":::

   The content of this text file resembles the following.

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/text-file-content.png" alt-text="Screenshot of the contents of the text file, as shown in NotePad." border="false":::

   To find the PCR information, go to the end of the file.

    :::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/pcr-information.png" alt-text="Screenshot of the text file that shows the PCR information at the end." border="false":::

## Use PCPTool to decode Measured Boot logs

> [!NOTE]
> PCPTool is a Visual Studio solution, but you need to build the executable before you can start using this tool.

PCPTool is part of the [TPM Platform Crypto-Provider Toolkit](https://www.microsoft.com/download/details.aspx?id=52487). The tool decodes a Measured Boot log file and converts it into an XML file.

To download and install PCPTool, go to the Toolkit page, select **Download**, and follow the instructions.

To decode a log, run the following command:

```console
PCPTool.exe decodelog <LogFolderPath>\<LogFileName>.log > <DestinationFolderName>\<DecodedFileName>.xml
```  

where the variables represent the following values:

- `<LogFolderPath>` = the path to the folder that contains the file to be decoded
- `<LogFileName>` = the name of the file to be decoded
- `<DestinationFolderName>` = the name of the folder for the decoded text file
- `<DecodedFileName>` = the name of the decoded text file

The content of the XML file resembles the following.

:::image type="content" source="media/decode-measured-boot-logs-to-track-pcr-changes/pcptool-output.png" alt-text="Screenshot of the Command Prompt window that shows an example of how to use PCPTool." border="false":::
