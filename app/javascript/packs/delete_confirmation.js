document.addEventListener("DOMContentLoaded", () => {
  let deleteButtons = document.querySelectorAll("form button.btn-danger");
  let confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
  let formToSubmit;

  deleteButtons.forEach(button => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      formToSubmit = button.closest("form");
      new bootstrap.Modal(document.getElementById('deleteConfirmationModal')).show();
    });
  });

  confirmDeleteBtn.addEventListener("click", () => {
    formToSubmit.submit();
  });
});
