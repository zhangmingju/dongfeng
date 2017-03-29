$(function () {
    var detail = {
        init: function () {
            var self = this;
            self.preRequirement();
            self.bindEvent();
            self.getPerAndMediaData();
            self.getCityCode(self.filmId, self.filmName);
            self.getTopicData();
            self.getNews();
            self.getCommentData();
            self.getRelativeMov();
            self.checkIfCole();
        },
        preRequirement: function () {
            var self = this;
            self.cid = $("#cid").val();
            self.isLogin = $("#isLogin").val();
            self.userId = $("#userId").val();
            self.cityCode = $("#cityCode").val();
            self.longitude = $("#longitude").val();
            self.latitude = $("#latitude").val();
            self.describe = $("#describe");
            self.topicWrap = $("#topicWrap");
            self.newsWrap = $("#newsWrap");
            self.filmId = "";
            self.filmName = "";
            self.cityCode = "";
            self.isCtime = 0;
            self.position_option = {
                enableHighAccuracy: true,
                maximumAge: 30000,
                timeout: 5000
            };
        },
        bindEvent: function () {
            var self = this;
            $("#downloadAppBtn").click(function () {
                var ifr = document.createElement("iframe");
                ifr.src = "migumovie://migumovie?nodeId=0&contentId=" + self.cid;
                ifr.style.display = 'none';
                document.body.appendChild(ifr);
                setTimeout(function () {
                    document.body.removeChild(ifr);
                    location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.cmvideo.migumovie";
                }, 1000);
            });
        }
    };
    detail.init();
});