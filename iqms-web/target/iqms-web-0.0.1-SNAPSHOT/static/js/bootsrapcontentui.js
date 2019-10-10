$(function()
{
	//override dialog's title function to allow for HTML titles （模式对话标题支持html）
//	$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
//		_title: function(title) {
//			var $title = this.options.title || '&nbsp;'
//			if(("title_html" in this.options) && this.options.title_html == true)
//				title.html($title);
//			else title.text($title);
//		}
//	}));
	
	
	//扩展jquery的方法自动填充表单
	$.fn.populateForm = function(data){
	    return this.each(function(){
	        var formElem, name;
	        if(data == null){this.reset(); return; }
	        for(var i = 0; i < this.length; i++){  
	            formElem = this.elements[i];
	            //checkbox的name可能是name[]数组形式
	            name = (formElem.type == "checkbox")? formElem.name.replace(/(.+)\[\]$/, "$1") : formElem.name;
	            if(data[name] == undefined) continue;
	            switch(formElem.type){
	                case "checkbox":
	                    if(data[name] == ""){
	                        formElem.checked = false;
	                    }else{
	                        //数组查找元素
	                        if(data[name].indexOf(formElem.value) > -1){
	                            formElem.checked = true;
	                        }else{
	                            formElem.checked = false;
	                        }
	                    }
	                break;
	                case "radio":
	                    if(data[name] == ""){
	                        formElem.checked = false;
	                    }else if(formElem.value == data[name]){
	                        formElem.checked = true;
	                    }
	                break;
	                case "button": break;
	                default: formElem.value = data[name];
	            }
	        }
	    });
	};
	
	
	/**
	* 将指定的form表单上的input、select、textarea的数据清除，隐藏框作为参数可选输入true/false或者是样式属性
	*/
	$.fn.clearForm = function(includeHidden) {
	    return this.each(function() {
	        $('input,select,textarea,file', this).clearFields(includeHidden);    //this表示设置上下文环境，有多个表单时只作用指定的表单
	    });
	};

	$.fn.clearFields = $.fn.clearInputs = function(includeHidden) {
	    var re = /^(?:color|date|datetime|email|month|number|password|range|search|tel|text|time|url|week)$/i; // 正则表达式匹配type属性
	    return this.each(function() {
	        var t = this.type, tag = this.tagName.toLowerCase(); //获取元素的type属性和标签
	        if (re.test(t) || tag == 'textarea') {
	            this.value = '';
	        }
	        else if (t == 'checkbox' || t == 'radio') {
	            this.checked = false;
	        }
	        else if (tag == 'select') {
	            this.selectedIndex = 0;
	        }
	        else if (t == "file") {
	            if (/MSIE/.test(navigator.userAgent)) {
	                $(this).replaceWith($(this).clone(true));
	            } else {
	                $(this).val('');
	            }
	       }
	       else if (includeHidden) {
	            if ( (includeHidden === true && /hidden/.test(t)) ||
	                 (typeof includeHidden == 'string' && $(this).is(includeHidden)) ) {   //true 、false或者样式属性
	                this.value = '';
	            }
	        }
	    });
	};
	
	//数组是否包含某个元素
	Array.prototype.contains = function ( needle ) {
		  for (i in this) {
		    if (this[i] == needle) return true;
		  }
		  return false;
		}
	
	
});

/**
 * 弹出信息弹出框
 * @param title    标题
 * @param content  内容
 * @param width    宽度
 * @param height   高度
 */
function msgAlert(title,content,width,height){
	
	$("#msgAlertContent").html(content);
	
	var $newDialog = $("#dialog-message").removeClass("hide").dialog({
		modal: true, //模式对话框
		title: "<div class='widget-header widget-header-small'><h4 class='smaller'><i class='ace-icon fa fa-check'></i> "+title+"</h4></div>",
		title_html: true,
		width:width,
		height:height,
		buttons: [{
			html: '<i class="ace-icon fa fa-times"></i>关闭', //按钮文本
			"class": "btn btn-minier",
			click: function() {
				//关闭窗口
				$(this).dialog("close");
			}
		}]
	});
}