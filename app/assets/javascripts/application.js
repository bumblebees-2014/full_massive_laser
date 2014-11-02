// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $('[data_claim="claim"]').click(function(event) {

    console.log("clicked")
    console.log($('[data-ticket]').data().ticket)
    var url = "/tickets/" + $('[data-ticket]').data().ticket
    $.ajax({
      url: url,
      type: 'PUT'
    }).success(function(response) {
      console.log(response)
      $('[data-status]').remove()
      $('[data-title]').after(response.toString)
    })
  })
});
