// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require templates
//= require jquery.datetimepicker.full.min
//= require submissions
//= require jquery.raty
//= require jquery.slimscroll
//= require bootstrap-tagsinput
//= require_self


$(document).ready(function(){
    $(".has_datepicker").datetimepicker({
      timepicker: false,
      format: 'Y/m/d'
    });


  $('.loc_auto_comp').click(function (e) {
    var id = $(this).attr('id');
    var input = document.getElementById(id);
    var options = {
      types: ['geocode']
    };

    var autocomplete = new google.maps.places.Autocomplete(input, options);
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
      var place = autocomplete.getPlace();
    });
  });
  $('.slim-scroll').slimScroll();
});