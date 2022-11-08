---
title: Input string was not in a correct format error when processing a message in eConnect
description: When you process a message in eConnect in Microsoft Dynamics GP, you receive an error message that states Input string was not in a correct format.
ms.reviewer: dclauson
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "System.FormatException: Input string was not in a correct format" error when you process a message in eConnect

This article provides a resolution for the **Input string was not in a correct format** error that may occur when you process a message in eConnect in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917001

## Symptoms

When you process a message, you receive the following error message from the eConnect Incoming Service:

> System.FormatException: Input string was not in a correct format.

## Cause

This problem occurs because the incoming message contains a non-numeric value in at least one field that has a numeric data type.

## Resolution

To resolve this problem, review the **Incoming Schemas** topic in the eConnect Help. This topic contains a list of the data types for each field in the schema that you are using. Then, modify the value of any fields that have a numeric data type and that contain a non-numeric value in the XML data of your message.
