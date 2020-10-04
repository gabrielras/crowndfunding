// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import bulmaQuickview from 'bulma-quickview/src/js'

document.addEventListener('turbolinks:load', function() {
    let quickviews = bulmaQuickview.attach()
})

document.addEventListener("turbolinks:load", function() {

  let notification = document.querySelector('.global-notification');
  if(notification) {
    window.setTimeout(function() {
      notification.style.display = "none";
    }, 4000);
  }

  $(".navbar-burger").click(function() {    
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });

  $(".showModal").click(function() {
    $(".modal").addClass("is-active");  
  });
  
  $(".modal-close").click(function() {
     $(".modal").removeClass("is-active");
  });

});

document.addEventListener('turbolinks:load', function() {
    const fileInput = document.querySelectorAll('input[type=file].file-input')
    fileInput.forEach(input => {
        input.onchange = () => {
        if (input.files.length > 0) {
            const fileName = input.parentNode.querySelector(".file-name")
            fileName.textContent = input.files[0].name
        }
    }
  })
})

document.addEventListener("turbolinks:load", function() {

  $(".filter-mobile-button").click(function() {
    $(".filter-mobile").toggle();
    $(".categories-mobile").hide();
  });
  $(".categories-mobile-button").click(function() {
    $(".categories-mobile").toggle();
    $(".filter-mobile").hide();
  });

});

$(document).on('turbolinks:load', function() {

    function limpa_formulário_cep() {
        // Limpa valores do formulário de cep.
        $("#street").val("");
        $("#neighborhood").val("");
        $("#city").val("");
        $("#state").val("");
    }
    
    //Quando o campo cep perde o foco.
    $("#cep").blur(function() {
        //Nova variável "cep" somente com dígitos.
        var cep = $(this).val().replace(/\D/g, '');
  
        //Verifica se campo cep possui valor informado.
        if (cep != "") {
  
            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;
  
            //Valida o formato do CEP.
            if(validacep.test(cep)) {
  
                //Preenche os campos com "..." enquanto consulta webservice.
                $("#street").val("...");
                $("#neighborhood").val("...");
                $("#city").val("...");
                $("#state").val("...");
  
                //Consulta o webservice viacep.com.br/
                $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {
  
                    if (!("erro" in dados)) {
                        //Atualiza os campos com os valores da consulta.
                        $("#street").val(dados.logradouro);
                        $("#neighborhood").val(dados.bairro);
                        $("#city").val(dados.localidade);
                        $("#state").val(dados.uf);
                    } //end if.
                    else {
                        //CEP pesquisado não foi encontrado.
                        limpa_formulário_cep();
                        alert("CEP não encontrado.");
                    }
                });
            } //end if.
            else {
                //cep é inválido.
                limpa_formulário_cep();
                alert("Formato de CEP inválido.");
            }
        } //end if.
        else {
            //cep sem valor, limpa formulário.
            limpa_formulário_cep();
        }
    });
});
