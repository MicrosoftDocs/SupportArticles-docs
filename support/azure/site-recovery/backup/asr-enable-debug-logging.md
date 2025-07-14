---
title: How to enable debug logging for the Azure Site Recovery in Hyper-V Site Protection
description: Describes how to enable debug logging (also known as ETL tracing) for Microsoft Azure Site Recovery (ASR) in Hyper-V Site to Azure protection scenarios running on a Windows Server 2012 R2 Hyper-V server.
ms.date: 03/05/2021
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: markstan
ms.custom: sap:I need help with Azure Backup
---
# How to enable debug logging for the Azure Site Recovery in Hyper-V Site Protection

_Original product version:_ &nbsp; Azure Backup, Windows Server 2012 R2 Standard  
_Original KB number:_ &nbsp; 3033922

## Summary

This article describes how to enable debug logging (also known as ETL tracing) for Microsoft Azure Site Recovery (ASR) in Hyper-V Site to Azure protection scenarios running on a Windows Server 2012 R2 Hyper-V server. You may use the steps in this article for ASR configured using the Setup Recovery Between an on-premises Hyper-V site and Azure option in the Azure Management Portal. ASR installations that use Microsoft System Center 2012 R2 Virtual Machine Manager (SC 2012 R2 VMM) should enable [VMM Debug Logging](https://support.microsoft.com/help/2913445) instead.

## More information

To enable debug logging for the ASR Provider, use the following steps:

1. Open an elevated PowerShell Window and then run the following commands to create your trace definition:

    ```powershell
    logman create trace ASRDebug -v mmddhhmm -o C:\temp\asr.etl -cnf 01:00:00 -nb 10 250 -bs 16 -ow -y
    logman update ASRDebug -p "Microsoft-Azure Site Recovery-Provider" 0x8000000000000000 0x5
    logman update ASRDebug -p "MicrosoftAzureRecoveryServices" 0xC000000000000000 0x5
    ```

    > [!NOTE]
    > The default location specified above is C:\temp. You may safely change this value if needed. The folder will be created if it does not exist.

2. Start the trace by typing the following command in the elevated Windows PowerShell window:

    ```powershell
    logman start ASRDebug
    ```

3. Reproduce your issue.
4. As soon as you reproduce your issue, stop the trace by running the following command:

    ```powershell
    logman stop ASRDebug
    ```

5. Convert the trace to readable text, run the following command:

    ```powershell
    netsh trace convert <filename>
    ```

    > [!NOTE]
    > In this command, the placeholder < filename > represents the name of the ETL that you found in step 5. The converted trace file will have a name in the format < filename >.txt.
6. Collect debug logs from the folder \<installation folder>\Temp. The default location will be _C:\Program Files\Microsoft Azure Recovery Services Agent\Temp_.
7. Use these steps to collect SRS logs from the Azure Site Recovery portal:

    1. Log on to the [Azure portal](https://portal.azure.com).
    2. Select **Recovery Services vaults**.
    3. Select the vault that hosts your ASR data.
    4. Select **Site Recovery jobs**.
    5. Select Export Jobs to begin the export process.
    6. Specify a file location, and then click Save to export the job details to an .xlsx file.

8. Run the following command:

    ```powershell
    wevtutil el | findstr /i microsoftazurerecoveryservices-replication | % { wevtutil qe $_ /f:text}  
    ```

9. Run the following PowerShell command to collect Hyper-V logs:

    ```powershell
    wevtutil el | findstr /i hyper-v-vmms | % { wevtutil qe $_ /f:text}  
    ```

10. Run the following PowerShell command to collect Hyper-V logs:

    ```powershell
    wevtutil el | findstr /i "microsoft-azure site recovery-provider" | % { wevtutil qe $_ /f:text}
    ```

For additional troubleshooting steps and help in interpreting error messages, see [this article](/azure/site-recovery/site-recovery-monitor-and-troubleshoot#reaching-out-for-microsoft-support).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

