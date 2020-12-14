// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.


const datePicker = (resource) => {

  const startDateInput = document.getElementById(`${resource}_start_date`);
  const endDateInput = document.getElementById(`${resource}_end_date`);

  // if startDateInput and endDateInput presentm (aka not null), then run the following)
  if (startDateInput && endDateInput) {
    endDateInput.disabled = true

    if (resource == 'job') {
      const formElement = document.getElementById('form_with_calendar');
      const minJobDate = formElement.dataset.minDate;
      const maxJobDate = formElement.dataset.maxDate;
      flatpickr(startDateInput, {
      minDate: minJobDate,
      maxDate: maxJobDate,
      dateFormat: "Y-m-d",
      });
    } else {
      flatpickr(startDateInput, {
        minDate: "today",
        dateFormat: "Y-m-d",
      });
    }


    console.log('im in the file')

    startDateInput.addEventListener("change", (e) => {
      if (startDateInput != "") {
        endDateInput.disabled = false
      }
      if (resource == 'job') {
        const formElement = document.getElementById('form_with_calendar');
        const maxJobDate = formElement.dataset.maxDate;
        flatpickr(endDateInput, {
          minDate: e.target.value,
          maxDate: maxJobDate,
          dateFormat: "Y-m-d"
        });
      } else {
          flatpickr(endDateInput, {
            minDate: e.target.value,
            dateFormat: "Y-m-d"
            });
      }
      })
  }
};

export { datePicker };
