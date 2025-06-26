---
title: OLE DB Provider for Jet and ODBC driver are 32-bit versions only
description: Describes that there are no 64-bit versions of the Microsoft OLE DB Provider for Jet or of the Jet ODBC driver.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Access
ms.date: 05/26/2025
---

# Microsoft OLE DB Provider for Jet and Jet ODBC driver are available in 32-bit versions only

## Introduction

The Microsoft OLE DB Provider for Microsoft Jet and the Microsoft Access ODBC driver (Jet ODBC driver) provide an interface to Microsoft Office Access databases. The Microsoft OLE DB Provider for Jet and the Jet ODBC driver are available in 32-bit versions only.

For example, you have a 32-bit application that uses the Microsoft OLE DB Provider for Jet. If you migrate the application to run in the 64-bit mode, the application can't connect to the data source by using the Microsoft OLE DB Provider for Jet. This issue occurs because the application requires a 64-bit version of the Microsoft OLE DB Provider for Jet.

However, you can still use the 32-bit version of the Microsoft OLE DB Provider for Jet and the 32-bit version of the Jet ODBC driver. In a 64-bit Windows environment, you can run an application in the 32-bit mode. This enables the application to use the 32-bit version of the Microsoft OLE DB Provider for Jet or the 32-bit version of the Jet ODBC driver.

## More information

The Jet Database Engine was designed to be a general-purpose database engine that's supplied together with Windows. The Access Database Engine, also called Access Connectivity Engine (ACE), is the Office database engine that's built from the foundation of Jet. ACE is provided in both 32-bit and 64-bit architectures. However, only one architecture is allowed on a device. The architecture of ACE must match the architecture of the Office installation on that computer. Both engines provide similar functionality, but ACE follows the design principles of Office and isn't suited for some of the previous scenarios that are supported by Jet. To make sure that ACE is the best solution for your scenario, read through all the intended use scenarios that are provided on the download page, [Download Microsoft Access Database Engine 2016 Redistributable](https://www.microsoft.com/download/details.aspx?id=54920).

To determine whether ACE is already available on your computer, or which installation is recommended, see [Unable to use the Access ODBC, OLEDB, or DAO interfaces outside Office Click-to-Run applications](./cannot-use-odbc-or-oledb.md).
