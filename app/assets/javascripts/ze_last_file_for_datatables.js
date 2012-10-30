// For now, this has to be the LAST js file since the dataTable Function interferes with Bootstap pills and tabs
// Basically, everything works fine if this is the last file and function added... 

$(document).ready(function() {
         
	// For fixed width containers
	$('.datatable').dataTable({
	  "sDom":"<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
	  "sPaginationType":"bootstrap"});	  
		
});




