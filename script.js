(function(){var a,b,c,d,e,f,g,h,i,j,k;a=function(a,b){return Array.isArray(a)&&(a=a.join(", ")),a.length-3>b?""+a.substr(0,b-3)+"...":null!=a?"":void 0},g=function(a){return a=new Date(a.substr(0,10)),""+a.getDate()+"."+(a.getMonth()+1)+"."+a.getFullYear()},j=function(){var a,b,c,d,e;for($(".cover").html(""),$(".cover").append('<section class="el"></section>'),$(".cover").append('<section class="el"></section>'),$(".cover").append('<section class="el"></section>'),b=0,d=0,e=data.length;e>d;d++)c=data[d],a=0===b?"mid":"",$(".cover").append('<section data-id="'+c.movieid+'" class="el pos-'+b++ +'"><img src="./poster.png" class="'+a+'" data-original="./thumbs/'+c.movieid+'.jpg" /></section>');return $(".cover > .el > img").lazyload({container:$(".coverwrap"),threshold:400}),i($(".cover .el.pos-0").data("id"))},e=function(a){var b,c,d;for(c=0,d=data.length;d>c;c++)if(b=data[c],b.movieid===a)return b},f=function(a){var b,c,d,e,f;for(c="<ul class='perslist'>",f=a.writer,d=0,e=f.length;e>d;d++)b=f[d],c+="<li>"+b+"</li>";return c+="</ul>"},d=function(a){var b,c,d,e,f;for(c="<ul class='perslist'>",f=a.cast,d=0,e=f.length;e>d;d++)b=f[d],c+="<li><strong>"+b.name+"</strong> as "+b.role+"</li>";return c+="</ul>"},i=function(a){var b;return b=e(a),null!=b&&($(".details .year").html(b.year),$(".details .title").html(b.label),$(".details .tagline").html(b.tagline),$(".details .plot").html(b.plot),$(".details .genre").html(b.genre.join(" / ")),$(".details .cast").html(d(b)),$(".details .writer").html(f(b)),$(".details .director").html(b.director.join(", ")),$(".details .country").html(b.country),$(".details .length").html(""+b.runtime/60+" min"),$(".details .rating").html("Rating: "+b.rating.toPrecision(3)),$(".details .id").html(b.movieid)),$(".marquee").marquee({duration:1e4,pauseOnHover:!0})},c=function(a,b){var c;return a===b?0:null!=(c=a>b)?c:{1:-1}},h=function(a,b){return c(a.label,b.label)},k=function(a,b){return c(a.year,b.year)},b=function(a,b){return c(a.dateadded,b.dateadded)},$(function(){var a,c;return console.log(data[0]),$(".coverwrap").animate({scrollLeft:0},500,"linear"),$("body").css({height:window.innerHeight-220}),$("ul.sort li").click(function(){var a;switch($(this).data("by")){case"title":data.sort(h);break;case"year":data.sort(k);break;case"added":data.sort(b)}return a=$(this).data("dir"),$(this).data("by")===$("ul.sort li.active").first().data("by")&&(a="asc"===a?"desc":"asc"),"desc"===a&&data.reverse(),$("ul.sort li.active").removeClass("active"),$(this).addClass("active"),$(this).data("dir",a),j()}),c=0,a=!0,$(".coverwrap").scroll(function(){return window.clearTimeout(c),a&&($(".coverwrap .el > img.mid").removeClass("mid"),a=!1),c=window.setTimeout(function(){var b,c;return c=Math.round($(".coverwrap").scrollLeft()/120),b=120*c,$(".coverwrap .el.pos-"+c+" > img").addClass("mid"),$(".coverwrap").animate({scrollLeft:b},500,"linear"),i($(".coverwrap .el.pos-"+c).data("id")),a=!0},250)}),j()})}).call(this);