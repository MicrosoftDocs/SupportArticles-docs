---
title: Event ID 15 when a computer resumes from sleep
description: Describes a problem that may occur when you use a Trusted Platform Module device on a computer that is running Windows 8.1 Windows Server 2012 R2, Windows 8, Windows Server 2012, Windows 7, or Windows Server 2008 R2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:bitlocker, csstroubleshoot
---
# Event ID 15 may be logged when a Windows-based computer that has a TPM chip resumes from sleep

This article describes a problem that may occur when a computer that has a Trusted Platform Module (TPM) chip resumes from sleep.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2696920

## Symptoms

Consider the following scenario:  

- You use a Trusted Platform Module (TPM) chip on a computer that is running Windows 8.1, Windows Server 2012 R2, Windows 8, Windows Server 2012, Windows 7 or Windows Server 2008 R2.
- You put the computer to sleep, and then you resume the computer from sleep.

In this scenario, the following event may be logged in the System log:

>The TPM driver and the TPM Base Services (TBS) log these errors when they cannot obtain a random number from the TPM chip for the Windows operating system. The operating system uses this random number as an additional source of entropy when the operating system's cryptographic methods generate random numbers.

## Cause

When the TPM chip resumes from sleep, it must receive a command to continue a self-test before it is ready to process other commands. On many computers, the system BIOS will issue a command to the TPM chip to continue the self-test. If Windows tries to retrieve a random number while this self-test is being processed, the command fails with `TPM_DOING_SELFTEST`. When Windows receives this error, it retries up to three times. If the command continues to fail, the operating system logs the event that is mentioned in the "Symptoms" section and then moves on.

## More information

You can safely ignore these errors, because Windows will fall back to the same mechanisms that are used to generate random numbers on systems that do not have a TPM chip. Additionally, Windows periodically retrieves a random number from the TPM chip. If this event is logged only one time, operating system was able to successfully obtain a random number.

## References

For information about the TPM specification, see the Trusted Computing Group (TCG) TPM Specification, Version 1.2, and the TCG PC Client TPM Interface Specification, Version 1.2. To do this, visit the following Trusted Computing Group website:
[http://www.trustedcomputinggroup.org/developers/pc_client/specifications](http://www.trustedcomputinggroup.org/developers/pc_client/specifications)  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
