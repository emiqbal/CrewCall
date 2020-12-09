// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.


const datePicker = () => {

  const startDateInput = document.getElementById('job_start_date');
  const endDateInput = document.getElementById('job_end_date');

  // if startDateInput and endDateInput presentm (aka not null), then run the following)
  if (startDateInput && endDateInput) {
    endDateInput.disabled = true

    flatpickr(startDateInput, {
      minDate: "today",
      dateFormat: "Y-m-d",
    });

    console.log('im in the file')

    startDateInput.addEventListener("change", (e) => {
      if (startDateInput != "") {
        endDateInput.disabled = false
      }
      flatpickr(endDateInput, {
        minDate: e.target.value,
        dateFormat: "Y-m-d"
        });
      })
  }
};

export { datePicker };
