---
title: Display images stored in a BLOB field
description: This article introduces how to display images stored in a BLOB field.
ms.date: 09/24/2020
ms.custom: sap:Active Server Pages
ms.reviewer: jlewis
ms.prod: iis
ms.technology: iis-active-server-pages
---
# Display images stored in a BLOB field

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 173308

## Summary

Using Active Server Pages (ASP), you can view images stored in BLOB (Binary Large Object) fields in your Internet browser. This article provides information on how to display a GIF image stored in the Microsoft SQL Server sample database table pub_info.

## More information

Most Internet browsers support the displaying of GIF and JPEG images. To display an image, the browser requests the image from a Web server. The server passes the image to the browser as an HTTP transaction with an HTTP header containing an MIME type of `IMAGE/GIF` or `IMAGE/JPEG`. You can simulate this behavior with Active Server Pages.

The following example constructs an HTTP header for an image and then uses the binary information from an image field in SQL Server to provide a GIF to the browser.

```vbscript
 FILE: SHOWIMG.ASP
 <%@ LANGUAGE="VBSCRIPT" %>
 <%
 ' Clear out the existing HTTP header information
 Response.Expires = 0
 Response.Buffer = TRUE
 Response.Clear

' Change the HTTP header to reflect that an image is being passed.
 Response.ContentType = "image/gif"

Set cn = Server.CreateObject("ADODB.Connection")
 ' The following open line assumes you have set up a System DataSource
 ' by the name of myDSN.
 ' Remember to change the following connection string parameters to reflect the correct values
 ' for your SQL server.
 cn.Open "DSN=myDSN;UID=<username>;PWD=<strong password>;DATABASE=pubs"
 Set rs = cn.Execute("SELECT logo FROM pub_info WHERE pub_id='0736'")
 Response.BinaryWrite rs("logo")
 Response.End
 %>
```

This script only displays an image on the screen. If you wish to display an image from an HTML or ASP document, you must refer to this script in an image tag. For example, if you wished to display this image with a caption describing it, you might use the following HTML page:

```html
 <HTML>
     <HEAD><TITLE>Display Image</TITLE></HEAD>
     <BODY>
         This page will display the image New Moon Books from a SQL Server
         image field.<BR>
         <IMG SRC="SHOWIMG.ASP">
     </BODY>
 </HTML>
```

> [!NOTE]
> The ASP script assumes that the image field (BLOB Data) in the SQL Server table contains a raw GIF image. Internet browsers assume that raw GIF or JPEG data follow the HTTP header. If any extraneous information is contained in the BLOB data, this will be passed by this script, and the image will not display properly. This becomes important when you realize that most methods of placing images into BLOB fields place extra information in the form of headers with the image. Examples of this are Microsoft Access and Microsoft Visual FoxPro. Both of these applications save OLE headers in the BLOB field along with the actual binary data.

This technique can also be applied to other types of binary data, not just graphics. The browser needs to know what type of content is being presented. Do this by specifying the proper mime type in the Response.ContentType variable. For example, if you wanted to view a word document, you would set the ContentType = "application/msword".

## References

For the latest Knowledge Base articles and other support information on Visual InterDev and Active Server Pages, see [Support Visual InterDev](https://support.microsoft.com/search/results?query=vinterdev&isEnrichedQuery=false).
