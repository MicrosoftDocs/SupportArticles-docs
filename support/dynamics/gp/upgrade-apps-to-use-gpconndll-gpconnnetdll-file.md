---
title: How to upgrade applications to use the GPConn.dll file or the GPConnNet.dll file in Microsoft Dynamics GP
description: Describes how to upgrade applications to use the GPConn.dll file or the GPConnNet.dll file in Microsoft Dynamics. These files replace the Crypto.dll file that's used in earlier versions of Microsoft Great Plains.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# How to upgrade applications to use the GPConn.dll file or the GPConnNet.dll file in Microsoft Dynamics GP

This article describes how to upgrade applications to use the GPConn.dll file or the GPConnNet.dll file in Microsoft Dynamics. These files replace the Crypto.dll file that's used in earlier versions of Microsoft Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912960

## Introduction

This article describes how to upgrade an application that uses the Crypto.dll file so that it instead uses the GPConn.dll file or the GPConnNet.dll file in Microsoft Dynamics GP. The Crypto.dll file works only with versions of Microsoft Great Plains that are earlier than version 9.0.

Microsoft Dynamics GP 9.0 and 10.0 include a change in the password policy that affects Dexterity in Microsoft Dynamics GP and also affects the Crypto.dll file. So you must replace code that calls the Crypto.dll file by using code that calls the new GPConn.dll file or the new GPConnNet.dll file.

## More information

To enable integrating applications to connect to the SQL database by using logon credentials for Microsoft Dynamics GP users, two more software components are provided: GPConn.dll and GPConnNet.dll. The GPConn.dll component provides COM and Win32 interfaces to create a database connection. The GPConnNet.dll provides a Microsoft .NET interface to create a database connection. Both components take logon credentials for a Microsoft Dynamics GP user in plain text format and return a connection to the database. Both .dll files require that registration keys be passed into them. Because these keys must be generated for your organization, you must open a Dexterity support incident to request keys for the new .dll files. You won't be charged for the initial support incident to request the keys. However, you may be charged for any more support incidents about how to implement a solution. You'll also receive documentation for the .dll file that you need.

If you're specifically using either of the .dll files from Visual Basic for Applications (VBA) or from VBScript in Integration Manager, the best integration option is to use the RetrieveGlobals9.dll file that's available on the Mod/VBA samples pages. In these situations, download the updated RetrieveGlobals9.dll file instead of requesting keys for the GPConn.dll file or the GPConnNet.dll file.

You can open a Dexterity support incident to obtain help that's unavailable in the documentation. You won't be charged for the initial support incident to request the .dll files. However, you may be charged for any more support incidents about how to implement a solution.

For more information about technical support options for Microsoft Business Solutions partners, customers, and ISVs, visit the following Microsoft Web site:

[Microsoft Dynamics Technical Support](https://support.microsoft.com/topic/df1e1f22-fb0c-48d8-6105-81febfbb87bf)
