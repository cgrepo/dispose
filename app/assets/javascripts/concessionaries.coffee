$(document).on "turbolinks:load", ->
    $('form').submit (e) ->
        e.preventDefault()
    $('.srch').click ->
        concesionario = $('#name').val()
        $.ajax
            type: 'GET'
            url: '/concessionaries/get_byName'
            cache: false
            data:
                name: concesionario