# need it global
#tax = 0
#$(document).on "turbolinks:load", ->
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