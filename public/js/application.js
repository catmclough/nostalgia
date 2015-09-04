$(document).ready(function() {
    var apiKey = "04a77a5882d327512673de9a22bd2ced";
    var request = $.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?jsoncallback=?",
    {
        tags: "fatcat",
        tagmode: "any",
        format: "json"


    },function(data){
        $.each(data.items,function(i,item){
            $('<img/>').attr("src", item.media.m).appendTo($('.container'));
            if (i== 9) return false;
        });
    });
});

// $(document).ready(function() {
//     var apiKey = "04a77a5882d327512673de9a22bd2ced";
//     var request = $.getJSON("https://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key="+
//         apiKey + "&user_id=135876445@N04&per_page=12&page=4&format=json&jsoncallback=? ",
//     {
//         format: "json"

//     },function(data){
//         $.each(data.items,function(i,item){
//             $('<img/>').attr("src", item.media.m).appendTo($('.container'));
//         });
//     });

//     });
