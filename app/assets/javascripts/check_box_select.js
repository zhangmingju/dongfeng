$(function () {
  check_box_select = {
    init: function () {
      var self = this;
      // 基础数据
      self.base_data();
      self.bind_check_box_click_event();
      self.bind_commit();
    
    },
    // 基础数据
    base_data: function(){
      var self = this;
      self.check_box_ids = [];
      self.vote_path = $('#vote_path').val();
      self.product_id = "";
    },

    //给复选框添加点击事件
    bind_check_box_click_event: function(){
      var self = this;
      $('[name="product_check_box"]').each(function(index){
        $(this).on('click',function(e){
          self.bind_check_box_push($(this))
        })
      });
    },

    bind_check_box_push: function(obj){
      var self = this;
      var tr = obj.closest("tr")
      self.product_id = tr.attr("id")
      product_count = tr.find('td[name="product_count"]');
      if(obj.prop("checked")){
        var count = parseInt(product_count.text())+1;
        tr.find('td[name="product_count"]').text(count)
        self.check_box_ids.push(self.product_id)
      }else{
        var index = self.check_box_ids.indexOf(self.product_id)
        self.check_box_ids.splice(index,1)
        var count = parseInt(product_count.text())-1;
        tr.find('td[name="product_count"]').text(count)
      }
    },

    bind_commit:function(){
      var self = this
      $('[name="product_count_commit"]').click(function(){
        if(self.check_box_ids.length > 3 || self.check_box_ids.length == 0){
          alert("每人最多只能投三票,最少一票")
        }else{
          $.ajax({
            type:"post",
            dataType:"json",
            url:self.vote_path,
            data:{
              ids:self.check_box_ids
            },
            success:function(data){
              if(data.info == true){
                alert('投票成功')
                window.location.reload();
              }else{
                alert('投票失败')
              }
              
            }
          })
        }
      });
    }
  };
  check_box_select.init();
});