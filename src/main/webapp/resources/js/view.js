let ing = false;
let clickedIndex = -1;
let begin = -1;
let end = -1;
let nowIndex = -1;
let flag = false;
let isClean = true;

$(window).keydown(function(evt) {
    if (evt.keyCode == 27) {
        clearLine();
        flag = false;
    }
});

$('.code .line').click(function() {

    //console.log('clickedIndex', getLine(this));
    //console.log('isSelected()', isSelected());

    if (flag) {
        return;
    }
    
    if (isSelected()) {
        ing = false;
        flag = true;
        //clearLine();
        showCommentForm();
    } else {
        ing = true;
        clickedIndex = getLine(this);
    }

    selLine(this, true);
    
});

$('.code .line').mouseenter(function() {
    
    if (ing) {
        selLine(this, true);
    }

});

function clearLine() {
    isClean = true;
    $('.code .line').removeClass('one');
    $('.code .line').removeClass('top');
    $('.code .line').removeClass('middle');
    $('.code .line').removeClass('bottom');
    $('.commentForm').fadeOut(100, function() {
        $('.commentForm textarea').val('');
    });
    $('.list .listitem').removeClass('selected');
    clearFloatLine();
}

function clearFloatLine() {
    if (tempSelectedListItemIndex == $('.list .listitem').length - 1) {
        $('.list .listitem').eq(tempSelectedListItemIndex-1).after(tempSelectedListItem);
    } else {
        $('.list .listitem').eq(tempSelectedListItemIndex).before(tempSelectedListItem);
    }
    // $('.selected-list').html('');
    $('.selected-list').hide();
    $('.selected-list').css({
        position: 'static',
        top: tempListTop
    });
}

function isSelected() {
    return $('.one, .top, .middle, .bottom').length > 0 ? true : false;
}

function getLine(line) {

    let lineIndex = -1;
    
    $('.code .line').each(function (index, item) {
        if (item == line) {
            lineIndex = index;
        }
    });
    return lineIndex;
}

function selLine(line, mode) {

    if (mode) {
        let nowIndex = getLine(line);

        if (nowIndex > clickedIndex) {
            begin = clickedIndex;
            end = nowIndex;
        } else {
            begin = nowIndex;
            end = clickedIndex;
        }
    }


    $('.code .line')
        .removeClass('one')
        .removeClass('top')
        .removeClass('middle')
        .removeClass('bottom');
    
    
    if (begin == end) {
        $($('.code .line').get(end)).addClass('one');
    } else {
        //console.log('begin', begin, 'end', end);
        for (let i=begin; i<=end; i++) {
            if (i != begin && i != end) {
                $($('.code .line').get(i)).addClass('middle');
            } if (i == begin) {
                $($('.code .line').get(begin)).addClass('top');
            } else if (i == end) {
                $($('.code .line').get(end)).addClass('bottom');
            }
        }
    }

	$('input[name=beginline]').val(begin);
    $('input[name=endline]').val(end);
    
}

function showCommentForm() {
    $('.commentForm').css({
        top: $($('.code .line').get(end)).position().top + 30
    }).fadeIn(100);
    $('textarea[name=content]').focus();
}

$('textarea[name=content]').keydown(function(evt) {
    if (evt.ctrlKey && evt.keyCode == 13) {
        
        this.form.submit();
        
    }
});

let tempSelectedListItem;
let tempSelectedListItemIndex;
let tempListTop;

$('.list .listitem').click(function() {

    flag = true;
    begin = $(this).data('begin');
    end = $(this).data('end');
    $('.list .listitem').removeClass('selected');
    $(this).addClass('selected');
    selLine(null, false);

    var offset = $($('.code .line').get(begin)).offset();
    $('html').animate({
        scrollTop: offset.top - 50
    }, 400);
    clearFloatLine();
    if (event.ctrlKey && isClean) { 

        
        tempSelectedListItem = this;
        tempSelectedListItemIndex = $(this).index();
        tempListTop = $(this).offset().top;

        console.log(tempSelectedListItemIndex);

        $(this).removeClass('selected');
        $('.selected-list').append(this);
        $('.selected-list').show();
        $('.selected-list').css({
            position: 'absolute',
            left: 1,
            width: 868,
            padding: 5,
            'background-color': 'white',
            'box-shadow': '0 0px 2px #DDD',
            top: $(this).offset().top
        });
        $('.selected-list').animate({
            top: $($('.code .line').get(end)).offset().top + 14
        }, 400);

    } else {
        isClean = false;  
    }
    
});