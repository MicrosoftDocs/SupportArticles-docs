---
title: Inconsistent results in MKL computations
description: This article provides a resolution for the problem where you get inconsistent results because of a missing environment variable.
ms.date: 01/14/2021
ms.custom: sap:Machine Learning Services (in database)
ms.topic: troubleshooting 
---
# Inconsistent results in MKL computations because of a missing environment variable in Microsoft R Server or Machine Learning Server

This article helps you resolve the problem where you get inconsistent results because of a missing environment variable.

_Applies to:_ &nbsp; SQL Server 2017 on Windows, Microsoft Machine Learning Server (R Server)  
_Original KB number:_ &nbsp; 4488257

## Symptoms

When you run Microsoft R Server 9.0, 9.1, 9.2, 9.3.x, or Microsoft Machine Learning Server as part of Microsoft SQL Server 2017, you experience inconsistent results in Intel Math Kernel Library (MKL) computations. This issue occurs because of a missing **MKL_CBWR** environment variable.

## Cause

This issue occurs because a new feature was added to the Intel MKL library that's included together with Microsoft R Server and SQL Server 2017. For more information about this feature, see [Introduction to Conditional Numerical Reproducibility (CNR)](https://software.intel.com/content/www/us/en/develop/articles/introduction-to-the-conditional-numerical-reproducibility-cnr.html)

## Resolution

To fix this issue, configure conditional numeric reproducibility in Microsoft R Server or Machine Learning Server by setting the **MKL_CBWR=AUTO** system environment variable. To do this, follow these steps:

1. In Control Panel, select **System and Security** > **System** > **Advanced System Settings** > **Environment Variables**.

2. Create a new User or System variable, and specify the following values:

   - Set the variable name to **MKL_CBWR**.
   - Set the variable value to **AUTO**.

3. Restart Microsoft R Server.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products.

In future versions of Microsoft R Server, the **MKL_CBWR=AUTO** setting will be the default setting.

## References

[Known issues in SQL Server Machine Learning Services](/sql/machine-learning/troubleshooting/known-issues-for-sql-server-machine-learning-services) Third-party information disclaimer

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
