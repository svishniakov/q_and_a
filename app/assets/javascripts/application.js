// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require cocoon
//= require_self
//= require_tree .

$(document).on('click', '.notification > button.delete', function() {
    $(this).parent().addClass('is-hidden');
    return false;
});

$(document).on('click', '.edit-answer-link', function(e) {
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    return $('form#edit_answer_' + answerId).show();
});


var ready = function() {
    return $('.vote-link').on('ajax:success', function(e, data, status, xhr) {
        var rating = '#rating_' + data.id;
        var button = '#voting_' + data.id;
        $(rating).html(data.content);
        $(button).load(location.href + ' ' + button + '>*');
    }).on('ajax:error', function(e, response, status, xhr) {
        data = response.responseJSON;
        return $('.errors').html(data.content);
    });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
$(document).on('page:load', ready);
$(document).on('page:update', ready);
