---
title: EWS notification return UnreadCount of -1
description: EWS push notification always returns incorrect value of UnreadCount property of notification, the issue is under investigation.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: catagh, v-six
appliesto: 
  - Exchange Server
  - Exchange Online
search.appverid: MET150
---
# Exchange Web Services notification events can sometimes return an UnreadCount of -1

_Original KB number:_ &nbsp; 4490422

## Symptoms

EWS push notifications sometimes return a value of **-1** for `UnreadCount`.

## Status

Microsoft is currently investigating this issue.

## Workaround

To work around this limitation, use a [GetFolder](/exchange/client-developer/web-service-reference/getfolder) request and include [PR_UNREAD_COUNT](/office/client-developer/outlook/mapi/pidtagcontentunreadcount-canonical-property) in the requested set of properties.

To include the `PR_UNREAD_COUNT` property, set the property tag to `PropertyTag="0x3603"` and the property type to `PropertyType="Integer"`.

\<ExtendedFieldURI PropertyTag="0x3603" PropertyType=" Integer"/>  

If you're using the EWS Managed API or EWS Java API, use the [ExtendedPropertyDefinition](/dotnet/api/microsoft.exchange.webservices.data.extendedpropertydefinition) class to request the `PR_UNREAD_COUNT` property.

## More information

For more information on properties and extended properties in EWS, see [Properties and extended properties in EWS in Exchange](/exchange/client-developer/exchange-web-services/properties-and-extended-properties-in-ews-in-exchange).
