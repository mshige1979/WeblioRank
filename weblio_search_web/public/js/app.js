/**
 * Created by m_shige1979 on 14/11/02.
 * 即時関数
 */
$(function(){

    function AppViewModel() {
        this.firstName = "Bert";
        this.lastName = "Bertington";
    }

    // Activates knockout.js
    ko.applyBindings(new AppViewModel());

});
