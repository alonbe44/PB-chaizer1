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
