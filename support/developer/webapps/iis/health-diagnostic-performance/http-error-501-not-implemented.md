---
title: HTTP error 501 when you use unknown methods
description: This article discusses a by-design HTTP 501 error when you use an unknown method from an Internet client.
ms.date: 07/17/2020
ms.custom: sap:Health, Diagnostic, and Performance Features
ms.reviewer: robmcm
ms.technology: health-diagnostic-performance
---
# HTTP/1.1 Error 501 - Not Implemented

This article discusses a by-design HTTP error 501 that occurs when you use an unknown method from an Internet client.

_Original product version:_ &nbsp; Internet Information Services (IIS)  
_Original KB number:_ &nbsp; 247643

## Symptoms

When you attempt to use an unknown method from an Internet client, the following error message occurs:

> HTTP/1.1 501 Not Implemented

## Cause

This behavior is by design. Microsoft Internet Information Services (IIS) only supports the methods defined in [RFC 2616 - Hypertext Transfer Protocol--HTTP/1.1](ftp://ftp.isi.edu/in-notes/rfc2616.txt) and [RFC 2518 - HTTP Extensions for Distributed Authoring--WEBDAV](ftp://ftp.isi.edu/in-notes/rfc2518.txt). The methods are listed in the following table:

| Method    | Protocol | RFC  | Section |
|-----------|----------|------|---------|
| CONNECT   | HTTP     | 2616 | 9.9     |
| COPY      | WEBDAV   | 2518 | 8.8     |
| DELETE    | HTTP     | 2616 | 9.7     |
| GET       | HTTP     | 2616 | 9.3     |
| HEAD      | HTTP     | 2616 | 9.4     |
| LOCK      | WEBDAV   | 2518 | 8.10    |
| MKCOL     | WEBDAV   | 2518 | 8.1     |
| MOVE      | WEBDAV   | 2518 | 8.9     |
| OPTIONS   | HTTP     | 2616 | 9.2     |
| POST      | HTTP     | 2616 | 9.5     |
| PROPFIND  | WEBDAV   | 2518 | 8.1     |
| PROPPATCH | WEBDAV   | 2518 | 8.2     |
| PUT       | HTTP     | 2616 | 9.6     |
| TRACE     | HTTP     | 2616 | 9.8     |
| UNLOCK    | WEBDAV   | 2518 | 8.11    |
|           |          |      |         |
