// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import * as mdb from 'mdb-ui-kit'; //MDBootstrap
import './mdb' //MdBootstrap
import './preview' //画像プレビューのスクリプトト
import "./jpostal.js"//jpostalの実行スクリプト

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap"; //bootstrap本体
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all' //

Rails.start()
Turbolinks.start()
ActiveStorage.start()