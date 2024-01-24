---
title: Content types for HTTP compression
description: This article describes how to add more content types for HTTP compression in Internet Information Services.
ms.date: 07/17/2020
ms.custom: sap:WWW Administration and Management
ms.reviewer: mlaing
ms.topic: how-to
ms.subservice: www-administration-management
---
# Content types for HTTP compression in Internet Information Services

This article describes how to add more content types for Hypertext Transfer Protocol (HTTP) compression in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 969062

## Introduction

In IIS, you can configure the HTTP compression by specifying the Multipurpose Internet Mail Extensions (MIME) types that are to be compressed. This manner differs from earlier versions of IIS, in which you can configure compression by specifying the file name extensions to be compressed. The ability to add, modify, or delete MIME types from the static and dynamic HTTP compression scheme isn't exposed through the default IIS user interface. To make these changes, you must use the Appcmd.exe command-line tool.

## Use Appcmd.exe to add MIME types

The following code examples show some of the Appcmd.exe syntax that you can use to add additional MIME types to the HTTP compression settings in IIS.

- To add the `text/xml` MIME type to the static compression configuration for the whole web server, use the following command:

  ```console
  appcmd set config /section:httpCompression /+staticTypes.[mimeType='text/xml',enabled='true'] /commit:apphost
  ```

- To add the `application/octet-stream` MIME type to the dynamic compression configuration for the whole web server, use the following command:

  ```console
  appcmd set config /section:httpCompression /+dynamicTypes.[mimeType='application/octet-stream',enabled='true'] /commit:apphost
  ```

- You can also add wildcard entries for the MIME types. However, you can set MIME types for the web server level only. For example, you can use the following commands to enable static compression for all MIME types for the default website. First add wildcard entries for the MIME types for the server level, and then enable static compression for the default website.

  ```console
  appcmd set config /section:httpCompression /staticTypes.[mimeType='*/*'].enabled:"true" /commit:apphost
  appcmd set config "Default Web Site" /section:urlCompression /doStaticCompression:"True"
  ```
