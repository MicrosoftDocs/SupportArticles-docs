---
title: Troubleshooting Data API builder usage
description: Troubleshoot common and well-known issues that might occur when you use Data API builder for Azure databases.
author: genlin
ms.author: genli
ms.reviewer: sidandrews
ms.service: data-api-builder
ms.date: 06/19/2024
ms.topic: troubleshooting-general
ms.custom: sap:Tools and Connectors
---

# Troubleshoot the usage of Data API builder for Azure databases

This article provides solutions to common errors that might occur when you use Data API builder for Azure databases.

## Generic endpoint: HTTP 400 "Bad Request" error

The following sections describe the causes and solutions to the HTTP 400 "Bad Request" error.

### Invalid Data API builder endpoint

The base of the URL path component maps to the Data API builder's REST or GraphQL endpoint. When the base of the URL path component doesn't match the value set in the Data API builder's runtime configuration, Data API builder returns an HTTP 400 "Bad Request" error.

You can configure the root paths for the GraphQL and REST endpoints in the `runtime` section of the Data API builder's runtime configuration. You must use the values to begin the URL paths for the REST and GraphQL endpoints.

For example, the following configuration sets `/api` as the root path of the REST endpoint and `/graphql` as the root of the GraphQL endpoint:

```json
"runtime": {
    "rest": {
      "enabled": true,
      "path": "/api"
    },
    "graphql": {
      "allow-introspection": true,
      "enabled": true,
      "path": "/graphql"
    },
    "...": "...",
}
```

So, the values you must use at the beginning of the URL paths for the REST and GraphQL endpoints are:

```https
/api/<entity>
```

```https
/graphql
```

> [!NOTE]
> When using Data API builder with the Static Web Apps using the Database Connections feature, the URL path begins with `/data-api`. You can add the value of your desired endpoint after this value. For example, `/data-api/api/<entity>` for REST and `/data-api/graphql` for GraphQL.

### Static Web Apps Database Connections configuration issue

When you use Data API builder with the Static Web Apps Database Connections feature, you encounter the error "Response status code does not indicate success: 400 (Bad Request)" in the response body:

```json
{"Message":"{\u0022Message\u0022:\u0022Response status code does not indicate success: 400 (Bad Request).\u0022,\u0022ActivityId\u0022:\u0022<GUID>\u0022}","ActivityId":"<GUID>"}
```

This error might indicate an issue with the configuration you provided when linking your database.

To resolve this issue, follow these steps:

1. Validate that your database credentials are valid in a tool like Azure Data Studio or SQL Server Management Studio (SSMS).
1. Unlink/Relink the connected database.

If you still encounter the error, ensure that you select **Allow Azure services and resources to access this server** for the **Exceptions** on the networking page of your Azure Database resource. This option configures the firewall to allow connections from IP addresses allocated to any Azure service or asset, including connections from other customers' subscriptions.

 :::image type="content" source="media/usage/allow-azure-resources-to-access-server.png" alt-text="Screenshot that shows the 'Allow Azure services and resources to access this server' checkbox." lightbox="media/usage/allow-azure-resources-to-access-server.png":::

## REST endpoint: HTTP 404 "Not Found" error

If the requested URL points to a route that's not associated with any entity, an HTTP 404 error is returned. By default, the entity's name is also the route name. For example, if you configure the sample `Todo` entity in the configuration file like the following example:

```json
"Todo": {
      "source": "dbo.todos",
      "...": "..."
    }
```

Then, the `Todo` entity is reachable via the following route:

```https
/<rest-route>/Todo
```

If you specify the `rest.path` property in the entity configuration to `todo`, as shown in the following example:

```json
"Todo": {
    "source": "dbo.todos",
    "rest": {
      "path": "todo"
    },
    "...": "..."
  }
```

Then, the URL route for the `Todo` entity is `todo`, with all lowercase characters matching the exact value defined in the runtime configuration:

```https
/<rest-route>/todo
```

## GraphQL endpoint: HTTP 400 "Bad Request" error

A GraphQL request results in an HTTP 400 "Bad Request" error every time the GraphQL request is constructed incorrectly. It might be due to a non-existing entity field or a misspelled entity name. Data API builder returns a descriptive error and error details in the response payload.

When you send a `GET` request to the GraphQL endpoint, the response body of the returned error states, "Either the parameter query or the parameter ID has to be set." Make sure to send your GraphQL requests using HTTP `POST`.

## GraphQL endpoint: HTTP 404 "Not Found" error

Make sure the GraphQL request is sent to the configured GraphQL endpoint by using the HTTP `POST` method. By default, the GraphQL endpoint route is `/graphql`.

## GraphQL endpoint: "The object type Query has to at least define one field in order to be valid" error

When the Data API builder startup fails to generate a GraphQL schema based on your runtime configuration, you receive the error message:

> The object type Query has to at least define one field in order to be valid.

The GraphQL specification requires at least one `Query` object be defined in the GraphQL schema. You must validate that your runtime configuration meets one of the following conditions:

- The `read` action is defined for at least one GraphQL-enabled entity. GraphQL is enabled on entities by default, so ensure that you *don't* apply this mitigation to an entity configured with `{"graphql": false}`.
- When you only expose stored procedures, define `{ "graphql": { "operation": query" } }` on at least one stored procedure entity, which overrides the default stored procedure GraphQL operation type `mutation`.
  
    You must have at least one stored procedure that only reads and doesn't modify the data. Otherwise, GraphQL schema generation fails due to an empty `query` field in the schema.

## GraphQL endpoint: Introspection doesn't work with the GraphQL endpoint

Tools that support GraphQL normally utilize GraphQL schema introspection without requiring extra setup. Make sure you set the runtime configuration property `allow-introspection` to `true` in the `runtime.graphql` configuration section. For example:

```json
"runtime": {
    "...": "...",
    "graphql": {
      "allow-introspection": true,
      "enabled": true,
      "path": "/graphql"
    },
    "...": "..."
}
```

## GraphQL endpoint: "The mutation operation \<operation_name> was successful but the current user is unauthorized to view the response due to lack of read permissions" error

For a GraphQL mutation operation to receive a valid response, read permissions should be configured in addition to the respective mutation operation type - create, update, and delete. As the error suggests, the mutation operation (create/update/delete) was successful at the database layer, but the lack of read permission caused Data API builder to return an error message. So, make sure to configure read permissions either in the "Anonymous" role or the role with which you want to execute the mutation operation.

## General error: HTTP 500 error returned by requests

HTTP 500 errors indicate that Data API builder can't properly operate on the backend database. Make sure to meet the following conditions:

- Data API builder can still connect to the configured database.
- The database objects used by Data API builder are still available and accessible.

To allow Data API builder to return specific database errors in responses, set the `runtime.host.mode` configuration property to `development`:

```json
"runtime": {
    [...]
    "host": {
        "mode": "development",
        [...]
    }
}
```

By default, Data API builder runs with `runtime.host.mode` that's set to `production`. In `production` mode, Data API builder doesn't return detailed errors in the response payload.

In both `development` and `production` modes, Data API builder writes detailed errors to the console to help with troubleshooting.

## General errors due to unauthenticated and unauthorized requests

### HTTP 401 "Unauthorized" error

HTTP 401 errors occur when the endpoint and entity being accessed require authentication and the requestor doesn't provide valid authentication metadata in their request.

When you configure Data API builder to use Microsoft Entra ID authentication, your requests result in HTTP 401 errors when the provided bearer (access) token is invalid. An access token can be invalid for many reasons. Here are some of them:

- The access token has expired.
- The access token isn't meant for the Data API builder's API (wrong access token audience).
- The access token isn't created by the expected authority (invalid access token issuer).

To resolve this error, make sure to meet the following conditions:

- You generate an access token using the `issuer` value defined in the `authentication` section of the runtime configuration.

- Your access token is generated for the `audience` value defined in the `authentication` section of the runtime configuration.

Here's a sample configuration:

```json
"authentication": {
    "provider": "AzureAD",
    "jwt": {
        "issuer": "https://login.microsoftonline.com/24c24d79-9790-4a32-bbb4-a5a5c3ffedd5/v2.0/",
        "audience": "b455fa3c-15fa-4864-8bcd-88fd83d686f3"
    }
}
```

You must generate a valid token for the defined audience. When using the Azure CLI, you can get an access token by specifying the audience in the `resource` parameter:

```azurecli
az account get-access-token --resource "b455fa3c-15fa-4864-8bcd-88fd83d686f3"
```

### HTTP 403 "Forbidden" error

If you send an authenticated request using Static Web Apps integration or Microsoft Entra ID, you might receive an HTTP 403 "Forbidden" error. This error indicates that you try to use a role that doesn't exist in the configuration file.

This error occurs when: 

- You don't provide an `X-MS-API-ROLE` HTTP header specifying a role name.

    Because **authenticated** requests are executed in the context of the system role `authenticated` by default, this scenario only applies when you use a non-system role (not `authenticated` nor `anonymous`).
- The role you define in the `X-MS-API-ROLE` header isn't configured in the Data API builder's runtime configuration file.
- The role you define in the `X-MS-API-ROLE` header doesn't match the role in your access token.

For example, in the following runtime configuration file, the role `role1` is defined, so you must provide an `X-MS-API-ROLE` HTTP header with the value `role1`.

> [!NOTE]
> Role name matching is case-sensitive.

```json
"Todo": {
    "role": "role1",
    "actions": [ "*" ]
}
```

## References

- [Troubleshoot the installation of Data API builder for Azure databases](installation.md)
- [Known issues in the Azure/data-api-builder GitHub repository](https://github.com/azure/data-api-builder/labels/known-issue)

## Next step

If your issue isn't resolved, provide feedback or report it in the [data-api-builder Discussions](https://github.com/azure/data-api-builder/discussions).

[!INCLUDE[Azure Help Support](../../includes/azure-help-support.md)]
