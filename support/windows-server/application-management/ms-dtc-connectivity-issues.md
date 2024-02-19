---
title: Troubleshoot connectivity issues in MS DTC by using the DTCPing tool
description: Explains how to use the DTCPing tool to troubleshoot MS DTC connectivity issues.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dtc-startup-configuration-connectivity-and-cluster, csstroubleshoot
---
# How to troubleshoot connectivity issues in MS DTC by using the DTCPing tool

This article describes how to troubleshoot connectivity issues in Microsoft Distributed Transaction Coordinator (MS DTC) by using the DTCPing tool.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 918331

## Introduction

By using the DTCPing tool, you can test the name resolution between two computers. You can also test the remote procedure call (RPC) communication between two computers. Additionally, you can obtain the following information by using the DTCPing tool:

- MS DTC security settings.
- RPC port range information.
- MS DTC `HKEY_CLASSES_ROOT\CID` registry key information.

## Download information

The following file is available for download from the Microsoft Download Center:  

[Download the Dtcping.exe package now.](https://download.microsoft.com/download/d/0/0/d00c8f6b-135d-4441-a97b-9de16a1935c1/dtcping.exe)

For more information about how to download Microsoft support files, click the following article number to view the article in the Microsoft Knowledge Base:

[119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

## Files that the Dtcping.exe package contains

|File name|File version|File size|Date|Time|
|---|---|---|---|---|
|Dtcping.exe|1.9.0.1|266,308|29-Jul-2005|00:54|
|Dtcping.pdb|Not Applicable|1,000,448|29-Jul-2005|00:54|
|HowtoAnalyze_Dtcping_Output.txt|Not Applicable|4,530|27-Jul-2005|15:38|
|Machinea_failure.log|Not Applicable|1,560|24-Nov-2003|22:59|
|Machinea_success.log|Not Applicable|1,901|24-Nov-2003|22:21|
|Machineb_failure.log|Not Applicable|999|24-Nov-2003|22:55|
|Machineb_success.log|Not Applicable|1,750|24-Nov-2003|22:31|
|Readme.txt|Not Applicable|3,244|27-Jul-2005|15:32|

## Troubleshooting information

The Dtcping.exe package includes the following text files that describe how to use the DTCPing tool:

- See the Readme.txt file for information about how to test RPC communication and MS DTC communication between two computers.

- See the HowtoAnalyze_Dtcping_Output.txt file for information about how to obtain RPC port information, CID registry key information, and other MS DTC-related information.
