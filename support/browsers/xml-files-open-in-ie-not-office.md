---
title: XML files open in IE if ContentType header has charset
description: Discusses a problem that occurs when the ContentType header contains the charset parameter. Your XML file may open in Internet Explorer instead of opening in the expected Office program.
ms.date: 03/08/2020
ms.prod-support-area-path: Internet Explorer
---
# XML files open in Internet Explorer instead of the expected Office program

This article provides the resolution to remove the charset parameter from your XML file to solve the issue that is described in the Symptoms section.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 888579

## Symptoms

If the ContentType header in your XML file contains the charset parameter, the XML file may open in Microsoft Internet Explorer instead of opening in the expected Microsoft Office program.

## Cause

This problem occurs if the ContentType header in the XML file includes the charset parameter.

## Resolution

To solve this problem, remove the charset parameter from your XML file.

## More Information

The following code does not open the XML file in Microsoft Office Word 2003.

```aspx
<%Response.ContentType = "text/xml; charset=utf-8"%>
<?xml version="1.0" encoding="UTF-8" ?>
<?mso-application progid="Word.Document"?>
<w:wordDocument xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml">
  <w:body>
<w:p>
  <w:r>
<w:t>My test document.</w:t>
  </w:r>
</w:p>
  </w:body>
</w:wordDocument>
```

The following code does open the XML file in Word 2003.

```aspx
<%Response.ContentType = "text/xml%>
<?xml version="1.0" encoding="UTF-8" ?>
<?mso-application progid="Word.Document"?>
<w:wordDocument xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml">
  <w:body>
<w:p>
  <w:r>
<w:t>My test document.</w:t>
  </w:r>
</w:p>
  </w:body>
</w:wordDocument>
```
