// import { Controller } from 'stimulus';

// export default class extends Controller {
//   static targets = ['form', 'card'];

//   confirmDelete(event) {
//     event.preventDefault();
//     const form = event.currentTarget;
//     const confirmDelete = confirm('Are you sure you want to delete this friend?');
//     if (confirmDelete) {
//       this.deleteFriend(form);
//     }
//   }

//   deleteFriend(form) {
//     const url = form.action;
//     const token = form.querySelector('input[name="_token"]').value;
//     fetch(url, {
//       method: 'POST',
//       headers: {
//         'Content-Type': 'application/json',
//         'X-CSRF-Token': token,
//       },
//       body: JSON.stringify({ _method: 'delete' }),
//     })
//       .then(response => {
//         if (response.ok) {
//           this.removeFriendCard(form);
//         } else {
//           console.error('Error deleting friend:', response.statusText);
//         }
//       })
//       .catch(error => {
//         console.error('Error deleting friend:', error);
//       });
//   }

//   removeFriendCard(form) {
//     const card = form.closest(this.cardTarget);
//     card.remove();
//   }
// }
