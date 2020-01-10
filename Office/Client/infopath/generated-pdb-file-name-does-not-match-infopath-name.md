---
title: Generated .PDB file name does not match InfoPath form name
description: Explains why .XSN forms created in InfoPath Designer 2013 do not match the generated .PDB files.
author: todmccoy
ms.author: v-todmc
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
- SPO160
audience: Admin
ms.custom: 
- CSSTroubleshoot
- CI 100405
ms.reviewer: doug.mahugh
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal 
appliesto:
- Microsoft InfoPath 2013
---
# Generated .PDB file name does not match InfoPath form name

## Symptoms
When a form is created in InfoPath Designer 2013 and then saved as an .XSN file which contains non-ASCII characters in the file name, the generated .PDB file does not match the .XSN file name. If you then attempt to debug the form with Visual Studio, Visual Studio is not able to find symbol definitions for the form. One symptom of this problem is that breakpoints set in Visual Studio are not triggered.

## Cause
InfoPath uses URLs to access files, but non-ASCII characters are not directly supported in URL strings. Non-ASCII characters must be encoded or replaced with ASCII characters to convert the .XSN filename to a .PDB filename, and this step causes the .PDB file name to differ from the form name as stored in the .XSN filename. Consequently, Visual Studio fails to load the .PDB file because it expects to find that information in a file with the same name as the .XSN file.

## Resolution
We recommend that you avoid using non-ASCII characters in InfoPath form names.
