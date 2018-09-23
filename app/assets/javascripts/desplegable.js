$(document).ready(function(){

	var substringMatcher = function(strs) {
		return function findMatches(q, cb) {
			var matches, substringRegex;
			 
			// an array that will be populated with substring matches
			matches = [];
			 
			// regex used to determine if a string contains the substring `q`
			substrRegex = new RegExp(q, 'i');
			 
			// iterate through the pool of strings and for any string that
			// contains the substring `q`, add it to the `matches` array
			$.each(strs, function(i, str) {
				if (substrRegex.test(str)) {
					// the typeahead jQuery plugin expects suggestions to a
					// JavaScript object, refer to typeahead docs for more info
					matches.push({ value: str });
				}
			});
			 
			cb(matches);
		};
	};

  $(".desplegable").each(function() {
    //var path = $("#listado_users").val();
    var contactos = [];
    var path = $(this).attr('datos_consulta') +  '.json';

    $.getJSON(path, function(data){
         $.each( data, function( key, val ) {
            contactos.push( val);
          });
    });
    $(this).typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: 'states',
      displayKey: 'value',
      source: substringMatcher(contactos)
    });
  });
});

