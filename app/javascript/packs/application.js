// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

/**
 * Import Bootstrap JS
 */
import 'bootstrap'

/**
 * Import Application Custom CSS
 */
import '../styles/application'

/**
 * Import/Require AdminLTE Package
 */
require('admin-lte')

/**
 * Import Adminlte Plugins
 */

import Inputmask from "inputmask"
import Stepper from "bs-stepper"
global.toastr = require("toastr")

// import "@fortawesome/fontawesome-free/js/all"
import "@fortawesome/fontawesome-free/css/all.css";
import "select2/dist/js/select2"
import "tempusdominus-bootstrap-4/build/js/tempusdominus-bootstrap-4"
import "bootstrap-switch/dist/js/bootstrap-switch"
import "dropzone/dist/dropzone"
import "summernote/dist/summernote-bs4"
import "jquery-validation/dist/jquery.validate"
import "jquery-validation/dist/additional-methods"


//add an event listener to use a specific library
document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()

  Inputmask("999.999.999-99").mask($(".cpf"));
  Inputmask("99.999.999/9999-99").mask($(".cnpj"));
  Inputmask("(99) 99999999[9]").mask($(".phone"));
  Inputmask("99.999-999").mask($(".cep"));
  Inputmask("99999999999").mask($(".nis"));

  // //Initialize Select2 Elements
  $('.select2').select2()
  $('.select2bs4').select2({
    theme: 'bootstrap4'
  })

  $('.date').datetimepicker({
    format: 'd/m/Y'
  });
  $('.datetime').datetimepicker({
    format: 'd/m/Y H:i:s'
  });

  if($('.bs-stepper').length) window.stepper = new Stepper($('.bs-stepper')[0]);

  $("input[data-bootstrap-switch]").each(function(){
    $(this).bootstrapSwitch('state', $(this).prop('checked'));
  })

  $(".summernote").summernote();

  $.validator.setDefaults({
    submitHandler: function () {
      alert( "Form successful submitted!" );
    },
    errorElement: 'span',
    errorPlacement: function (error, element) {
      error.addClass('invalid-feedback');
      element.closest('.form-group').append(error);
    },
    highlight: function (element, errorClass, validClass) {
      $(element).addClass('is-invalid');
    },
    unhighlight: function (element, errorClass, validClass) {
      $(element).removeClass('is-invalid');
    }
  });

  $.validator.addMethod("validateCPF", function (value, element) {
    value = value.replace('.', '');
    value = value.replace('.', '');
    cpf = value.replace('-', '');
    while (cpf.length < 11) cpf = "0" + cpf;
    var expReg = /^0+$|^1+$|^2+$|^3+$|^4+$|^5+$|^6+$|^7+$|^8+$|^9+$/;
    var a = [];
    var b = new Number;
    var c = 11;
    for (i = 0; i < 11; i++) {
      a[i] = cpf.charAt(i);
      if (i < 9) b += (a[i] * --c);
    }
    if ((x = b % 11) < 2) {
      a[9] = 0
    } else {
      a[9] = 11 - x
    }
    b = 0;
    c = 11;
    for (y = 0; y < 10; y++) b += (a[y] * c--);
    if ((x = b % 11) < 2) {
      a[10] = 0;
    } else {
      a[10] = 11 - x;
    }
    if ((cpf.charAt(9) != a[9]) || (cpf.charAt(10) != a[10]) || cpf.match(expReg)) return false;
    return true;
  }, "Invalid CPF.");

  $('#loginForm').validate({
    rules: {
      cpf: { 
        required: true, 
        validateCPF: true
      },
      email: {
        required: true,
        email: true,
      },
      password: {
        required: true,
        minlength: 5
      },
      terms: {
        required: true
      },
    },
    messages: {
      cpf: { 
        required: "Digite o seu CPF!",
        verificaCPF: "CPF inválido" 
      },
      email: {
        required: "Please enter a email address",
        email: "Please enter a vaild email address"
      },
      password: {
        required: "Please provide a password",
        minlength: "Your password must be at least 5 characters long"
      },
      terms: "Please accept our terms"
    },
  });

  // // $.datetimepicker.setLocale('pt-BR')
  // // $('.date').datetimepicker({
  // //   format: 'd/m/Y',
  // //   timepicker: false,
  // //   lang: 'pt-BR',
  // //   mask: true,
  // //   step:30
  // // })

  // // $('.datetime').datetimepicker({
  // //   format: 'd/m/Y H:i:s',
  // //   timepicker: true,
  // //   lang: 'pt-BR',
  // //   mask: true,
  // //   step:30
  // // })

})

// document.addEventListener("load", () => {
  
// })


/**
 * Create a images context to serve images through Webpack
 */
 const images = require.context('../images', true)
