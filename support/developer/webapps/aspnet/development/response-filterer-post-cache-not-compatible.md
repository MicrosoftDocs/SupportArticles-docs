---
title: Response filtering and post-cache substitution not compatible
description: This article describes a fact that ASP.NET response filter module and post-cache substitution aren't compatible.
ms.date: 04/16/2020
ms.custom: sap:General Development
---
# ASP.NET response filtering and post-cache substitution aren't compatible

This article helps you resolve the problem that are caused when you use response filtering and post-cache substitution at the same time.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 2014472

## Symptoms

Consider the following scenario:

1. You have an ASP.NET application running on IIS 7.0 or a later version.
2. The application uses post-cache substitution.
3. The application also uses an Hypertext Transfer Protocol (HTTP) filter module to filter out rendered content.

In this scenario, one of the following problems may occur:

- If the application is hosted on IIS7 in Classic Pipeline mode, the substitution blocks are only rendered on the first request. Subsequent page accesses cause the full page to be served from the output cache and the substitution blocks to not be updated.

- If the application is hosted on IIS7 in Integrated Pipeline mode, an exception of type `System.InvalidOperationException` occurs with the following details:

     > Exception Details: System.InvalidOperationException: Post cache substitution is not compatible with modules in the IIS integrated pipeline that modify the response buffers. Either a native module in the pipeline has modified an HTTP_DATA_CHUNK structure associated with a managed post cache substitution callback, or a managed filter has modified the response.

## Cause

Response filtering and post-cache substitution aren't compatible.

## Resolution

To avoid the problem,use one of the following options:

- Disable output caching on pages that are using substitution blocks.
- Don't use the response filter module.

## More information

Post-cache substitution is implemented using a list of substitution blocks (.NET delegates) used to reconstruct individual pieces of the response. ASP.NET internally maintains a list of `HTTP_DATA_CHUNK` structures associated with a managed post-cache substitution callback. When a response filter is used, a raw response is rendered into a single buffer and the list of substitution blocks is lost. Therefore, the substitution blocks can't be rendered. For more information on post-cache substitution, see [Caching Portions of an ASP.NET Page](/previous-versions/h30h475z(v=vs.140)).
