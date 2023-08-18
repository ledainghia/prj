(function($) {
	$.fn.footerReveal = function(options) {
		var $this = $(this),
	    $prev = $this.prev(),
		defaults = {
            shadow : true
        }, 
        options = $.extend(defaults, options);
	 	
	 	$this.css({
		   position : 'fixed',
		   bottom : '0',
		   'z-index' : -1000,
		   margin : '0 auto'
		});
		$(function() {
			$prev.css({
				'margin-bottom' : $this.css('height')
			});
			if (defaults.shadow) {
				$prev.css({
					'box-shadow' : '0 20px 20px -20px rgba(0,0,0,0.8)',
					'-moz-box-shadow' : '0 20px 20px -20px rgba(0,0,0,0.8)',
					'-webkit-box-shadow' : '0 20px 30px -20px rgba(0,0,0,0.8)'
				});
			}
		});
	}
}) (jQuery);