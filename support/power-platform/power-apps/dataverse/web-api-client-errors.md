---
title: Troubleshoot Web API client errors
description: Provides resolutions for the common client errors that occur when you use the Dataverse Web API.
ms.date: 10/25/2023
author: divkamath
ms.author: dikamath
ms.reviewer: jdaly
manager: kvivek
search.audienceType: 
  - developer
search.app: 
  - PowerApps
  - D365CE
contributors: 
  - JimDaly
  - hakhemic
---
# Troubleshoot Dataverse Web API client errors

This article describes common client errors you might encounter when using the [Dataverse Web API](/power-apps/developer/data-platform/webapi/overview) and how you can avoid them.

## Resource not found for the segment

### Symptoms

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

### Cause

This error occurs when you use the incorrect name for a resource. That resource might be the name of an entity set, a function or an action. These resource names are case sensitive.

In the example above, there is an entity set called `accounts`, but not one named `Account`.

### How to avoid

- If the resource is an entity type, query the Web API [Service document](/power-apps/developer/data-platform/webapi/web-api-service-documents#service-document) which will provide a list of all the known entity set names.
- If the resource is a function or action, verify that the name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents#csdl-metadata-document).

## Could not find a property named '{property name}' on type 'Microsoft.Dynamics.CRM.{entity name}'

### Symptoms

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

### Cause

This error occurs when you use the incorrect name for a property. Property names are case sensitive.

In the example above, there is a property called `name`, but not one named `Name`.

### How to avoid

Verify that the name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents#csdl-metadata-document). For more information, see [Web API properties](/power-apps/developer/data-platform/webapi/web-api-properties).

## No HTTP resource was found that matches the request URI

### Symptoms

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

### Cause

This error occurs when the incorrect HTTP method is applied to a function or action. In this case, <xref:Microsoft.Dynamics.CRM.WhoAmI?text=WhoAmI Function> requires the use of `GET` but `POST` was used.

### How to avoid

Be aware of what kind of OData operation you are using and the correct HTTP method to use. For more information, see:

- [Web API Actions](/power-apps/developer/data-platform/webapi/web-api-actions)
- [Use Web API actions](/power-apps/developer/data-platform/webapi/use-web-api-actions)
- [Web API Functions](/power-apps/developer/data-platform/webapi/web-api-functions)
- [Use Web API functions](/power-apps/developer/data-platform/webapi/use-web-api-functions)

## Invalid property {property name} was found in entity 'Microsoft.Dynamics.CRM.{entity name}'

### Symptoms

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
  "message": "An error occurred while validating input parameters: 
    Microsoft.Crm.CrmException: Invalid property 'Name' was found in entity 'Microsoft.Dynamics.CRM.account'. 
    ---> Microsoft.OData.ODataException: Does not support untyped value in non-open type.<truncated for brevity>"
 }
}
```

### Cause

This error occurs because the incorrect name for a property was used. Property names are case sensitive and `Name` was used rather than `name`.

### How to avoid

Verify that the property name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents#csdl-metadata-document). For more information, see [Web API properties](/power-apps/developer/data-platform/webapi/web-api-properties).

## Error identified in Payload provided by the user for Entity '{entity name}'

There are two separate issues that can occur with this error. The difference is in the InnerException.

- [InnerException : Microsoft.OData.ODataException: An undeclared property [...] was found in the payload.](#innerexception--microsoftodataodataexception-an-undeclared-property--was-found-in-the-payload)
- [InnerException : System.ArgumentException: Stream was not readable.](#innerexception--systemargumentexception-stream-was-not-readable)

### InnerException : Microsoft.OData.ODataException: An undeclared property [...] was found in the payload

This error occurs when an invalid navigation property name is sent with a request.

#### Symptoms

**Request**

```http
POST [Organization URI]/api/data/v9.0/contacts HTTP/1.1

{
  "firstname":"test",
  "lastname":"contact",
  "parentcustomerid@odata.bind": "accounts(a779956b-d748-ed11-bb44-6045bd01152a)"
}
```

**Response**

```http
HTTP/1.1 400 Bad Request

{
    "error": {
        "code": "0x80048d19",
        "message": "Error identified in Payload provided by the user for Entity :'contacts'  ---->  
        InnerException : Microsoft.OData.ODataException: An undeclared property 'parentcustomerid' 
        which only has property annotations in the payload but no property value was found in the payload. 
        In OData, only declared navigation properties and declared named streams can be represented as 
        properties without values <truncated for brevity>".
    }
}
```

#### Cause

This error occurs because there is no single-valued navigation property in the contact entity type named `parentcustomerid`. For more information, see [contact EntityType > Single-valued navigation properties](/power-apps/developer/data-platform/webapi/reference/contact#single-valued-navigation-properties).

`parentcustomerid` is the logical name of a lookup column in the contact table. All lookups are represented by single-valued navigation properties in OData. The names of the lookup properties don't always match the corresponding single-valued navigation property name.

In this case, the `parentcustomerid` column is a customer lookup type, a kind of [multi-table lookup](/power-apps/developer/data-platform/webapi/web-api-navigation-properties#multi-table-lookups) that might link to either the account or contact tables. To support this customer lookup, there are two separate relationships and each has a different single-valued navigation property. The correct single-valued navigation property in this case is `parentcustomerid_account`.

#### How to avoid

Verify that the navigation property name you use exists in the [CSDL $metadata document](/power-apps/developer/data-platform/webapi/web-api-service-documents#csdl-metadata-document). For more information, see [Web API Navigation Properties](/power-apps/developer/data-platform/webapi/web-api-navigation-properties), especially the [Multi-table lookups](/power-apps/developer/data-platform/webapi/web-api-navigation-properties#multi-table-lookups) section.

### InnerException : System.ArgumentException: Stream was not readable

This error occurs when [executing batch operations](/power-apps/developer/data-platform/webapi/execute-batch-operations-using-web-api).

#### Symptoms

You get the following error when sending a `$batch` request.

**Response**

```http
HTTP/1.1 400 Bad Request

--batchresponse_5bd81edb-2ef9-4269-85c3-4623981e6c6e
Content-Type: application/http
Content-Transfer-Encoding: binary

HTTP/1.1 400 Bad Request
REQ_ID: 4c8c75eb-10bf-47f9-9998-c119146d511f
Content-Type: application/json; odata.metadata=minimal
OData-Version: 4.0

{"error":{"code":"0x80048d19","message":"Error identified in Payload provided by the user for Entity :'accounts',
For more information on this error please follow this help link https://go.microsoft.com/fwlink/?linkid=2195293
---->  InnerException : System.ArgumentException: Stream was not readable.\r\n
at System.IO.StreamReader..ctor(Stream stream, Encoding encoding, Boolean detectEncodingFromByteOrderMarks, Int32 bufferSize, Boolean leaveOpen)\r\n
at System.IO.StreamReader..ctor(Stream stream, Encoding encoding)\r\n
at Microsoft.OData.JsonLight.ODataJsonLightInputContext.CreateTextReader(Stream messageStream, Encoding encoding)\r\n
at Microsoft.OData.JsonLight.ODataJsonLightInputContext..ctor(ODataMessageInfo messageInfo, ODataMessageReaderSettings messageReaderSettings)\r\n
at Microsoft.OData.Json.ODataJsonFormat.CreateInputContext(ODataMessageInfo messageInfo, ODataMessageReaderSettings messageReaderSettings)\r\n
at Microsoft.OData.ODataMessageReader.ReadFromInput[T](Func`2 readFunc, ODataPayloadKind[] payloadKinds)\r\n
at System.Web.OData.Formatter.Deserialization.ODataResourceDeserializer.Read(ODataMessageReader messageReader, Type type, ODataDeserializerContext readContext)\r\n
at System.Web.OData.Formatter.ODataMediaTypeFormatter.ReadFromStream(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger)."}}
--batchresponse_5bd81edb-2ef9-4269-85c3-4623981e6c6e--
```

#### Cause

This deserialization error is caused by the use of line endings other than [CRLF](https://developer.mozilla.org/docs/Glossary/CRLF) in the batch request body.

Depending on the editor you use, these non-printing characters can be difficult to see . If you use [Notepad++](https://notepad-plus-plus.org/), you can use the **Show all characters** option to make these characters visible.

This payload will work:

:::image type="content" source="media/web-api-client-errors/batch-request-body-with-crlf-endings-for-all-lines.png" alt-text="Screenshot that shows a batch request body with CRLF endings for all lines.":::

This payload will fail because the last line doesn't end with `CRLF`.

:::image type="content" source="media/web-api-client-errors/batch-request-body-with-crlf-missing-last-line.png" alt-text="Screenshot that shows a batch request body with CRLF missing on the last line.":::

In this case, just adding a carriage return at the end of the last line is enough to make it succeed.

#### How to avoid

Ensure all line endings in the `$batch` request body are `CRLF`. If you can't use `CRLF`, add two non-`CRLF` line endings at the end of the batch request body to resolve this deserialization error. For more information, see [Batch requests](/power-apps/developer/data-platform/webapi/execute-batch-operations-using-web-api#batch-requests).

## See also

- [Web API types and operations](/power-apps/developer/data-platform/webapi/web-api-types-operations)
- [Compose HTTP requests and handle errors](/power-apps/developer/data-platform/webapi/compose-http-requests-handle-errors)
