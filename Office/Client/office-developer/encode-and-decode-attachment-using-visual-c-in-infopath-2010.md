---
title: Encode and to decode an attachment by using Visual C# in InfoPath
description: Explains how to encode and to decode a file attachment by using Visual C# in InfoPath 2010 or in InfoPath 2007. Contains a link to information about InfoPath 2003.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- InfoPath 2010
- InfoPath 2007
---

# How to encode and to decode a file attachment programmatically by using Visual C# in InfoPath 2010 or in InfoPath 2007

## Summary

In Microsoft InfoPath 2010 or in Microsoft Office InfoPath 2007, you can use a File Attachment control to attach a file to the InfoPath form template. In specific circumstances, you may want to encode and then to decode the file that is attached to the File Attachment control. In this case, you can use Microsoft Visual C# to create an Encoderclass and a Decoderclass. Then, you can use the Encoderclass and the Decoderclass to encode and to decode the file attachment. This article describes how to design an InfoPath form template that encodes a file for attachment to the form and decodes the attachment for saving to the file system.  

For more information about how to do this in InfoPath 2003, click the following article number to view the article in the Microsoft Knowledge Base: 

[892730](https://support.microsoft.com/help/892730) How to encode and decode a file attachment programmatically by using Visual C# in InfoPath

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs. 

In the following example, you will follow these steps: 

1. Create a form that includes a Visual C# project.   
2. Create an Encoderclass.   
3. Create a Decoderclass.   
4. Modify the form to call the code.   
5. Test the code operations in the form.

### Create a form that includes a Visual C# project 

Create a form template and project by using the directions for the version of InfoPath that you are using.

#### InfoPath 2010 

1. In InfoPath Designer, create a blank form template, and then click the Save icon.    
2. When you are prompted, type the file name, and then click Save.    
3. Click the **Developer **tab, and then click Language.    
4. Under Form template code language, select C#, and then click OK.    

#### InfoPath 2007

1. On the **File **menu, click **Design a Form Template**.    
2. In the **Design a Form Template **task pane, click **Blank** , and then click **OK**.    
3. On the **File** menu, click **Save**.  
4. When you are prompted, type the file name InfoPathAttachmentEncoding, and then click **Save**.   
5. On the **Tools** menu, click **Form Options**.   
6. Under **Category** in the **Form Options **dialog box, click **Programming**.   
7. Under **Programming language**, in the **Form template code language** list, select **C#**, and then click **OK**.   

### Create an Encoder class 
Create an Encoderclass by using the directions for the version of InfoPath that you are using.

#### InfoPath 2010

1. Under the **Developer** tab, click **Code Editor **to start the Visual Studio Tools for Applications (VSTA) editor.   
2. In the **Project** menu, click **Add New Item**.   
3. Click to select **Class**.    
4. In the **Name** field, change the name to InfoPathAttachmentEncoder.cs, and then click **Save**.   
5. In the code window, replace the existing code with the code from the following "Encoder code" section.    

#### InfoPath 2007

1. Start the Visual Studio Tools for Applications (VSTA) editor.    
2. In the **Project Explorer **pane, right-click **InfoPathAttachmentEncoding**, click **Add**, and then click **New Item**.   
3. In the **Templates** section, select **Class**, change the name to InfoPathAttachmentEncoder.cs, and then click **Add**.   
4. In the code window, paste the code from the following "Encoder code" section.   

#### Encoder code

Use the following code in InfoPath 2010 or in InfoPath 2007:

```cs
using System;
using System.IO;
using System.Text;
using System.Security.Cryptography;
using InfoPathAttachmentEncoding;

namespace InfoPathAttachmentEncoding
{
/// <summary>
/// InfoPathAttachment encodes file data into the format expected by InfoPath for use in file attachment nodes.
/// </summary>
public class InfoPathAttachmentEncoder
{
private string base64EncodedFile = string.Empty;
private string fullyQualifiedFileName;

/// <summary>
/// Creates an encoder to create an InfoPath attachment string.
/// </summary>
/// <param name="fullyQualifiedFileName"></param>
public InfoPathAttachmentEncoder(string fullyQualifiedFileName)
{
if (fullyQualifiedFileName == string.Empty)
throw new ArgumentException("Must specify file name", "fullyQualifiedFileName");

if (!File.Exists(fullyQualifiedFileName))
throw new FileNotFoundException("File does not exist: " + fullyQualifiedFileName, fullyQualifiedFileName);

this.fullyQualifiedFileName = fullyQualifiedFileName;
}

/// <summary>
/// Returns a Base64 encoded string.
/// </summary>
/// <returns>String</returns>
public string ToBase64String()
{
if (base64EncodedFile != string.Empty)
return base64EncodedFile;

// This memory stream will hold the InfoPath file attachment buffer before Base64 encoding.
MemoryStream ms = new MemoryStream();

// Obtain the file information.
using (BinaryReader br = new BinaryReader(File.Open(fullyQualifiedFileName, FileMode.Open, FileAccess.Read, FileShare.Read)))
{
string fileName = Path.GetFileName(fullyQualifiedFileName);

uint fileNameLength = (uint)fileName.Length + 1;

byte[] fileNameBytes = Encoding.Unicode.GetBytes(fileName);

using (BinaryWriter bw = new BinaryWriter(ms))
{
// Write the InfoPath attachment signature. 
bw.Write(new byte[] { 0xC7, 0x49, 0x46, 0x41 });

// Write the default header information.
bw.Write((uint)0x14);// size
bw.Write((uint)0x01);// version
bw.Write((uint)0x00);// reserved

// Write the file size.
bw.Write((uint)br.BaseStream.Length);

// Write the size of the file name.
bw.Write((uint)fileNameLength);

// Write the file name (Unicode encoded).
bw.Write(fileNameBytes);

// Write the file name terminator. This is two nulls in Unicode.
bw.Write(new byte[] {0,0});

// Iterate through the file reading data and writing it to the outbuffer.
byte[] data = new byte[64*1024];
int bytesRead = 1;

while (bytesRead > 0)
{
bytesRead = br.Read(data, 0, data.Length);
bw.Write(data, 0, bytesRead);
}
}
}

// This memorystream will hold the Base64 encoded InfoPath attachment.
MemoryStream msOut = new MemoryStream();

using (BinaryReader br = new BinaryReader(new MemoryStream(ms.ToArray())))
{
// Create a Base64 transform to do the encoding.
ToBase64Transform tf = new ToBase64Transform();

byte[] data = new byte[tf.InputBlockSize];
byte[] outData = new byte[tf.OutputBlockSize];

int bytesRead = 1;

while (bytesRead > 0)
{
bytesRead = br.Read(data, 0, data.Length);

if (bytesRead == data.Length)
tf.TransformBlock(data, 0, bytesRead, outData, 0);
else
outData = tf.TransformFinalBlock(data, 0, bytesRead);

msOut.Write(outData, 0, outData.Length);
}
}

msOut.Close();

return base64EncodedFile = Encoding.ASCII.GetString(msOut.ToArray());
}
}
}
```

### Create a Decoder class

Create a Decoderclass by using the directions for the version of InfoPath that you are using.

#### InfoPath 2010

1. In Code Editor, in the **Project** menu, click **Add New Item**, and then click to select **Class**.   
2. In the **Name** field, change the name to InfoPathAttachmentDecoder.cs, and then click **Save**.   
3. In the code window, replace the existing code with the code from the following "Decoder code" section.    

#### InfoPath 2007

1. In VSTA, in the **Project Explorer **pane, right-click **InfoPathAttachmentEncoding**, click **Add**, and then click **New Item**.   
2. In the **Templates** section, select **Class**, change the name to InfoPathAttachmentDecoder.cs, and then click **Add**.   
3. In the code window, paste the code from the following "Decoder code" section.   

#### Decoder code
Use the following code in InfoPath 2010 or in InfoPath 2007:

```cs
using System;
using System.IO;
using System.Text;

namespace InfoPathAttachmentEncoding
{
/// <summary>
/// Decodes a file attachment and saves it to a specified path.
/// </summary>
public class InfoPathAttachmentDecoder
{
private const int SP1Header_Size = 20;
private const int FIXED_HEADER = 16;

private int fileSize;
private int attachmentNameLength;
private string attachmentName;
private byte[] decodedAttachment;

/// <summary>
/// Accepts the Base64 encoded string
/// that is the attachment.
/// </summary>
public InfoPathAttachmentDecoder(string theBase64EncodedString)
{
byte [] theData = Convert.FromBase64String(theBase64EncodedString);
using(MemoryStream ms = new MemoryStream(theData))
{
BinaryReader theReader = new BinaryReader(ms);
DecodeAttachment(theReader);
}
}

private void DecodeAttachment(BinaryReader theReader)
{
//Position the reader to obtain the file size.
byte[] headerData = new byte[FIXED_HEADER];
headerData = theReader.ReadBytes(headerData.Length);

fileSize = (int)theReader.ReadUInt32();
attachmentNameLength = (int)theReader.ReadUInt32() * 2;

byte[] fileNameBytes = theReader.ReadBytes(attachmentNameLength);
//InfoPath uses UTF8 encoding.
Encoding enc = Encoding.Unicode;
attachmentName = enc.GetString(fileNameBytes, 0, attachmentNameLength - 2);
decodedAttachment = theReader.ReadBytes(fileSize);
}

public void SaveAttachment(string saveLocation)
{
string fullFileName = saveLocation;
if (!fullFileName.EndsWith(Path.DirectorySeparatorChar.ToString())){
fullFileName += Path.DirectorySeparatorChar;
}

fullFileName += attachmentName;

if(File.Exists(fullFileName))
File.Delete(fullFileName);

FileStream fs = new FileStream(fullFileName, FileMode.CreateNew);
BinaryWriter bw = new BinaryWriter(fs);
bw.Write(decodedAttachment);

bw.Close();
fs.Close();
}

public string Filename
{
get{ return attachmentName; }
}

public byte[] DecodedAttachment
{
get{ return decodedAttachment; }
}
}
}
```

### Modify the form
Add a File Attachment control, a Text Box control, and a Button control to the InfoPath form. To do this, follow these steps:

1. Open the **Controls** task pane by using the directions for the version of InfoPath that you are using. 
   - InfoPath 2010:In the InfoPathAttachmentEncoding InfoPath form template, under the **Home **tab, expand the **Controls **gallery.   
   - InfoPath 2007:In the InfoPathAttachmentEncoding InfoPath form template, click **Controls** in the **Design Tasks **task pane.   
   
2. Add a File Attachment control to the InfoPath form by using the directions for the version of InfoPath that you are using: 
   - InfoPath 2010:In the **Controls** task pane, under **Objects**, click **File Attachment.**   
   - InfoPath 2007:In the **Controls** task pane, under **File and Picture**, click **File Attachment**.   
   
3. Right-click the **File Attachment **control, and then click **File Attachment Properties**.   
4. In the **File Attachment Properties **dialog box, type theAttachmentFieldin the **Field Name **box, and then click **OK**.   
5. Add a Text Box control to the InfoPath form by using the directions for the version of InfoPath that you are using: 
   - InfoPath 2010: In the **Controls** task pane, under **Input**, click **Text Box**.   
   - InfoPath 2007: In the **Controls** task pane, under **Standard**, click **Text Box**.   
   
6. Right-click the Text Box control, and then click **Text Box Properties**.   
7. In the **Text Box Properties **dialog box, type theAttachmentName in the **Field Name **box, and then click **OK**.    
8. Add an Attach button to the InfoPath form by using the directions for the version of InfoPath that you are using: 
   - InfoPath 2010: In the **Controls** task pane, under **Objects**, click **Button**.   
   - InfoPath 2007: In the **Controls** task pane, under **Standard**, click **Button**.   
   
9. Right-click the new Button control, and then click **Button Properties**.    
10. In the **Button Properties **dialog box, type Attach in the **Label **box, type btnAttach in the **ID** box, and then click **Edit Form Code**.   
11. Move to the top of the code window, and then add the following line of code: 
    ```cs
    using InfoPathAttachmentEncoding;
    ```

12. Return to "write your code here," and then add the following code:   

    ```cs
     //Create an XmlNamespaceManager
     XmlNamespaceManager ns = this.NamespaceManager;
    
    //Create an XPathNavigator object for the Main data source
     XPathNavigator xnMain = this.MainDataSource.CreateNavigator();
    
    //Create an XPathNavigator object for the attachment node
     XPathNavigator xnAttNode = xnMain.SelectSingleNode("/my:myFields/my:theAttachmentField", ns);
    
    //Create an XPathNavigator object for the filename node
     XPathNavigator xnFileName = xnMain.SelectSingleNode("/my:myFields/my:theAttachmentName", ns);
    
    //Obtain the text of the filename node.
     string fileName = xnFileName.Value;
     if (fileName.Length > 0)
     {
      //Encode the file and assign it to the attachment node.
      InfoPathAttachmentEncoder myEncoder = new InfoPathAttachmentEncoder(fileName);
    
    //Check for the "xsi:nil" attribute on the file attachment node and remove it
      //before setting the value to attach the filerRemove the "nil" attribute
      if (xnAttNode.MoveToAttribute("nil", "http://www.w3.org/2001/XMLSchema-instance"))
       xnAttNode.DeleteSelf();
    
    //Attach the file
      xnAttNode.SetValue(myEncoder.ToBase64String());
     }              
    
    ```

### Add a Save button to the InfoPath form 

1. Return to the InfoPathAttachmentEncoding form template.   
2. Add a Save button by using the directions for the version of InfoPath that you are using: 
   - InfoPath 2010: In the **Controls** task pane, under **Objects**, click **Button**.   
   - InfoPath 2007: In the **Controls** task pane, under **Standard**, click **Button**.   
   
3. Right-click the new Button control, and then click **Button Properties**.   
4. In the **Button Properties **dialog box, type Save in the **Label **box, type btnSave in the **ID **box, and then click **Edit Form Code**.    
5. Insert the following code: 


    ```cs
     //Create an XmlNamespaceManager
     XmlNamespaceManager ns = this.NamespaceManager;
    
    //Create an XPathNavigator object for the Main data source
     XPathNavigator xnMain = this.MainDataSource.CreateNavigator();
    
    //Create an XPathNavigator object for the attachment node
     XPathNavigator xnAttNode = xnMain.SelectSingleNode("/my:myFields/my:theAttachmentField", ns);
    
    //Obtain the text of the node.
     string theAttachment = xnAttNode.Value;
     if(theAttachment.Length > 0)
     {
         InfoPathAttachmentDecoder myDecoder = new InfoPathAttachmentDecoder(theAttachment);
         myDecoder.SaveAttachment(@"Path to the folder to save the attachment");
     }                                              
    
    ```

> [!NOTE]
> In this code, the placeholder Path to the folder to save the attachmentrepresents the location in which you want to save the file.

Click the Save icon, and then close VSTA. 

### Test the form

Before this form can attach a file, the InfoPath form template must be fully trusted. To make sure of this, take one of the following actions:

- Use a code-signing certificate to digitally sign the form template file (.xsn). When you do this, users are prompted to trust the form when they open the form. This makes the form fully trusted. Therefore, Full Trust permissions are granted to your Visual C# code.   
- Create an installable template.   

After you make sure that the form template is fully trusted, you should test it. To do this, follow these steps: 

1. Open the form in Preview mode by following the steps for the version of InfoPath that you are using: 
   - InfoPath 2010 Under the **Home** tab, click **Preview**.   
   - InfoPath 2007 On the Standardtoolbar, click **Preview**.   
   
2. In the InfoPath form, type the path of the file that you want to attach in the text box, and then click **Attach**.

    **Note** Double-click the File Attachment control to verify that the file is encoded correctly.    
3. Click **Save**.    
4. Locate the path that you provided in the code for the "Add a Save button to the InfoPath form" section, and then make sure that the file was saved to that folder.    
5. Click Close Preview. This ends the test.   
