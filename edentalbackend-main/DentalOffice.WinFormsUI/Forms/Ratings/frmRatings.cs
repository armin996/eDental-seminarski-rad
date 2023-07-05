using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.WinFormsUI.APIServices;

namespace DentalOffice.WinFormsUI.Forms.Ratings
{
    public partial class frmRatings : Form
    {
        private readonly BaseAPIService<int, RatingDto, RatingSearchRequestDto> _apiService = new("ratings");
        private readonly BaseAPIService<int, DentistDto, DentistSearchRequestDto> _dentistApiService = new("dentists");
        private readonly BaseAPIService<int, UserDto, UserSearchRequestDto> _userApiService = new("users");
        private ComboBoxHelper comboBoxHelper = new();
        public frmRatings()
        {
            InitializeComponent();
        }

        private async void frmRatings_Load(object sender, EventArgs e)
        {
            await LoadDentists();

            dgvRatings.AutoGenerateColumns = false;
            dgvRatings.DataSource = await _apiService.GetAll<List<RatingDto>>();
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            RatingSearchRequestDto searchRequest = new()
            {
                DentistId = comboBoxHelper.GetIdFromComboBox(cmbDentists.SelectedValue),
                UserId = comboBoxHelper.GetIdFromComboBox(cmbClients.SelectedValue)
            };

            dgvRatings.AutoGenerateColumns = false;
            dgvRatings.DataSource = await _apiService.GetFilteredData<List<RatingDto>>(searchRequest);
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
        }

        private async Task LoadDentists()
        {
            var dentists = await _dentistApiService.GetAll<List<DentistDto>>();
            dentists.Insert(0, new DentistDto());
            cmbDentists.DataSource = dentists;
            cmbDentists.DisplayMember = "FullName";
            cmbDentists.ValueMember = "Id";

            await LoadClients();
        }
    }
}
