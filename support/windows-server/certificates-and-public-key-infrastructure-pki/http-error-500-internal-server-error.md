---
title: Http error 500.0 - internal server error when generating NDES enrollment challenge password on an NDES server that is running Windows Server 2012
description: Works around an error that occurs when trying to get the NDES enrollment challenge password.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jkuehler, kaushika
ms.custom: sap:network-device-enrollment-services-ndes, csstroubleshoot
---
# Error message when generating NDES enrollment challenge password on an NDES server that is running Windows Server 2012: Http error 500.0 - internal server error

This article helps work around an error that occurs when trying to get the NDES enrollment challenge password.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2800975

## Symptoms

Assume that you install the Network Device Enrollment Service (NDES) role service on a server that is running Windows Server 2012. In this scenario, you receive the following error when trying to get the NDES enrollment challenge password:

> Http error 500.0 - internal server error.  
 the page cannot be displayed because an internal server error has occurred.  

Additionally, an event that resembles the following is logged on the server on which the NDES role service is installed:

> Log Name: Application  
Source: Microsoft-Windows-NetworkDeviceEnrollmentService  
Date: date time  
Event ID: 2  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: computer name  
Description:  
The Network Device Enrollment Service cannot be started (0x800700ea). More data is available.

## Workaround

A workaround for this issue is to change the order of the handlers for the Microsoft Simple Certificate Enrollment Protocol (MSCEP) applications in IIS so that the ExtensionlessUrlHandler-ISAPI-4.0_64bit handler comes after the StaticFile handler. To do so, you can follow the steps below:

1. Install and configure NDES (and CEP/CES).
2. Open IIS.
3. Select "Default Web Site".
4. Click "View Applications" in the action panel on the right.
5. Double-click the mscep application.
6. Double-click "Handler Mappings".
7. Click "View Ordered List..." in the action panel.
8. Select ExtensionlessUrlHandler-ISAPI-4.0_64bit and move it down so it is below StaticFile.
9. Repeat steps 6-8 for the mscep_admin application.
10. Restart IIS.
