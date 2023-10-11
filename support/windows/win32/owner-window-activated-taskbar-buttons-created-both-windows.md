---
title: The owner window gets activated when taskbar buttons are created
description: Provides resolution for an issue where the owner window of a modal dialog can get activated when taskbar buttons are created for both windows.
ms.date: 09/22/2022
ms.custom: sap:Desktop app UI development
ms.reviewer: hihayak, davean, v-sidong
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# The owner window of a modal dialog can get activated when taskbar buttons are created for both windows

## Symptoms

Consider the following scenario:

- A .NET desktop application is created by using [Windows Forms](/dotnet/desktop/winforms/overview/) or [Windows Presentation Foundation](/dotnet/desktop/wpf/overview/) (WPF).

- The application uses the `ShowDialog()` method to display a modal dialog that is owned by another window.

- The application creates taskbar buttons for both windows by setting the `ShowInTaskbar` property value to `true`.

    > [!NOTE]
    > The window has a taskbar button if the property value is `true`. The default value is `true`.

In this scenario, the owner window can be activated by selecting its associated taskbar button. However, activating the owner window of a modal dialog can cause unexpected behavior or crashes in some applications, as the owner window should remain inactive and disabled until the modal dialog is dismissed.

## Resolution

Use the following method corresponding to your situation to create a single taskbar button for windows in a window ownership group, which includes the top-level window and any owned windows:

- If you use a `System.Windows.Forms.Form` object to display a modal dialog with an owner window, set the Form object's `ShowInTaskbar` property value to `false` prior to calling the `ShowDialog` method.

- If you use a `System.Windows.Window` object to display a modal dialog with an owner window, set the Window object's `ShowInTaskbar` property value to `false` prior to calling the `ShowDialog` method.

Then, when the taskbar button is selected, the system will activate the correct window in the ownership group.

## More information

The following example demonstrates this resolution in a .NET 6 desktop application using Windows Forms:

```csharp
namespace WinFormsApp1
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.Run(new Form1());
        }
    }

    public class Form1 : Form
    {
        public Form1()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            this.button1.Location = new System.Drawing.Point(20, 20);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(200, 34);
            this.button1.TabIndex = 0;
            this.button1.Text = "Form2.ShowDialog";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.Button1_Click);
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.button1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
        }

        private void Button1_Click(object? sender, EventArgs e)
        {
            Form2 form = new Form2();
            form.Owner = this;
            form.ShowInTaskbar = false;
            form.ShowDialog();
        }
        private Button button1;
    }

    public class Form2 : Form
    {
        public Form2()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            this.button1.Location = new System.Drawing.Point(20, 20);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(200, 34);
            this.button1.TabIndex = 0;
            this.button1.Text = "Form3.ShowDialog";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.Button1_Click);
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.button1);
            this.Name = "Form2";
            this.Text = "Form2";
            this.BackColor = System.Drawing.Color.Aqua;
            this.ResumeLayout(false);
        }

        private void Button1_Click(object? sender, EventArgs e)
        {
            Form3 form = new Form3();
            form.Owner = this;
            form.ShowInTaskbar = false;
            form.ShowDialog();
        }
        private Button button1;
    }

    public class Form3 : Form
    {
        public Form3()
        {
            this.SuspendLayout();
            this.AutoScaleDimensions = new System.Drawing.SizeF(10F, 25F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Name = "Form3";
            this.Text = "Form3";
            this.BackColor = System.Drawing.Color.Olive;
            this.ResumeLayout(false);
        }
    }
}
```
