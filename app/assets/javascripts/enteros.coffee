$(document).on "turbolinks:load", ->
    $('.btnrm').hide()
    $('.tag').fadeToggle()
    $('.generate').toggle()
    $('.pdfcol').hide()
    $('.unit option[value="3"]').attr('disabled','disabled')
    $('.unit option[value="4"]').attr('disabled','disabled')
    $('.services').on 'change', ->
        if parseInt($('.services option:selected').val()) > 3
            $('.unit option[value="1"]').attr('disabled','disabled')#disable TON
            $('.unit option[value="2"]').attr('disabled','disabled')#disable KG
            $('.unit option[value="4"]').attr('disabled','disabled')#disable VEHICLE
            $('.unit option[value="3"]').removeAttr('disabled')#enable M3
            $('.unit').val(3)#SELECT M3
        else if parseInt($('.services option:selected').val()) == 3
                $('.unit option[value="1"]').attr('disabled','disabled')#disable TON
                $('.unit option[value="2"]').attr('disabled','disabled')#disable KG
                $('.unit option[value="3"]').attr('disabled','disabled')#disable M3
                $('.unit option[value="4"]').removeAttr('disabled')#enable VEHICLE
                $('.unit').val(4)#SELECT VEHICLE
            else
                $('.unit option[value="1"]').removeAttr('disabled')#enable TON
                $('.unit option[value="2"]').removeAttr('disabled')#enable KG
                $('.unit option[value="3"]').attr('disabled','disabled')#disable M3
                $('.unit option[value="4"]').attr('disabled','disabled')#disable VEHICLE
                $('.unit').val(1)#SELECT TON
    
    # $('.tbone').on 'click', ->
    #     #console.log($(this).find('td:eq(1)').text())
    #     id = $(this).find('td:eq(0)').text()
    #     console.log id
    #     $(this).remove()
    #     $.ajax
    #       type: 'DELETE'
    #       url: '/enteros/popService'
    #       dataType: 'json'
    #       data: id: id
    #       success: (data) ->
    #           console.log 'success'
    #           rowCount = $('.tbone').children('tr').length
    #           if rowCount == 0
    #             $('.btnrm').hide()
    #             $('.generate').hide()
    #             $('.tag').hide()
    #           if rowCount <= 6 and rowCount >= 1
    #             $('.btnplus').show()
    #             $('.generate').show()
    #       error: (data) ->
    #           console.log 'fail'
    #           console.log data
    #           debugger