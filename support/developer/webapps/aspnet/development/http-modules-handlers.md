---
title: ASP.NET HTTP modules and handlers
description: This article provides information about the HTTP modules and HTTP handlers.
ms.date: 04/03/2020
ms.custom: sap:General Development
ms.reviewer: mdunner
ms.topic: how-to
---
# ASP.NET HTTP modules and HTTP handlers

This article introduces the ASP.NET Hypertext Transfer Protocol (HTTP) modules and HTTP handlers.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 307985

## Summary

HTTP modules and HTTP handlers are an integral part of the ASP.NET architecture. While a request is being processed, each request is processed by multiple HTTP modules (for example, the authentication module and the session module) and is then processed by a single HTTP handler. After the handler has processed the request, the request flows back through the HTTP modules.

## HTTP modules overview

Modules are called before and after the handler executes. Modules enable developers to intercept, participate in, or modify each individual request. Modules implement the `IHttpModule` interface, which is located in the `System.Web` namespace.

## Available events that HTTP modules can synchronize with

An `HttpApplication` class provides a number of events with which modules can synchronize. The following events are available for modules to synchronize with on each request. These events are listed in sequential order:

- `BeginRequest`: Request has been started. If you need to do something at the beginning of a request (for example, display advertisement banners at the top of each page), synchronize this event.

- `AuthenticateRequest`: If you want to plug in your own custom authentication scheme (for example, look up a user against a database to validate the password), build a module that synchronizes this event and authenticates the user how you want to.

- `AuthorizeRequest`: This event is used internally to implement authorization mechanisms (for example, to store your access control lists (ACLs) in a database rather than in the file system). Although you can override this event, there are not many good reasons to do so.

- `ResolveRequestCache`: This event determines if a page can be served from the Output cache. If you want to write your own caching module (for example, build a file-based cache rather than a memory cache), synchronize this event to determine whether to serve the page from the cache.

- `AcquireRequestState`: Session state is retrieved from the state store. If you want to build your own state management module, synchronize this event to grab the session state from your state store.

- `PreRequestHandlerExecute`: This event occurs before the HTTP handler is executed.

- `PostRequestHandlerExecute`: This event occurs after the HTTP handler is executed.

- `ReleaseRequestState`: Session state is stored back in the state store. If you are building a custom session state module, you must store your state back in your state store.

- `UpdateRequestCache`: This event writes output back to the Output cache. If you are building a custom cache module, you write the output back to your cache.

- `EndRequest`: Request has been completed. You may want to build a debugging module that gathers information throughout the request and then writes the information to the page.

The following events are available for modules to synchronize with for each request transmission. The order of these events is non-deterministic.

- `PreSendRequestHeaders`: This event occurs before the headers are sent. If you want to add additional headers, you can synchronize this event from a custom module.

- `PreSendRequestContent`: This event occurs when the `Response.Flush` method is called. If you want to add additional content, you can synchronize this event from a custom module.

- `Error`: This event occurs when an unhandled exception occurs. If you want to write a custom error handler module, synchronize this event.

## Configure HTTP modules

The `<httpModules>` configuration section handler is responsible for configuring the HTTP modules within an application. It can be declared at the computer, site, or application level. Use the following syntax for the `<httpModules>` section handler:

```xml
<httpModules>
    <add type="[COM+ Class], [Assembly]" name="[ModuleName]" />
    <remove type="[COM+ Class], [Assembly]" name="[ModuleName]" />
    <clear />
</httpModules>
```

## Create HTTP modules

To create an HTTP module, you must implement the `IHttpModule` interface. The `IHttpModule` interface has two methods with the following signatures:

```csharp
void Init(HttpApplication);
void Dispose();
```

## HTTP handlers overview

Handlers are used to process individual endpoint requests. Handlers enable the ASP.NET framework to process individual HTTP URLs or groups of URL extensions within an application. Unlike modules, only one handler is used to process a request. All handlers implement the `IHttpHandler` interface, which is located in the `System.Web namespace`. Handlers are analogous to Internet Server Application Programming Interface (ISAPI) extensions.

## Configure HTTP handlers

The `<httpHandlers>` configuration section handler is responsible for mapping incoming URLs to the `IHttpHandler` or `IHttpHandlerFactory` class. It can be declared at the computer, site, or application level. Subdirectories inherit these settings.

Administrators use the `<add>` tag directive to configure the `<httpHandlers>` section. `<Add>` directives are interpreted and processed in a top-down sequential order. Use the following syntax for the `<httpHandler>` section handler:

```xml
<httpHandlers>
    <add verb="[verb list]" path="[path/wildcard]" type="[COM+ Class], [Assembly]" validate="[true/false]" />
    <remove verb="[verb list]" path="[path/wildcard]" />
    <clear />
</httpHandlers>
```

## Create HTTP handlers

To create an HTTP handler, you must implement the `IHttpHandler` interface. The `IHttpHandler` interface has one method and one property with the following signatures:

```csharp
void ProcessRequest(HttpContext);
bool IsReusable {get;}
```

> [!NOTE]
> If session state is required in your HTTP handler, you also need to implement the `IRequiresSessionState` interface.
