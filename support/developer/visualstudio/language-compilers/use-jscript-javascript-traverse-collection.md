---
title: Use JScript or JavaScript to traverse a collection
description: This article describes how to use JScript or JavaScript to traverse through a collection.
ms.date: 09/24/2020
ms.custom: sap:Language or Compilers\JavaScript and TypeScript
ms.reviewer: TFERRAND
ms.topic: how-to
---
# Use JScript or JavaScript to traverse through a collection

This article shows how to use JScript or JavaScript to traverse through a collection.

_Original product version:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 229693

## Summary

This article describes how to use server-side scripts on Active Server Pages (ASP) pages with Visual Basic Script (VBScript) and JScript or JavaScript to traverse through a collection. In VBScript, you can use the `FOR EACH...NEXT` loop to traverse through a collection. In JScript or JavaScript, you must use an enumerator object.

## More information

The examples in this article use the file system object to traverse a folder (in this case, `C:\Text`) and list all the files located in the folder. The first example uses a `FOR EACH...NEXT` loop in VBScript to traverse:

1. Create a new folder in the root folder of drive C and name it *Text*.
2. Place five text files in the directory you created.
3. Create a new ASP page and add the following VBScript code:

```vbscript
<% @LANGUAGE="VBScript" %>
<%
'Reference the FileSystemObject
set FSO = Server.CreateObject("Scripting.FileSystemObject")'Reference the Text directory
set Folder = FSO.GetFolder("C:\Text")'Reference the File collection of the Text directory
set FileCollection = Folder.Files

Response.Write("VBScript Method<BR>")'Display the number of files within the Text directory
Response.Write("Number of files found: " & FileCollection.Count & "<BR>")'Traverse through the FileCollection using the FOR EACH...NEXT loop
For Each FileName in FileCollection

strFileName = FileName.Name
Response.Write(strFileName & "<BR>")

Next

'De-reference all the objects
set FileCollection = Nothing
set Folder = Nothing
set FSO = Nothing

%>
```

The following example demonstrates the equivalent but uses JScript or JavaScript and the enumerator object as shown below. Follow the steps outlined previously, except use the following code in step 3.

```javascript
<% @LANGUAGE="JScript" %>
<%
// Reference the FileSystemObject
var FSO = Server.CreateObject("Scripting.FileSystemObject");

// Reference the Text directory
var Folder = FSO.GetFolder("c:\\Text");

// Reference the File collection of the Text directory
 var FileCollection = Folder.Files;

Response.Write("JScript Method<BR>");

// Display the number of files within the Text directory
Response.Write("Number of files found: " + FileCollection.Count + "<BR>");

// Traverse through the FileCollection using the FOR loop
for(var objEnum = new Enumerator(FileCollection); !objEnum.atEnd(); objEnum.moveNext()) {
 strFileName = objEnum.item();
 Response.Write(strFileName + "<BR>");
}

// Destroy and de-reference enumerator object
delete objEnum;
objEnum = null;

// De-reference FileCollection and Folder object
FileCollection = null;
Folder = null;

// Destroy and de-reference FileSystemObject
delete FSO;
FSO = null;
%>
```

> [!NOTE]
> The enumerator object is instantiated within the FOR loop, which is okay in JScript or JavaScript. The syntax for the FOR statement is as follows:
>
>FOR(*initialize*; *test*; *increment*)
> *statement*;

The output for each example in this article will appear differently. In VBScript, the output shows only the file name and its file extension as shown here:

```console
VBScript Method
Number of files found: 5
test1.txt
test2.txt
test3.txt
test4.txt
test5.txt
```

In JScript or JavaScript, the output displays the physical folder, the file name, and its file extension:

```console
JScript Method
Number of files found: 5
C:\Text\test1.txt
C:\Text\test2.txt
C:\Text\test3.txt
C:\Text\test4.txt
C:\Text\test5.txt
```

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.  

## References

For more information on JScript and VBScript, see [Introduction to Windows Script Technologies](/previous-versions/tn-archive/ee176792(v=technet.10)).
