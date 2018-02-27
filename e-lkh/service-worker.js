/**
 * @license
 * Copyright (c) 2016 The Polymer Project Authors. All rights reserved.
 * This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
 * The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
 * The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
 * Code distributed by Google as part of the polymer project is also
 * subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
 */

/* eslint no-console: ["error", { allow: ["info"] }] */

// console.info(
//   'Service worker disabled for development, will be generated at build time.'
// );

importScripts('https://www.gstatic.com/firebasejs/4.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/4.10.1/firebase-messaging.js');

firebase.initializeApp({
    apiKey: "AIzaSyDKeX0MeJWB0hRcWNLhULc5bkwxKmjgovs",
    authDomain: "pusdikadm-196510.firebaseapp.com",
    databaseURL: "https://pusdikadm-196510.firebaseio.com",
    projectId: "pusdikadm-196510",
    storageBucket: "pusdikadm-196510.appspot.com",
    messagingSenderId: "240276356095"
});

const messanger = firebase.messaging();

messanger.setBackgroundMessageHandler(function(payload) {
  const notificationTitle = payload.data.title;
  const notificationOptions = {
        body: payload.data.body,
        icon: 'images/logo/logo-48x48.png'
  };
  return self.registration.showNotification(notificationTitle, notificationOptions);
});