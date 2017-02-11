class EnteroPdf < Prawn::Document
    def initialize(enteros)
        super()
        @enteros = enteros
        @SM = 80.04
        @folio = Time.now.strftime("%d%m%Y-%j-#{Concessionary.find_by(name:@enteros.first.taxpayer).id}")
        setUp
        setQuantities(@enteros,@SM)
        @quantity = 0
        @cost = 0
        @percent = 0
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
        setFoot
        setShapes
        setTable
    end
#------QUANTITYES-------------------------------------------------------------------------------------------------------------------------
    def setQuantities(enteros,sm)
        enteros.each do |entero|

            case entero.service
                when '1'
                    setOne(entero,(sm*4))
                when '2'
                    setTwo(entero,(sm*5))
                when '3'
                    setTree(entero,(sm*3))
                when '4'
                    setFour(entero,sm)
                when '5'
                    setFive(entero,sm)
                when '6'
                    setSix(entero,sm)
            end
        end
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
        
        formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,590], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,215], width:43, height:10
       	formatted_text_box [
    	    { :text => "#{(@cost*100).round / 100}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,590], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,215], width:43, height:10 
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,590], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,215], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,590], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,215], width:43, height:10
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
    	
        formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,575], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,200], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,575], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,200], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,575], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,200], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,575], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,200], width:43, height:10
    end
    def setTree(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        
        formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,560], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,185], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,560], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,185], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,560], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,185], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,560], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,185], width:43, height:10
    end
    def setFour(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        
        formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,545], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,170], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,545], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,170], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,545], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,170], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,545], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,170], width:43, height:10
    end
    def setFive(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        
        formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,530], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,154], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,530], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,154], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,530], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,154], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,530], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,154], width:43, height:10
    end
    def setSix(entero,tax)
        calculator(entero.quantity,tax,entero.unit)
        
        formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,505], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{entero.quantity}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,130], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,505], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,130], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,505], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,130], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,505], width:43, height:10
    	formatted_text_box [
    	    { :text => "#{@cost+@percent}", size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,130], width:43, height:10
    end
#------TABLE------------------------------------------------------------------------------------------------------------------------------
    def setTable
    #------TABLA-------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => 'No.', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,604], width:15, height:10
    	formatted_text_box [
    	    { :text => 'No.', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,229], width:15, height:10
    	
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
    #------1-----------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '1', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,590], width:10, height:10
    	formatted_text_box [
    	    { :text => '1', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,215], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESIDUOS SOLIDOS COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,590], width:309, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESIDUOS SOLIDOS COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,215], width:309, height:10
    #------2-----------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '2', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,575], width:10, height:10
    	formatted_text_box [
    	    { :text => '2', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,200], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE ESCOMBROS DE CONSTRUCCION COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,575], width:320, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE ESCOMBROS DE CONSTRUCCION COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,200], width:320, height:10
    #------3-----------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '3', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,560], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,185], width:10, height:10
    	
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
    #------4-----------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '4', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,545], width:10, height:10
    	formatted_text_box [
    	    { :text => '4', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,170], width:10, height:10
    	
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
    #------5-----------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '5', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,530], width:10, height:10
    	formatted_text_box [
    	    { :text => '5', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,154], width:10, height:10
    	
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LLANTAS DE VEHICULOS DE AUTOMORES COMERCIAL ', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,530], width:270, height:20
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LLANTAS DE VEHICULOS DE AUTOMORES COMERCIAL ', size:9, style:[:normal], font:"Calibri", color:'000000' }
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
    #------6-----------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '6', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,505], width:10, height:10
    	formatted_text_box [
    	    { :text => '6', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,130], width:10, height:10
    	
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
    	    rounded_rectangle [23,605], 530,120, 7 #1
    	    rounded_rectangle [23,230], 530,120, 7 #2
    	    rectangle [21,465], 100,17     #1
    	    rectangle [21,90], 100,17     #2
    	    rectangle [320,450], 200,60    #1
    	    rectangle [320,75], 200,60    #2
    	    
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
    	    
    	    vertical_line  485,605, at:315 #1
    	    vertical_line  110,230, at:315 #2
    	    vertical_line  485,605, at:42  #1
    	    vertical_line  110,230, at:42  #2
    	    vertical_line  485,605, at:360 #1
    	    vertical_line  110,230, at:360 #2
    	    vertical_line  485,605, at:405 #1
    	    vertical_line  110,230, at:405 #2
    	    vertical_line  485,605, at:451 #1
    	    vertical_line  110,230, at:451 #2
    	    vertical_line  485,605, at:496 #1
    	    vertical_line  110,230, at:496 #2
    	end
        dash([1, 2, 3, 4, 5, 6, 7, 8])
        stroke_horizontal_line -30, 590, :at => 350
    end
#------FOOT-------------------------------------------------------------------------------------------------------------------------------
    def setFoot
        @t = Time.now
        mes = getMes(@t)
        formatted_text_box [
            { :text => 'FUNDAMENTACION: ART. 119 DE LA LEY DE HACIENDA PARA EL MUNICIPIO DE LOS CABOS, INCISO C) DISPOCISION FINAL EN LOS RELLENOS MUNICIPALES.',
            size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[21,480], width:600, height:10
        formatted_text_box [
            { :text => 'FUNDAMENTACION: ART. 119 DE LA LEY DE HACIENDA PARA EL MUNICIPIO DE LOS CABOS, INCISO C) DISPOCISION FINAL EN LOS RELLENOS MUNICIPALES.',
            size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[21,105], width:600, height:10
        
        formatted_text_box [
            { :text => 'CLAVE:',
            size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[25,462], width:600, height:10
        formatted_text_box [
            { :text => 'CLAVE:',
            size:8.5, style:[:italic], font:"Calibri", color:'000000' }
        ], at:[25,87], width:600, height:10
    
        formatted_text_box [
            { :text => "CABO SAN LUCAS, B.C.S. A #{@t.day} DE #{mes} DEL #{@t.year}",
            size:10, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[318,465], width:220, height:10
        formatted_text_box [
            { :text => "CABO SAN LUCAS, B.C.S. A #{@t.day} DE #{mes} DEL #{@t.year}",
            size:10, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[318,90], width:220, height:10
        
        formatted_text_box [
            { :text => 'NOMBRE Y FIRMA',
            size:13, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[105,405], width:100, height:15
        formatted_text_box [
            { :text => 'NOMBRE Y FIRMA',
            size:13, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[105,30], width:100, height:15
        
        formatted_text_box [
            { :text => 'SELLO               ORIGINAL',
            size:12, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[400,385], width:200, height:15
        formatted_text_box [
            { :text => 'SELLO               ORIGINAL',
            size:12, style:[:bold], font:"Calibri", color:'000000' }
        ], at:[400,10], width:200, height:15
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
    end
end