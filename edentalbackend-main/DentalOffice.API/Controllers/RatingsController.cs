using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Dtos;
using DentalOffice.Entities.dbEntities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using DentalOffice.Repositories.Interfaces;

namespace DentalOffice.API.Controllers
{
    [Route("api/ratings"), Authorize]
    [ApiController]
    public class RatingsController : BaseController<int, RatingDto, RatingSearchRequestDto, Rating>
    {
        public RatingsController(IBaseRepository<int, RatingDto, RatingSearchRequestDto, Rating> repository) : base(repository)
        {
        }

        [HttpGet("canRate")]
        public async Task<IActionResult> GetRatePermissionAsync([FromQuery] int userId, [FromQuery] int dentistId)
        => Ok(await _repository.CanRateAsync(userId, dentistId));
        
    }
}
