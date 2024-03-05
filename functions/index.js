const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {setGlobalOptions} = require("firebase-functions/v2");
const {getMessaging} = require("firebase-admin/messaging");
const {logger} = require("firebase-functions");

initializeApp();
setGlobalOptions({maxInstances: 10});
const msg = getMessaging();

exports.sendOrderMessage = onDocumentCreated("Order/{id}", (event) => {
  const id = event.params.id;
  const topic = "order";
  const payload = {
    notification: {
      title: "New Order",
      body: "You have a new Order!",
    },
    data: {
      key: "neworder",
      value: id,
    },
    topic: topic,
  };
  msg
      .send(payload)
      .then((response) => {
        logger.log("Order message send");
      })
      .catch((error) => {
        logger.log("Error occured", error);
      });
});
