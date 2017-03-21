function captcha(obj){
  var d = new Date()
  var url = obj.attr("src").split("?")[0] + "?" +  d.getTime()
  obj.attr("src",url)
}