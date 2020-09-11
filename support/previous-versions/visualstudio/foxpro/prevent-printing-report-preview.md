---
title: Prevent printing from a report preview
description: This article explains how to disable the option to print a report while it is being previewed by using Object-Assisted Reporting in Visual FoxPro 9.0.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.reviewer: TREVORH
ms.topic: how-to
ms.prod: visual-studio-family
---
# Prevent printing from a report preview in Visual FoxPro 9.0

This article shows how to disable the option to print a report while it is being previewed by using Object-Assisted Reporting in Visual FoxPro 9.0.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 895279

## Summary

Microsoft Visual FoxPro 9.0 introduces Object-Assisted Reporting architecture. With this new design, you can directly interface through code with Visual FoxPro 9.0 reporting tools, such as the Report Designer and report previews. Therefore, it is easier to disable the ability to print from a report preview in Visual FoxPro 9.0 than it was in earlier versions of Visual FoxPro. This article describes how to write code to directly interact with and to configure Object-Assisted Reporting report previews.

## More information

By default, when an Object-Assisted report is previewed in Visual FoxPro 9.0, the user can print the report from the Report Preview window by using either of the following methods:

- On the Report Preview toolbar, click the **Print** button.
- Right-click inside the Report Preview window, and then click **Print**.

You may want to disable this option. In earlier versions of Visual FoxPro, the Visual FoxPro Resource File (FoxUser.dbf) had to be changed.

In Visual FoxPro 9.0, you can still change the FoxUser.dbf file to disable printing from the Report Preview window. However, with the introduction of Object-Assisted Reporting, an alternate approach is now available. By default, Object-Assisted Reporting in Visual FoxPro 9.0 is not enabled. To enable it, you have to change the `REPORTBEHAVIOR` setting. To do this, use one of the following methods:

- Method 1, Change the Report Engine behavior setting through the Visual FoxPro IDE:
  1. On the **Tools** menu, click **Options**.
  2. In the **Options** dialog box, click the **Reports** tab, and then select **90 (Object Assisted)** in the **Report Engine behavior** list.
  3. (Optional) If you want this setting to persist between Visual FoxPro 9.0 sessions, click **Set As Default** in the **Options** dialog box.
  
- Method 2, Run the following command in code to enable Object-Assisted Reporting:
  
    `SET REPORTBEHAVIOR 90`.

### Code sample

When you run the following code sample, the sample report file that is named Colors.frx is previewed. The code sample previews the report and uses a combination of property settings in the preview container and Preview Extension Handler to completely disable printing from the Report Preview window.

This code sample also addresses a problem in the Visual FoxPro 9.0 Object-Assisted report preview where the Report Preview toolbar does not correctly persist display settings between appearances in the same Report Preview session.

This code sample applies both to the Visual FoxPro 9.0 development environment and to executables that are created by using Visual FoxPro 9.0, as long as you are using Object-Assisted Reporting.

To use this code sample, follow these steps:

1. Save the following code to a new program file in Visual FoxPro 9.0, and then run the code.

    ```console
    *----------- START CODE
    *
    *-----------------------------------
    * AUTHOR: Trevor Hancock
    * CREATED: 02/24/05 02:47:08 PM
    * ABSTRACT:
    * Shows how to disable printing from
    * PREVIEW when you use object-assisted
    * reporting in VFP9.
    *
    * Also includes a workaround for problem
    * where the PREVIEW toolbar does not
    * recognize the TextOnToolbar or
    * PrintFromPreview settings between
    * toolbar displays during same preview.
    *-----------------------------------
  
    *-- Defines whether to alllow for
    *-- printing during preview. Used to set
    *-- the "AllowPrintfromPreview" property
    *-- of the object-assisted preview container
    *-- later in this code.
    #DEFINE PrintFromPreview .T.
  
    LOCAL loPreviewContainer AS FORM, ;
    loReportListener AS REPORTLISTENER, ;
    loExHandler AS ExtensionHandler OF SYS(16)

    *-- Get a preview container from the
    *-- .APP registered to handle object-assisted
    *-- report previewing.
    loPreviewContainer = NULL
    DO (_REPORTPREVIEW) WITH loPreviewContainer
    *-- Create a PREVIEW listener
    loReportListener = NEWOBJECT('ReportListener')
    loReportListener.LISTENERTYPE = 1 &&Preview
  
    *-- Link the Listener and preview container
    loReportListener.PREVIEWCONTAINER = loPreviewContainer
  
    *-- Changing this property prevents printing from the Preview toolbar
    *-- and from right-clicking on the preview container, and then clicking "print".
    *-- This property is not in the VFP9 documentation at this point.
    loPreviewContainer.AllowPrintfromPreview = PrintFromPreview
    *-- Controls appearance of text on some of the
    *-- Preview toolbar buttons. .F. is the default.
    *-- Included here just to show that it is an available option.
    loPreviewContainer.TextOnToolbar = .F.
  
    *-- Create an extension handler and hook it to the
    *-- preview container. This will let you manipulate
    *-- properties of the container and its Preview toolbar
    loExHandler = NEWOBJECT('ExtensionHandler')
    loPreviewContainer.SetExtensionHandler( loExHandler )
  
    REPORT FORM ;
    HOME() + 'Samples\Solution\Reports\colors.frx' ;
    OBJECT loReportListener
  
    RELEASE loPreviewContainer, loReportListener, loExHandler
  
    *-------------------------
    *-------------------------
    DEFINE CLASS ExtensionHandler AS CUSTOM
    *-- Ref to the Preview Container's Preview Form
    PreviewForm = NULL
  
    *-- Here you implement (hook into) the PreviewForm_Assign
    *-- event of the preview container's parent proxy
    PROCEDURE PreviewForm_Assign( loRef )
    *-- Perform default behavior: assign obj ref.
    THIS.PreviewForm = loRef
  
    *-- Grab the obj ref to the preview form and bind to its
    *-- ShowToolbar() method. This lets the
    *-- STB_Handler() method of this extension handler
    *-- to run code whenever the Preview toolbar is shown
    *-- by the PreviewForm.ShowToolbar() method.
    IF !ISNULL( loRef )
    BINDEVENT(THIS.PreviewForm, ;
    'ShowToolbar', THIS, 'STB_Handler')
    ENDIF
    ENDPROC
  
    PROCEDURE STB_Handler(lEnabled)
    *-- Here you work around the setting
    *-- persistence problem in the Preview toolbar. 
    *-- The Preview toolbar class (frxpreviewtoolbar)
    *-- already has code that you can use to enforce
    *-- setting's persistence; it is just not called. Here,
    *-- you call it.
    WITH THIS.PreviewForm.TOOLBAR
    .REFRESH()
    *-- When you call frxpreviewtoolbar::REFRESH(), the
    *-- toolbar caption is set to its Preview form,
    *-- which differs from typical behavior. You must revert that
    *-- to be consistent. If you did not do this,
    *-- you would see " - Page 2" appended to the toolbar
    *-- caption if you skipped pages.
    .CAPTION = THIS.PreviewForm.formCaption
    ENDWITH
    ENDPROC
  
    *-- A preview container requires these methods
    *-- to be implemented in an associated preview extension handler.
    *-- They are not used in this example, but still must be here.
    PROCEDURE AddBarsToMenu( cPopup, iNextBar )
    PROCEDURE SHOW( iStyle )
    ENDPROC
    PROCEDURE HandledKeyPress( nKeyCode, nShiftAltCtrl )
    RETURN .F.
    ENDPROC
    PROCEDURE PAINT
    ENDPROC
    PROCEDURE RELEASE
    RETURN .T.
    ENDPROC ENDDEFINE
    *
    *
    *----------- END CODE
    ```
  
    A preview of the Colors.frx report will open.

    > [!NOTE]
    > You can print from the Report Preview window by right-clicking the preview or by clicking **Print** on the Report Preview toolbar.

2. Close the preview, and then modify the code in the program editor.
3. Change the #DEFINE statement at the top of the code to a value of .F. To do this, locate the following code.

    ```console
    #DEFINE PrintFromPreview .T.
    ```
  
    Replace it with the following code:
  
    ```console
    #DEFINE PrintFromPreview .F.
    ```

4. Save the code, and then run it again.

> [!NOTE]
> Now you cannot print from the Report Preview window by right-clicking the preview or by clicking **Print** on the Report Preview toolbar.
