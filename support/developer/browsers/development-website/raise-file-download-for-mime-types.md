---
title: How to raise file download dialog box for known MIME types
description: Introduces how to change the default behavior to raise a file download dialog box for known MIME types to save a file in Microsoft Edge and Internet Explorer.
ms.date: 03/24/2020
ms.reviewer: JAYALLEN
---
# How to raise a File Download dialog box for a known MIME type

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the information about how to raise a **File Download** dialog box for known MIME types in Microsoft Edge and Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 8, Internet Explorer 7, Microsoft Edge  
_Original KB number:_ &nbsp; 260519

## Summary

When you serve a document from a Web server, you might want to immediately prompt the user to save the file directly to the user's disk, without opening it in the browser. However, for known MIME (Multipurpose Internet Mail Extensions) types such as Microsoft Word (application/ms-word), the default behavior is to open the document in Internet Explorer.

You can use the content-disposition header to override this default behavior. Its format is:

```console
Content-disposition: attachment; filename=fname.ext
```

## More information

`Content-disposition` is an extension to the MIME protocol that instructs a MIME user agent on how it should display an attached file. The range of valid values for `content-disposition` are discussed in Request for Comment (RFC) 1806 (see the [References](#references) section of this article). This article focuses on the attachment argument, which instructs a user agent (in this case, Internet Explorer) to save a file to disk instead of saving it inline.

When Internet Explorer receives the header, it raises a **File Download** dialog box whose file name box is automatically populated with the file name that is specified in the header. Note that this is by design; there is no way to use this feature to save a document to the user's computer without prompting for a save location.

There are two ways that you can use Internet Explorer to specify a `content-disposition` header for a file: dynamically and statically.

To apply the header dynamically, create an Active Server Pages (ASP) file that writes the document out to the browser. Use the `Response.AddHeader` method to add the `content-disposition` header. For example:

```console
Response.AddHeader "content-disposition","attachment; filename=fname.ext"
```

This technique is ideal when you want to protect a document store on your server, especially one that exists outside of the Web root.

To apply the header statically, right-click the document in the **Internet Service Manager**, and then select **Properties**. Select the **HTTP Header** tab and enter the `content-disposition` header there. This works best when you only want to apply `content-disposition` to a few files on your system and don't require the overhead of ASP.

## References

For more information about `content-disposition`, see [Request for Comments (RFC) 1806](https://www.ietf.org/rfc/rfc1806.txt).
