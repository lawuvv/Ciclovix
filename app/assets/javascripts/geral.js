
$(document).on("ready page:load", EventosGerais);

function EventosGerais() {
  EventosMarcarTodos();
  EventosRedimensionarImagens();
  EventosDenuncia();
  EventosLightbox();
}

function EventosMarcarTodos() {
  $("#ckTodosPontos").click(function () { MarcarTodos($(this).is(":checked"), 'tipo_ponto'); });
  $("#ckTodasRotas").click(function () { MarcarTodos($(this).is(":checked"), 'tipo_rota'); });
  
  $(":checkbox[name*='tipo_ponto']").click(function () {
    Revisar_MarcarTodos($(this).prop('name'), $("#ckTodosPontos"));
  });

  $(":checkbox[name*='tipo_rota']").click(function () {
    Revisar_MarcarTodos($(this).prop('name'), $("#ckTodasRotas"));
  });

  Revisar_MarcarTodos('tipo_ponto', $("#ckTodosPontos"));
  Revisar_MarcarTodos('tipo_rota', $("#ckTodasRotas"));
}

function MarcarTodos(is_checked, names) {
  $(":checkbox[name*='" + names + "']").prop("checked", is_checked);
}

function Revisar_MarcarTodos(name, element_checkall) {
  var all_checked = true;
  $(":checkbox[name*='" + name + "']").each(function () {
    var checked = $(this).is(":checked");
    if (!checked) {
      all_checked = false;
      return false;
    }
  });

  element_checkall.prop("checked", all_checked);
}

function EventosRedimensionarImagens() {
  $('#ponto_interesse_remove_foto').change(function () {
    $('#ponto_interesse_foto').val(null);
  });

  $('#ponto_interesse_foto').change(function () {
    $('#ponto_interesse_remove_foto').prop("checked", false);
  });
}

function EventosDenuncia() {

  $(".form-denuncia").on('ajax:complete', function(event, xhr, status) {
    var text = 'Denuncia concretizada. Obrigado pela colaboração!';
    var addClass = 'alert-success';
    var removeClass = 'alert-danger';    

    if (status != 'success' && status != 'ok') {
      text = 'Erro. A pergunta não foi respondida corretamente';
      addClass = 'alert-danger';
      removeClass = 'alert-success';  
    }
    else {
      grecaptcha.reset();
      $(this).find(':submit').hide("slow");
    }

    $(".alert-denuncia").show();
    $(".alert-denuncia span").text(text);
    $(".alert-denuncia").addClass(addClass);
    $(".alert-denuncia").removeClass(removeClass);
  });

  $('#ModalDenuncia').on('show.bs.modal', function () {
    $(this).find(':radio').prop('checked', false);
    $(this).find(':submit').show();
    $(".alert-denuncia").hide();
  });

}

function EventosLightbox() {
  $('.ekkoLightbox').click(function (event) {
    $(this).ekkoLightbox();
    event.preventDefault();
  });
}