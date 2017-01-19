class EnteroPdf < Prawn::Document
    def initialize(enteros)
        super()
        stroke_axis
        Prawn::Font::AFM.hide_m17n_warning = true
        name = 'SERVICIOS SANITARIOS DE DISPOSICION DE MATERIALES TOXICOS EL CHARLY BROWN'
#------SET UP IMAGES-----------------------------------------------------------------------------------------------------------------------
        imgshield = "#{Rails.root.to_s}/app/assets/images/shield.png"
        image imgshield, at: [26,710], fit:[80,80]
        
        imglogo = "#{Rails.root.to_s}/app/assets/images/logo.png"
		image imglogo, at: [400,700], fit:[150,150]
#------SET UP FONTS------------------------------------------------------------------------------------------------------------------------
		font_families["Verdana"] = { normal:{file:"#{Rails.root.to_s}/app/assets/fonts/Verdana.ttf", font:"Verdana"} }
		font_families["Calibri"] = { normal:{file:"#{Rails.root.to_s}/app/assets/fonts/Calibri.ttf", font:"Calibri"} }
#------SET UP HEADERS----------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	{
    	    :text => "H. XII AYUNTAMIENTO DE LOS CABOS DIRECCÍON MUNICIPAL DE INGRESOS",
    		size:13, 
    		style:[:bold], 
    	    font:"Verdana", color:'000000'
    	}, ], at:[120,710], width:320, height:300
    	
    	formatted_text_box [
    	{
    	    :text => "ENTERO DE PAGO",
    		size:11,
    		style:[:normal],
    	    font:"Calibri", color:'000000'
    	}, ], at:[210,679], width:150, height:100
    	
    	formatted_text_box [
    	{
    	    :text => "CONCESIONARIO DE SERVICIOS",
    		size:11,
    		style:[:normal],
    		font:"Calibri", color:'000000'
    	}, ], at:[180,670], width:200, height:100
    	
    	formatted_text_box [
    	{
    	    :text => "RELLENO SANITARIO CANDELARIA CABO SAN LUCAS",
    		size:12, 
    		style:[:bold], 
    	    font:"Calibri", color:'000000'
    	}, ], at:[120,660], width:280, height:100
    	
    	formatted_text_box [
    	    { :text => "NOMBRE: #{name}                   ", size:10, style:[:bold], font:"Calibri", color:'000000' }, 
    	    { :text => 'FOLIO No. 00003', size:12, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,620], width:520, height:100
    	
    	formatted_text_box [
    	    { :text => 'No.                                                             SERVICIOS                                                           UNIDAD      CANTIDAD    COSTO          30% ADICIONAL  TOTAL', size:9, style:[:bold], font:"Calibri", color:'000000' }
    	], at:[26,604], width:520, height:100
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '1', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,590], width:10, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESIDUOS SOLIDOS COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,590], width:309, height:10
    	formatted_text_box [
    	    { :text => 'TONELADA', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,590], width:45, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '2', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,575], width:10, height:10
    		formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE ESCOMBROS DE CONSTRUCCION COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,575], width:320, height:10
    	formatted_text_box [
    	    { :text => 'TONELADA', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,575], width:45, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '3', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,560], width:10, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RESTOS DE ANIMALES COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' } 
    	], at:[48,560], width:320, height:10
        formatted_text_box [
    	    { :text => 'TONELADA', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[317,560], width:45, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '4', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,545], width:10, height:10
    	formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE RAMAS Y DESECHOS DE JARDINERIA COMERCIAL', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,545], width:309, height:10
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,545], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,546], width:10, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '5', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,530], width:10, height:10
    		formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LLANTAS DE VEHICULOS DE AUTOMORES COMERCIAL ', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,530], width:270, height:20
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,530], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,530], width:10, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '6', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[26,510], width:10, height:10
   		formatted_text_box [
    	    { :text => 'DISPOSICION FINAL DE LODOS ESTABILIZADOS DERIVADO DE PLANTAS DE TRATAMIENTO', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[48,510], width:260, height:20
    	formatted_text_box [
    	    { :text => 'M', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[332,510], width:10, height:10
    	formatted_text_box [
    	    { :text => '3', size:6, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[340,510], width:10, height:10
#-------CANTIDADES-------------------------------------------------------------------------------------------------------------------------
        formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,590], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,575], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,560], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,545], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,530], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[363,510], width:43, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,590], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,575], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,560], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,545], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,530], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[408,510], width:43, height:10
#------------------------------------------------------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,590], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,575], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,560], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,545], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,530], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[453,510], width:43, height:10
    	#-----------------------------------------------------------------------------------------------
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,590], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,575], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,560], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,545], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,530], width:43, height:10
    	formatted_text_box [
    	    { :text => '100000000', size:9, style:[:normal], font:"Calibri", color:'000000' }
    	], at:[498,510], width:43, height:10
    	#-----------------------------------------------------------------------------------------------
#------SHAPES------------------------------------------------------------------------------------------------------------------------------
    	stroke_color '000000'
    	stroke do
    	    horizontal_line 67,460, at:608
    	    horizontal_line 23,553, at:595
    	    rounded_rectangle [23,605], 530,120, 7
    	    vertical_line  485,605, at:42
    	    vertical_line  485,605, at:314
    	    vertical_line  485,605, at:314
    	    vertical_line  485,605, at:360
    	    vertical_line  485,605, at:405
    	    vertical_line  485,605, at:451
    	    vertical_line  485,605, at:496
    	end
    	
    	
    end
end