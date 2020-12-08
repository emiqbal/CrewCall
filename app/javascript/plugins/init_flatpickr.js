// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.


const datePicker = () => {

  const startDateInput = document.getElementById('project_start_date');
  const endDateInput = document.getElementById('project_end_date');
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
};

export { datePicker };
