using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.WinFormsUI.APIServices;
using DocumentFormat.OpenXml.EMMA;
using System.Net;

namespace DentalOffice.WinFormsUI.Forms.Appointments
{
    public partial class frmAppointments : Form
    {
        private readonly BaseAPIService<int, AppointmentDto, AppointmentSearchRequestDto> _apiService = new("appointments");
        private readonly BaseAPIService<int, DentistDto, DentistSearchRequestDto> _dentistApiService = new("dentists");
        private readonly BaseAPIService<int, TreatmentDto, TreatmentSearchRequestDto> _treatmentApiService = new("treatments");
        private readonly BaseAPIService<int, UserDto, UserSearchRequestDto> _userApiService = new("users");

        private ComboBoxHelper comboBoxHelper = new();
        public frmAppointments()
        {
            InitializeComponent();
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            AppointmentSearchRequestDto searchRequest = new()
            {
                Start = dtPicStart.Value.ToUniversalTime(),
                End = dtPicEnd.Value.ToUniversalTime(),
                DentistId = comboBoxHelper.GetIdFromComboBox(cmbDentists.SelectedValue),
                TreatmentId = comboBoxHelper.GetIdFromComboBox(cmbTreatments.SelectedValue),
                UserId = comboBoxHelper.GetIdFromComboBox(cmbClients.SelectedValue)
            };

            dgvAppointments.AutoGenerateColumns = false;
            dgvAppointments.DataSource = await _apiService.GetFilteredData<List<AppointmentDto>>(searchRequest);
        }

        private async Task LoadTreatments()
        {
            var treatments = await _treatmentApiService.GetAll<List<TreatmentDto>>();
            treatments.Insert(0, new TreatmentDto());
            cmbTreatments.DataSource = treatments;
            cmbTreatments.DisplayMember = "Name";
            cmbTreatments.ValueMember = "Id";

            await LoadClients();
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

            var users = await _userApiService.GetFilteredData<List<UserDto>>(searchRequest);
            users.Insert(0, new UserDto());
            cmbClients.DataSource = users;
            cmbClients.DisplayMember = "FullName";
            cmbClients.ValueMember = "Id";
        }

        private async Task LoadDentists()
        {
            var dentists = await _dentistApiService.GetAll<List<DentistDto>>();
            dentists.Insert(0, new DentistDto());
            cmbDentists.DataSource = dentists;
            cmbDentists.DisplayMember = "FullName";
            cmbDentists.ValueMember = "Id";

            await LoadTreatments();
        }

        private async void frmAppointments_Load(object sender, EventArgs e)
        {
            await LoadDentists();

            dgvAppointments.AutoGenerateColumns = false;
            dgvAppointments.DataSource = await _apiService.GetAll<List<AppointmentDto>>();
        }

        private void dgvAppointments_CellMouseDoubleClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            var id = dgvAppointments.SelectedRows[0].Cells[0].Value;
            frmAppointmentDetails frm = new(int.Parse(id.ToString()));
            frm.Show();
        }
    }
}
