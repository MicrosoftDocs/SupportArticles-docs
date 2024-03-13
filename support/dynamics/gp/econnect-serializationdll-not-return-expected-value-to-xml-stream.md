---
title: The eConnect Serialization.dll file doesn't return the expected value into the XML stream that serialized in a Visual Studio project
description: The eConnect Serialization.dll file doesn't return the expected value into the XML stream that serialized in a Visual Studio project.
ms.reviewer: dclauson
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The eConnect Serialization.dll file doesn't return the expected value into the XML stream that serialized in a Visual Studio project

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917000

The eConnect Serialization.dll file doesn't return the expected value into the XML stream that's serialized in a Microsoft Visual Studio project. The eConnect Serialization.dll file is included in the Microsoft Dynamics GP 9.0 eConnect installation CD.

Some elements that are available in the XML node contain an element name specified property. You must set this property to True.

For example, the taUpdateCreateCustomerRcd node contains a BALNCTYP element and a BALNCTYPSpecified element. The BALNCTYPSpecified element must be set to True before the BALNCTYP element for the value of the BALNCTYP element to be correctly serialized.

For example, you must use the following code example.

`.BALNCTYPSpecified = True .BALNCTYP = 1`
