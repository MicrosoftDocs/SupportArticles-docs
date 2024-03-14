---
title: Spell checker doesn't check text in the form fields in Word
description: Describes how to use a macro to spell check the form fields in Word.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
ms.date: 03/31/2022
---

# Spell checker doesn't check text in the form fields in Word

## Symptom

The spelling and grammar checker in Microsoft Word doesn't check text in the form fields.  

## Cause

Because form field text is formatted as No Proofing, the spelling and grammar checker ignores text in form fields. 

## Resolution

To work around this issue, you can use the following macro to: 

- Temporarily unprotect the form.    
- Change the language of the form fields.    
- Perform a spelling check or update a field.    
- Reprotect the form while preserving the text you've typed into the form fields.    

You can use this macro as an On Exit macro for the last form field so you can check the spelling or update a field before you save the form. 

```vb
Sub FormsSpellCheck()
    ' If document is protected, Unprotect it. 
    If ActiveDocument.ProtectionType <> wdNoProtection Then 
       ActiveDocument.Unprotect Password:="" 
    End If 

    ' Set the language for the document. 
    Selection.WholeStory 
    Selection.LanguageID = wdEnglishUS 
    Selection.NoProofing = False

   ' Perform Spelling/Grammar check. 
    If Options.CheckGrammarWithSpelling = True Then 
       ActiveDocument.CheckGrammar 
    Else 
       ActiveDocument.CheckSpelling 
    End If

   ' ReProtect the document. 
    If ActiveDocument.ProtectionType = wdNoProtection Then 
       ActiveDocument.Protect Type:=wdAllowOnlyFormFields, NoReset:=True 
    End If

End Sub
```

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
