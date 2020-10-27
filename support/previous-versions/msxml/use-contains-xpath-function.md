---
title: Use the contains XPath function
description: This article describes how to use the contains() XPath function when you are programming the MSXML DOM.
ms.date: 10/15/2020
ms.prod-support-area-path: 
ms.reviewer: KARTHIKR
ms.topic: how-to
ms.prod: .net
---
# Use the contains() XPath function when you are programming the MSXML DOM

This article shows how to use the `contains() XPath` function when you are programming the MSXML DOM.

_Original product version:_ &nbsp; Microsoft XML  
_Original KB number:_ &nbsp; 304265

## Summary

When you use the Microsoft XML (MSXML) Document Object Model (DOM) in code to load and parse an XML document, it is common programming practice to identify elements and/or elements with attributes whose data contains a specified string value or word. This article documents a code sample that demonstrates how you can use the contains XML Path Language (XPath) string function to implement this requirement.

## Step-by-Step Example

1. In Notepad, create a new XML document named *Books.xml*, and paste the following XML:

    ```xml
    <?xml version="1.0"?>
    <!-- This file represents a fragment of a bookstore inventory database -->
    <bookstore specialty="novel">
     <book>
         <Title>Beginning XML</Title>
         <Publisher>Wrox</Publisher>
     </book>
     <book>
         <Title>Professional XML</Title>
         <Publisher>Wrox</Publisher>
     </book>
     <book>
         <Title>Programming ADO</Title>
         <author>
             <first-name>Mary</first-name>
             <last-name>Bob</last-name>
         </author>
         <datePublished>1/1/2000</datePublished>
         <Publisher>Microsoft Press</Publisher>
     </book>
    </bookstore>
    ```

2. Save *Books.xml* in the root folder of drive C.
3. Open a new Standard EXE project in Microsoft Visual Basic. **Form1** is created by default.
4. From the Project menu, click **References**, and then select the **Microsoft XML 3.0** check box.
5. Drag a Command button, and drop it onto **Form1**.
6. Copy and paste the following code in the Click event procedure of the Command button:

    ```vbnet
    Dim doc As MSXML2.DOMDocument
    Dim nlist As MSXML2.IXMLDOMNodeList
    Dim node As MSXML2.IXMLDOMNode

    Set doc = New MSXML2.DOMDocument
    doc.setProperty "SelectionLanguage", "XPath"
    doc.Load "c:\books.xml"
    Set nlist = doc.selectNodes("//book/Title[contains(.,'ADO')]")
    MsgBox "Matching Nodes : " & nlist.length

    For Each node In nlist
        Debug.Print node.nodeName & " : " & node.Text
    Next
    ```

7. The preceding code loads the XML from *Books.xml* into an instance of the MSXML DOMDocument object. It then runs an XPath query that uses the `contains XPath` function to identify all Book titles that contain the word ADO. Finally, the For loop iterates through the selected nodes and displays the matching titles that were identified by running the XPath query.
8. The first parameter of the `contains XPath` function is used to specify the source node or string against which the comparison is to be executed. The second parameter is a string that specifies the word or string value to look for in the source node. It is important to remember that the string or word that is supplied as the second parameter of the contains function is case-sensitive.
