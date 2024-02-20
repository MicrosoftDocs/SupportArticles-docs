---
title: Can't activate Windows 7 with KMS
description: Describes why you may receive an error message when you try to activate Windows Vista or Windows 7 on a computer by using the Key Management Service (KMS).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# You receive an error message when you try to activate Windows Vista or Windows 7 on a computer that was obtained from an OEM

This article provides a solution to solve errors that occur when you activate Windows Vista or Windows 7 on a computer that's obtained from an Original Equipment Manufacturer (OEM).

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 942962

## Symptoms

When you try to activate Windows Vista or Windows 7 on a computer that was obtained from an OEM, you experience one of the following symptoms.

### Symptom 1

You receive one of the following error messages:

Error message 1  
> Error Code: Invalid Volume License Key
>
> In order to activate, you need to change your product key to a valid Multiple Activation Key (MAK) or Retail key.
>
> You must have a qualifying operating system license AND a Volume license Windows <**operating system**> upgrade license, or a full license for Windows <**operating system**> through an OEM or from a retail source.
>
> ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW.  

Error message 2  
> Error Code: 0xC004F059
>
> Description: The Software Licensing Service reported that a license in the computer BIOS is invalid.

### Symptom 2

You receive the following error message:  
> Error Code: 0xc004f035  
The Software Licensing Service reported that the computer could not be activated with a Volume license product key. Volume licensed systems require upgrading from a qualified operating system. Please contact your system administrator or use a different type of key.  

This behavior occurs when the following conditions are true:  

- You are using the Key Management Service (KMS) to perform activation.
- The computer uses an ACPI_SLIC table in the computer BIOS program.  

> [!NOTE]
> An ACPI_SLIC table is used by an Advanced Configuration and Power Interface (ACPI)-compliant BIOS program to store Software Licensing description information.

## Cause

This problem occurs if the KMS server does not find a valid Windows marker in the ACPI_SLIC table in the computer's BIOS program. This problem occurs for one of the following reasons.

### Cause 1

You purchased a computer that has a qualifying Windows operating system installed. However, the Windows marker in the ACPI_SLIC table is corrupted.

### Cause 2

You purchased a computer that does not have a qualifying Windows operating system installed. In this case, the Windows marker is not present in the ACPI_SLIC table.

## Resolution

Windows Volume License is for upgrades only. Before you try to upgrade, you must first purchase an underlying, qualifying, and genuine Windows license. For more information, visit the following Microsoft website:  
[Legalization licensing solutions](https://devicepartner.microsoft.com/communications/comm-legalization-licensing-solutions)  
The information on this website includes an easy way to correct improper licensing by using a Get Genuine Agreement. Next, you must change the product key to a Multiple Activation Key (MAK). To do this, contact the Microsoft Volume Licensing Service Center at the following Microsoft website:  
[Volume Licensing Service Center](https://www.microsoft.com/licensing/servicecenter/)  

## More information

The behavior that is mentioned in the "Symptoms" section may occur when the Windows marker is missing from the Software Licensing table or when the Windows marker information is present but corrupted. For more information about Volume Activation 2.0, visit the following Microsoft Web site:  
[Volume Activation 2.0 Operations Guide](https://technet.microsoft.com/library/cc303695.aspx)  
A computer that was obtained from an OEM and that has an ACPI_SLIC table in the system BIOS must have a valid Windows marker in that ACPI_SLIC table if that system includes an OEM license for a Microsoft operating system (Windows XP, Windows Vista, or Windows 7). OEM systems that do not include an OEM Microsoft operating system may include an ACPI_SLIC table that does not include a valid marker file. This Windows marker is important for volume license customers who plan to use Windows Vista or Windows 7 volume license media to reimage or upgrade an OEM system according to the reimaging rights in the volume license agreement.

A computer whose ACPI_SLIC table lacks a valid Windows marker generates an error when you try to activate through KMS when you are using a volume edition of Windows Vista or of Windows 7. You cannot activate such a system by using KMS. This is a compliance check for the use of volume media as per the Volume License Agreement. However, you can activate the system by using a multiple activation key (MAK). (You may not be compliant from a licensing scenario when you use a MAK. Contact your licensing specialist to make sure that you are complaint.) Or, you can use a retail key. Alternatively, if you purchased an OEM system that has Windows Vista or Windows 7 installed and activated, you can contact the OEM for more help. Or, you can purchase a new computer that has a Microsoft Windows operating system and an ACPI_SLIC table that has a valid Windows marker.

### The MGADiag tool

The MGADiag tool detects and reports BIOS information. However, the BIOS information for the ACPI_SLIC table does not appear in the graphical user interface output. To see the BIOS information, click the **Windows** tab, click **Copy**, and then paste the output into Notepad or into another text editor. The output will resemble the following example:

> Will not be able to KMS Activate:
>
> OEM Activation 2.0 Data-->  
BIOS valid for OA 2.0: No, invalid SLIC table  
Windows marker version: N/A  
OEMID and OEMTableID Consistent: N/A  
>
> Windows Marker not present  
OEM Activation 2.0 Data-->  
BIOS valid for OA 2.0: Yes, but no Windows Marker  
Windows marker version: N/A  
OEMID and OEMTableID Consistent: Yes  
>
> Will be able to KMS Activate:  
>
> Windows Marker present  
OEM Activation 2.0 Data-->  
BIOS valid for OA 2.0: Yes  
Windows marker version: 0x20001  
OEMID and OEMTableID Consistent: Yes  
>
> SLIC table not present  
OEM Activation 2.0 Data-->  
BIOS valid for OA 2.0: Yes, but no SLIC table  
Windows marker version: N/A  
OEMID and OEMTableID Consistent: N/A  

> [!NOTE]
> The KMS compliance check only applies to Windows 7 and Windows Vista machines running as KMS clients, it does not apply to Windows Server 2008 or Windows Server 2008 R2 machines running as KMS client machines.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
