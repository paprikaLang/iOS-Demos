function pa_imageSourceFromPoint(x,y){
	var element = document.elementFromPoint(x,y);
	if(element.tagName == 'IMG' && element.src){
        var rect = element.getBoundingClientRect();
        alert(rect.top + '|' + rect.left + '|' + rect.right + '|' + rect.height);
        return element.src;
	}
	return null;
}
