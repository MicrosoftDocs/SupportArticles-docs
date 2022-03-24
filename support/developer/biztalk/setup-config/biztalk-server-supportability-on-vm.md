---
title: BizTalk Server supportability on VM
description: Discusses the support policy for running BizTalk Server in a virtualization environment.
ms.date: 03/06/2020
ms.custom: sap:BizTalk Server Setup and Configuration
ms.reviewer: larryfr
---
# Microsoft BizTalk Server supportability on a virtual machine

This article discusses the support policy for running Microsoft BizTalk Server in a virtualization environment.

_Original product version:_ &nbsp; BizTalk Server 2013, 2010, 2009  
_Original KB number:_ &nbsp; 842301

## Supportability of hosting a BizTalk Server VM

If a BizTalk Server virtual machine (VM) is hosted on any other virtualization program than those listed below, BizTalk Server may not perform as expected.

The following table indicates the supportability of hosting a BizTalk Server virtual machine. In this table, **Yes** means that it's fully supported.

|Virtualization program|BizTalk Server 2004|BizTalk Server 2006|BizTalk Server 2006 R2|BizTalk Server 2009|BizTalk Server 2010|BizTalk Server 2013|BizTalk Server 2013 R2|
|-|-|-|-|-|-|-|-|
|Microsoft Virtual Server 2005|Yes|Yes|Yes|Yes|No|No|No|
|Windows Server 2008 Hyper-V|Yes|Yes|Yes|Yes|Yes|No|No|
|Microsoft Hyper-V Server 2008|Yes|Yes|Yes|Yes|Yes|No|No|
|Windows Server 2008 R2 Hyper-V, including Hypervisor|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Microsoft Hyper-V Server 2008 R2|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Windows Server 2012 Hyper-V|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Microsoft Hyper-V Server 2012|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Windows Server 2012 R2 Hyper-V|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Microsoft Hyper-V Server 2012 R2|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Server Virtualization Validation Program (SVVP) certified *|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Non-SVVP certified|Commercially reasonable support|Commercially reasonable support|Commercially reasonable support|Commercially reasonable support|Commercially reasonable support|Commercially reasonable support|Commercially reasonable support|

> [!NOTE]
> SVVP lists products that have been tested and validated to work with Windows Server. Some SVVP companies have only been validated for Windows Server 2008 and later.

For more information on the operating systems that are supported by BizTalk Server, see [Summary of operating systems and SQL Server versions supported by different versions of BizTalk Server](https://support.microsoft.com/help/926628).

## More information

Product support for a BizTalk Server VM hosted on a virtualization program that's not listed in the **Supportability of hosting a BizTalk Server VM** section is provided as commercially reasonable support. Commercially reasonable support is defined as all reasonable support efforts by Microsoft Customer Service and Support that don't require BizTalk Server code fixes.

If you have problems with a BizTalk Server VM hosted on a virtualization program that's not listed in the **Supportability of hosting a BizTalk Server VM** section, and the problem can't be resolved through commercially reasonable support, the problem must be reproducible in a non-VM environment, or on one of the supported virtualization programs that are listed in the **Supportability of hosting a BizTalk Server VM** section for the problem to be escalated to the BizTalk Server product group as a bug.

For more information about Microsoft server software and supported virtualization environments, see [Microsoft server software and supported virtualization environments](https://support.microsoft.com/help/957006).

Microsoft SQL Server has strict guidelines and a formal support policy for SQL Server products that are running in a hardware virtualization environment. Make sure that SQL Server is installed and configured correctly in a hardware virtualization environment. Also, because BizTalk Server makes extensive use of SQL Server databases, it's important to be aware of support policies for running SQL Server on a Hyper-V virtual machine.

For more information about SQL Server support in a virtualization environment or on a Hyper-V virtual machine, see [Support policy for Microsoft SQL Server products that are running in a hardware virtualization environment](https://support.microsoft.com/help/956893).

## Frequently Asked Questions

- **What level of technical support will I receive if my non-Microsoft vendor configuration is certified through SVVP?**

    Customer Service and Support will work together with you and the SVVP certified vendor to investigate the problem. Customer Service and Support or the SVVP vendor will  use the TSANet program together with your permission in an attempt to resolve the problem.

- **What if the non-Microsoft vendor virtualization configuration is not certified through SVVP?**

    Customer Service and Support will follow the support policies that are documented in Microsoft Knowledge Base article 897615. For more information, see [Support policy for Microsoft software running in non-Microsoft hardware virtualization software](https://support.microsoft.com/help/897615).

If Customer Service and Support determine that the problem may be related to the vendor virtualization software, Customer Service and Support may require that you try to reproduce the problem outside the virtualization environment. It's important to carefully read about the configurations that are supported for SVVP.

> [!NOTE]
> Not all vendor configurations are considered certified by SVVP even though the vendor participates in the program. The list of validated configurations may be updated as vendors submit changes through this program.
