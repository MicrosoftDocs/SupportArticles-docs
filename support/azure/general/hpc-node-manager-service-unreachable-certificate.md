---
title: Node management service unreachable error in HPC
description: Provides a solution for an issue where HPC Management shows the "Node management service unreachable" error.
ms.date: 09/19/2022
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
ms.reviewer: hclvteam
---

# "Node management service unreachable" error in HPC

This article provides a solution for an issue where HPC Management console shows "Node management service unreachable".

## Symptoms

A compute node's health is error, and you see the "HPC Node Manager Service Unreachable" error in the HPC management console.

:::image type="content" source="./media/hpc-node-manager-service-unreachable-certificate/node-manager-service-unreachabl.png alt-text="Image show the "HPC Node Manager Service Unreachable" error":::

The [HPC service log](/powershell/high-performance-computing/using-service-log-files-for-hpc-pack?view=hpc19-ps#BKMK_loc) shows the following error:

> Can not find cert with thumbprint < thumbprint -id> in store My, LocalMachine

## Cause

This issue occurs if the certificate installed on the head node and compute node are not matched.

## Resolution

To resolve the issue, you can either export the certificate from the head node, then import it to compute node. Or generate a new self-signed certificate, then install it on both head node and compute node.

To generate a new self-signed certificate, follow these steps:

1. Run the following command to generate the self-signed certificate:

    ```powershell
    New-SelfSignedCertificate -Subject "CN=HPC Pack Communication" -KeySpec KeyExchange -KeyLength 2048 -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1,1.3.6.1.5.5.7.3.2") -CertStoreLocation cert:\CurrentUser\My -KeyExportPolicy Exportable -HashAlgorithm SHA256 -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -NotAfter (Get-Date).AddYears(5) -NotBefore (Get-Date).AddDays(-1)
    ```
1. Open **certmgr.msc** > **Personal** > **Certificates**, located the certificate named **HPC Pack Communication**.
1. Right click the certificate, select **All Tasks** > **Export** > **Next**.
1. In the **Export private Key** section, select **Yes, export the private Key** checkbox:  
1. In the **Export file format** section, make sure the following settings are selected:
    -  Personal Information Exchange - PKC #12 (.PFC)
    - Include all certificates in the certification path if possible
    - Enable certificate privacy
1. In the **Security** section, enter a password that will be used for importing the certificate.
1. Save the exported certificate.
1. Install this certificate on the head node and compute node.
  

