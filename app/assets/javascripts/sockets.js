
jQuery(function($) {
	var socket = io.connect("http://192.168.100.6:8000");

	socket.on('connect', function (data){
			console.log('Client has connected to the server!');
	});

	socket.on('refrescar', function (data){
			var str = document.URL;

		  if (str.substr(-4, 4) != 'edit') {
				setTimeout('location.reload(false);',2000);
		  }
	});

	$(document).ready(function(){
			$('#boton_aceptar_expediente').click(function(){
				socket.emit('cambios', { text: 'cambios'});
				return true;
			});
	});

	$(document).ready(function(){
			$('#boton_aceptar_contacto').click(function(){
				socket.emit('cambios', { text: 'cambios'});
				return true;
			});
	});

	$(document).ready(function(){
			$('#boton_aceptar').click(function(){
				socket.emit('cambios', { text: 'cambios'});
				return true;
			});
	});

	$(document).ready(function(){
			$('#boton_borrar').click(function(){
				socket.emit('cambios', { text: 'cambios'});
				return true;
			});
	});
});

