---
title: Create a File-Compare function in C#
description: Describes how to create a File-Compare function in Visual C#. Also includes a code sample to explain the methods.
ms.date: 04/13/2020
ms.reviewer: keithf
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to create a File-Compare function

This article provides information about how to create a File-Compare function in Visual C# and includes a code sample to explain the methods.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 320348

## Summary

This article refers to the Microsoft .NET Framework Class Library namespace `System.IO`.

This step-by-step article demonstrates how to compare two files to see if their contents are the same. This comparison looks at the contents of the two files, not at the file names, locations, dates, times, or other attributes.

This functionality is similar to the MS-DOS-based Fc.exe utility that is included with various versions of Microsoft Windows and Microsoft MS-DOS, and with some development tools.

The sample code that is described in this article performs a byte-by-byte comparison until it finds a mismatch or it reaches the end of the file. The code also performs two simple checks to increase the efficiency of the comparison:

- If both file references point to the same file, the two files must be equal.
- If the size of the two files is not the same, the two files are not the same.

## Create the sample

1. Create a new Visual C# Windows Application project. By default, Form1 is created.
2. Add two textbox controls to the form.
3. Add a command button to the form.
4. On the **View** menu, click **Code**.
5. Add the following `using` statement to the `Form1` class:

    ```csharp
    using System.IO;
    ```

6. Add the following method to the `Form1` class:

    ```csharp
    // This method accepts two strings the represent two files to
    // compare. A return value of 0 indicates that the contents of the files
    // are the same. A return value of any other value indicates that the
    // files are not the same.
    private bool FileCompare(string file1, string file2)
    {
        int file1byte;
        int file2byte;
        FileStream fs1;
        FileStream fs2;

        // Determine if the same file was referenced two times.
        if (file1 == file2)
        {
            // Return true to indicate that the files are the same.
            return true;
        }

        // Open the two files.
        fs1 = new FileStream(file1, FileMode.Open);
        fs2 = new FileStream(file2, FileMode.Open);

        // Check the file sizes. If they are not the same, the files
        // are not the same.
        if (fs1.Length != fs2.Length)
        {
            // Close the file
            fs1.Close();
            fs2.Close();

            // Return false to indicate files are different
            return false;
        }

        // Read and compare a byte from each file until either a
        // non-matching set of bytes is found or until the end of
        // file1 is reached.
        do
        {
            // Read one byte from each file.
            file1byte = fs1.ReadByte();
            file2byte = fs2.ReadByte();
        }
        while ((file1byte == file2byte) && (file1byte != -1));

        // Close the files.
        fs1.Close();
        fs2.Close();

        // Return the success of the comparison. "file1byte" is
        // equal to "file2byte" at this point only if the files are
        // the same.
        return ((file1byte - file2byte) == 0);
    }
    ```

7. Paste the following code in the `Click` event of the command button:

    ```csharp
    private void button1_Click(object sender, System.EventArgs e)
    {
        // Compare the two files that referenced in the textbox controls.
        if (FileCompare(this.textBox1.Text, this.textBox2.Text))
        {
            MessageBox.Show("Files are equal.");
        }
        else
        {
            MessageBox.Show("Files are not equal.");
        }
    }
    ```

8. Save and then run the sample.
9. Supply the full paths to the two files in the text boxes, and then click the command button.

## References

For more information, visit the Microsoft Web sites [System.IO Namespace](/dotnet/api/system.io).
