$(document).on "turbolinks:load", ->
    $('.btnrm').hide()
    $('.tag').fadeToggle()
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
    
            
# $('.unit option[value="1"]').prop("disabled", true)
#             $('.unit option[value="2"]').prop("disabled", true)
#             $('.unit option[value="3"]').prop("enabled", true)  
            
# $('.unit option[value="1"]').prop("enabled", true)
#             $('.unit option[value="2"]').prop("enabled", true)
#             $('.unit option[value="3"]').prop("disabled", true)
        
#    $('.btnplus').click ->  
#        $('.btnrm').show()
    
#    $('.btnrm').click ->
#        alert $('.tbone').children('tr').length
    
# need it global
#tax = 0
#$(document).on "turbolinks:load", ->
#    $('#btn').click ->
#        $.ajax
#            url:'/enteros/'
#            type:'POST'
#            dataType:'script'
#            data: { service: $('.services option:selected').val(),quantity: $('.cantidad').val(), unit: $('.unit').val() }
#    op = 1
#    $('.plus').click ->
#        $.ajax
#            url:'/enteros/insertServices'
#    		type:'GET'
#    		dataType:'script'
#    		data:
#   			s: $('.services option:selected').val(),
#    			q: $('.cantidad').val(),
#    			u: $('.unit').val()
	
#    $('.services').change ->
#        op = $('.services option:selected').val()
#        sm = 80.04
#        if op == '1'
#            tax = 4 * sm
#        else
#            if op == '2'
#                tax = 5 * sm
#            else
#                if op == '3'
#                    tax = 3 * sm
#                else
#                    tax = sm
#    $('form').on 'keypress', (e) ->
#        if e.keyCode == 13
#            return false
#    $('.cantidad').on "keydown", (e) ->
#        if e.keyCode == 13
#            alert('enter the matrix'+$('.cantidad').val())
#            if ($('.cantidad').val() == '0') || ($('.cantidad').val() == '')
#                alert('PROPORCIONAR UN VALOR SUPERIOR A 0')
#                $('.cantidad').val(0)
				
#        else
#            if ((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105))
#                alert('process')
#            else
#                alert('proporcionar solo numeros')
#                $('.cantidad').val(0)
#            if e.keyCode < 48 || e.keyCode > 57
#                alert('proporcionar solo numeros')
#                $('.cantidad').val(0)
#            else
#                if e.keyCode < 96 && e.keyCode > 105
#                    alert('not number numeric')
        
        
#        if ((e.keyCode < 48 && e.keyCode > 57) || (e.keyCode < 96 && e.keyCode > 105))
#            alert('no es numero')

#    $('.cantidad').val(0)
    
    
#    $('.cantidad').keydown ->
#        alert($('.cantidad').val())
#        alert(tax)
#           
#        $('.cost').textContent = tax.toPrecision(4)