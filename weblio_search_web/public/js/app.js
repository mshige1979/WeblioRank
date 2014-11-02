/**
 * Created by m_shige1979 on 14/11/02.
 * 即時関数
 */
$(function(){

    function AppViewModel() {
        this.firstName = "Bert";
        this.lastName = "Bertington";

        self.rankListData = ko.observable();
        self.rankList = function(){
            $.get('/api/rank', {}, self.rankListData);
        };

        // すぐに表示
        self.rankList();
    }

    // Activates knockout.js
    ko.applyBindings(new AppViewModel());

});
