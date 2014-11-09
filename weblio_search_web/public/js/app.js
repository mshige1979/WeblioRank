/**
 * Created by m_shige1979 on 14/11/02.
 * 即時関数
 */
$(function(){

    function AppViewModel() {

        var self = this;
        self.links = [
            {
                'id':'rankList',
                'disp': '当日'
            },
            {
                'id':'rankWeekList',
                'disp': '週間'
            },
            {
                'id':'rankTopList',
                'disp': '1位'
            },
            {
                'id':'rankCountList',
                'disp': 'ランクイン'
            }
        ];

        self.selectedLinkId = ko.observable();
        self.rankListData = ko.observable();
        self.rankWeekListData = ko.observable();
        self.rankTopListData = ko.observable();
        self.rankCountListData = ko.observable();

        // 指定のハッシュへパスを変更
        self.goToLink = function(link) {
            location.hash = link.id;
        };

        var _app = Sammy(function() {
            // 当日
            this.get('#rankList', function() {
                console.log("rankList");
                self.selectedLinkId("rankList");
                self.rankWeekListData(null);
                self.rankTopListData(null);
                self.rankCountListData(null);
                $.get('/api/rank', {}, self.rankListData);
            });

            // 週間
            this.get('#rankWeekList', function() {
                console.log("rankWeekList");
                self.selectedLinkId("rankWeekList");
                self.rankListData(null);
                self.rankTopListData(null);
                self.rankCountListData(null);
                $.get('/api/rankPeriod/20141026', {}, self.rankWeekListData);
            });

            // 1位
            this.get('#rankTopList', function() {
                console.log("rankTopList");
                self.selectedLinkId("rankTopList");
                self.rankWeekListData(null);
                self.rankListData(null);
                self.rankCountListData(null);
                $.get('/api/rankTop', {}, self.rankTopListData);
            });

            // ランクイン
            this.get('#rankCountList', function() {
                console.log("rankCountList");
                self.selectedLinkId("rankCountList");
                self.rankWeekListData(null);
                self.rankListData(null);
                self.rankTopListData(null);
                $.get('/api/rankCount', {}, self.rankCountListData);
            });

            // 初期
            this.get('', function() {
                // 当日にリダイレクト
                this.app.runRoute('get', '#rankList')
            });
        });
        _app.run();
    }

    // Activates knockout.js
    ko.applyBindings(new AppViewModel());

});
