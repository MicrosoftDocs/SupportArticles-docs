---
title: Timeout issues when you deploy SQL CLR objects
description: This article provides resolutions for the timeout issues that occur when deploying SQL CLR objects through Visual Studio.
ms.date: 01/20/2021
ms.custom: sap:Database Design and Development
---

# You may experience timeout issues when deploying SQL CLR objects through Visual Studio

This article helps you resolve the timeout problem that occurs when deploying SQL Common Language Runtime (CLR) objects through Visual Studio.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2011805

## Symptoms

When you deploy SQL CLR objects from Visual Studio to SQL Server, you may experience various errors similar to the following:

- Error message 1:

    > Error: starting database upload transaction failed.  
     Error: The operation could not be completed

- Error message 2:

    > Deploying file: TEstAssembly.dll, Path: E:\cases\CL MY\TEstAssembly\TEstAssembly\obj\Debug\TEstAssembly.dll ...
     Error: Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.  

But if you deploy the same CLR objects using `CREATE ASSEMBLY` command in SQL Server Management Studio you don't experience any issues.

## Cause

The issue occurs when the SQL CLR objects are so large that it takes a long time to deploy them to SQL Server. The default timeout value for connections is 15 seconds and for queries is 30 seconds respectively. When deploying large assemblies, the `CREATE ASSEMBLY` statement that gets executed on the SQL Server backend may take more than 30 seconds to return resulting in the error described in the [Symptoms](#symptoms) section.

## Resolution

Increase the Query timeout and Connection timeout values in Visual Studio using the following procedures.

### Changing the Query Timeout

1. In Visual Studio IDE, navigate to **Tools** -> **Options** -> **Database Tools** -> **Query and View Designers**.  

1. You can either uncheck the option **Cancel long running query** or change the value of the **Cancel after** option **** to a higher value.

### Changing the Connection Timeout

1. In Visual Studio IDE, enable Server Explorer by navigating to **View** -> **Server Explorer**.  

1. In the Server Explorer, right click on the connection to SQL Server where the CLR objects are being deployed and select **Modify Connection**.

1. Select the **Advanced** button in the **Modify Connection** window.

1. In the **Advanced Properties** window, change the **Connect Timeout** value under the **Initialization** section to a higher value.
