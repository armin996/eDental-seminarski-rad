namespace DentalOffice.WinFormsUI.Forms.Payments
{
    partial class frmPayments
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dgvPayments = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Date = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Amount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TreatmentName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Client = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.CardNumber = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.txtCardNumber = new System.Windows.Forms.TextBox();
            this.cmbTreatments = new System.Windows.Forms.ComboBox();
            this.cmbClients = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.btnSearch = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPayments)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvPayments
            // 
            this.dgvPayments.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPayments.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Date,
            this.Amount,
            this.TreatmentName,
            this.Client,
            this.CardNumber});
            this.dgvPayments.Location = new System.Drawing.Point(12, 121);
            this.dgvPayments.Name = "dgvPayments";
            this.dgvPayments.RowTemplate.Height = 25;
            this.dgvPayments.Size = new System.Drawing.Size(776, 307);
            this.dgvPayments.TabIndex = 0;
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.Name = "Id";
            this.Id.Visible = false;
            // 
            // Date
            // 
            this.Date.DataPropertyName = "Date";
            this.Date.HeaderText = "Date";
            this.Date.Name = "Date";
            // 
            // Amount
            // 
            this.Amount.DataPropertyName = "Amount";
            this.Amount.HeaderText = "Amount";
            this.Amount.Name = "Amount";
            // 
            // TreatmentName
            // 
            this.TreatmentName.DataPropertyName = "TreatmentName";
            this.TreatmentName.HeaderText = "Treatment";
            this.TreatmentName.Name = "TreatmentName";
            // 
            // Client
            // 
            this.Client.DataPropertyName = "Client";
            this.Client.HeaderText = "Client";
            this.Client.Name = "Client";
            // 
            // CardNumber
            // 
            this.CardNumber.DataPropertyName = "CardNumber";
            this.CardNumber.HeaderText = "Card number";
            this.CardNumber.Name = "CardNumber";
            // 
            // txtCardNumber
            // 
            this.txtCardNumber.Location = new System.Drawing.Point(418, 32);
            this.txtCardNumber.Name = "txtCardNumber";
            this.txtCardNumber.Size = new System.Drawing.Size(198, 23);
            this.txtCardNumber.TabIndex = 2;
            // 
            // cmbTreatments
            // 
            this.cmbTreatments.FormattingEnabled = true;
            this.cmbTreatments.Location = new System.Drawing.Point(21, 32);
            this.cmbTreatments.Name = "cmbTreatments";
            this.cmbTreatments.Size = new System.Drawing.Size(121, 23);
            this.cmbTreatments.TabIndex = 4;
            // 
            // cmbClients
            // 
            this.cmbClients.FormattingEnabled = true;
            this.cmbClients.Location = new System.Drawing.Point(207, 32);
            this.cmbClients.Name = "cmbClients";
            this.cmbClients.Size = new System.Drawing.Size(165, 23);
            this.cmbClients.TabIndex = 5;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(21, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(60, 15);
            this.label2.TabIndex = 7;
            this.label2.Text = "Treatment";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(207, 9);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(38, 15);
            this.label3.TabIndex = 8;
            this.label3.Text = "Client";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(418, 9);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(77, 15);
            this.label4.TabIndex = 9;
            this.label4.Text = "Card number";
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(713, 82);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(75, 23);
            this.btnSearch.TabIndex = 10;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // frmPayments
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cmbClients);
            this.Controls.Add(this.cmbTreatments);
            this.Controls.Add(this.txtCardNumber);
            this.Controls.Add(this.dgvPayments);
            this.Name = "frmPayments";
            this.Text = "Payments";
            this.Load += new System.EventHandler(this.frmPayments_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPayments)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DataGridView dgvPayments;
        private TextBox txtCardNumber;
        private ComboBox cmbTreatments;
        private ComboBox cmbClients;
        private Label label2;
        private Label label3;
        private Label label4;
        private Button btnSearch;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn Date;
        private DataGridViewTextBoxColumn Amount;
        private DataGridViewTextBoxColumn TreatmentName;
        private DataGridViewTextBoxColumn Client;
        private DataGridViewTextBoxColumn CardNumber;
    }
}