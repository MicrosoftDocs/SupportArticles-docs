---
title: Cloud Platform System 1.0 Update 2
description: Describes Update 2 for Cloud Platform System 1.0. Covers the full range of fixes and functionality that this update provides.
author: genlin
ms.author: genli
ms.service: cps
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Cloud Platform System 1.0 Update 2

_Original product version:_ &nbsp; Cloud Platform System  
_Original KB number:_ &nbsp; 3073826

This articles describes the new features in the Cloud Platform System 1.0 Update 2.

### Features

Disaster recovery to Azure Public Cloud 
Before Cloud Platform System (CPS) 1.0 Update 2, offering disaster recovery to tenants through Azure Site Recovery (ASR) required a minimum of two CPS stamps, and this increases costs. After you install Update 2, you can use Microsoft Azure as the recovery site. This requires fewer configuration steps for CPS administrators who create and publish Azure Pack plans that include disaster recovery. If disasters affect the primary CPS stamp, workloads can be temporarily moved to Azure by a simple click. This lets CPS customers avoid the expense of acquiring and managing a second CPS stamp for recovery. 

FedRAMP 
CPS has been evaluated for compliance with the most current FedRAMP moderate baseline. Customers seeking FedRAMP certification can now use a precompiled System Security Plan (SSP) template and a Customer Responsibility Matrix (CRM). The SSP and CRM help streamline parts of the FedRAMP authorization process, providing CPS customers an easy way to understand their compliance levels when they are deploying services to internal or tenant users who require FedRAMP compliance. The SSP and CRM can increase confidence that with CPS, your IT infrastructure can be certified for FedRAMP with a significant reduction in the time, cost, and resources that are required by the process.

BitLocker drive encryption 
Customers who seek stronger security for their data at rest can now encrypt management, tenant, and backup data in CPS by configuring BitLocker Drive Encryption. For more information, see [https://support.microsoft.com/kb/3078425](https://support.microsoft.com/help/3078425). 

Off-stamp backup 
Before Update 2, CPS backup allowed customers to back up tenant VMs to disk and retain them for a week, which gave them time to perform operational recovery. However, this solution does not provide for scenarios such as offsite backup or long-term retention. As part of CPS Update 2, customers can now deploy Data Protection Manager (DPM) servers either onsite or offsite, outside CPS. They can back up tenant VMs to secondary DPM servers. By using secondary DPM servers, customers can have an offsite, backed-up copy on disk or on tape for long-term retention. Off-stamp backup lets customers more easily meet tenant backup requirements, such as offsite backup copies or long-term retention for their VMs.

Updates for System Center 2012 R2 
System Center 2012 R2 Data Protection Manager Update Rollup 7 [https://support.microsoft.com/kb/3065246](https://support.microsoft.com/help/3065246) 
System Center 2012 R2 Orchestrator - Service Management Automation Update Rollup 7 [https://support.microsoft.com/kb/3069115](https://support.microsoft.com/help/3069115) 
System Center 2012 R2 Operations Manager Update Rollup 6 [https://support.microsoft.com/kb/3051169](https://support.microsoft.com/help/3051169) 
System Center 2012 R2 Orchestrator - Service Provider Foundation Update Rollup 6 [https://support.microsoft.com/kb/3050307](https://support.microsoft.com/help/3050307) 
System Center 2012 R2 Virtual Machine Manager Update Rollup 7 [https://support.microsoft.com/kb/3066340](https://support.microsoft.com/help/3066340) 

Updates for Windows Azure Pack 
Update Rollup 7.1 for Windows Azure Pack [https://support.microsoft.com/kb/3091399](https://support.microsoft.com/help/3091399) 

Updates for Windows Server 2012 R2 
MS15-011: Vulnerability in Group Policy could allow remote code execution: February 10, 2015: [https://support.microsoft.com/kb/3000483](https://support.microsoft.com/help/3000483) 
Performance regressing in Hyper-V guest system in Windows Server 2012 R2 or Windows 8.1: [https://support.microsoft.com/kb/3014069](https://support.microsoft.com/help/3014069) 
Update to add support for Generic Routing Encapsulation in Windows 8.1 and Windows Server 2012 R2: [https://support.microsoft.com/kb/3022776](https://support.microsoft.com/help/3022776) 
Shared Hyper-V virtual disk is inaccessible when it's located in Storage Spaces on a Windows Server 2012 R2-based computer: [https://support.microsoft.com/kb/3025091](https://support.microsoft.com/help/3025091) 
MS15-021: Vulnerabilities in Adobe font driver could allow remote code execution: March 10, 2015: [https://support.microsoft.com/kb/3032323](https://support.microsoft.com/help/3032323) 
MS15-020: Description of the security update for Windows text services: March 10, 2015: [https://support.microsoft.com/kb/3033889](https://support.microsoft.com/help/3033889) 
MS15-020: Description of the security update for Windows shell: March 10, 2015: [https://support.microsoft.com/kb/3039066](https://support.microsoft.com/help/3039066) 
MS15-034: Vulnerability in HTTP.sys could allow remote code execution: April 14, 2015: [https://support.microsoft.com/kb/3042553](https://support.microsoft.com/help/3042553)"STATUS_PURGE_FAILED" error when you perform VM replications by using SCVMM in Windows Server 2012 R2 [https://support.microsoft.com/kb/3044457](https://support.microsoft.com/help/3044457) 
MS15-044 and MS15-051: Description of the security update for Windows font drivers: [https://support.microsoft.com/kb/3045171](https://support.microsoft.com/help/3045171) 
MS15-068: Description of the security update for Windows Hyper-V: July 14, 2015: [https://support.microsoft.com/kb/3046359](https://support.microsoft.com/help/3046359) 
Hyper-V cluster unnecessarily recovers the virtual machine resources in Windows Server 2012 R2: [https://support.microsoft.com/kb/3072380](https://support.microsoft.com/help/3072380) 
Possible performance degradation updating very large de-duplicated files [https://support.microsoft.com/kb/3073062](https://support.microsoft.com/help/3073062) 
MS15-078: Vulnerability in Microsoft font driver could allow remote code execution: July 16, 2015: [https://support.microsoft.com/kb/3079904](https://support.microsoft.com/help/3079904)"The URL cannot be resolved" error in DirectAccess and routing failure on HNV gateway cluster in Windows Server 2012 R2 - [https://support.microsoft.com/kb/3047280](https://support.microsoft.com/help/3047280) 
Tenant VMs lose network connectivity if NAT gateway VM exhausts all TCP/IP ephemeral ports in Windows Server 2012 R2: [https://support.microsoft.com/kb/3078411](https://support.microsoft.com/help/3078411) 

Hardware updates 
Firmware and driver updates have been incorporated in the Microsoft Patch and Update Framework (P&U) for this release. As part of the P&U process, every node is updated to have the most current, tested version of firmware or drivers to help ensure optimal system performance. After P&U applies software, firmware, and driver updates, it restarts CPS nodes when restarts are required.

The following is a list of automated firmware updates that are applied as part of CPS 1.0 Update 2: 

| Platform| Component| Type| Previous version| Updated version| Updated by P&U |
|---|---|---|---|---|---|
|C6220|Mellanox ConnectX-3 PRO (10Gb Mezz)|Driver|4.8|4.8|No|
|C6220|Chelsio T420-CR|Driver|Package 5.0.0.33, Driver 5.3.14.0|Package 5.0.0.44, Driver 5.5.11.0|Yes|
|C6220|BIOS|Firmware DUP|2.5.3|2.7.1|Yes|
|C6220|BMC|Firmware DUP|2.57|2.59|Yes|
|C6220 II|Mellanox ConnectX-3 PRO (10Gb Mezz)|Driver|4.8|4.8|No|
|Force10|Active Fabric Manager (AFM)|Tools-Deployment|AFM-CPS-1.0.0.1|AFM-CPS-1.0.0.1|No|
|C6220 II|Chelsio T520-CR|Driver|Package 5.0.0.33, Driver 5.3.14.0|Package 5.0.0.44, Driver 5.5.11.0|Yes|
|C6220 II|BIOS|Firmware DUP|2.5.3|2.7.1|Yes|
|C6220 II|BMC|Firmware DUP|2.57|2.59|Yes|
|C6000 Chassis|Fan Control Board|Firmware DUP|1.24|1.25|No|
|MD3060e|EMM/ESM|Firmware|396|396|No|
|MD3060e|HGST Ultrastar 7K4000|Firmware|W1CG|W1CG|No|
|MD3060e|Seagate 529FG|Firmware|GS0D|GS0D|No|
|MD3060e|SanDisk LB 806M|Firmware|D326|D326|No|
|MD3060e|Toshiba SSD TC2MH|Firmware|A3AC|A3AC|No|
|MD3060e|SanDisk SDLTODKM-800G|Firmware|D40T|D40T|No|
|MD3060e|SECLI|Tools-Deployment|1.3.0.1101|1.4.0.1557|No|
|R620|LSI 9207-8e (Dell Part # 4G89X)|Driver|2.00.72.10|2.00.76.00|Yes|
|R620|Chelsio T420-CR|Driver|Package 5.0.0.33 Driver 5.3.14.0|Package 5.0.0.44, Driver 5.5.11.0|Yes|
|R620|LSI 9207-8e (Dell Part # 4G89X)|Firmware|P18|P20|Yes|
|R620|BIOS|Firmware DUP|2.4.3|2.5.2|Yes|
|R620|iDRAC7|Firmware DUP|1.57.57|2.15.10.10|Yes|
|R620|Intel X520 (10Gb NDC)|Firmware DUP|15.0.28|16.5.20|Yes|
|R620|PERC H310|Firmware DUP|20.13.0-0007|20.13.1-0002|Yes|
|R620 v2|LSI 9207-8e (Dell Part # 4G89X)|Driver|2.00.72.10|2.00.76.00|Yes|
|R620 v2|Chelsio T520-CR|Driver|Package 5.0.0.33 Driver 5.3.14.0|Package 5.0.0.44, Driver 5.5.11.0|Yes|
|R620 v2|LSI 9207-8e (Dell Part # 4G89X)|Firmware|P18|P20|Yes|
|R620 v2|BIOS|Firmware DUP|2.4.3|2.5.2|Yes|
|R620 v2|iDRAC7|Firmware DUP|1.57.57|2.15.10.10|Yes|
|R620 v2|Intel X520 (10Gb NDC)|Firmware DUP|15.0.28|16.5.20|Yes|
|R620 v2|PERC H310|Firmware DUP|20.13.0-0007|20.13.1-0002|Yes|
|R630|LSI 9207-8e (Dell Part # 4G89X)|Firmware|P18|P20|Yes|
|R630|BIOS|Firmware DUP|1.1.4|1.3.6|Yes|
|R630|iDRAC7|Firmware DUP|2.02.01.01|2.15.10.10|Yes|
|R630|LifeCycle Controller2|Firmware DUP|2.02.01.01|2.15.10.10|Yes|
|R630|Intel X520 (10Gb NDC)|Firmware DUP|16.0.24|16.5.20|Yes|
|R630|PERC H330|Firmware DUP|25.2.1.0037|25.3.0.0016|Yes|
|R630|Toshiba Phoenix M2 MU P/N K41XJ|Firmware DUP|A3AC|A3AE|Yes|
|R630|Intel S3610 P/N 3481G|Firmware DUP|DL22|DL22|Yes|
|T520-CR|Chelsio T5 Firmware|Firmware|1.12.19.0|1.12.25.0|Yes|
|T520-CR|Chelsio T5 Firmware|Firmware|1.12.19.0|1.12.25.0|Yes|
|||||||

## More information

[Read the CPS overview white paper](https://download.microsoft.com/download/0/e/7/0e74a4a3-6d35-4a14-ad94-fedf8d265d36/microsoft_cloud_platform_system_white_paper.pdf) 
 [Download the CPS datasheet](https://download.microsoft.com/download/1/4/c/14ce6fe8-e5ea-4979-8278-8156a5cdae2b/cloud_platform_system_datasheet.pdf) 
 [Download the IDC Solution brief on the value of integrated systems](http://idcdocserv.com/idc_solution_brief_254796) 
 [Technical and how-to references for Cloud Platform System](https://www.microsoft.com/server-cloud/products/cloud-platform-system/resources.aspx)
