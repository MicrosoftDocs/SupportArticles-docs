---
title: Copy image from database to PictureBox control
description: This article describes how to copy an image stored in a database directly into a PictureBox control on a Windows Form without needing to save the image to a file.
ms.date: 10/10/2020
ms.custom: sap:Language or Compilers\C#
ms.topic: how-to
---
# Copy a Picture from a Database Directly to a PictureBox Control with Visual C sharp  

This article describes how to copy an image stored in a database directly into a PictureBox control on a Windows Form without needing to save the image to a file.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 317701

## Summary

This step-by-step article describes how to copy an image stored in a database directly into a PictureBox control on a Windows Form without needing to save the image to a file.

In Visual Basic 6.0, the only way to display an image from a database in a PictureBox control, without the intermediate step of saving the binary large object {BLOB) data to a file, is to bind the PictureBox to a data source such as an ActiveX Data Objects (ADO) Data Control or Recordset. There is no way (without data binding) to programmatically load a BLOB into a control without saving the image to a file for use by the LoadPicture statement.

In this article, we will use the `MemoryStream` object from the `System.IO` base class to copy the image data from the database directly into the PictureBox control.

## Requirements

The following list outlines the recommended hardware, software, network infrastructure, and service packs that you will need:

- Visual Studio .NET installed on a compatible Windows operating system
- An available instance of SQL Server or an available Access database for testing

This article assumes that you are familiar with the following topics:

- Visual C# .NET Windows Forms applications
- Binary large object (BLOB) storage in databases
- ADO.NET data access

## Sample

1. Create a SQL Server or Access table with the following structure:

    ```sql
    CREATE TABLE BLOBTest
    (
        BLOBID INT IDENTITY NOT NULL,
        BLOBData IMAGE NOT NULL
    )
    ```

2. Open Visual Studio .NET and create a new Visual C# Windows Application Project.
3. Add a PictureBox and two Button controls to the default Form1 from the toolbox. Set the `Text` property of `Button1` to **File to Database** and the `Text` property of `Button2` to **Database to PictureBox**.
4. Insert the following using statements at the top of the form's code module:

    ```csharp
    using System.Data.SqlClient;
    using System.IO;
    using System.Drawing.Imaging;
    ```

5. Add the following declaration for the database connection string just inside the public class Form1: `System.Windows.Forms.Form class` declaration and adjust the connection string as necessary:

    ```csharp
    String strCn = "Data Source=localhost;integrated security=sspi;initial catalog=mydata";
    ```

6. Insert the following code in the `Click` event procedure of `Button1` (**File to Database**). Adjust the file path to an available sample image file as necessary. This code reads the image file from disk (using a `FileStream` object) into a `Byte` array, and then inserts the data into the database by using a parameterized Command object.

    ```csharp
    try
    {
        SqlConnection cn = new SqlConnection(strCn);
        SqlCommand cmd = new SqlCommand("INSERT INTO BLOBTest (BLOBData) VALUES (@BLOBData)", cn);
        String strBLOBFilePath = @"C:\blue hills.jpg";//Modify this path as needed.

        //Read jpg into file stream, and from there into Byte array.
        FileStream fsBLOBFile = new FileStream(strBLOBFilePath,FileMode.Open, FileAccess.Read);
        Byte[] bytBLOBData = new Byte[fsBLOBFile.Length];
        fsBLOBFile.Read(bytBLOBData, 0, bytBLOBData.Length);
        fsBLOBFile.Close();

        //Create parameter for insert command and add to SqlCommand object.
        SqlParameter prm = new SqlParameter("@BLOBData", SqlDbType.VarBinary, bytBLOBData.Length, ParameterDirection.Input, false,
        0, 0, null, DataRowVersion.Current, bytBLOBData);
        cmd.Parameters.Add(prm);

        //Open connection, execute query, and close connection.
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    catch(Exception ex)
    {
        MessageBox.Show(ex.Message);
    }
    ```

7. Insert the following code in the `Click` event procedure of `Button2` (**Database to PictureBox**). This code retrieves the rows from the `BLOBTest` table in the database into a `DataSet`, copies the most recently added image into a `Byte` array and then into a `MemoryStream` object, and then loads the `MemoryStream` into the `Image` property of the PictureBox control.

    ```csharp
    try
    {
        SqlConnection cn = new SqlConnection(strCn);
        cn.Open();

        //Retrieve BLOB from database into DataSet.
        SqlCommand cmd = new SqlCommand("SELECT BLOBID, BLOBData FROM BLOBTest ORDER BY BLOBID", cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds, "BLOBTest");
        int c = ds.Tables["BLOBTest"].Rows.Count;

        if(c>0)
        {
            //BLOB is read into Byte array, then used to construct MemoryStream,
            //then passed to PictureBox.
            Byte[] byteBLOBData = new Byte[0];
            byteBLOBData = (Byte[])(ds.Tables["BLOBTest"].Rows[c - 1]["BLOBData"]);
            MemoryStream stmBLOBData = new MemoryStream(byteBLOBData);
            pictureBox1.Image= Image.FromStream(stmBLOBData);
        }
        cn.Close();
    }
    catch(Exception ex)
    {
        MessageBox.Show(ex.Message);
    }
    ```

8. Press **F5** to compile and run the project.
9. Click the **File to Database** button to load at least one sample image into the database.
10. Click the **Database to PictureBox** button to display the saved image in the PictureBox control.
11. If you would like to be able to insert the image from the PictureBox control directly into the database, add a third Button control and insert the following code in its `Click` event procedure. This code retrieves the image data from the PictureBox control into a `MemoryStream` object, copies the `MemoryStream` into a `Byte` array, and then saves the `Byte` array to the database using a parameterized Command object.

    ```csharp
    try
    {
        SqlConnection cn = new SqlConnection(strCn);
        SqlCommand cmd = new SqlCommand("INSERT INTO BLOBTest (BLOBData) VALUES (@BLOBData)", cn);

        //Save image from PictureBox into MemoryStream object.
        MemoryStream ms = new MemoryStream();
        pictureBox1.Image.Save(ms, ImageFormat.Jpeg);

        //Read from MemoryStream into Byte array.
        Byte[] bytBLOBData = new Byte[ms.Length];
        ms.Position = 0;
        ms.Read(bytBLOBData, 0, Convert.ToInt32(ms.Length));

        //Create parameter for insert statement that contains image.
        SqlParameter prm = new SqlParameter("@BLOBData", SqlDbType.VarBinary, bytBLOBData.Length, ParameterDirection.Input, false,
        0, 0,null, DataRowVersion.Current, bytBLOBData);
        cmd.Parameters.Add(prm);
        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    catch(Exception ex)
    {
        MessageBox.Show(ex.Message);
    }
    ```

12. Run the project. Click the **Database to PictureBox** button to display a previously saved image in the PictureBox control. Click the newly added button to save the image from the PictureBox into the database. Then click the **Database to PictureBox** button again to confirm that the image was saved correctly.

## Pitfalls

- This test will not work with the Photo column in the Employees table of the sample Northwind database distributed with Access and SQL Server. The bitmap images stored in the Photo column are wrapped with the header information created by the Visual Basic 6.0 OLE Container control.

- If you need to use an Access database to test this code, you will need to create the column in the Access table as type OLE Object, and use the `System.Data.OleDb` namespace with the Jet 4.0 Provider in place of the `System.Data.SqlClient` namespace.
