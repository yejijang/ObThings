$('.language .icon').click(function() {
    $(this).toggleClass('off');

	let lseq = '';    
    $('.language .icon').each(function(index, item) {
    	if (!$(this).hasClass('off')) {
    		lseq += $(this).data('lseq') + ','; 
    	}
    });
    
    $('input[name=lseq]').val(lseq.substr(0, lseq.length-1));   
});