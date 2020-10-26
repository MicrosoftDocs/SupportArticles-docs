---
title: Use XML notepad to create an XML document
description: This article describes how to use XML Notepad to create an XML document.
ms.date: 10/20/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Use XML Notepad to create an XML document

This article describes how to use XML Notepad to create an XML document.

_Original product version:_ &nbsp; Microsoft XML Notepad  
_Original KB number:_ &nbsp; 296560

## Summary

Microsoft XML Notepad is an application that allows you to create and edit XML documents quickly and easily. With this tool, the structure of your XML data is displayed graphically in a tree structure. The interface presents two panes: one for the structure, and one for the values. You may add elements, attributes, comments, and text to the XML document by creating the tree structure in the left pane and entering values in the right pane's corresponding text boxes.

## More information

To create a well-formed XML document with XML Notepad, follow these steps:

1. To open XML Notepad, click **Start**, point to **Programs**, point to XML Notepad, and then click **Microsoft XML Notepad**. The interface shows two panes. The Structure pane on the left presents the beginning of an XML tree structure, with a `Root_Element` and `Child_Element` already created. Empty text boxes in the Values pane accept corresponding values.

1. Change `Root_Element` to **Catalog** and `Child_Element` to **Book**, and add an attribute and three child elements to the **Book** child element.

   > [!NOTE]
   > When you insert the following values, do not include apostrophes. XML Notepad inserts them for you as your XML document requires.

    1. To insert an attribute for Book, right-click **Book**, point to **Insert**, and click **Attribute**. Next to the cube icon, type *ID*. To insert a value for this attribute, highlight ID and type *Bk101* in the corresponding text box in the **Values** pane.

    1. To insert a child element for **Book**, right-click the folder icon next to **Book**, point to **Insert**, and click **Child Element**. A leaf icon appears. Type *Author* next to this icon, and then type *Gambardella*, *Matthew* in the corresponding text box in the **Values** pane.

    1. Add two more child elements: **Title** and **Genre**. Type *XML Developer's Guide* and
     *Computer* in the corresponding text boxes in the **Values** pane.

1. To add another **Book** child element to the **Root** node, right-click an existing **Book** element and click **Duplicate**. Fill in the values as needed.

1. To add text to existing elements, highlight the node for which you would like to add a text node. On the **Insert** menu, click **Text**.

1. To add comments to existing elements, highlight the node after which or in which you want to insert the comment. On the **Insert** menu, click **Comment**. If the highlighted node is expanded, the comment is inserted within the highlighted node.

1. To change a node's type, highlight the node that you want to change. On the **Tools** menu, point to **Change To** and click the appropriate type.

   > [!NOTE]
   > You cannot change the type of the root node or of nodes with children.

1. To view the XML source of the document, on the **View** menu, click **Source**. The sample output resembles the following:

    ```xml
    <catalog>
        <book id="bk101">
            <author>Gambardella, Matthew</author>
            <title>XML Developer's Guide</title>
            <genre>Computer</genre>
            text1
            </book>
            <!--Comment1-->
            <book id="bk102">
            <!--Comment2-->
            <author>Ralls, Kim</author>
            <title>Midnight Rain</title>
            <genre>Fantasy</genre>
        </book>
    </catalog>
    ```

   > [!NOTE]
   > The following message at the bottom of the **View** window:

   > The current XML definition is well formed.

   Also, note that the XML declaration or processing instructions must be added with an external editor, such as Notepad.

1. To save the XML document, on the File menu, click **Save**. To exit XML Notepad, on the **File** menu, click **Exit**.

## References

- [XML Extended Data Type](/previous-versions/dynamics/ax-2012/reference/gg920029(v=ax.60))

- [World Wide Web Consortium](http://www.w3.org)
