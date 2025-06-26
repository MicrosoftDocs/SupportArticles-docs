---
title: GetFolder requests return wrong TotalCount values
description: This article describes a limitation that the EWS GetFolder returns an incorrect TotalCount value when it's issued against a Public Folder mailbox hosted in Exchange Online and provides a workaround.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: catagh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
---
# GetFolder requests for Public Folder mailbox hosted in Exchange Online return wrong TotalCount value

_Original KB number:_ &nbsp; 4490420

## Symptoms

When you issue an Exchange Web Services (EWS) `GetFolder` request to a public folder mailbox that's hosted in Microsoft 365 Exchange Online, the `TotalCount` returned in the response contains an incorrect value of **0** or **-1**.

## Cause

This is a known architecture limitation. The issue occurs because the public folder hierarchy and content are stored in separate mailboxes.

## Workaround

To work around this limitation, use the [ExtendedFieldURI](/exchange/client-developer/web-service-reference/extendedfielduri) element to include [PR_CONTENT_COUNT](/office/client-developer/outlook/mapi/pidtagcontentcount-canonical-property) in the requested set of properties.

To include the [PR_CONTENT_COUNT](/office/client-developer/outlook/mapi/pidtagcontentcount-canonical-property) property, set the property tag to PropertyTag="0x3602" and the property type is PropertyType="Integer".

```console
<ExtendedFieldURI PropertyTag="0x3602" PropertyType=" Integer"/>
```

If you are using the EWS Managed API or EWS Java API, use the [ExtendedPropertyDefinition](/dotnet/api/microsoft.exchange.webservices.data.extendedpropertydefinition) class to request the [PR_CONTENT_COUNT](/office/client-developer/outlook/mapi/pidtagcontentcount-canonical-property) property.

## More information

For more information about properties and extended properties in EWS, see [Properties and extended properties in EWS in Exchange](/exchange/client-developer/exchange-web-services/properties-and-extended-properties-in-ews-in-exchange).
