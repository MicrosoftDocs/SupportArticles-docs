---
title: "Troubleshoot Web API client errors (Microsoft Dataverse)| Microsoft Docs"
description: "Describes common client errors you may encounter when using the Dataverse Web API and how you can avoid them."
ms.date: 06/05/2022
author: divka78
ms.author: dikamath
ms.reviewer: jdaly
manager: sunilg
search.audienceType: 
  - developer
search.app: 
  - PowerApps
  - D365CE
contributors: 
  - JimDaly
---
# Troubleshoot Dataverse Web API client errors

This topic describes common client errors you may encounter when using the [Dataverse Web API](/power-apps/developer/data-platform/webapi/overview) and how you can avoid them.

## Resource not found for the segment

**Request**

```http
GET [Organization URI]/api/data/v9.2/Account HTTP/1.1
```

**Response**

```http
HTTP/1.1 404 Not Found

{
 "error": {
  "code": "0x8006088a",
  "message": "Resource not found for the segment 'Account'."
 }
}
```

**Cause:**

This error occurs when you use the incorrect name for a resource. That resource might be the name of an entity set, a function or an action. These resource names are case sensitive.

In the example above, there is an entity set called `accounts`, but not one named `Account`.

**How to avoid:**

If the resource is an entity type, query the Web API [Service document](/power-apps/developer/data-platform/webapi/web-api-service-documents.md#service-document) and it will provide a list of all the known entity set names.

If the resource is a function or action, verify that the name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents.md#csdl-metadata-document).

## Could not find a property named '{property name}' on type 'Microsoft.Dynamics.CRM.{entity name}'

**Request**

```http
GET [Organization URI]/api/data/v9.2/accounts?$select=Name HTTP/1.1
```

**Response**

```http
HTTP/1.1 400 Bad Request

{
 "error": {
  "code": "0x0",
  "message": "Could not find a property named 'Name' on type 'Microsoft.Dynamics.CRM.account'."
 }
}
```

**Cause:**

This error occurs when you use the incorrect name for a property. Property names are case sensitive.

In the example above, there is property called `name`, but not one named `Name`.

**How to avoid:**

Verify that the name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents.md#csdl-metadata-document). More information: [Web API Properties](/power-apps/developer/data-platform/webapi/web-api-properties.md)

## No HTTP resource was found that matches the request URI

**Request**

```http
POST [Organization URI]/api/data/v9.2/WhoAmI
```

**Response**

```http
HTTP/1.1 404 Not Found

{
 "error": {
  "code": "",
  "message": "No HTTP resource was found that matches the request URI '[Organization URI]/api/data/v9.2/WhoAmI'."
 }
}
```

**Cause:**

This error occurs when the incorrect HTTP method is applied to a function or action. In this case, <xref:Microsoft.Dynamics.CRM.WhoAmI?text=WhoAmI Function> requires the use of `GET` but `POST` was used.

**How to avoid:**

Be aware of what kind of OData operation you are using and the correct HTTP method to use.

More information:

- [Web API Actions](/power-apps/developer/data-platform/webapi/web-api-actions.md)
- [Use Web API actions](/power-apps/developer/data-platform/webapi/use-web-api-actions.md)
- [Web API Functions](/power-apps/developer/data-platform/webapi/web-api-functions.md)
- [Use Web API functions](/power-apps/developer/data-platform/webapi/use-web-api-functions.md)

## Invalid property {property name} was found in entity 'Microsoft.Dynamics.CRM.{entity name}'

**Request**

```http
POST [Organization URI]/api/data/v9.2/accounts HTTP/1.1

{
 "Name": "Account name"
}
```

**Response**

```http
HTTP/1.1 400 Bad Request

{
 "error": {
  "code": "0x0",
  "message": "An error occurred while validating input parameters: Microsoft.Crm.CrmException: Invalid property 'Name' was found in entity 'Microsoft.Dynamics.CRM.account'. ---> Microsoft.OData.ODataException: Does not support untyped value in non-open type.<truncated for brevity>"
 }
}
```

**Cause:**

This error is because the incorrect name for a property was used. Property names are case sensitive and `Name` was used rather than `name`.

**How to avoid:**

Verify that the property name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents.md#csdl-metadata-document). More information: [Web API Properties](/power-apps/developer/data-platform/webapi/web-api-properties.md)

<!-- Template START

## Error Text: This should be a generic form of the most distinct error string that people would search for. Use brackets for placeholders.

**Request**

```http
GET [Organization URI]/api/data/v9.2/
```

**Response**

```http

```

**Cause:**

Describe cause for the error in the example.

**How to avoid:**

Describe how to avoid
Include links to related content

Template END-->

### See also

[Web API types and operations](/power-apps/developer/data-platform/webapi/web-api-types-operations)<br />
[Compose HTTP requests and handle errors](/power-apps/developer/data-platform/webapi/compose-http-requests-handle-errors)
