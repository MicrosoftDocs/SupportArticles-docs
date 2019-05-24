---
title: How to automate Excel from a client-side VBScript
description: 
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to automate Excel from a client-side VBScript

## Summary

This article illustrates Microsoft Visual Basic, Scripting Edition (VBScript) client-side code that launches and automates Microsoft Office Excel or Microsoft Excel when a user clicks a button on a Web page.

## More Information

### Sample code

1. Create the following HTML file in any text editor and save the file as c:\excel.htm.
    ```HTML
    <HTML>
    <BODY>
    
    <INPUT id=button1 name=button1 type=button value=Button>
    
    <SCRIPT LANGUAGE="VBScript">
    
    sub button1_onclick()
    
    ' Launch Excel
              dim app
              set app = createobject("Excel.Application")
    
    ' Make it visible
              app.Visible = true
    
    ' Add a new workbook
              dim wb
              set wb = app.workbooks.add
    
    ' Fill array of values first...
              dim arr(19,9) ' Note: VBScript is zero-based
              for i = 1 to 20
                 for j = 1 to 10
                    arr(i-1,j-1) = i*j
                 next
              next
    
    ' Declare a range object to hold our data
              dim rng
              set rng = wb.Activesheet.Range("A1").Resize(20,10)
    
    ' Now assign them all in one shot...
              rng.value = arr
    
    ' Add a new chart based on the data
              wb.Charts.Add
              wb.ActiveChart.ChartType = 70 'xl3dPieExploded
              wb.ActiveChart.SetSourceData rng, 2 ' xlColumns
              wb.ActiveChart.Location 2, "Sheet1" 'xlLocationAsObject
    
    ' Rotate it around...
              for i = 1 to 360 step 30
                 wb.activechart.rotation = i
              next
    
    ' Give the user control of Excel
              app.UserControl = true
    
    end sub
    </SCRIPT>
    
    </BODY>
    </HTML>
    
    ```

2. Start Microsoft Internet Explorer, type c:\excel.htm in the **Address** bar, and then press ENTER.    
3. Click the button that is displayed on the page. 

> [!NOTE]
> If you are prompted by a security warning about an ActiveX control on the page, click **Yes**.   