using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.WinFormsUI.APIServices;

namespace DentalOffice.WinFormsUI.Forms.Payments
{
    public partial class frmPayments : Form
    {
        private BaseAPIService<int, PaymentDto, PaymentSearchRequestDto> _apiService = new("payments");
        private BaseAPIService<int, UserDto, UserSearchRequestDto> _userApiService = new("users");
        private BaseAPIService<int, TreatmentDto, TreatmentSearchRequestDto> _treatmentApiService = new("treatments");
        private ComboBoxHelper comboBoxHelper = new();

        public frmPayments()
        {
            InitializeComponent();
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            PaymentSearchRequestDto searchRequest = new()
            {
                CardNumber = txtCardNumber.Text,
                UserId = comboBoxHelper.GetIdFromComboBox(cmbClients.SelectedValue),
                TreatmentId = comboBoxHelper.GetIdFromComboBox(cmbTreatments.SelectedValue)
            };

            dgvPayments.AutoGenerateColumns = false;
            dgvPayments.DataSource = await _apiService.GetFilteredData<List<PaymentDto>>(searchRequest);
        }

        private async void frmPayments_Load(object sender, EventArgs e)
        {
            await LoadClients();

            dgvPayments.AutoGenerateColumns = false;
            dgvPayments.DataSource = await _apiService.GetAll<List<PaymentDto>>();
        }

        private async Task LoadClients()
        {
            UserSearchRequestDto searchRequest = new()
            {
                FirstName = string.Empty,
                LastName = string.Empty,
                Username = string.Empty,
                Email = string.Empty,
                Phone = string.Empty,
                Gender = null,
                Role = Enums.Role.Client
            };

            var clients = await _userApiService.GetFilteredData<List<UserDto>>(searchRequest);
            clients.Insert(0, new UserDto());
            cmbClients.DataSource = clients;
            cmbClients.DisplayMember = "FullName";
            cmbClients.ValueMember = "Id";

            await LoadTreatments();
        }

        private async Task LoadTreatments()
        {
            var treatements = await _treatmentApiService.GetAll<List<TreatmentDto>>();
            treatements.Insert(0, new TreatmentDto());
            cmbTreatments.DataSource = treatements;
            cmbTreatments.DisplayMember = "Name";
            cmbTreatments.ValueMember = "Id";
        }
    }
}
