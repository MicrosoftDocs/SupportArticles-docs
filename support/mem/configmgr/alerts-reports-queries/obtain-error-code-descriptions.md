---
title: Obtain error code descriptions
description: Describes how to convert error codes to a hexadecimal value to obtain an error description in Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Reports and subscriptions
---
# How to obtain error code descriptions in Configuration Manager reports

This article describes how to obtain error code descriptions in Configuration Manager reports.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 944375

## Obtain error code descriptions

Some reports that are included together with Configuration Manager display errors codes that don't contain an error description. However, you can obtain a description by deciphering the error code. To do this, follow these steps:

1. In the Configuration Manager console, open the report that contains the error code that you want to decipher.
2. Convert the error code from decimal to hexadecimal. For example, if the error code is **-2147012889**, you must convert **-2147012889** to a hexadecimal value. In this case, the hexadecimal value is **FFFFFFFF80072EE7**.

3. Remove the **FFFFFFFF** in front of the converted error code. In this example, the error code becomes **80072EE7**.

4. Use the following information to locate the error description:

   - Converted error codes that begin with **80072** are typically WinHTTP error codes, such as **host not found** errors. Convert the trailing four hexadecimal bytes to a decimal value. For example, **2EE7** is **12007** decimal. To view the WinHTTP error codes, see [Error Messages](/windows/win32/winhttp/error-messages?redirectedfrom=MSDN).

     For example, error code **12007** maps to the following error description:

     > ERROR_WINHTTP_NAME_NOT_RESOLVED 12007 The server name cannot be resolved

   - Converted error codes that begin with **8009** are typically CryptoAPI error codes, such as **certificate expired** errors or **CN= mismatch** errors. You can use the Trace32 program to view the error code directly when you type trace32 together with the error code. For more information about CryptoAPI error codes and other Windows System error codes, see [Error Codes](/windows/win32/debug/system-error-codes?redirectedfrom=MSDN).

   - Converted error codes that begin with **800402** or **800403** are typically Configuration Manager error codes.

   - All other error codes are typically Windows error codes or third-party error codes. All Windows error codes can be identified by using the Trace32 program and by specifying the error code, such as **80072EE7**.
