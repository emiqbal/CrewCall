import consumer from "./consumer";

const generateNotificationAlert = (content) => {
  return `<div class="alert alert-warning" role="alert"><p>${content}</p></div>`;
};

const initNotificationsCable = () => {
  
    const recipient = document.getElementById('user-id').dataset.userId;
    const notificationBadge = document.querySelector('.navbar-badge');
    const navBar = document.querySelector('.navbar.navba-lewagon');

    if (recipient !== "") {
      console.log("notifschannel is connected");
      consumer.subscriptions.create({ channel: "Noticed::NotificationChannel" }, {
        received(data) {
          console.log(data.comment); // called when data is broadcast in the cable
          navBar.insertAdjacentHTML('afterend', generateNotificationAlert(data.comment));
          notificationBadge.classList.remove('d-none');
        },
      });
    }
};

export { initNotificationsCable };  