---
title: 0-byte file is returned
description: This article provides a resolution for the problem where A 0-byte file might be returned when compression is enabled on a server that is running IIS.
ms.date: 03/30/2020
ms.custom: sap:Site behavior and performance
ms.subservice: site-behavior-performance
---
# A 0-byte file might be returned when compression is enabled on a server that is running IIS

This article helps you resolve the problem where a 0-byte file might be returned instead of the expected file when compression is enabled on a server that is running Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 8.0, 8.5  
_Original KB number:_ &nbsp; 817442

## Symptoms

When compression is enabled on a server running IIS, and an HyperText Transfer Protocol (HTTP) request is served from the IIS compression directory, a 0-byte file may be returned instead of the expected file.

> [!NOTE]
> You may only see these symptoms if HTTP Static Compression is enabled.

## Cause

Antivirus software running on the IIS server is scanning the IIS compression directory.

## Resolution

Exclude the IIS compression directory from the antivirus software's scan list. The steps may vary based on the antivirus software you're using. Microsoft recommends you contact the manufacturer of the antivirus software for information about how to exclude directories from scanning.

## More information

The default compression directory in IIS 6.0 is `%systemroot%\IIS Temporary Compressed Files`. This directory may have been changed to another location. In IIS 7.0 or a later version for IIS 7.0, the default location of the compressed file cache is `%SystemDrive%\inetpub\temp\IIS Temporary Compressed Files`.

To verify the compression directory, follow these steps:

1. Select **Start**, point to **Programs,** point to **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In IIS Manager, right-click the **Web Sites** folder, and then select **Properties**.
3. Select the **Service** tab.
4. Under **HTTP Compression**, make sure that **Compress static files** is selected, and then locate the path to the temporary directory.
