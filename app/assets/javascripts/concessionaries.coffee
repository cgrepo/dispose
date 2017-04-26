$(document).on "turbolinks:load", ->
    $('.form-inline').submit (e) ->
        e.preventDefault()
    $('.srch').click ->
        concesionario = $('#name').val()
        $.ajax
            type: 'GET'
            url: '/concessionaries/get_byName'
            cache: false
            data:
                name: concesionario
            # success: (data) ->
            #     alert data
            #     return
            # error: (data) ->
            #     console.log data
            #     return
    