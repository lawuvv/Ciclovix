
$(document).on("ready page:load", EventosManterPontoInteresse);
$(document).on("ready page:load", IniciarMapaPrincipal);
$(document).on("ready page:load", IniciarMapaDetalhes);

function EventosManterPontoInteresse() {
  $('.usar_geolocalizacao').click(function(e) { BuscarPorGeolocalizacao(e); });
  $(".buscar_endereco").keypress(function(e) { KeyPressEndereco(e); });
  $(".nav-tabs a[href='#mapa']").on('shown.bs.tab', function() { IniciarMapaUsuario(); });
}

function BuscarPorGeolocalizacao(event) {
  event.preventDefault();
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      AtualizarMapa(position.coords.latitude, position.coords.longitude);
      geocoder.geocode({ 'latLng': new google.maps.LatLng(position.coords.latitude, position.coords.longitude) }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          if (results[0])
            $('#ponto_interesse_endereco').val(results[0].formatted_address);
        }
      });
      },
      function( error ) {
          console.log("Something went wrong: ", error);
      }
    );
  }
}

function KeyPressEndereco(event) {
  if (event.which == 13) {
     event.preventDefault();
     BuscarNoMapa();
  }
}

function BuscarNoMapa() {
  var address = $('#ponto_interesse_endereco').val().trim();
  if (address == "") return;
  geocoder.geocode( {'address': address}, function(results, status) {
    switch(status) {
      case google.maps.GeocoderStatus.OK:
        var msg = AvaliarLocalidadeConfiguracao(results[0]);
        if (msg != '') {
          $('#ponto_latitude').val(null);
          $('#ponto_longitude').val(null);
          $('#ponto_interesse_endereco').val(null);
          alert(msg);
        } else {
          var latitude = results[0].geometry.location.lat();
          var longitude = results[0].geometry.location.lng();
          AtualizarMapa(latitude, longitude, 16);
        }
        break;
      case google.maps.GeocoderStatus.ZERO_RESULTS:
        alert("Nenhum endereço foi encontrado"); break;
      default:
        alert('Erro interno ao Buscar o Endereço'); break;
    }
  });
}

function AtualizarMapa(latitude, longitude, zoom, showMarker) {
  var position = new google.maps.LatLng(latitude, longitude);
  showMarker = typeof showMarker !== 'undefined' ? showMarker : true;
  zoom = typeof zoom !== 'undefined' ? zoom : 16;
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function() {
    markers = showMarker ? handler.addMarkers([{"lat":latitude,"lng":longitude}], {draggable: true}) : null;
  	if (showMarker) handler.bounds.extendWith(markers);  		
    handler.getMap().setCenter(position);
    handler.getMap().setZoom(zoom);
    if (showMarker) {
      for (var i = 0; i < markers.length; ++i) {
        google.maps.event.addListener(markers[i].serviceObject, 'dragend', function() {
          AtualizarCampos(this.getPosition(), true);
        });
      }
    }
  });

  if (showMarker) AtualizarCampos(position);
}

function AtualizarCampos(position, updateAddress) {
  $('#ponto_latitude').val(position.lat());
  $('#ponto_longitude').val(position.lng());

  if (updateAddress) {
    geocoder.geocode({ 'latLng': position}, function (results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0]) {
          $('#ponto_interesse_endereco').val(results[0].formatted_address);
          var msg = AvaliarLocalidadeConfiguracao(results[0]);
          if (msg != '') {
            $('#ponto_latitude').val(null);
            $('#ponto_longitude').val(null);
            $('#ponto_interesse_endereco').val(null);
            alert(msg);
          }
        }
      }
    });
  }
}

function AvaliarLocalidadeConfiguracao(result) {
  var estado = $('#ponto_estado'); estado.val(null);
  var uf = $('#ponto_uf'); uf.val(null);
  var estado_configuracao = $('#estado_configuracao').val();
  var uf_configuracao = $('#uf_configuracao').val();
  var msg = '';

  $.each(result.address_components, function(i, component) {
    if (component.types[0] == 'administrative_area_level_1') {
      estado.val(component.long_name);
      uf.val(component.short_name);
      if (estado.val() != estado_configuracao && uf.val() != uf_configuracao) {
        msg = 'O Endereço está fora do limite de ' + estado_configuracao + ' (' + uf_configuracao + ')';
        return false;
      }
    }
  });

  return msg;
}

function IniciarMapaPrincipal() {
  if ($('#map').length <= 0) return;
  if ($('.form_principal').length <= 0) return;
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function() {
    //var kmls = handler.addKml({ url: "http://scriptseguro.com.br/routes.kml" });
    markers = handler.addMarkers(pontos);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
}

function IniciarMapaUsuario() {
  if ($('#map_user').length <= 0) return;
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map_user'}}, function() {
    markers = handler.addMarkers(pontos);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
}

function IniciarMapaDetalhes() {
  if ($('.mapa-detalhes').length <= 0) return;
  var latitude = $('#ponto_latitude').val();
  var longitude = $('#ponto_longitude').val();
  var position = new google.maps.LatLng(latitude, longitude);
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map_user'}}, function() {
    markers = handler.addMarkers([{"lat":latitude,"lng":longitude}]);
    handler.bounds.extendWith(markers);
    handler.getMap().setCenter(position);
    handler.getMap().setZoom(16);
  });
}

