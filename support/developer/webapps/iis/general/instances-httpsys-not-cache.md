---
title: Instances where HTTP.sys doesn't cache
description: This article describes the instances that the HTTP.sys driver doesn't cache content.
ms.date: 03/30/2020
ms.subservice: general
---
# Instances in which HTTP.sys doesn't cache content

This article introduces Instances where the HTTP.sys driver doesn't cache content.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 817445

## Situations where HTTP.sys doesn't cache

The `HTTP.sys` response cache caches any request with the appropriate flag in the request header. This cache is disabled on a per-request basis. However, if one or more of the following conditions are true, `HTTP.sys` doesn't cache the request response:

- The request isn't an anonymous request.
- The request requires authentication. (For example, the request contains an `Authorization:` header.)
- The website is configured to use a footer.
- Dynamic compression is enabled and is used for the response.

    > [!NOTE]
    > Static compression can be used with `HTTP.sys` caching.

- The static file is a Universal Naming Convention (UNC) file and the `DoDirMonitoringForUnc` registry key is not enabled.

    > [!NOTE]
    >  You can use the `DoDirMonitoringForUnc` registry property (a DWORD value) to switch the static file cache back to a change notification cache. This is set as follows:  `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Inetinfo\Parameters`  
    > The default value is 0, or not enabled. It can be set to 1 to enable caching of static content based on change notification.
- The request contains a query string.
- The cache is disabled. (That is, the `MD_VR_NO_CACHE` metabase property equals 1.)

    > [!NOTE]
    > More information about the `MD_VR_NO_CACHE` metabase property is available in the product documentation. To view this documentation, see [DisableStaticFileCache](/previous-versions/iis/6.0-sdk/ms524754(v=vs.90)).

- The request has an entity body.
- Certificate mapping is enabled for the URL.
- Custom logging is enabled for the website.
- The request HTTP version is not 1.1 or 1.0.
- The request contains a `Translate: f` header.
- An `Expect:` header that doesn't contain exactly `100 continue` is present.
- The request contains either an `If-Range:` header or a `Range:` header.

    > [!NOTE]
    > `HTTP.sys` processes only whole responses. `HTTP.sys` does not try to send ranged responses.

- The response spans multiple `SendResponse` and `SendResponseEntityBody` calls.

    > [!NOTE]
    > A cacheable response must come down in a single, vectored `SendResponse` call.

- The total response size is larger than the per-response maximum size. The maximum is controlled by the `UriMaxUriBytes` registry key, and the default value is 256 KB.

- The response header size is larger than the per-response maximum header size. The default value is 1,024 bytes.

- The cache is already full. The default size is proportional to the physical memory in the computer.

- The response is zero length.

- An Internet Server Application Program Interface (ISAPI) filter that isn't cache-aware is installed.

    > [!NOTE]
    > By default, ISAPI filters are not cache-aware. You must set the `FilterEnableCache` metabase property for the filter to make it cache-aware. All filters in a default installation of IIS are cache-aware. This includes FrontPage and ASP.NET.  
    For more information about the `FilterEnableCache` metabase property, view [What's new in Windows 10 deployment](/windows/deployment/deploy-whats-new).

- A static file is accessed as a default document. (For example, Default.htm exists in the root directory.) Accessing the specific file by name (`http://contoso.com/default.htm/`) causes `HTTP.sy`s to cache the file. Accessing the website by requesting the root folder (`http://contoso.com/`) results in a non-cached response.

    > [!NOTE]
    >  If the first page that's listed in the Default Document list is inaccessible, IIS tries to serve the second page in the Default Document list. In this situation, that static page will not be served from the cache.
