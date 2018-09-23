
$(document).ready(function(){
    (function($){
        $.fn.datetimepicker.dates['es'] = {
            days: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"],
            daysShort: ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"],
            daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"],
            months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
            today: "Hoy",
            suffix: [],
            meridiem: []
        };
    }(jQuery));

    $(".anyo").datepicker({format: "yyyy", language: "es", autoclose: true, viewMode: "years", minViewMode: "years"});
    $('.fecha').datepicker({format: "dd/mm/yyyy", weekStart: 1, language: "es", autoclose: true, todayHighlight: true});
    $('.fecha-hora').datetimepicker({format: "dd/mm/yyyy hh:ii", weekStart: 1, language: "es", autoclose: true, todayHighlight: true});
});

