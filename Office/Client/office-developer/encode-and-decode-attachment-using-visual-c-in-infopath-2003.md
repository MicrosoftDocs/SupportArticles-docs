---
title: Encode and decode an attachment by using Visual C# in InfoPath 2003
description: Introduces how to encode and decode a file attachment by using Visual C# in InfoPath 2003. Contains link to information for later versions.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- InfoPath 2003
---

# How to encode and decode a file attachment programmatically by using Visual C# in InfoPath 2003

## Summary

In Microsoft Office InfoPath 2007 or in Microsoft Office InfoPath 2003 Service Pack 1 (SP1), you can use a **File Attachment** control to attach a file to the InfoPath form template. In specific circumstances, you may want to encode and then decode the file that is attached to the **File Attachment** control. In this case, you can use Microsoft Visual C# to create an Encoder class and a Decoder class. Then, you can use the Encoder class and the Decoder class to encode and decode the file attachment.

## Introduction 

This article introduces how to encode and decode a file attachment programmatically by using Microsoft Visual C# in InfoPath 2003. For information on how to do this in InfoPath 2010 or in InfoPath 2007, see the following web page: [How to encode and to decode a file attachment programmatically by using Visual C# in InfoPath 2010 or in InfoPath 2007 ](https://support.microsoft.com/help/2517906).

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. 

### Create a Visual C# InfoPath 2003 project

1. Start Microsoft Visual Studio .NET 2003.   
2. On the **File** menu, click **New**, and then click **Project**.   
3. In the **New Project** dialog box, click **Visual C# Projects** in the Microsoft Office InfoPath Projects folder.   
4. In the **Name** box, type AttachmentEncoding, and then click **OK**.   
5. In the Microsoft Office Project Wizard, click **Create a new form template**, and then click **Finish**.

    The Microsoft Office Project Wizard creates a new Visual Studio .NET 2003 project that is named AttachmentEncoding. An InfoPath form template is also created. The InfoPath form template is named AttachmentEncoding.   

### Create an Encoder class in Visual Studio .NET 2003

1. In Solution Explorer, right-click **AttachmentEncoding**, point to **Add**, and then click **Add New Item**.   
2.  In the **Add New Item** dialog box, click **Class** in the **Template** pane, type InfoPathAttachmentEncoder.cs in the **Name** box, and then click **Open**.   
3. Replace all the code in the InfoPathAttachmentEncoder.cs file with the following code. 
    ```cs
    using System;
    using System.IO;
    using System.Text;
    using System.Security.Cryptography;
    
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
    
    // Get the file information.
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

### Create a Decoder class in Visual Studio .NET 2003

1. In Solution Explorer, right-click **AttachmentEncoding**, point to **Add**, and then click **Add New Item**.   
2. In the **Add New Item** dialog box, click **Class** in the **Template** pane, type
InfoPathAttachmentDecoder.cs in the **Name** box, and then click **Open**.   
3. Replace all the code in the InfoPathAttachmentDecoder.cs file with the following code. 
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
    //Position the reader to get the file size.
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
    if(!fullFileName.EndsWith(Path.DirectorySeparatorChar))
    {
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

### Add a File Attachment control and a Text Box control to the InfoPath form

1. In the AttachmentEncoding InfoPath form template, click **Controls** in the **Design Tasks** task pane.   
2. In the **Controls** task pane, click **File Attachment** under **Insert controls**.   
3. Right-click the **File Attachment** control, and then click **File Attachment Properties**.   
4. In the **File Attachment Properties** dialog box, type theAttachmentField in the **Field Name** box, and then click **OK**.   
5. In the **Controls** task pane, click **Text Box** under **Insert controls**.   
6. Right-click the **Text Box** control, and then click **Text Box Properties**.   
7.  In the **Text Box Properties** dialog box, type theAttachmentName in the **Field Name** box, and then click **OK**.   

### Add an Attach button to the InfoPath form

1. In the **Controls** task pane, click **Button** under **Insert controls**.   
2. Right-click the new **Button** control, and then click **Button Properties**.   
3. In the **Button Properties** dialog box, type Attach in the **Label** box, type btnAttach in the **ID** box, and then click **Edit Form Code**.   
4. Add the following code into the btnAttach_OnClick method. 
    ```cs
    //Get a reference to the attachment node.
    IXMLDOMNode theAttachmentNode = thisXDocument.DOM.selectSingleNode("my:myFields/my:theAttachmentField");
    
    //Get a reference to the filename node.
    IXMLDOMNode fileNameNode = thisXDocument.DOM.selectSingleNode("my:myFields/my:theAttachmentName");
    //Get the text of the node.
    String fileName = fileNameNode.text;
    if(fileName.Length > 0)
    {
    //Encode the file and assign it to the attachment node.
    InfoPathAttachmentEncoding.Encoder myEncoder = new InfoPathAttachmentEncoding.Encoder(fileName);
    if(theAttachmentNode.attributes.getNamedItem("xsi:nil") != null)
    theAttachmentNode.attributes.removeNamedItem("xsi:nil");
    theAttachmentNode.text = myEncoder.ToBase64String();
    }
    
    ```

### Add a Save button to the InfoPath form

1. Switch to the AttachmentEncoding InfoPath form template.   
2. In the **Controls** task pane, click **Button** under **Insert controls**.   
3. Right-click the new **Button** control, and then click **Button Properties**.   
4. In the **Button Properties** dialog box, type Save in the **Label** box, type btnSave in the **ID** box, and then click **Edit Form Code**.   
5. Add the following code into the btnSave _OnClick method. 
    ```cs
    //Get a reference to the attachment node.
    IXMLDOMNode n = thisXDocument.DOM.selectSingleNode("my:myFields/my:theAttachmentField");
    //Get the text of the node.
    String theAttachment = n.text;
    if(theAttachment.Length > 0)
    {
    InfoPathAttachmentEncoding.Decoder myDecoder = new InfoPathAttachmentEncoding.Decoder(theAttachment);
    myDecoder.SaveAttachment(@"<Path to save the file>");
    }
    
    ```

> [!NOTE]
> In this code, replace **<Path to save the file>** with the location where you want to save the file.   

### Make sure that the InfoPath form template is fully trusted

Before you can test this form, the InfoPath form template must be fully trusted. You can use one of the following methods to make sure that the InfoPath form template is fully trusted: 

- Use the Microsoft .NET Framework 1.1 Configuration utility to grant Full Trust permissions only to your Visual C# code.    
-  Use the RegForm utility from the InfoPath Software Development Kit (SDK) to make the form a fully trusted form. This grants Full Trust permissions to your Visual C# code.    
- Use a code-signing certificate to digitally sign the form template file (.xsn). When you use a code-signing certificate to digitally sign the form template file, users are prompted to trust the form when they open the form. This makes the form fully trusted. Therefore, Full Trust permissions are granted to your Visual C# code.    
- Use the IPFullTrust macro from the InfoPath SDK to make the form a fully trusted form. The IPFullTrust macro automates setting the manifest file (.xsf) and the form template file in the InfoPath project for full trust, and then the IPFullTrust macro automatically registers the form template.

    For more information about how to install and use the macro, visit the following Microsoft Developer Network (MSDN) Web site:

    [https://msdn.microsoft.com/en-us/library/aa202736(office.11).aspx](https://msdn.microsoft.com/library/aa202736%28office.11%29.aspx)   
- Use external Automation in InfoPath to call the RegisterSolution method. Typically, this method is only used for form development because a registered form only registers for an individual computer. For any additional forms, other users must register the additional forms on their own computers. We do not recommend this method for additional forms. We recommend any one of the previous methods when you publish the form. 
  
Because this form is under form development, you can use the last method. To do this, locate the AttachmentEncoding InfoPath form template, and then follow these steps: 

1. On the **Tools** menu, click **Form Options**.   
2. Click the **Security** tab.   
3. Click to clear the **Automatically determine security level based on form's design (recommended)** check box.

    **Note** InfoPath cannot automatically detect business logic that requires Full Trust permissions. Therefore, you must explicitly grant Full Trust permissions.   
4. Click **Full Trust**, and then click **OK**.    
5. Close the AttachmentEncoding InfoPath form template. If you are prompted to save changes, click **Yes**.

    **Note** Do not close the Visual Studio .NET 2003 project.   
6. In Visual Studio .NET 2003, double-click the **Manifest.xsf** file in Solution Explorer. The Manifest.xsf file opens.   
7.  In the root node, locate the publishUrl attribute. Remove the publishUrl attribute and the value of the publishUrl attribute.   
8. Save your changes, and then close the Manifest.xsf file.   
9. Click **Start**, click **Run**, type notepad, and then click **OK**.   
10. Add the following code to the blank text file. 

    ```cs
    oApp = WScript.CreateObject("InfoPath.ExternalApplication");
    strAbsolutePath = "<project_folder_url>\\Manifest.xsf";
    oApp.RegisterSolution(strAbsolutePath,"overwrite"); 

    ```

    **Note** In this code, replace **project_folder_url** with the path of the Manifest.xsf file in your project folder. Remember to escape the path of the Manifest.xsf file. All single backslashes (\\) in the path must be replaced with two backslashes (\\\\).   
11. Save the Manifest.xsf file on the computer as the Register.js file.   
12. To call the RegisterSolution method, double-click the **Register.js** file that you created.   
### Test the form

1. In the AttachmentEncoding Visual Studio .NET 2003 project, click **Start** on the **Debug** menu. This starts the InfoPath form in Preview mode.   
2. On the InfoPath form, type the path of the file that you want to attach in the text box, and then click **Attach**.

    **Note** Double-click the **File Attachment** control to verify that the file is correctly encoded.   
3. Click **Save**. Locate the path that you provided in the "Add a **Save** button to the InfoPath form" section.   
4. To end the test, click **Close Preview**.   

## References

For more information about the file attachment header format, visit the following MSDN Web site:

Attaching files in InfoPath 2003
[https://msdn.microsoft.com/en-us/library/aa168351(office.11).aspx](https://msdn.microsoft.com/library/aa168351%28office.11%29.aspx)