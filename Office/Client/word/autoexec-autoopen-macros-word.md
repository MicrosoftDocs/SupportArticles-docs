---
title: Auto-Exec and Auto-Open macros in Word
description: This article describes the behaviors of Auto-Exec and Auto-Open macros in Word.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Office Products
search.appverid: MET150
ms.reviewer:
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# Description of behaviors of Auto-Exec and Auto-Open macros in Word

You can use the Auto-Exec and Auto-Open macros in Word to establish default paths, styles, links, environment conditions, and so on, at the time Word opens a new document or opens an existing document. This article discusses how these macros work and how they behave in various situations.

## Auto-Exec

An Auto-Exec macro runs when Word starts if the Auto-Exec macro is saved as part of the default (Normal.dot) template, or if it is saved as part of a global add-in. By using an Auto-Exec macro, you can make adjustments when Word starts but before a document is created or loaded. For example, you can use an Auto-Exec macro to change the default directory when Word starts.

You can suppress the Auto-Exec macro in several ways. One way is to start Word from the command line by using either the /m or the /embedding switch. To use these switches, select **Start**, select **Run**, type either *winword /m* or *winword /embedding*, and then select **OK**.

Another method you may use to suppress an Auto-Exec macro is to press the Shift key while Word starts. Auto-Exec macros are also suppressed when Word is started from an Automation client.

## Auto-Open

The Auto-Open macro runs after you open a new document. Auto-Open runs when you open a document in the following ways:

- Use the Open command on the **File** menu.
- Use the `FileOpen` or `FileFind` commands.
- Select a document from the Most Recently Used (MRU) list on the **File** menu.

When a document is opened, an Auto-Open macro runs if the Auto-Open macro is saved as part of that document or if the macro is saved as part of the template on which the document is based. An Auto-Open macro does not run when it saved as part of a global add-in.

You may prevent an Auto-Open macro from running by holding down the Shift key when you open a document.

## Create an Auto-Exec Macro and an Auto-Open Macro

- Word 2002 or Word 2003

    1. Create a new blank document in Word.
    2. On the **Tools** menu, point to **Macro** and then select **Security**.
    3. In the **Security** dialog box, select **Security Level** and then select **Medium**. select **Trusted Sources**, select **Trust all installed Add-ins and Templates**, and then select **OK**.
    4. Create an Auto-Exec macro. To do this, follow these steps:

        1. On the **Tools** menu, point to **Macro** and then select **Record New Macro**.
        2. In the **Record Macro** dialog box, type *AutoExec* under Macro name, and then select **OK**. By default, the macro is saved in the Normal template. A small two-button command bar appears on your Word document or elsewhere on the Word desktop. Find the command bar and then select the square (Stop Recording) button to stop recording.
        3. On the **Tools** menu, point to Macro and then select **Macros**. Select **AutoExec** in the list of macros and then select **Edit**.
        4. Add the following code to the AutoExec macro:

            ```cmd
            MsgBox "You're seeing the AutoExec macro in action", vbMsgBoxSetForeground
            ```

        5. On the **File** menu in the Microsoft Visual Basic Editor, select **Save Normal**, and then close the Visual Basic Editor.

    5. Follow the same steps that you used for the Auto-Exec macro to create an Auto-Open macro. This time, use the Auto-Open expression to replace the Auto-Exec expression in each step.
    6. Save the document as *C:\Yourfile.doc*, close the document, and then exit Word.
    7. Open the document in Word by using the different methods that are described in the table below. Observe when the macros run and when the macros do not run.

Word 2007

1. Create a new blank document in Word.
2. Select the **Microsoft Office Button**, and then select **Word Options**.
3. Select **Trust Center**, select **Trust Center Settings**, and then select **Trusted Locations**.
4. Add the trusted locations that you want, and then select **OK** two times.
5. Create an Auto-Exec macro. To do this, follow these steps:

    1. Select the **Developer** tab, and then select **Record Macro** in the **Code** group.
    2. In the **Record Macro** dialog box, type Auto-Exec under **Macro name**, and then select **OK**. By default, the macro is saved in the Normal template. select **Stop Recording** in the **Code** group.
    3. On the **Developer** tab, select **Macros** in the **Code** group. Select **AutoExec** in the list of macros, and then select **Edit**.
    4. Add the following code to the Auto-Exec macro:

        ```cmd
        MsgBox "You're seeing the AutoExec macro in action", vbMsgBoxSetForeground
        ```

    5. In Microsoft Visual Basic Editor, select **Save Normal** on the **File** menu, and then close Visual Basic Editor.

6. Follow the same steps that you used for the Auto-Exec macro to create an Auto-Open macro. This time, use the Auto-Open expression to replace the Auto-Exec expression in each step.
7. Save the document as *C:\Yourfile.doc*, close the document, and then exit Word.
8. Open the document in Word by using the different methods that are described in the table in the [Macro Behaviors in Different Situations](#macro-behaviors-in-different-situations) section. Notice when the macros run and when the macros do not run.

## Macro Behaviors in Different Situations

The following table summarizes the behavior of these two macros when Word is started, or when a document is opened by various means:

|Action |AutoExec |AutoOpen|
|-|-|-|
|Start Word with a blank document by typing Runs Does not run the following at a command prompt:   Winword.exe|Runs |Does not run|
|Start Word with a saved document by typing the following at a command prompt:</br>Winword.exe C:\<Yourfile>.doc|Runs|Runs|
|Embed a Word document in an OLE container by typing the following at a command prompt:</br>WinWord.exe /embedding C:\<Yourfile>.doc|Does not run|Runs|
|Use code to automate Word and open Does not run Runs C:\<Yourfile>.doc by using the following code:</br> Set oWord = CreateObject("Word.Application")</br>oWord.Visible = True </br>oWord.Documents. Open "C:\YourFile.doc"|Does not run|Runs|
|Browse to the document in Internet Explorer or the WebBrowser control|Does not run|Runs|

## References

[Command-line switches for Microsoft Office products](https://support.microsoft.com/help/210565)
