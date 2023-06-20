---
title: Error loading when you run Integration package
description: This article helps you resolve package load failures that occur when SSIS cannot decrypt the password stored in the package.
ms.date: 09/02/2020
ms.custom: sap:Integration Services
ms.reviewer: craigg
---
# You receive an 'Error loading' error message when you try to run a SQL Server Integration Services package

This article helps you resolve package load failures that occure when SSIS cannot decrypt the password stored in the package.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 904800

## Symptoms

In Microsoft SQL Server, when you try to run a SQL Server Integration Services (SSIS) package from inside Microsoft SQL Server Business Intelligence Studio or by using the SQL Server Execute Package Utility (Dtexec.exe) command-line tool, you receive the following error message:

> Error loading **PackageName**: Failed to decrypt protected XML node "PackagePassword" with error 0x8009000B "Key not valid for use in specified state."  
You may not be authorized to access this information. This error occurs when there is a cryptographic error. Verify that the correct key is available.

> [!NOTE]
> The **PackageName** placeholder is a placeholder for the name of the SSIS package that you are trying to run.

This behavior occurs when you try to run the SSIS package by using a different computer or a different user account than the computer and user account that were used to create the SSIS package.

## Cause

This behavior occurs if the value of the `ProtectionLevel` property in the SSIS package is set to provide the maximum amount of protection for the Password property in the SSIS package. By default, the value of the `ProtectionLevel` property is set to **EncryptSensitiveWithUserKey**. The **EncryptSensitiveWithUserKey** value encrypts all the properties of the SSIS package that are considered sensitive, such as the Password property. When the same user account and the same computer that were used to create the SSIS package are used to run the SSIS package, the SSIS package automatically decrypts, and no error message is generated. However, when a different user account or a different computer is used to run the SSIS package, the **EncryptSensitiveWithUserKey** value of the `ProtectionLevel` property is engaged, and the Password property of the SSIS package remains encrypted. When this occurs, an error message is generated.

## Resolution

To resolve this behavior, change the value of the `ProtectionLevel` property in the SSIS package.

## More information

For more information, see the following topics in SQL Server Books Online:

- Security Considerations for Integration Services
- Setting the Protection Level of Packages

## References

For more information about a similar problem, see [SSIS package does not run when called from a SQL Server Agent job step](https://support.microsoft.com/help/918760).
