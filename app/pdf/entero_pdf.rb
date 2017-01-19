class EnteroPdf < Prawn::Document
    def initialize(enteros)
        super()
        stroke_axis
        Prawn::Font::AFM.hide_m17n_warning = true
        
        #------SET UP IMAGES---------------------------------------------------------------------------------------------
        imgshield = "#{Rails.root.to_s}/app/assets/images/shield.png"
        image imgshield, at: [26,710], fit:[80,80]
        
        imglogo = "#{Rails.root.to_s}/app/assets/images/logo.png"
		image imglogo, at: [400,700], fit:[150,150]
		
		#------SET UP FONTS----------------------------------------------------------------------------------------------
		font_families["Verdana"] = { normal:{file:"#{Rails.root.to_s}/app/assets/fonts/Verdana.ttf", font:"Verdana"} }
		font_families["Calibri"] = { normal:{file:"#{Rails.root.to_s}/app/assets/fonts/Calibri.ttf", font:"Calibri"} }
		
		#------SET UP HEADERS--------------------------------------------------------------------------------------------
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
    end
end