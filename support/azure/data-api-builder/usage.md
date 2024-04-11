---
title: Troubleshooting Data API builder usage
description: Troubleshoot common issues that might occur when you use the Data API builder for Azure databases.
ms.reviewer: jerrynixon, sidandrews
ms.service: data-api-builder
ms.date: 04/10/2024
---
# Troubleshoot the usage of Data API builder for Azure databases

This article provides solutions to common issues that might occur when you use Data API builder for Azure databases.

## Generic endpoints: HTTP 400 "Bad Request" error

The following sections describe causes and solutions of the HTTP 400 "Bad Request" error.

### Invalid Data API builder endpoint

The base of the URL path component maps to Data API builder's REST or GraphQL endpoint. When the base of the URL path component doesn't match a value set in Data API builder's runtime configuration, Data API builder returns an HTTP 400 "Bad Request" error.

You can configure the root paths of the GraphQL and REST endpoints in the `runtime` section of Data API builder's runtime configuration. You must use the values at the beginning of the URL paths for the REST and GraphQL endpoints.

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
> When using Data API builder with the Static Web Apps using the Database Connections feature, the beginning of the URL path is `/data-api`. You can add the value for your desired endpoint after that value. For example, `/data-api/api/<entity>` for REST and `/data-api/graphql` for GraphQL.

### Static Web Apps Database Connections configuration issue

When you use Data API builder with the Static Web Apps Database Connections feature, you encounter an error "Response status code doesn't indicate success: 400 (Bad Request)." in the response body:

```json
{"Message":"{\u0022Message\u0022:\u0022Response status code does not indicate success: 400 (Bad Request).\u0022,\u0022ActivityId\u0022:\u0022<GUID>\u0022}","ActivityId":"<GUID>"}
```

This error might indicate an issue whith the configuration you provide when linking your database.

To resolve this issue, follow these steps:

1. Validate your database credentials work in a tool like Azure Data Studio or SQL Server Management Studio (SSMS).
1. Unlink/Relink the connected database.

If you still encounter the error, ensure that you select **"Allow Azure services and resources to access this server"** for the **Exceptions** in the networking page of your Azure Database resource. This option configures the firewall to allow connections from IP addresses allocated to any Azure service or asset, including connections from the subscriptions of other customers.

 :::image type="content" source="media/usage/allow-azure-resources-to-access-server.png" alt-text="Screenshot that shows the 'Allow Azure services and resources to access this server' checkbox.":::

## REST endpoints: HTTP 404 "Not Found" error

If the requested URL points to a route that's not associated with any entity, an HTTP 404 error is returned. By default, the name of the entity is also the route name. For example, if you configured the sample `Todo` entity in the configuration file like the following sample:

```json
"Todo": {
      "source": "dbo.todos",
      "...": "..."
    }
```

The entity `Todo` is reachable via the following route:

```https
/<rest-route>/Todo
```

If you specified the `rest.path` property in the entity configuration to `todo` as shown in the following example:

```json
"Todo": {
    "source": "dbo.todos",
    "rest": {
      "path": "todo"
    },
    "...": "..."
  }
```

Then the URL route for the `Todo` entity is `todo` with all lower case characters matching the exact value defined in the runtime configuration:

```https
/<rest-route>/todo
```

## GraphQL endpoints: HTTP 400 "Bad Request" error

GraphQL requests result in an HTTP 400 "Bad Request" error every time the GraphQL request is improperly constructed. It could be due to a nonexisting entity field or the misspelled entity name. Data API builder returns a descriptive error and error details in the response payload.

When you send a `GET` request to the GraphQL endpoint, the response body of the returned error states *"Either the parameter query or the parameter ID has to be set."*. Make sure you're sending your GraphQL requests using HTTP `POST`.

## GraphQL endpoints: HTTP 404 "Not Found" error

Make sure the GraphQL request is sent to the configured GraphQL endpoint by using the HTTP `POST` method. By default, the GraphQL endpoint route is `/graphql`.

## GraphQL endpoints: "The object type Query has to at least define one field in order to be valid" error

When Data API builder startup fails to generate a GraphQL schema based on your runtime configuration, you receive the error message:

> The object type Query has to at least define one field in order to be valid.

The GraphQL specification requires at least one `Query` object be defined in a GraphQL schema. You must validate that your runtime configuration has one of the following properties:

- The `read` action defined for at least one GraphQL enabled entity. GraphQL is enabled on entities by default, so ensure that you *don't* apply this mitigation to an entity configured with `{"graphql": false}`.
- When you're only exposing stored procedures, `{ "graphql": { "operation": query" } }` is defined on at least one stored procedure entity, which override the default stored procedure GraphQL operation type `mutation`.
  
    You must have at least one stored procedure, which only reads and doesn't modify data. Otherwise, GraphQL schema generation fails due to an empty `query` field in the schema.

## GraphQL endpoints: Introspection doesn't work with GraphQL endpoint

Tooling that supports GraphQL normally utilizes GraphQL schema introspection without extra setup. Make sure you set the runtime configuration property `allow-introspection` to `true` in the `runtime.graphql` configuration section. For example:

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

## GraphQL endpoints: "The mutation operation \<operation_name> was successful but the current user is unauthorized to view the response due to lack of read permissions" error

For a graphQL mutation operation to receive a valid response, read permission should be configured in addition to the respective mutation operation type -  create/update/delete. As the error suggests, the mutation operation(create/update/delete) was successful at the database layer but the lack of read permission caused Data API builder to return an error message. So, make sure to configure read permission either in the Anonymous role or the role with which you would like to execute the mutation operation.

## General errors: HTTP 500 error returned by requests

HTTP 500 errors indicate that Data API builder can't properly operate on the backend database. Make sure the following:

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

In both `development` or `production` modes, Data API builder writes detailed errors to the console to help with troubleshooting.

## General errors due to unauthenticated and unauthorized requests

### HTTP 401 "Unauthorized" error

HTTP 401 errors occur when the endpoint and entity being accessed require authentication and the requestor doesn't supply valid authentication metadata with their request.

When you configure Data API builder to use Microsoft Entra ID authentication, your requests result in HTTP 401 errors when the provided bearer (access) token is invalid. There are many reasons an access token might be invalid. A nonexhaustive list of reasons are:

- Expired access token.
- Access token isn't meant for Data API builder's API (wrong access token audience).
- Access token isn't created from the expected authority (invalid access token issuer).

To resolve this error, make sure the following:

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

You must generate a token valid for the defined audience. When using the Azure CLI, you can get an access token by specifying the audience in the `resource` parameter:

```azurecli
az account get-access-token --resource "b455fa3c-15fa-4864-8bcd-88fd83d686f3"
```

### HTTP 403 "Forbidden" error

If you send an authenticated request using Static Web Apps integration or Microsoft Entra ID, you might receive an HTTP 403 "Forbidden" error. This error indicates that you try to use a role that doesn't exist in the configuration file.

This error occurs in the following circumstances: 

1. You don't supply an `X-MS-API-ROLE` HTTP header specifying a role name.

    Because by default, **authenticated** requests execute in the context of the system role `authenticated`, this scenario only applies when you use a nonsystem role (not `authenticated` nor `anonymous`).
1. The role you define in the `X-MS-API-ROLE` isn't configured in Data API builder's runtime configuration file.
1. The role you define in the `X-MS-API-ROLE` header doesn't match a role in your access token.

For example, in the following runtime configuration file, the role `role1` is defined, so you must supply a `X-MS-API-ROLE` HTTP header with the value `role1`.

> [!CAUTION]
> Roles name matching is case-sensitive
```json
"Todo": {
    "role": "role1",
    "actions": [ "*" ]
}
```

## References

- [Troubleshoot the installation of Data API builder for Azure databases](installation.md)
- [Known issues in the Azure/data-api-builder GitHub repository](https://github.com/azure/data-api-builder/labels/known-issue)

## Next Step

If your issue isn't resolved, provide feedback or report it in the [data-api-builder Discussions](https://github.com/azure/data-api-builder/discussions).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
