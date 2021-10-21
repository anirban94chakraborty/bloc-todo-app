# FLUTTER TODO APP with REST API


Basic App to demonstrate working with REST API

---

A local REST API Server can be installed via NPM using the command:

> npm -g install json-server

The REST API Server stores data in this file (present in the root of this repository):

> db.json

Then the server can be run using the command:

> json-server --watch db.json

In order to access the REST API Endpoints from the server running on *__localhost:3000__* in the debug mode, the following base URL is to be used:

> http://10.0.2.2:3000
