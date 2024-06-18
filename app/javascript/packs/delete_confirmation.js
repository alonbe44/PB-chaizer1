// document.addEventListener("DOMContentLoaded", () => {
//   let deleteButtons = document.querySelectorAll("form button.btn-danger");
//   let confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
//   let formToSubmit;
//
//   deleteButtons.forEach(button => {
//     button.addEventListener("click", (event) => {
//       event.preventDefault();
//       formToSubmit = button.closest("form");
//       new bootstrap.Modal(document.getElementById('deleteConfirmationModal')).show();
//     });
//   });
//
//   confirmDeleteBtn.addEventListener("click", () => {
//     formToSubmit.submit();
//   });
// });


// app/javascript/packs/delete_confirmation.js

document.addEventListener('DOMContentLoaded', () => {
  const deleteButtons = document.querySelectorAll('.btn-danger[data-bs-toggle="modal"]');
  const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

  deleteButtons.forEach(button => {
    button.addEventListener('click', () => {
      const form = button.closest('form');
      confirmDeleteBtn.addEventListener('click', () => {
        form.submit();
      }, { once: true });
    });
  });
});
