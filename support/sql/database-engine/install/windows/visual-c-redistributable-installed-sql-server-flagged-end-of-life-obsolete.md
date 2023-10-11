---
title: Visual C++ Redistributable installed with SQL Server alerts end of life or obsolete
description: Provides a resolution for an issue where a Microsoft Visual C++ Redistributable installed with SQL Server is flagged as end of life or obsolete software components.
ms.date: 06/28/2023
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: sureshka, v-sidong
---
# Microsoft Visual C++ Redistributable installed with SQL Server is flagged as end of life or obsolete

## Symptoms

When you install Microsoft SQL Server on a computer and the SQL Server setup program installs a Microsoft Visual C++ Redistributable, your security software may send alerts about end of life (EOL) or obsolete software components on this computer. These security alerts refer to the following Microsoft Visual C++ Redistributable components.

|SQL Server version|Redistributable installed by SQL Server|
|-|-|
|SQL Server 2016|Microsoft Visual C++ 2010 Redistributable|
|SQL Server 2014|Microsoft Visual C++ 2010 Redistributable|
|SQL Server 2012|Microsoft Visual C++ 2010 Redistributable|

## Cause

The security software produces alerts for the following reason:

According to the lifecycle policy, [support for Visual Studio components that belong to version 2010](/lifecycle/products/visual-studio-2010) ended in the year 2020. This policy is applicable for the standalone installation of these components.

## Resolution

If the Microsoft Visual C++ Redistributable is installed as part of SQL Server, it will continue to be supported until the end of the [SQL Server lifecycle](/sql/sql-server/end-of-support/sql-server-end-of-support-overview).

If you receive these alerts on computers that have the listed SQL Server versions installed, we recommend that you work with your security team to implement exclusions for those computers as appropriate. If you receive these alerts on computers that don't have the listed SQL Server versions installed, follow the guidance provided in the alert details.

> [!NOTE]
> There may be third-party products, such as security scanners, that flag the Redistributable as expired. If the Microsoft Visual C++ Redistributable is installed by a Microsoft product that's still in support, the Redistributable is in support per the Microsoft component policy for that product. For more information, see [Microsoft Visual C++ Redistributable](/visualstudio/productinfo/vs-servicing#microsoft-visual-c-redistributable).

Don't uninstall any component that SQL Server installs as part of the standard setup and patching process. If you remove the Microsoft Visual C++ Redistributable, SQL Server components and features might encounter unexpected behavior and results. For example, programs within SQL Server rely on the specific behavior of [C runtime functions](/cpp/c-runtime-library/reference/crt-alphabetical-function-reference) and may fail if Visual C++ runtime is removed. You may also notice that these components get reinstalled when you perform patching of the SQL Server instances.

## More information

- The [Redistributable package policy](../../../../developer/visualstudio/cpp/libraries/minimum-service-pack-levels.md#summary) indicates:

   If the Visual C++ Redistributable is installed by a product that's still in support, the Redistributable is in support per the Lifecycle General Policy for that product.

- The Redistributable lifecycle policy is stated in [Microsoft Visual C++ Redistributable](/visualstudio/releases/2019/servicing-vs2019#microsoft-visual-c-redistributable).  

   There are a few specific instances where the Microsoft Visual C++ Redistributable is still supported beyond the underlying Visual Studio product lifecycle, only for security fixes and only in the context and timeframe of the Microsoft product(s) that depend on it. One such instance is when the Microsoft Visual C++ Redistributable is distributed in other Microsoft products, such as SQL Server, Windows Server, or Microsoft Office.

- SQL Server 2017 and later versions install Microsoft Visual C++ 2015 or higher. Per [Microsoft Visual C++ Redistributable latest supported downloads](/cpp/windows/latest-supported-vc-redist), Visual Studio versions since Visual Studio 2015 share the same Redistributable files. For example, any apps built by the Visual Studio 2015, 2017, 2019, or 2022 toolsets can use the latest Microsoft Visual C++ Redistributable.
