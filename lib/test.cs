using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.Text;
using System.Windows.Forms;




namespace PDFdriverAPI
{

    public partial class Form1 : Form
    {

        PXCComLib6.CPXCPrinter PDFPrinter = null;
        bool bPXCPrinterDefault;

        public Form1()
        {
            InitializeComponent();
        }

        delegate void AddEventLogCallback(string text);

        void AddEventLog(string sText)
        {
            if (this.InvokeRequired)
            {
                AddEventLogCallback d = new AddEventLogCallback(AddEventLog);
                this.Invoke(d, new object[] { sText });
            }
            else
            {
                tbEventsLog.Text = sText + "\r\n" + tbEventsLog.Text;
                if (bPXCPrinterDefault)
                {
                    PDFPrinter.RestoreDefaultPrinter();
                    bPXCPrinterDefault = false;
                    tbEventsLog.Text = "!Restored Default Printer\r\n" + tbEventsLog.Text;
                }
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
			PXCComLib6.CPXCControlEx prnFactory = new PXCComLib6.CPXCControlEx();

            PDFPrinter = prnFactory.get_Printer("", "PDF-XChange Standard V6", "<REG CODE>", "<DEV CODE>") as PXCComLib6.CPXCPrinter;
            PDFPrinter.OnStartDoc += new PXCComLib6._IPXCPrinterEvents_OnStartDocEventHandler(prn_OnStartDoc);
            PDFPrinter.OnFileSaved += new PXCComLib6._IPXCPrinterEvents_OnFileSavedEventHandler(prn_OnFileSaved);
            PDFPrinter.OnDocSpooled += new PXCComLib6._IPXCPrinterEvents_OnDocSpooledEventHandler(prn_OnDocSpooled);
            PDFPrinter.OnError += new PXCComLib6._IPXCPrinterEvents_OnErrorEventHandler(prn_OnError);
            PDFPrinter.OnStartPage += new PXCComLib6._IPXCPrinterEvents_OnStartPageEventHandler(prn_OnStartPage);
            PDFPrinter.OnEndPage += new PXCComLib6._IPXCPrinterEvents_OnEndPageEventHandler(prn_OnEndPage);
            PDFPrinter.OnEndDoc += new PXCComLib6._IPXCPrinterEvents_OnEndDocEventHandler(prn_OnEndDoc);

            AddEventLog("Events inited");
            tbEventsLog.Select(0, 0);
            bPXCPrinterDefault = false;
        }

        void prn_OnStartPage(int JobID, int nPageNumber)
        {
            AddEventLog("StartPageEvent");
        }

        void prn_OnEndPage(int JobID, int nPageNumber)
        {
            AddEventLog("EndPageEvent");
        }

        void prn_OnEndDoc(int JobID, int nOK)
        { 
            AddEventLog("EndDocEvent");
        }

        void prn_OnError(int JobID, int dwErrorCode)
        {
            AddEventLog("ErrorEvent");
        }

        void prn_OnDocSpooled(int JobID, string lpszDocName, string lpszAppName)
        {
            AddEventLog("DocSpooledEvent");
        }

        void prn_OnFileSaved(int JobID, string lpszFileName)
        {
            AddEventLog("FileSavedEvent");
        }

        private void prn_OnStartDoc(int JobID, string lpszDocName, string lpszAppName)
        {
            AddEventLog("StartDocEvent");
        }

        private void printDoc_PrintPage(Object sender, PrintPageEventArgs e)
        {
            String textToPrint = "Just a simple Text";
            Font printFont = new Font("Courier New", 12, FontStyle.Bold);

            int leftMargin = e.MarginBounds.Left;
            int topMargin = e.MarginBounds.Top;
            e.Graphics.DrawString(textToPrint, printFont, Brushes.Black, leftMargin, topMargin);
            Pen dPen = new Pen(Color.Blue, 1);
            e.Graphics.DrawEllipse(dPen, e.MarginBounds.Left-20, e.MarginBounds.Top-20, 240, 70);
        }


        private void bPrint_Click(object sender, EventArgs e)
        {
            PDFPrinter.SetAsDefaultPrinter();
            bPXCPrinterDefault = true;

            PrintDocument printDoc = new PrintDocument();
            printDoc.PrintPage += new PrintPageEventHandler(printDoc_PrintPage); 
            printDoc.Print();
        }

        private void Form1_FormClosed(object sender, FormClosedEventArgs e)
        {            
            PDFPrinter = null;
        }

        private void bFilePrint_Click(object sender, EventArgs e)
        {
            PDFPrinter.SetAsDefaultPrinter();
            bPXCPrinterDefault = true;

            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = "TextFiles|*.doc;*.txt";
            if (DialogResult.OK == ofd.ShowDialog(this))
            {
                System.Diagnostics.Process printJob = new System.Diagnostics.Process();
                printJob.StartInfo.FileName = ofd.FileName;
                printJob.StartInfo.UseShellExecute = true;
                printJob.StartInfo.Verb = "print";
                printJob.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Minimized;
                printJob.Start();
            }
        }
    }
}