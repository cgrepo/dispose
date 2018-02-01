# class HighlightCallback
#   def initialize(options)
#     @color    = options[:color]
#     @document = options[:document]
#   end
#   def render_behind(fragment)
#     original_color       = @document.fill_color
#     @document.fill_color = @color
#     @document.fill_rectangle(fragment.top_left, fragment.width, fragment.height)
#     @document.fill_color = original_color
#   end
# end
#require 'action_view'
#include ActionView::Helpers::NumberHelper
require 'active_support'

class EnteroPdf < Prawn::Document
    include ActiveSupport::NumberHelper
    def initialize(enteros)
        super()
        
        @enteros = enteros
        @UMA = 75.49
        #@UMA = 104.78
        @folio = Time.now.strftime("%d%m%Y-%j-#{Concessionary.find_by(name:@enteros.first.taxpayer).id}")
        @grandTotal = 0
        @quantity = 0
        @cost = 0
        @percent = 0
        @total = 0
        setUp
        setQuantities(@enteros,@UMA)
        setFoot
    end
#------PRIVATE METHODS--------------------------------------------------------------------------------------------------------------------
    private
#------SETUP------------------------------------------------------------------------------------------------------------------------------
    def setUp
		font_families["Verdana"] = { normal:{file:"#{Rails.root.to_s}/app/assets/fonts/Verdana.ttf", font:"Verdana"} }
		font_families["Calibri"] = { normal:{file:"#{Rails.root.to_s}/app/assets/fonts/Calibri.ttf", font:"Calibri"} }
        #stroke_axis(step_length:20)
        #stroke_axis(at:[1,609], height:140, width:600, color:'FF00', step_length:50)
        Prawn::Font::AFM.hide_m17n_warning = true
        setHeaders
        setShapes
        setTable
    end
#------QUANTITYES-------------------------------------------------------------------------------------------------------------------------
    def setQuantities(enteros,uma)
        printOne = true
        printTwo = true
        
        enteros.each do |entero|
            case entero.service
                when '1'
                    setOne(entero,(uma*4))
                    printOne = false
                when '2'
                    setTwo(entero,(uma*5))
                    printTwo = false
                when '3'
                    setTree(entero,(uma*3))
                when '4'
                    setFour(entero,uma)
                when '5'
                    setFive(entero,uma)
                when '6'
                    setSix(entero,uma)
            end
        end
        checkPrint(printOne,1)
        checkPrint(printTwo,2)
    end
    
    def setOne(entero,tax)
        if entero.unit == 'K.G.'
            unit = 'KILOGRAMO'
            med = 8
        else
            med = 9
            unit = 'TONELADA'
        end
        
        formatted_text_box [
    	    { :text => "#{unit}", size:med, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,590], width:45, height:10
    	formatted_text_box [
    	    { :text => "#{unit}", size:med, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,215], width:45, height:10
        calculator(entero.quantity,tax,unit)
        setTexts(363,590,"#{entero.quantity}")
        setTexts(363,215,"#{entero.quantity}")
    	setTexts(408,590,"#{@cost}")
    	setTexts(408,215,"#{@cost}")
        setTexts(453,590,"#{@percent}")
    	setTexts(453,215,"#{@percent}")
        setTexts(498,590,"#{@total}")
    	setTexts(498,215,"#{@total}")
    end
    def setTwo(entero,tax)
        if entero.unit == 'K.G.'
            med = 8
            unit = 'KILOGRAMO'
        else
            med = 9
            unit = 'TONELADA'
        end
    	formatted_text_box [
    	    { :text => "#{unit}", size:med, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,575], width:45, height:10
    	formatted_text_box [
    	    { :text => "#{unit}", size:med, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,200], width:45, height:10
    	calculator(entero.quantity,tax,unit)
    	setTexts(363,575,"#{entero.quantity}")
        setTexts(363,200,"#{entero.quantity}")
    	setTexts(408,575,"#{@cost}")
    	setTexts(408,200,"#{@cost}")
        setTexts(453,575,"#{@percent}")
    	setTexts(453,200,"#{@percent}")
        setTexts(498,575,"#{@total}")
    	setTexts(498,200,"#{@total}")
    end
    def setTree(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        setTexts(363,560,"#{entero.quantity}")
        setTexts(363,185,"#{entero.quantity}")
    	setTexts(408,560,"#{@cost}")
    	setTexts(408,185,"#{@cost}")
        setTexts(453,560,"#{@percent}")
    	setTexts(453,185,"#{@percent}")
        setTexts(498,560,"#{@total}")
    	setTexts(498,185,"#{@total}")
    end
    def setFour(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        setTexts(363,545,"#{entero.quantity}")
        setTexts(363,170,"#{entero.quantity}")
    	setTexts(408,545,"#{@cost}")
    	setTexts(408,170,"#{@cost}")
        setTexts(453,545,"#{@percent}")
    	setTexts(453,170,"#{@percent}")
        setTexts(498,545,"#{@total}")
    	setTexts(498,170,"#{@total}")
    end
    def setFive(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        setTexts(363,530,"#{entero.quantity}")
        setTexts(363,154,"#{entero.quantity}")
    	setTexts(408,530,"#{@cost}")
    	setTexts(408,154,"#{@cost}")
        setTexts(453,530,"#{@percent}")
    	setTexts(453,154,"#{@percent}")
        setTexts(498,530,"#{@total}")
    	setTexts(498,154,"#{@total}")
    end
    def setSix(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        setTexts(363,505,"#{entero.quantity}")
        setTexts(363,130,"#{entero.quantity}")
    	setTexts(408,505,"#{@cost}")
    	setTexts(408,130,"#{@cost}")
        setTexts(453,505,"#{@percent}")
    	setTexts(453,130,"#{@percent}")
        setTexts(498,505,"#{@total}")
    	setTexts(498,130,"#{@total}")
    end
#------TABLE------------------------------------------------------------------------------------------------------------------------------
    def setTable
    #------TABLA-------HEADERS------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => 'clave', size:8, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,604], width:20, height:10
    	formatted_text_box [
    	    { :text => 'clave', size:8, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,229], width:20, height:10
    	
    	formatted_text_box [
    	    { :text => 'S E R V I C I O', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[170,604], width:55, height:10
    	formatted_text_box [
    	    { :text => 'S E R V I C I O', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[170,229], width:55, height:10
    	
    	formatted_text_box [
    	    { :text => 'UNIDAD', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[321,604], width:35, height:10
    	formatted_text_box [
    	    { :text => 'UNIDAD', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[321,229], width:35, height:10
    	
    	formatted_text_box [
    	    { :text => 'CANTIDAD', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[363,604], width:     40, height:10
    	formatted_text_box [
    	    { :text => 'CANTIDAD', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[363,229], width:     40, height:10
    	
    	formatted_text_box [
    	    { :text => 'COSTO', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[415,604], width:30, height:10
    	formatted_text_box [
    	    { :text => 'COSTO', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[415,229], width:30, height:10
    	
    	formatted_text_box [
    	    { :text => '30% ADICIONAL', size:6.5, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[452,602], width:60, height:10
    	formatted_text_box [
    	    { :text => '30% ADICIONAL', size:6.5, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[452,227], width:60, height:10
    	
    	formatted_text_box [
    	    { :text => 'TOTAL', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[506,604], width:30, height:10
    	formatted_text_box [
    	    { :text => 'TOTAL', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[506,229], width:30, height:10
    #------1------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '22', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,590], width:10, height:10
    	formatted_text_box [
    	    { :text => '22', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,215], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESIDUOS SOLIDOS COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,590], width:309, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESIDUOS SOLIDOS COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,215], width:309, height:10
    #------2------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '23', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,575], width:10, height:10
    	formatted_text_box [
    	    { :text => '23', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,200], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE ESCOMBROS DE CONSTRUCCION COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,575], width:320, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE ESCOMBROS DE CONSTRUCCION COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,200], width:320, height:10
    #------3------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '24', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,560], width:10, height:10
    	formatted_text_box [
    	    { :text => '24', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,185], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESTOS DE ANIMALES COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,560], width:320, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESTOS DE ANIMALES COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,185], width:320, height:10
    	
        formatted_text_box [
    	    { :text => 'VEHICULO', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,560], width:45, height:10
    	formatted_text_box [
    	    { :text => 'VEHICULO', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,185], width:45, height:10
    #------4------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '25', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,545], width:10, height:10
    	formatted_text_box [
    	    { :text => '25', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,170], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RAMAS Y DESECHOS DE JARDINERIA COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,545], width:309, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RAMAS Y DESECHOS DE JARDINERIA COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,170], width:309, height:10
    	
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,545], width:10, height:10
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,170], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,546], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,170], width:10, height:10
    #------5------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '26', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,530], width:10, height:10
    	formatted_text_box [
    	    { :text => '26', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,154], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LLANTAS DE VEHICULOS DE AUTOMORES COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,530], width:270, height:20
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LLANTAS DE VEHICULOS DE AUTOMORES COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,154], width:270, height:20
    	
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,530], width:10, height:10
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,154], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,530], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,154], width:10, height:10
    #------6------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '27', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,505], width:10, height:10
    	formatted_text_box [
    	    { :text => '27', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[29,130], width:10, height:10
    	
   		formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LODOS ESTABILIZADOS DERIVADO DE PLANTAS DE TRATAMIENTO', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,505], width:260, height:20
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LODOS ESTABILIZADOS DERIVADO DE PLANTAS DE TRATAMIENTO', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,130], width:260, height:20
    	
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,505], width:10, height:10
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,130], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,505], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,130], width:10, height:10
    end
#------HEADERS----------------------------------------------------------------------------------------------------------------------------
    def setHeaders
        formatted_text_box [
    	    { :text => "H. XII AYUNTAMIENTO DE LOS CABOS DIRECCÍON MUNICIPAL DE INGRESOS", size:13, style:[:bold], font:"Verdana", 
    	      color:'000000'}, 
    	], at:[120,710], width:320, height:200
    	formatted_text_box [
    	    { :text => "H. XII AYUNTAMIENTO DE LOS CABOS DIRECCÍON MUNICIPAL DE INGRESOS", size:13, style:[:bold], font:"Verdana", 
    	      color:'000000'}, 
    	], at:[120,335], width:320, height:200
    	
    	formatted_text_box [
    	    { :text => "ENTERO DE PAGO", size:11, style:[:normal], font:"Calibri", color:'000000' }, 
    	], at:[210,679], width:150, height:20
    	formatted_text_box [
    	    { :text => "ENTERO DE PAGO", size:11, style:[:normal], font:"Calibri", color:'000000' }, 
    	], at:[210,304], width:150, height:20
    	
    	formatted_text_box [
    	    { :text => "CONCESIONARIO DE SERVICIOS", size:11, style:[:normal], font:"Calibri", color:'000000' }, 
    	], at:[180,670], width:200, height:20
    	formatted_text_box [
    	    { :text => "CONCESIONARIO DE SERVICIOS", size:11, style:[:normal], font:"Calibri", color:'000000' }, 
    	], at:[180,295], width:200, height:20
    	
    	formatted_text_box [
    	    { :text => "RELLENO SANITARIO CANDELARIA CABO SAN LUCAS", size:12, style:[:bold], font:"Calibri", color:'000000' }, 
    	], at:[120,660], width:280, height:50
    	formatted_text_box [
    	    { :text => "RELLENO SANITARIO CANDELARIA CABO SAN LUCAS", size:12, style:[:bold], font:"Calibri", color:'000000' }, 
    	], at:[120,265], width:280, height:50
    	
    	formatted_text_box [
    	    { :text => "NOMBRE: #{@enteros.first.taxpayer}", size:10, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,624], width:435, height:30
    	formatted_text_box [
    	    { :text => "FOLIO No.#{@folio}", size:12, style:[:bold], font:"Calibri", color:'000FFF' }
    	], at:[400,624], width:200, height:200
    
    	formatted_text_box [
    	    { :text => "NOMBRE: #{@enteros.first.taxpayer}", size:10, style:[:bold], font:"Calibri", color:'000000' }, 
    	], at:[26,249], width:520, height:30
    	formatted_text_box [
    	    { :text => "FOLIO No.#{@folio}", size:12, style:[:bold], font:"Calibri", color:'000FFF' }
    	], at:[400,249], width:200, height:200
    end
#------SHAPES-----------------------------------------------------------------------------------------------------------------------------
    def setShapes
        imgshield = "#{Rails.root.to_s}/app/assets/images/shield.png"
		imglogo = "#{Rails.root.to_s}/app/assets/images/logo.png"
        image imgshield, at: [26,710], fit:[80,80]
        image imgshield, at: [26,335], fit:[80,80]
		image imglogo, at: [400,700], fit:[150,150]
		image imglogo, at: [400,335], fit:[150,150]
		stroke_color '000000'
    	
    	stroke do
    	    self.line_width = 0.5
    	    rounded_rectangle [23,605], 530,120, 1 #1
    	    rounded_rectangle [23,230], 530,120, 1 #2
    	    rounded_rectangle [496,485], 57,14, 1
    	    rounded_rectangle [496,110], 57,14, 1
    	    #rectangle [21,465], 100,17     #1
    	    #rectangle [21,90], 100,17     #2
    	    rectangle [320,440], 200,60    #1---------->
    	    rectangle [320,65], 200,60    #2----------->
    	    
    	    horizontal_line 67,400, at:613 #1
    	    horizontal_line 67,400, at:238 #2
    	    horizontal_line 23,553, at:595 #1
    	    horizontal_line 23,553, at:220 #2
    	    horizontal_line 23,553, at:580 #1
    	    horizontal_line 23,553, at:205 #2
    	    horizontal_line 23,553, at:565 #1
    	    horizontal_line 23,553, at:190 #2
    	    horizontal_line 23,553, at:550 #1
    	    horizontal_line 23,553, at:175 #2
    	    horizontal_line 23,553, at:535 #1
    	    horizontal_line 23,553, at:160 #2
    	    horizontal_line 23,553, at:510 #1
    	    horizontal_line 23,553, at:135 #2
    	    horizontal_line 23,280, at:410 #1
    	    horizontal_line 23,280, at:35 #2
    	    
    	    vertical_line  485,605, at:44  #1
    	    vertical_line  110,230, at:44  #2
    	    vertical_line  485,605, at:315 #1
    	    vertical_line  110,230, at:315 #2
    	    vertical_line  485,605, at:360 #1
    	    vertical_line  110,230, at:360 #2
    	    vertical_line  485,605, at:405 #1
    	    vertical_line  110,230, at:405 #2
    	    vertical_line  485,605, at:451 #1
    	    vertical_line  110,230, at:451 #2
    	    vertical_line  485,605, at:496 #1--------->
    	    vertical_line  110,230, at:496 #2--------->
    	end
        dash([1, 2, 3, 4, 5, 6, 7, 8])
        stroke_horizontal_line(-30, 590, :at => 350)
    end
#------FOOT-------------------------------------------------------------------------------------------------------------------------------
    def setFoot
        @t = Time.now
        mes = getMes(@t)
        formatted_text_box [
            { :text => 'FUNDAMENTACION: ART. 119 DE LA LEY DE HACIENDA PARA EL MUNICIPIO DE LOS CABOS, INCISO C) DISPOCISION FINAL EN LOS RELLENOS MUNICIPALES.',
            size:8, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[25,483], width:481, height:50
        #highlight = HighlightCallback.new(:color => 'ffff00', :document => self)
        formatted_text_box [
            { :text => "#{number_to_currency(@grandTotal)}", #:callback => highlight,
            size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[500,483], width:100, height:10
        formatted_text_box [
            { :text => 'FUNDAMENTACION: ART. 119 DE LA LEY DE HACIENDA PARA EL MUNICIPIO DE LOS CABOS, INCISO C) DISPOCISION FINAL EN LOS RELLENOS MUNICIPALES.',
            size:8, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[25,108], width:483, height:50
        formatted_text_box [
            { :text => "#{number_to_currency(@grandTotal)}", #:callback => highlight,
            size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[500,108], width:100, height:10
        # formatted_text_box [
        #     { :text => 'CLAVE:',
        #     size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        # ], at:[25,462], width:600, height:10
        # formatted_text_box [
        #     { :text => 'CLAVE:',
        #     size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        # ], at:[25,87], width:600, height:10
    
        formatted_text_box [
            { :text => "CABO SAN LUCAS, B.C.S. A #{@t.day} DE #{mes} DEL #{@t.year}",
            size:10, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[318,455], width:220, height:10
        formatted_text_box [
            { :text => "CABO SAN LUCAS, B.C.S. A #{@t.day} DE #{mes} DEL #{@t.year}",
            size:10, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[318,80], width:220, height:10
        
        formatted_text_box [
            { :text => 'Lic. Sheila R. Peralta Zumaya',
            size:13, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[65,405], width:200, height:15
        formatted_text_box [
            { :text => 'COORDINADORA DE INGRESOS CSL',
            size:11, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[62,392], width:200, height:15
        formatted_text_box [
            { :text => 'Lic. Sheila R. Peralta Zumaya',
            size:13, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[65,30], width:200, height:15
        formatted_text_box [
            { :text => 'COORDINADORA DE INGRESOS CSL',
            size:11, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[62,17], width:200, height:15
        
        formatted_text_box [
            { :text => 'OBSERVACIONES',
            size:12, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[380,375], width:200, height:15
        formatted_text_box [
            { :text => 'OBSERVACIONES',
            size:12, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[380,1], width:200, height:15
    end
#------HELP-------------------------------------------------------------------------------------------------------------------------------
    def getMes(t)
        case t.month
            when 1
                'ENERO'
            when 2
                'FEBRERO'
            when 3
                'MARZO'
            when 4
                'ABRIL'
            when 5
                'MAYO'
            when 6
                'JUNIO'
            when 7
                'JULIO'
            when 8
                'AGOSTO'
            when 9
                'SEPTIEMBRE'
            when 10
                'OCTUBRE'
            when 11
                'NOVIEMBRE'
            when 12
                'DICIEMBRE'
        end
    end
    
    def calculator(quantity,tax,unit)
        if unit == 'KILOGRAMO'
            @quantity = quantity * 0.001
        else
            @quantity = quantity
        end
        @cost = (@quantity*tax).round(2)
        @percent = (@cost*0.3).round(2)
        @total = (@cost + @percent).round(2)
        @grandTotal = (@grandTotal + @total).round(2)
    end
    
    def setTexts(x,y,message)
         bounding_box([x,y], width:43, height:10) do
            font('Calibri', size:9) do
                text message, align: :center
            end
            #stroke_bounds 
        end
    end
    
    def checkPrint(shallPrint,who)
        if who == 1
            rows = [590,215]
        else
            rows = [575,200]
        end
        
        if shallPrint
            formatted_text_box [
        	    { :text => "TONELADA", size:9, style:[:normal], font:"Calibri", color:'000000' }
            ], at:[317,rows[0]], width:45, height:10
            formatted_text_box [
                { :text => "TONELADA", size:9, style:[:normal], font:"Calibri", color:'000000' }
            ], at:[317,rows[1]], width:45, height:10
        end
    end
end