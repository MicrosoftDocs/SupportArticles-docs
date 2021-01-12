---
title: Type many characters into a Silverlight TextBox or RichTextBox
description: This article provides a resolution for the problem that occurs when you type many characters into a Silverlight TextBox or RichTextBox by using Chinese or Japanese IMEs.
ms.date: 01/04/2021
ms.prod-support-area-path: 
ms.reviewer: MarkRi
ms.topic: troubleshooting
---
# Type many characters into a Silverlight TextBox or RichTextBox using Chinese or Japanese IMEs can produce unexpected results

This article helps you resolve the problem that occurs when you type many characters into a Silverlight TextBox or RichTextBox by using Chinese or Japanese IMEs.

_Applies to:_ &nbsp; Silverlight  
_Original KB number:_ &nbsp; 2450968

## Symptoms

In a Silverlight TextBox, when inputting large amounts of text into the composition window of a Microsoft Simplified Chinese, Traditional Chinese or Japanese Input Method Editor (IME) without committing the characters to the TextBox, you could see the browser throw an exception and you could also see blocks of text in the composition window repeated and committed to the TextBox. This problem can occur on any version of Windows and can occur in Internet Explorer, Firefox, and Chrome. A variation of this problem can also occur when performing the same actions in a Silverlight RichTextBox in which case an unhandled exception is thrown in the browser.

## Cause

This is due to a bug in Silverlight.

## Resolution

The only way to prevent this from occurring at this time is to commit characters in the composition window before the 40 character limit is reached.

## Steps to reproduce

The steps to reproduce the problem could vary depending on the IME. It does not appear to matter which browser is used or on which platform it is run. I have personally reproduced the problem on Vista using Chinese (Simplified) Microsoft Pinyin IME, Chinese (Traditional) New Phonetic IME, and Japanese IME. Repro steps are as follows.

1. Create a Silverlight 4 application
1. Add a TextBox capable of holding at least 60 characters.
1. Run the application. You will see the textbox in the browser.  Set focus to the Textbox and make the Chinese (Simplified) Microsoft Pinyin IME active and set the input mode to Chinese.
1. Type the following three letters 'a','s', and 'd' from an English keyboard repeatedly into the Silverlight textbox.

Around the 47th character, you could see some characters repeated and you could see the following exception thrown:

> nhandled Error in Silverlight Application  
Code:  4004  
Category: ManagedRuntimeError  
Message: System.Exception: Catastrophic failure (Exception from HRESULT: 0x8000FFFF (E_UNEXPECTED))
   at MS.Internal.XcpImports.CheckHResult(UInt32 hr)
   at MS.Internal.XcpImports.Control_Raise(Control control, IManagedPeerBase arguments, Byte nDelegate)
   at System.Windows.Controls.TextBox.OnTextInputUpdate(TextCompositionEventArgs e)
   at System.Windows.Controls.Control.OnTextInputUpdate(Control ctrl, EventArgs e)  
   ...  
