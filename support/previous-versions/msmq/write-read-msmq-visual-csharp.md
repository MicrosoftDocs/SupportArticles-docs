---
title: Write and read Message Queuing in Visual C#
description: This article describes how to write to and read from Microsoft Message Queuing in Visual C#.
ms.date: 07/24/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Use Visual C# to write to and read from Microsoft Message Queuing

This article describes how to write to and read from Microsoft Message Queuing (MSMQ) in Visual C#.

_Original product version:_ &nbsp; Microsoft Message Queuing  
_Original KB number:_ &nbsp; 815811

## In this task

- [Summary](#summary)
- [Requirements](#requirements)
- [Write to and read from MSMQ](#write-to-and-read-from-msmq)
- [Complete code listing (Form1.cs)](#complete-code-listing-form1cs)
- [Verify the code](#verify-the-code)
- [Troubleshoot](#troubleshoot)

## Summary

This article describes the following:

- How to create a message and send it to MSMQ in a Windows application.
- How to read from a private queue and to deserialize the message contents for display.

## Requirements

The following items describe the recommended hardware, software, network infrastructure, skills and knowledge, and service packs that are required:

- One of the following operating systems with MSMQ installed (it is included as an option on the four operating systems): Windows 2000 Professional (or Server), or Windows XP Professional (or Server).

This article also assumes that you are familiar with the following:  

- MSMQ
- Using tools from the command prompt

[back to the top](#in-this-task)

## Write to and read from MSMQ

The `System.Messaging` namespace in the .NET Framework has the classes that you must have to read from and write to MSMQ. To create a small Windows application that mimics an online bill payment system, follow these steps:

1. Open Visual Studio .NET or Visual Studio 2005.
2. Create a new Windows application in Visual C#, and then name it *MSMQ*.
3. To display **Solution Explorer** if it does not appear, press CTRL+ALT+L. In **Solution Explorer**, right-click **References**, and then click **Add Reference**.
4. On the **.NET** tab, select the *System.Messaging.dll* file in the list of *.dll* files. Click **Select**, and then click **OK**.

   > [!NOTE]
   > In Visual Studio 2005, click the *System.Messaging.dll* file in the list of DLLs, and then click **OK**.

5. *Form1.cs* is open in Design view. If it is not open, double-click *Form1.cs* in **Solution Explorer**.  
6. Press CTRL+ALT+X to open the toolbox. In the **Toolbox**, click the **Windows Forms** tab.  
7. From the **Toolbox**, drag the following to the middle of *Form1*:
    - Four rows each of a Label and a Textbox (positioned to the right of each label).
    - Under the labels and text boxes, drag two Button controls onto *Form1*.
8. Right-click the controls, click **Properties**, and then set the **Text** property for the labels to the following (in order):

    - Pay To:
    - Your Name:
    - Amount:
    - Due Date:

9. In the **Properties** dialog box, set the **Text** property of button1 to **Send Payment**, and set the **Text** property of button2 to **Process Payment**.
10. This application works with a private queue that you must first create in the Computer Management console. To do this, follow these steps:

    1. On the desktop, right-click **My Computer**, and then click **Manage**.
    1. Expand the **Services and Applications** node to find MSMQ.

    > [!NOTE]
    > If you do not find MSMQ, it is not installed.

11. Expand **Message Queuing**, right-click **Private Queues**, point to **New**, and then click **Private Queue**.
12. In the **Queue name** box, type *billpay*, and then click **OK**.

    > [!NOTE]
    > Do not select the **Transactional** check box. Leave the Computer Management console open because you return to it later to view messages.

13. At the top of the code in *Form1*, add two `USING` statements before the class declaration to include the additional classes that reside in the `System.Messaging` namespace and the `System.Text` namespaces. (The `System.Text` namespace is for the use of the `StringBuilder` class, a new .NET Framework class that it is best to use when you concatenate strings.)

    ```csharp
    using System.Messaging;
    using System.Text;
    ```

14. Create a structure that contains variables to hold the data that defines a payment. To create the structure, add the following code after the Main procedure:

    ```csharp
    public struct Payment
    {
        public string Payor,Payee;
        public int Amount;
        public string DueDate;
    }
    ```

15. Add the code in the following steps to the `Click` event of `button1`.

    1. Set the properties of the structure to values of the form elements as follows:

        ```csharp
        Payment myPayment;
        myPayment.Payor = textBox1.Text;
        myPayment.Payee = textBox2.Text;
        myPayment.Amount = Convert.ToInt32(textBox3.Text);
        myPayment.DueDate = textBox4.Text;
        ```

    2. Create an instance of the `Message` class, and then set the `Body` property to the `payment` structure:

        ```csharp
        System.Messaging.Message msg = new System.Messaging.Message();
        msg.Body=myPayment;
        ```

    3. To send a message to MSMQ, create an instance of the `MessageQueue` class and call the `Send` method that passes in the `Message` object. The `MessageQueue` class is the wrapper that manages the interaction with MSMQ.

        > [!NOTE]
        > The syntax for setting the path of the private queue that you created in the Computer Management console. Private queues take the form `machinename\Private$\queuename`. Local host machines are referenced with a dot or a period (shown as *.*).

        ```csharp
        MessageQueue msgQ =new MessageQueue(".\\Private$\\billpay");
        msgQ.Send(msg);
        ```

        The code now exists to send a message to MSMQ. The .NET Framework automatically serializes the message by using an `XMLMessageFormatter` object. This object is implicitly created when messages are sent.

16. Add the code in the following steps to the `Click` event of button2. The `button2_Click` event handler receives and processes the payment message that is sent in the `button1` event handler.

    1. The first line of code is the same as the line of code that is in the first event handler:

        ```csharp
        MessageQueue msgQ = new MessageQueue(".\\Private$\\billpay");
        ```

    2. Create an array of types to pass to the `XMLMessageFormatter` class.

        > [!NOTE]
        > This class must be explicitly created when receiving messages. The constructor of the `XMLMessageFormatter` class takes either a string array of type names or, more preferably, a `Type` array of types:

        ```csharp
        Payment myPayment=new Payment();
        Object o=new Object();
        System.Type[] arrTypes=new System.Type [2];
        arrTypes[0] = myPayment.GetType();
        arrTypes[1] = o.GetType();
        msgQ.Formatter = new XmlMessageFormatter(arrTypes);
        myPayment=((Payment)msgQ.Receive().Body);
        ```

        These types tell the `XMLMessageFormatter` how to deserialize the message.

    3. Messages are received by calling the `Receive` method. Access the `Body` property to read the message contents. The `Body` property returns an object, therefore the object has to be cast to the payment type to retrieve the contents in a usable form:

        ```csharp
        StringBuilder sb = new StringBuilder();
        sb.Append("Payment paid to: " + myPayment.Payor);
        sb.Append("\n");
        sb.Append("Paid by: " + myPayment.Payee);
        sb.Append("\n");
        sb.Append("Amount: $" + myPayment.Amount.ToString());
        sb.Append("\n");
        sb.Append("Due Date: " + Convert.ToDateTime(myPayment.DueDate));
        ```

    4. Create a message box to display the results:

        ```csharp
        MessageBox.Show(sb.ToString(), "Message Received!");
        ```

[back to the top](#in-this-task)

## Complete code listing (Form1.cs)

```csharp
using System.Messaging;
using System.Text;
using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace WindowsApplication1
{
/// <summary>
/// Summary description for Form1.
/// </summary>
    public class Form1 : System.Windows.Forms.Form
    {
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.TextBox textBox4;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.Container components = null;
        public Form1()
        {
        // Required for Windows Form Designer support
            InitializeComponent();
        // TODO: Add any constructor code after InitializeComponent call
        }
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose( bool disposing )
        {
            if( disposing )
            {
                if (components != null)
                {
                    components.Dispose();
                }
            }
            base.Dispose( disposing );
        }
        #region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // label1
            this.label1.Location = new System.Drawing.Point(8, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(104, 32);
            this.label1.TabIndex = 0;
            this.label1.Text = "Pay To:";
            // label2
            this.label2.Location = new System.Drawing.Point(8, 80);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(104, 32);
            this.label2.TabIndex = 1;
            this.label2.Text = "Your Name:";
            // label3
            this.label3.Location = new System.Drawing.Point(8, 136);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(112, 32);
            this.label3.TabIndex = 2;
            this.label3.Text = "Amount:";
            // label4
            this.label4.Location = new System.Drawing.Point(8, 184);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(104, 40);
            this.label4.TabIndex = 3;
            this.label4.Text = "Due To:";
            // textBox1
            this.textBox1.Location = new System.Drawing.Point(152, 24);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(128, 20);
            this.textBox1.TabIndex = 4;
            this.textBox1.Text = "textBox1";
            // textBox2
            this.textBox2.Location = new System.Drawing.Point(160, 80);
            this.textBox2.Name = "textBox2";
            this.textBox2.TabIndex = 5;
            this.textBox2.Text = "textBox2";
            // textBox3
            this.textBox3.Location = new System.Drawing.Point(160, 128);
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new System.Drawing.Size(112, 20);
            this.textBox3.TabIndex = 6;
            this.textBox3.Text = "textBox3";
            // textBox4
            this.textBox4.Location = new System.Drawing.Point(160, 184);
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new System.Drawing.Size(120, 20);
            this.textBox4.TabIndex = 7;
            this.textBox4.Text = "textBox4";
            // button1
            this.button1.Location = new System.Drawing.Point(8, 232);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(104, 40);
            this.button1.TabIndex = 8;
            this.button1.Text = "Send Payment";
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // button2
            this.button2.Location = new System.Drawing.Point(160, 232);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(120, 40);
            this.button2.TabIndex = 9;
            this.button2.Text = "Process Payment";
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // Form1
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.ClientSize = new System.Drawing.Size(292, 273);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.textBox4);
            this.Controls.Add(this.textBox3);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
        }
        #endregion
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.Run(new Form1());
        }
        private void button1_Click(object sender, System.EventArgs e)
        {
            Payment myPayment;
            myPayment.Payor = textBox1.Text;
            myPayment.Payee = textBox2.Text;
            myPayment.Amount = Convert.ToInt32(textBox3.Text);
            myPayment.DueDate = textBox4.Text;
            System.Messaging.Message msg = new System.Messaging.Message();
            msg.Body=myPayment;
            MessageQueue msgQ =new MessageQueue(".\\Private$\\billpay");
            msgQ.Send(msg);
        }
        private void button2_Click(object sender, System.EventArgs e)
        {
            MessageQueue msgQ = new MessageQueue(".\\Private$\\billpay");
            Payment myPayment=new Payment();
            Object o=new Object();
            System.Type[] arrTypes=new System.Type [2];
            arrTypes[0] = myPayment.GetType();
            arrTypes[1] = o.GetType();
            msgQ.Formatter = new XmlMessageFormatter(arrTypes);
            myPayment=((Payment)msgQ.Receive().Body);
            StringBuilder sb = new StringBuilder();
            sb.Append("Payment paid to: " + myPayment.Payor);
            sb.Append("\n");
            sb.Append("Paid by: " + myPayment.Payee);
            sb.Append("\n");
            sb.Append("Amount: $" + myPayment.Amount.ToString());
            sb.Append("\n");
            sb.Append("Due Date: " + Convert.ToDateTime(myPayment.DueDate));
            MessageBox.Show(sb.ToString(), "Message Received!");
        }
        public struct Payment
        {
            public string Payor,Payee;
            public int Amount;
            public string DueDate;
        }
    }
}
```

> [!NOTE]
> The code should be changed in Visual Studio 2005. When you create a Windows Forms project, Visual C# adds one form to the project by default. This form is named *Form1*. The two files that represent the form are named *Form1.cs* and *Form1.designer.cs*. You write your code in *Form1.cs*. The *Designer.cs* file is where the Windows Forms Designer writes the code that implements all the actions that you performed by adding controls. For more information about the Windows Forms Designer in Visual C# 2005, see [Creating a Project (Visual C#)](/previous-versions/visualstudio/visual-studio-2008/ms173077(v=vs.90))

[back to the top](#in-this-task)

## Verify the code

1. On the **Debug** menu, click **Start**.
2. Type values in each text box, and then click **Send Payment**.
3. Return to the Computer Management console. Click the **Queue messages** folder in **Private Queues** under **billpay**, and then verify that MSMQ received a message (indicated by an envelope icon).
4. Right-click the message, click **Properties**, and then click the **Body** tab. You notice the payment message.

    > [!NOTE]
    > The contents of the payment message are serialized as XML.

5. Return to the bill payment Windows application, and then click the **Process Payment** button. You see a message box that confirms the receipt of a message and displays the message.

[back to the top](#in-this-task)

## Troubleshoot

- The lack of a private queue is generally an issue only on Windows 2000 Professional and Windows XP Professional. Windows 2000 Server and Windows XP Server permit the use of the public queue.

- Passing the correct arguments to `XMLMessageFormatter()` can be tricky. In this example, exceptions are thrown if either the object or the Payment Types are not included in the Type array that is passed to the constructor.

[back to the top](#in-this-task)
