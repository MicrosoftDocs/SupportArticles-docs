---
title: Maximum row size exceeds the allowed maximum
description: Describes an issue where the message Maximum row size exceeds the allowed maximum occurs during solution import.
ms.reviewer: matp
ms.topic: troubleshooting
ms.date: 08/01/2023
author: nhelgren
ms.author: nhelgren
---
# Maximum row size exceeds the allowed maximum

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

During a solution import that includes columns that aren't already present in a target table, the following information is included in an error:

> Exception type: System.ServiceModel.FaultException`1[Microsoft.Xrm.Sdk.OrganizationServiceFault]
Creating or altering table [table name] failed because the minimum row size would be 8070, including 1287 bytes of internal overhead. This exceeds the maximum allowable table row size of 8060 bytes.

## Cause

SQL has a hard row limit of 8060 bytes per row. Each column consumes some of this space, the size varies by data type.

## Workaround

This limit can't be extended. You have to remove columns in order to successfully import.

The following include estimated total columns and size for various data types:

- Choices columns: 4 bytes.
- Date and Time: 8 bytesID 20 bytes + more depending on unicode values.
- Lookups: Two to three columns each consuming 16 bytes or more depending on unicode values are added for each lookup depending on if it's a standard lookup or custom polymorphic lookup.
- Image: Two columns are used one for the image and one for the thumbnail, size may vary depending on pointer size and thumbnail.
- File: Varies depending on pointer size.
- Currency: Consumes between two to four columns depending on the decimal conversion. Number of bytes vary depending on the decimal conversion.
- Multiline text: Up to 24 bytes.
