---
title: OLE DB Provider for Jet and ODBC driver are 32-bit versions only
description: Describes that there are no 64-bit versions of the Microsoft OLE DB Provider for Jet or of the Jet ODBC driver.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Access
---

# Microsoft OLE DB Provider for Jet and Jet ODBC driver are available in 32-bit versions only

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## INTRODUCTION

The Microsoft OLE DB Provider for Microsoft Jet and the Microsoft Access ODBC driver (Jet ODBC driver) provide an interface to Microsoft Office Access databases. The Microsoft OLE DB Provider for Jet and the Jet ODBC driver are available in 32-bit versions only.

## More Information

We do not provide a 64-bit version of the Microsoft OLE DB Provider for Jet. Additionally, we do not provide a 64-bit version of the Jet ODBC driver. If you use the Microsoft OLE DB Provider for Jet or the Jet ODBC driver to connect to a data source in a 64-bit environment, you experience different problems.

For example, you have a 32-bit application that uses the Microsoft OLE DB Provider for Jet. If you migrate the application to run in the 64-bit mode, the application cannot connect to the data source by using the Microsoft OLE DB Provider for Jet. This issue occurs because the application requires a 64-bit version of the Microsoft OLE DB Provider for Jet.

However, we still have the 32-bit version of the Microsoft OLE DB Provider for Jet and the 32-bit version of the Jet ODBC driver. In a 64-bit Windows environment, you can run an application in the 32-bit mode. Therefore, the application can use the 32-bit version of the Microsoft OLE DB Provider for Jet or the 32-bit version of the Jet ODBC driver.