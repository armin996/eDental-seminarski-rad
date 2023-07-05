﻿using System.ComponentModel.DataAnnotations;

namespace DentalOffice.Dtos
{
    public record PaymentDto
    {
        public int Id { get; set; }
        [Required]
        public DateTime Date { get; set; }
        [Required]
        public decimal Amount { get; set; }
        [Required]
        public int UserId { get; set; }
        [Required]
        public int TreatmentId { get; set; }
        public string CardNumber { get; set; }
        public string PaymentIntent { get; set; }
        public string Client { get; set; }
        public string TreatmentName { get; set; }
        public string DentistName { get; set; }
        public int DentistId { get; set; }
    }
}
