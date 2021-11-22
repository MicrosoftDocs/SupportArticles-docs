---
title: Use the new RetrieveGlobals9.dll file
description: Describes how to use the new RetrieveGlobals9.dll file in Integration Manager and in Microsoft Dynamics GP 9.0 This new file uses Visual Basic for Applications (VBA) code.
ms.reviewer:
ms.topic: how-to
ms.date: 03/31/2021
---
# How to use the new RetrieveGlobals9.dll file in Integration Manager and in Microsoft Dynamics GP 9.0

This article describes how to use the new RetrieveGlobals9.dll file in Integration Manager and in Microsoft Dynamics GP 9.0. This file is now available for download.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 913341

## Introduction

When Microsoft Dynamics GP 9.0 was released, a change was made in the password policy. This change required changes in how Microsoft Dynamics GP Dexterity works with passwords and in how the RetrieveGlobals.dll file works with passwords. The RetrieveGlobals.dll file was available for all earlier versions but doesn't work with Microsoft Dynamics GP 9.0. So you must replace the RetrieveGlobals.dll file with the new RetrieveGlobals9.dll file.

The new RetrieveGlobals9.dll file is an ActiveX file. It returns the following information:

- The current user ID
- The current company to which you're signed in
- The current SQL data source
- The current user date in Microsoft Dynamics GP 9.0

The RetrieveGlobals9.dll file also returns an ActiveX Data Objects (ADO) connection object that lets you connect to Microsoft Dynamics GP data. The RetrieveGlobals9.dll file works only with version 9.0 of Microsoft Dynamics GP. Additionally, this file works only if you've one session of Microsoft Dynamics GP running and if you're signed into this session.

## More information

The RetrieveGlobals9.dll file is for use only in Modifier with VBA or in Integration Manager. Modifiers with VBA and Integration Manager both require that Microsoft Dynamics GP is open and running.

For more information about the new connection objects in Microsoft Dynamics GP 10.0, see [Information about the new connection objects in VBA that replace the RetrieveGlobals.dll and RetrieveGlobals9.dll files in Microsoft Dynamics GP 10.0](https://support.microsoft.com/help/936115).

The issue that is described in the Introduction section doesn't apply to Dynamics GP 10.0.
