---
title: Use the starts-with() XPath function
description: This article describes how to use the starts-with() XPath Function.
ms.date: 10/21/2020
ms.prod-support-area-path: 
ms.topic: how-to 
ms.prod: .net
---
# Use the starts-with() XPath Function

This article describes how to use the `starts-with()` XPath function.

_Original product version:_ &nbsp; Microsoft XML  
_Original KB number:_ &nbsp; 303516

## Summary

It is a common programming requirement when you load and parse an XML document using the Microsoft XML (MSXML) Document Object Model (DOM) to identify elements and/or elements with attributes whose values begin with a specific character or sequence of characters. This article includes a code sample that demonstrates how you can use the `starts-with` XML Path Language (XPath) string function to implement this requirement.

## Step-by-Step Example

1. In Notepad, create a new XML document named *Books.xml*, and paste the following XML:

    ```xml
    <?xml version="1.0"?>
    <!-- This file represents a fragment of a bookstore inventory database -->
    <bookstore specialty="novel">
        <book style="autobiography">
            <author>
                <first-name>Joe</first-name>
                <last-name>Bob</last-name>
                <award>Trenton Literary Review Honorable Mention</award>
            </author>
            <price>12</price>
        </book>
        <book style="textbook">
            <author>
                <first-name>Mary</first-name>
                <last-name>Bob</last-name>
                <publication>Selected Short Stories of
                    <first-name>Mary</first-name>
                    <last-name>Bob</last-name>
                </publication>
            </author>
            <price>55</price>
        </book>
    </bookstore>
    ```

2. Save *Books.xml* in the root folder of drive C.
3. Open a new Standard EXE project in Visual Basic. Form1 is created by default.
4. From the **Project** menu, click **References**, and then select the **Microsoft XML 3.0** check box.
5. Drag a **Command** button, and drop it onto Form1.
6. Copy and paste the following code in the `Click` event procedure of the **Command** button:

    ```vb
    Dim doc As MSXML2.DOMDocument
    Dim nlist As MSXML2.IXMLDOMNodeList
    Dim node As MSXML2.IXMLDOMNode

    Set doc = New MSXML2.DOMDocument
    doc.setProperty "SelectionLanguage", "XPath"
    doc.Load "c:\books.xml"
    Set nlist = doc.selectNodes("//book/author/first-name[starts-with(.,'M')]")
    MsgBox "Matching Nodes : " & nlist.length

    For Each node In nlist
    Debug.Print node.nodeName & " : " & node.Text
    Next
    ```

7. The preceding code loads the XML from *Books.xml* into an instance of the MSXML `DOMDocument` object. It then executes an XPath query that uses the `starts-with` XPath function to identify all authors whose first names begin with the letter M. Finally, the For loop iterates through the selected nodes and displays the first names of the matching author elements.

8. The first parameter of the `starts-with` XPath function is used to specify the source node or string against which the comparison is to be executed. The second parameter is the pattern string that specifies the character or character sequence that is to be used in the comparison. It is important to remember that the pattern string that is supplied as the second parameter of the `starts-with` function is case-sensitive.
